`timescale 1ns / 1ps

`include "defines.vh"


module DCache(
    input  wire         cpu_clk,
    input  wire         cpu_rst,        // high active
    // Interface to CPU
    input  wire [ 3:0]  data_ren,
    input  wire [31:0]  data_addr,
    output reg          data_valid,
    output reg  [31:0]  data_rdata,
    input  wire [ 3:0]  data_wen,
    input  wire [31:0]  data_wdata,
    output reg          data_wresp,
    // Interface to Write Bus
    input  wire         dev_wrdy,
    output reg  [ 3:0]  cpu_wen,
    output reg  [31:0]  cpu_waddr,
    output reg  [31:0]  cpu_wdata,
    // Interface to Read Bus
    input  wire         dev_rrdy,
    output reg  [ 3:0]  cpu_ren,
    output reg  [31:0]  cpu_raddr,
    input  wire         dev_rvalid,
    input  wire [127:0] dev_rdata
);

    // Peripherals access should be uncached.
    wire uncached = (data_addr[31:16] == 16'hFFFF) && (data_ren != 4'h0 || data_wen != 4'h0) ? 1'b1 : 1'b0;

`ifdef ENABLE_DCACHE

    wire [1:0]  offset         = data_addr[3:2];
    wire [4:0]  tag_from_cpu   = data_addr[14:10];
    wire        valid_bit      = cache_line_r[133];
    wire [4:0]  tag_from_cache = cache_line_r[132:128];

    // Read FSM (cached path: R_IDLE -> R_TAG_CHECK -> hit?R_IDLE : R_REFILL -> R_TAG_CHECK)
    localparam R_IDLE      = 3'd0;
    localparam R_TAG_CHECK = 3'd1;
    localparam R_REFILL    = 3'd2;
    localparam R_BUS0      = 3'd3;
    localparam R_BUS1      = 3'd4;
    reg [2:0] r_state, r_nstat;

    // Write FSM
    localparam W_IDLE      = 3'd0;
    localparam W_TAG_CHECK = 3'd1;
    localparam W_BUS0      = 3'd2;
    localparam W_BUS1      = 3'd3;
    localparam W_RESP      = 3'd4;
    reg [2:0] w_state, w_nstat;

    wire hit_r = (r_state == R_TAG_CHECK) && valid_bit && (tag_from_cache == tag_from_cpu);
    wire hit_w = (w_state == W_TAG_CHECK) && valid_bit && (tag_from_cache == tag_from_cpu);

    // Uncached read: registered outputs (matching passthrough timing)
    reg        uncached_valid;
    reg [31:0] uncached_rdata;

    always @(*) begin
        if (uncached_valid) begin
            data_valid = 1'b1;
            data_rdata = uncached_rdata;
        end else begin
            data_valid = hit_r;
            case (offset)
                2'b00: data_rdata = cache_line_r[31:0];
                2'b01: data_rdata = cache_line_r[63:32];
                2'b10: data_rdata = cache_line_r[95:64];
                2'b11: data_rdata = cache_line_r[127:96];
            endcase
        end
    end

    reg  [127:0] modified_data;
    always @(*) begin
        modified_data = cache_line_r[127:0];
        case (offset)
            2'd0: begin
                if (data_wen[0]) modified_data[7:0]   = data_wdata[7:0];
                if (data_wen[1]) modified_data[15:8]  = data_wdata[15:8];
                if (data_wen[2]) modified_data[23:16] = data_wdata[23:16];
                if (data_wen[3]) modified_data[31:24] = data_wdata[31:24];
            end
            2'd1: begin
                if (data_wen[0]) modified_data[39:32]  = data_wdata[7:0];
                if (data_wen[1]) modified_data[47:40]  = data_wdata[15:8];
                if (data_wen[2]) modified_data[55:48]  = data_wdata[23:16];
                if (data_wen[3]) modified_data[63:56]  = data_wdata[31:24];
            end
            2'd2: begin
                if (data_wen[0]) modified_data[71:64]  = data_wdata[7:0];
                if (data_wen[1]) modified_data[79:72]  = data_wdata[15:8];
                if (data_wen[2]) modified_data[87:80]  = data_wdata[23:16];
                if (data_wen[3]) modified_data[95:88]  = data_wdata[31:24];
            end
            2'd3: begin
                if (data_wen[0]) modified_data[103:96]  = data_wdata[7:0];
                if (data_wen[1]) modified_data[111:104] = data_wdata[15:8];
                if (data_wen[2]) modified_data[119:112] = data_wdata[23:16];
                if (data_wen[3]) modified_data[127:120] = data_wdata[31:24];
            end
        endcase
    end

    wire [133:0] wr_cache_data = {1'b1, tag_from_cpu, modified_data};

    wire cache_we = ((r_state == R_REFILL) && dev_rvalid) || (w_state == W_TAG_CHECK);

    wire [133:0] cache_line_w = ((r_state == R_REFILL) && dev_rvalid)
                                ? {1'b1, tag_from_cpu, dev_rdata}
                                : (w_state == W_TAG_CHECK)
                                  ? 134'b0      // invalidate on write (write-no-allocate)
                                  : wr_cache_data;

    wire [5:0]  cache_index  = data_addr[9:4];
    wire [133:0] cache_line_r;

    blk_mem_gen_1 U_dsram (
        .clka   (cpu_clk),
        .wea    (cache_we),
        .addra  (cache_index),
        .dina   (cache_line_w),
        .douta  (cache_line_r)
    );

    reg        refill_req;
    reg [3:0]  ren_saved;

    // Read FSM state register
    always @(posedge cpu_clk or posedge cpu_rst) begin
        r_state <= cpu_rst ? R_IDLE : r_nstat;
    end

    // Read FSM next-state logic
    always @(*) begin
        case (r_state)
            R_IDLE: begin
                if (|data_ren && uncached)
                    r_nstat = R_BUS0;
                else if (|data_ren && !uncached)
                    r_nstat = R_TAG_CHECK;
                else
                    r_nstat = R_IDLE;
            end
            R_TAG_CHECK: r_nstat = hit_r ? R_IDLE : R_REFILL;
            R_REFILL:    r_nstat = dev_rvalid ? R_TAG_CHECK : R_REFILL;
            R_BUS0:      r_nstat = dev_rrdy ? R_BUS1 : R_BUS0;
            R_BUS1:      r_nstat = dev_rvalid ? R_IDLE : R_BUS1;
            default:     r_nstat = R_IDLE;
        endcase
    end

    // Read FSM output logic
    always @(posedge cpu_clk or posedge cpu_rst) begin
        if (cpu_rst) begin
            cpu_ren        <= 4'h0;
            cpu_raddr      <= 32'h0;
            refill_req     <= 1'b0;
            ren_saved      <= 4'h0;
            uncached_valid <= 1'b0;
            uncached_rdata <= 32'h0;
        end else begin
            uncached_valid <= 1'b0;
            case (r_state)
                R_IDLE: begin
                    cpu_ren    <= 4'h0;
                    refill_req <= 1'b0;
                    if (|data_ren && uncached)
                        ren_saved <= data_ren;
                end
                R_TAG_CHECK: begin
                    cpu_ren <= 4'h0;
                end
                R_REFILL: begin
                    if (!refill_req && dev_rrdy) begin
                        cpu_ren   <= 4'hF;
                        cpu_raddr <= {data_addr[31:4], 4'b0};
                        refill_req <= 1'b1;
                    end else begin
                        cpu_ren <= 4'h0;
                    end
                end
                R_BUS0: begin
                    if (dev_rrdy) begin
                        cpu_ren   <= ren_saved;
                        cpu_raddr <= data_addr;
                    end else begin
                        cpu_ren <= 4'h0;
                    end
                end
                R_BUS1: begin
                    cpu_ren <= 4'h0;
                    if (dev_rvalid) begin
                        uncached_valid <= 1'b1;
                        uncached_rdata <= dev_rdata[31:0];
                    end
                end
                default: begin
                    cpu_ren    <= 4'h0;
                    refill_req <= 1'b0;
                end
            endcase
        end
    end

    // Write FSM
    reg [3:0] wen_saved;

    always @(posedge cpu_clk or posedge cpu_rst) begin
        w_state <= cpu_rst ? W_IDLE : w_nstat;
    end

    always @(*) begin
        case (w_state)
            W_IDLE: begin
                if (|data_wen && uncached)
                    w_nstat = W_BUS0;
                else if (|data_wen && !uncached)
                    w_nstat = W_TAG_CHECK;
                else
                    w_nstat = W_IDLE;
            end
            W_TAG_CHECK: w_nstat = W_BUS0;
            W_BUS0:      w_nstat = dev_wrdy ? W_BUS1 : W_BUS0;
            W_BUS1:      w_nstat = W_RESP;
            W_RESP:      w_nstat = (dev_wrdy && cpu_wen == 4'h0) ? W_IDLE : W_RESP;
            default:     w_nstat = W_IDLE;
        endcase
    end

    always @(posedge cpu_clk or posedge cpu_rst) begin
        if (cpu_rst) begin
            cpu_wen    <= 4'h0;
            cpu_waddr  <= 32'h0;
            cpu_wdata  <= 32'h0;
            data_wresp <= 1'b0;
            wen_saved  <= 4'h0;
        end else begin
            case (w_state)
                W_IDLE: begin
                    data_wresp <= 1'b0;
                    cpu_wen    <= 4'h0;
                    if (|data_wen) begin
                        wen_saved <= data_wen;
                        cpu_waddr <= data_addr;
                        cpu_wdata <= data_wdata;
                    end
                end
                W_TAG_CHECK: begin
                    cpu_wen <= 4'h0;
                end
                W_BUS0: begin
                    if (dev_wrdy) begin
                        cpu_wen <= wen_saved;
                    end else begin
                        cpu_wen <= 4'h0;
                    end
                end
                W_BUS1: begin
                    cpu_wen <= 4'h0;
                end
                W_RESP: begin
                    cpu_wen    <= 4'h0;
                    data_wresp <= (dev_wrdy && cpu_wen == 4'h0) ? 1'b1 : 1'b0;
                end
                default: begin
                    cpu_wen    <= 4'h0;
                    data_wresp <= 1'b0;
                end
            endcase
        end
    end

`else

    localparam R_IDLE  = 2'b00;
    localparam R_STAT0 = 2'b01;
    localparam R_STAT1 = 2'b11;
    reg [1:0] r_state, r_nstat;
    reg [3:0] ren_r;

    always @(posedge cpu_clk or posedge cpu_rst) begin
        r_state <= cpu_rst ? R_IDLE : r_nstat;
    end

    always @(*) begin
        case (r_state)
            R_IDLE:  r_nstat = (|data_ren) ? (dev_rrdy ? R_STAT1 : R_STAT0) : R_IDLE;
            R_STAT0: r_nstat = dev_rrdy ? R_STAT1 : R_STAT0;
            R_STAT1: r_nstat = dev_rvalid ? R_IDLE : R_STAT1;
            default: r_nstat = R_IDLE;
        endcase
    end

    always @(posedge cpu_clk or posedge cpu_rst) begin
        if (cpu_rst) begin
            data_valid <= 1'b0;
            cpu_ren    <= 4'h0;
        end else begin
            case (r_state)
                R_IDLE: begin
                    data_valid <= 1'b0;
                    if (|data_ren) begin
                        if (dev_rrdy)
                            cpu_ren <= data_ren;
                        else
                            ren_r   <= data_ren;
                        cpu_raddr <= data_addr;
                    end else
                        cpu_ren   <= 4'h0;
                end
                R_STAT0: begin
                    cpu_ren    <= dev_rrdy ? ren_r : 4'h0;
                end
                R_STAT1: begin
                    cpu_ren    <= 4'h0;
                    data_valid <= dev_rvalid ? 1'b1 : 1'b0;
                    data_rdata <= dev_rvalid ? dev_rdata : 32'h0;
                end
                default: begin
                    data_valid <= 1'b0;
                    cpu_ren    <= 4'h0;
                end
            endcase
        end
    end

    localparam W_IDLE  = 2'b00;
    localparam W_STAT0 = 2'b01;
    localparam W_STAT1 = 2'b11;
    reg  [1:0] w_state, w_nstat;
    reg  [3:0] wen_r;
    wire       wr_resp = dev_wrdy & (cpu_wen == 4'h0) ? 1'b1 : 1'b0;

    always @(posedge cpu_clk or posedge cpu_rst) begin
        w_state <= cpu_rst ? W_IDLE : w_nstat;
    end

    always @(*) begin
        case (w_state)
            W_IDLE:  w_nstat = (|data_wen) ? (dev_wrdy ? W_STAT1 : W_STAT0) : W_IDLE;
            W_STAT0: w_nstat = dev_wrdy ? W_STAT1 : W_STAT0;
            W_STAT1: w_nstat = wr_resp ? W_IDLE : W_STAT1;
            default: w_nstat = W_IDLE;
        endcase
    end

    always @(posedge cpu_clk or posedge cpu_rst) begin
        if (cpu_rst) begin
            data_wresp <= 1'b0;
            cpu_wen    <= 4'h0;
        end else begin
            case (w_state)
                W_IDLE: begin
                    data_wresp <= 1'b0;
                    if (|data_wen) begin
                        if (dev_wrdy)
                            cpu_wen <= data_wen;
                        else
                            wen_r   <= data_wen;
                        cpu_waddr  <= data_addr;
                        cpu_wdata  <= data_wdata;
                    end else
                        cpu_wen    <= 4'h0;
                end
                W_STAT0: begin
                    cpu_wen    <= dev_wrdy ? wen_r : 4'h0;
                end
                W_STAT1: begin
                    cpu_wen    <= 4'h0;
                    data_wresp <= wr_resp ? 1'b1 : 1'b0;
                end
                default: begin
                    data_wresp <= 1'b0;
                    cpu_wen    <= 4'h0;
                end
            endcase
        end
    end

`endif

endmodule
