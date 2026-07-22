`timescale 1ns / 1ps

`include "defines.vh"


module ICache(
    input  wire         cpu_clk,
    input  wire         cpu_rst,        // high active
    // Interface to CPU
    input  wire         inst_rreq,
    input  wire [31:0]  inst_addr,      
    output reg          inst_valid,     
    output reg  [31:0]  inst_out,       
    // Interface to Read Bus
    input  wire         dev_rrdy,
    output reg  [ 3:0]  cpu_ren,        
    output reg  [31:0]  cpu_raddr,      
    input  wire         dev_rvalid,
    input  wire [127:0] dev_rdata       
);

`ifdef ENABLE_ICACHE    

    wire [1:0]  offset         = inst_addr[3:2];
    wire [4:0]  tag_from_cpu   = inst_addr[14:10];     
    wire        valid_bit      = cache_line_r[133];
    wire [4:0]  tag_from_cache = cache_line_r[132:128];

    // ICache
    localparam IDLE      = 2'b00;
    localparam TAG_CHECK = 2'b01;
    localparam REFILL    = 2'b10;
    reg [1:0] state, nstat;

    wire hit = (state == TAG_CHECK) && valid_bit && (tag_from_cache == tag_from_cpu);

    always @(*) begin
        inst_valid = hit;
        case (offset)
            2'b00: inst_out = cache_line_r[31:0];
            2'b01: inst_out = cache_line_r[63:32];
            2'b10: inst_out = cache_line_r[95:64];
            2'b11: inst_out = cache_line_r[127:96];
        endcase
    end

    wire        cache_we     = (state == REFILL) && dev_rvalid;
    wire [5:0]  cache_index  = inst_addr[9:4];
    wire [133:0] cache_line_w = {1'b1, tag_from_cpu, dev_rdata};
    wire [133:0] cache_line_r;

    
    blk_mem_gen_1 U_isram (
        .clka   (cpu_clk),
        .wea    (cache_we),
        .addra  (cache_index),
        .dina   (cache_line_w),
        .douta  (cache_line_r)
    );

    
    always @(posedge cpu_clk or posedge cpu_rst) begin
        state <= cpu_rst ? IDLE : nstat;
    end

    
    always @(*) begin
        case (state)
            IDLE:      nstat = inst_rreq ? TAG_CHECK : IDLE;
            TAG_CHECK: nstat = hit ? IDLE : REFILL;
            REFILL:    nstat = dev_rvalid ? TAG_CHECK : REFILL;
            default:   nstat = IDLE;
        endcase
    end

    
    reg refill_req;
    always @(posedge cpu_clk or posedge cpu_rst) begin
        if (cpu_rst) begin
            cpu_ren    <= 4'h0;
            cpu_raddr  <= 32'h0;
            refill_req <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    cpu_ren    <= 4'h0;
                    refill_req <= 1'b0;
                end
                TAG_CHECK: begin
                    cpu_ren    <= 4'h0;
                    refill_req <= 1'b0;
                end
                REFILL: begin
                    if (!refill_req && dev_rrdy) begin
                        cpu_ren    <= 4'hF;
                        cpu_raddr  <= {inst_addr[31:4], 4'b0};
                        refill_req <= 1'b1;
                    end else begin
                        cpu_ren    <= 4'h0;
                    end
                end
                default: begin
                    cpu_ren    <= 4'h0;
                    refill_req <= 1'b0;
                end
            endcase
        end
    end

    
`else

    localparam IDLE  = 2'b00;
    localparam STAT0 = 2'b01;
    localparam STAT1 = 2'b11;
    reg [1:0] state, nstat;

    always @(posedge cpu_clk or posedge cpu_rst) begin
        state <= cpu_rst ? IDLE : nstat;
    end

    always @(*) begin
        case (state)
            IDLE:    nstat = inst_rreq ? (dev_rrdy ? STAT1 : STAT0) : IDLE;
            STAT0:   nstat = dev_rrdy ? STAT1 : STAT0;
            STAT1:   nstat = dev_rvalid ? IDLE : STAT1;
            default: nstat = IDLE;
        endcase
    end

    always @(posedge cpu_clk or posedge cpu_rst) begin
        if (cpu_rst) begin
            inst_valid <= 1'b0;
            cpu_ren    <= 4'h0;
        end else begin
            case (state)
                IDLE: begin
                    inst_valid <= 1'b0;
                    cpu_ren    <= (inst_rreq & dev_rrdy) ? 4'hF : 4'h0;
                    cpu_raddr  <= inst_rreq ? inst_addr : 32'h0;
                end
                STAT0: begin
                    cpu_ren    <= dev_rrdy ? 4'hF : 4'h0;
                end
                STAT1: begin
                    cpu_ren    <= 4'h0;
                    inst_valid <= dev_rvalid ? 1'b1 : 1'b0;
                    inst_out   <= dev_rvalid ? dev_rdata[31:0] : 32'h0;
                end
                default: begin
                    inst_valid <= 1'b0;
                    cpu_ren    <= 4'h0;
                end
            endcase
        end
    end

`endif

endmodule
