`timescale 1ns / 1ps

`include "defines.vh"

module axi_master #(
    parameter IC_BLK_LEN = `IC_BLK_LEN,
    parameter DC_BLK_LEN = `DC_BLK_LEN
)(
    input  wire         aclk,
    input  wire         areset,

    output reg          ic_dev_rrdy,
    input  wire         ic_cpu_ren,
    input  wire [31:0]  ic_cpu_raddr,
    output reg          ic_dev_rvalid,
    output reg  [`IC_BLK_SIZE-1:0] ic_dev_rdata,

    output reg          dc_dev_wrdy,
    input  wire [ 3:0]  dc_cpu_wen,
    input  wire [31:0]  dc_cpu_waddr,
    input  wire [31:0]  dc_cpu_wdata,

    output reg          dc_dev_rrdy,
    input  wire         dc_cpu_ren,
    input  wire [31:0]  dc_cpu_raddr,
    output reg          dc_dev_rvalid,
    output reg  [`DC_BLK_SIZE-1:0] dc_dev_rdata,

    output reg  [31:0]  m_axi_awaddr,
    output reg  [ 7:0]  m_axi_awlen,
    output reg  [ 2:0]  m_axi_awsize,
    output reg  [ 1:0]  m_axi_awburst,
    output reg          m_axi_awvalid,
    input  wire         m_axi_awready,

    output reg  [31:0]  m_axi_wdata,
    output reg  [ 3:0]  m_axi_wstrb,
    output wire         m_axi_wlast,
    output reg          m_axi_wvalid,
    input  wire         m_axi_wready,

    output reg          m_axi_bready,
    input  wire [ 1:0]  m_axi_bresp,
    input  wire         m_axi_bvalid,

    output reg  [31:0]  m_axi_araddr,
    output reg  [ 7:0]  m_axi_arlen,
    output reg  [ 2:0]  m_axi_arsize,
    output reg  [ 1:0]  m_axi_arburst,
    output reg          m_axi_arvalid,
    input  wire         m_axi_arready,

    output reg          m_axi_rready,
    input  wire [31:0]  m_axi_rdata,
    input  wire [ 1:0]  m_axi_rresp,
    input  wire         m_axi_rlast,
    input  wire         m_axi_rvalid
);

    localparam FSM_IDLE     = 3'h0;
    localparam FSM_IC_RD    = 3'h1;
    localparam FSM_DC_RD    = 3'h2;
    localparam FSM_DC_WR_AW = 3'h3;
    localparam FSM_DC_WR_W  = 3'h4;
    localparam FSM_DC_WR_B  = 3'h5;
    localparam FSM_DC_RD_WAIT = 3'h6;
    localparam FSM_IC_RD_WAIT = 3'h7;

    reg [2:0] state, nstate;

    always @(posedge aclk or posedge areset) begin
        state <= areset ? FSM_IDLE : nstate;
    end

    localparam ASIZE = 3'b010;      // 4 bytes per beat
    localparam ABURST = 2'b01;      // INCR

    reg [31:0] rd_addr;
    reg [ 7:0] rd_beat;       // current beat index (0..arlen)
    reg [ 7:0] rd_arlen;      // arlen for this transaction
    reg [31:0] rd_buf [3:0];  // up to 4 beats (128-bit max)
    reg        rd_is_dc;      // 1=DCache, 0=ICache

    reg [31:0] wr_addr;
    reg [ 3:0] wr_wstrb;
    reg [31:0] wr_data;

    wire dc_w_req = |dc_cpu_wen;
    wire dc_r_req = dc_cpu_ren;
    wire ic_r_req = ic_cpu_ren;

    wire start_dc_w = dc_w_req && dc_dev_wrdy;
    wire start_dc_r = dc_r_req && dc_dev_rrdy && !start_dc_w;
    wire start_ic_r = ic_r_req && ic_dev_rrdy && !start_dc_w && !start_dc_r;

    wire [7:0] ic_burst_len = IC_BLK_LEN - 1;
    wire [7:0] dc_burst_len = DC_BLK_LEN - 1;

    assign m_axi_wlast = (state == FSM_DC_WR_W) && m_axi_wvalid;

    always @(*) begin
        nstate = state;
        case (state)
            FSM_IDLE: begin
                if (start_dc_w)
                    nstate = FSM_DC_WR_AW;
                else if (start_dc_r)
                    nstate = FSM_DC_RD;
                else if (start_ic_r)
                    nstate = FSM_IC_RD;
            end
            FSM_DC_WR_AW: if (m_axi_awvalid && m_axi_awready) nstate = FSM_DC_WR_W;
            FSM_DC_WR_W:  if (m_axi_wvalid && m_axi_wready) nstate = FSM_DC_WR_B;
            FSM_DC_WR_B:  if (m_axi_bvalid && m_axi_bready) nstate = FSM_IDLE;
            FSM_DC_RD:    if (m_axi_arvalid && m_axi_arready) nstate = FSM_DC_RD_WAIT;
            FSM_DC_RD_WAIT: if (m_axi_rvalid && m_axi_rready && m_axi_rlast) nstate = FSM_IDLE;
            FSM_IC_RD:    if (m_axi_arvalid && m_axi_arready) nstate = FSM_IC_RD_WAIT;
            FSM_IC_RD_WAIT: if (m_axi_rvalid && m_axi_rready && m_axi_rlast) nstate = FSM_IDLE;
            default: nstate = FSM_IDLE;
        endcase
    end

    always @(posedge aclk or posedge areset) begin
        if (areset) begin
            ic_dev_rrdy   <= 1'b1;
            ic_dev_rvalid <= 1'b0;
            ic_dev_rdata  <= 0;
            dc_dev_wrdy   <= 1'b1;
            dc_dev_rrdy   <= 1'b1;
            dc_dev_rvalid <= 1'b0;
            dc_dev_rdata  <= 0;

            m_axi_awaddr  <= 0;
            m_axi_awlen   <= 0;
            m_axi_awsize  <= ASIZE;
            m_axi_awburst <= ABURST;
            m_axi_awvalid <= 0;
            m_axi_wdata   <= 0;
            m_axi_wstrb   <= 0;
            m_axi_wvalid  <= 0;
            m_axi_bready  <= 1;
            m_axi_araddr  <= 0;
            m_axi_arlen   <= 0;
            m_axi_arsize  <= ASIZE;
            m_axi_arburst <= ABURST;
            m_axi_arvalid <= 0;
            m_axi_rready  <= 1;

            rd_addr    <= 0;
            rd_beat    <= 0;
            rd_arlen   <= 0;
            rd_is_dc   <= 0;
            wr_addr    <= 0;
            wr_wstrb   <= 0;
            wr_data    <= 0;
        end else begin
            ic_dev_rvalid <= 1'b0;
            dc_dev_rvalid <= 1'b0;

            case (state)
                FSM_IDLE: begin
                    m_axi_awvalid <= 1'b0;
                    m_axi_wvalid  <= 1'b0;
                    m_axi_arvalid <= 1'b0;
                    if (start_dc_w) begin
                        dc_dev_wrdy <= 1'b0;
                        wr_addr     <= dc_cpu_waddr;
                        wr_wstrb    <= dc_cpu_wen;
                        wr_data     <= dc_cpu_wdata;
                    end
                    if (start_dc_r) begin
                        dc_dev_rrdy <= 1'b0;
                        rd_addr     <= dc_cpu_raddr;
                        rd_arlen    <= dc_burst_len;
                        rd_beat     <= 0;
                        rd_is_dc    <= 1'b1;
                    end
                    if (start_ic_r) begin
                        ic_dev_rrdy <= 1'b0;
                        rd_addr     <= ic_cpu_raddr;
                        rd_arlen    <= ic_burst_len;
                        rd_beat     <= 0;
                        rd_is_dc    <= 1'b0;
                    end
                end

                FSM_DC_WR_AW: begin
                    m_axi_awaddr  <= wr_addr;
                    m_axi_awlen   <= 8'h0;   // single beat for passthrough
                    m_axi_awsize  <= ASIZE;
                    m_axi_awburst <= ABURST;
                    m_axi_awvalid <= 1'b1;
                end

                FSM_DC_WR_W: begin
                    m_axi_awvalid <= 1'b0;  // AW handshake done
                    m_axi_wdata  <= wr_data;
                    m_axi_wstrb  <= wr_wstrb;
                    m_axi_wvalid <= 1'b1;
                end

                FSM_DC_WR_B: begin
                    m_axi_wvalid <= 1'b0;  // W handshake done
                    if (m_axi_bvalid) begin
                        dc_dev_wrdy <= 1'b1;
                    end
                end

                FSM_DC_RD: begin
                    m_axi_araddr  <= rd_addr;
                    m_axi_arlen   <= dc_burst_len;
                    m_axi_arsize  <= ASIZE;
                    m_axi_arburst <= ABURST;
                    m_axi_arvalid <= 1'b1;
                end

                FSM_DC_RD_WAIT: begin
                    m_axi_arvalid <= 1'b0;  // AR handshake done
                    if (m_axi_rvalid && m_axi_rready) begin
                        rd_buf[rd_beat[1:0]] <= m_axi_rdata;
                        if (m_axi_rlast) begin
                            dc_dev_rvalid <= 1'b1;
                            dc_dev_rrdy   <= 1'b1;
`ifdef ENABLE_DCACHE
                            begin
                                dc_dev_rdata[31:0]   <= rd_beat == 8'd0 ? m_axi_rdata : rd_buf[0];
                                dc_dev_rdata[63:32]  <= rd_beat == 8'd1 ? m_axi_rdata : rd_buf[1];
                                dc_dev_rdata[95:64]  <= rd_beat == 8'd2 ? m_axi_rdata : rd_buf[2];
                                dc_dev_rdata[127:96] <= rd_beat == 8'd3 ? m_axi_rdata : rd_buf[3];
                            end
`else
                                dc_dev_rdata <= m_axi_rdata;
`endif
                        end else begin
                            rd_beat <= rd_beat + 1;
                        end
                    end
                end

                FSM_IC_RD: begin
                    m_axi_araddr  <= rd_addr;
                    m_axi_arlen   <= ic_burst_len;
                    m_axi_arsize  <= ASIZE;
                    m_axi_arburst <= ABURST;
                    m_axi_arvalid <= 1'b1;
                end

                FSM_IC_RD_WAIT: begin
                    m_axi_arvalid <= 1'b0;  // AR handshake done
                    if (m_axi_rvalid && m_axi_rready) begin
                        rd_buf[rd_beat[1:0]] <= m_axi_rdata;
                        if (m_axi_rlast) begin
                            ic_dev_rvalid <= 1'b1;
                            ic_dev_rrdy   <= 1'b1;
`ifdef ENABLE_ICACHE
                            begin
                                ic_dev_rdata[31:0]   <= rd_beat == 8'd0 ? m_axi_rdata : rd_buf[0];
                                ic_dev_rdata[63:32]  <= rd_beat == 8'd1 ? m_axi_rdata : rd_buf[1];
                                ic_dev_rdata[95:64]  <= rd_beat == 8'd2 ? m_axi_rdata : rd_buf[2];
                                ic_dev_rdata[127:96] <= rd_beat == 8'd3 ? m_axi_rdata : rd_buf[3];
                            end
`else
                                ic_dev_rdata <= m_axi_rdata;
`endif
                        end else begin
                            rd_beat <= rd_beat + 1;
                        end
                    end
                end

                default: begin
                    ic_dev_rrdy <= 1'b1;
                    dc_dev_wrdy <= 1'b1;
                    dc_dev_rrdy <= 1'b1;
                end
            endcase
        end
    end

endmodule
