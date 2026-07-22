`timescale 1ns / 1ps

`include "defines.vh"

module miniRV_SoC(
    input  wire         fpga_clk,
    input  wire         fpga_rst,   // Low Active (BUT: fpga_rst=1 means ACTIVE in trace test!)
    input  wire [15:0]  sw,
    output wire [15:0]  led,
    output wire [ 7:0]  dig_en,
    output wire [ 7:0]  dig_seg,    // {CA, CB, ..., CG, DP}
    output wire [ 7:0]  dig_seg1,
    input  wire         rx,
    output wire         tx,

    // ================= AXI4 Memory Interface (for FPGA synthesis) =================
    // Write address
    output wire [31:0]  mem_axi_awaddr,
    output wire [ 7:0]  mem_axi_awlen,
    output wire [ 2:0]  mem_axi_awsize,
    output wire [ 1:0]  mem_axi_awburst,
    input  wire         mem_axi_awready,
    output wire         mem_axi_awvalid,
    // Write data
    output wire [31:0]  mem_axi_wdata,
    input  wire         mem_axi_wready,
    output wire [ 3:0]  mem_axi_wstrb,
    output wire         mem_axi_wlast,
    output wire         mem_axi_wvalid,
    // Write response
    output wire         mem_axi_bready,
    input  wire [ 1:0]  mem_axi_bresp,
    input  wire         mem_axi_bvalid,
    // Read address
    output wire [31:0]  mem_axi_araddr,
    output wire [ 7:0]  mem_axi_arlen,
    output wire [ 2:0]  mem_axi_arsize,
    output wire [ 1:0]  mem_axi_arburst,
    input  wire         mem_axi_arready,
    output wire         mem_axi_arvalid,
    // Read data
    input  wire [31:0]  mem_axi_rdata,
    output wire         mem_axi_rready,
    input  wire [ 1:0]  mem_axi_rresp,
    input  wire         mem_axi_rlast,
    input  wire         mem_axi_rvalid
);

`ifdef RUN_TRACE
    // ========================================================================
    // RUN_TRACE 模式: 绕过 PLL，内部实例化 bram_axi 作为 AXI 存储器
    // 用于 Verilator trace 测试 和 Vivado xsim 快速仿真
    // ========================================================================
    wire sys_clk = fpga_clk;
    wire sys_rst = fpga_rst;    // Trace test: fpga_rst is HIGH active

    // ------ cpu_top AXI ↔ bram_axi 信号 ------
    wire [31:0]  cpu_awaddr;
    wire [ 7:0]  cpu_awlen;
    wire [ 2:0]  cpu_awsize;
    wire [ 1:0]  cpu_awburst;
    wire         cpu_awvalid;
    wire         cpu_awready;
    wire [31:0]  cpu_wdata;
    wire [ 3:0]  cpu_wstrb;
    wire         cpu_wlast;
    wire         cpu_wvalid;
    wire         cpu_wready;
    wire         cpu_bready;
    wire [ 1:0]  cpu_bresp;
    wire         cpu_bvalid;
    wire [31:0]  cpu_araddr;
    wire [ 7:0]  cpu_arlen;
    wire [ 2:0]  cpu_arsize;
    wire [ 1:0]  cpu_arburst;
    wire         cpu_arvalid;
    wire         cpu_arready;
    wire [31:0]  cpu_rdata;
    wire         cpu_rready;
    wire [ 1:0]  cpu_rresp;
    wire         cpu_rlast;
    wire         cpu_rvalid;

    // ------ CPU + Cache + AXI Master ------
    cpu_top U_cpu (
        .cpu_clk        (sys_clk),
        .cpu_rst        (sys_rst),
        .m_axi_awaddr   (cpu_awaddr),
        .m_axi_awlen    (cpu_awlen),
        .m_axi_awsize   (cpu_awsize),
        .m_axi_awburst  (cpu_awburst),
        .m_axi_awready  (cpu_awready),
        .m_axi_awvalid  (cpu_awvalid),
        .m_axi_wdata    (cpu_wdata),
        .m_axi_wready   (cpu_wready),
        .m_axi_wstrb    (cpu_wstrb),
        .m_axi_wlast    (cpu_wlast),
        .m_axi_wvalid   (cpu_wvalid),
        .m_axi_bready   (cpu_bready),
        .m_axi_bresp    (cpu_bresp),
        .m_axi_bvalid   (cpu_bvalid),
        .m_axi_araddr   (cpu_araddr),
        .m_axi_arlen    (cpu_arlen),
        .m_axi_arsize   (cpu_arsize),
        .m_axi_arburst  (cpu_arburst),
        .m_axi_arready  (cpu_arready),
        .m_axi_arvalid  (cpu_arvalid),
        .m_axi_rdata    (cpu_rdata),
        .m_axi_rready   (cpu_rready),
        .m_axi_rresp    (cpu_rresp),
        .m_axi_rlast    (cpu_rlast),
        .m_axi_rvalid   (cpu_rvalid)
    );

    // ------ AXI BRAM 存储器 ------
    // 模块名 bram_axi / 实例名 U_bram 是 trace 测试框架的硬性要求
    bram_axi U_bram (
        .s_aclk         (sys_clk),
        .s_aresetn      (~sys_rst),        // bram_axi 使用低复位
        .s_axi_awaddr   (cpu_awaddr),
        .s_axi_awlen    (cpu_awlen),
        .s_axi_awsize   (cpu_awsize),
        .s_axi_awburst  (cpu_awburst),
        .s_axi_awvalid  (cpu_awvalid),
        .s_axi_awready  (cpu_awready),
        .s_axi_wdata    (cpu_wdata),
        .s_axi_wstrb    (cpu_wstrb),
        .s_axi_wlast    (cpu_wlast),
        .s_axi_wvalid   (cpu_wvalid),
        .s_axi_wready   (cpu_wready),
        .s_axi_bready   (cpu_bready),
        .s_axi_bresp    (cpu_bresp),
        .s_axi_bvalid   (cpu_bvalid),
        .s_axi_araddr   (cpu_araddr),
        .s_axi_arlen    (cpu_arlen),
        .s_axi_arsize   (cpu_arsize),
        .s_axi_arburst  (cpu_arburst),
        .s_axi_arvalid  (cpu_arvalid),
        .s_axi_arready  (cpu_arready),
        .s_axi_rdata    (cpu_rdata),
        .s_axi_rresp    (cpu_rresp),
        .s_axi_rlast    (cpu_rlast),
        .s_axi_rvalid   (cpu_rvalid),
        .s_axi_rready   (cpu_rready)
    );

    // 外设和外部 AXI 接口悬空
    assign led     = 16'h0;
    assign dig_en  = 8'h0;
    assign dig_seg = 8'h0;
    assign dig_seg1 = 8'h0;
    assign tx      = 1'b1;

    // 外部 AXI 接口悬空（RUN_TRACE 时不接外部 DDR）
    assign mem_axi_awaddr  = 32'h0;
    assign mem_axi_awlen   = 8'h0;
    assign mem_axi_awsize  = 3'h0;
    assign mem_axi_awburst = 2'h0;
    assign mem_axi_awvalid = 1'b0;
    assign mem_axi_wdata   = 32'h0;
    assign mem_axi_wstrb   = 4'h0;
    assign mem_axi_wlast   = 1'b0;
    assign mem_axi_wvalid  = 1'b0;
    assign mem_axi_bready  = 1'b0;
    assign mem_axi_araddr  = 32'h0;
    assign mem_axi_arlen   = 8'h0;
    assign mem_axi_arsize  = 3'h0;
    assign mem_axi_arburst = 2'h0;
    assign mem_axi_arvalid = 1'b0;
    assign mem_axi_rready  = 1'b0;

`else
    // ========================================================================
    // FPGA 模式: PLL + 外部 AXI 存储器接口
    // ========================================================================
    wire pll_clk1;
    wire pll_lock;
    wire sys_clk = pll_lock & pll_clk1;
    reg  sys_rst;
    always @(posedge fpga_clk) sys_rst <= !fpga_rst | !pll_lock;

    clk_wiz_0 U_clkgen (
        .clk_in1    (fpga_clk),
        .locked     (pll_lock),
        .clk_out1   (pll_clk1)
    );

    // ------ CPU + Cache + AXI Master → 外部 AXI 接口 ------
    cpu_top U_cpu (
        .cpu_clk        (sys_clk),
        .cpu_rst        (sys_rst),
        .m_axi_awaddr   (mem_axi_awaddr),
        .m_axi_awlen    (mem_axi_awlen),
        .m_axi_awsize   (mem_axi_awsize),
        .m_axi_awburst  (mem_axi_awburst),
        .m_axi_awready  (mem_axi_awready),
        .m_axi_awvalid  (mem_axi_awvalid),
        .m_axi_wdata    (mem_axi_wdata),
        .m_axi_wready   (mem_axi_wready),
        .m_axi_wstrb    (mem_axi_wstrb),
        .m_axi_wlast    (mem_axi_wlast),
        .m_axi_wvalid   (mem_axi_wvalid),
        .m_axi_bready   (mem_axi_bready),
        .m_axi_bresp    (mem_axi_bresp),
        .m_axi_bvalid   (mem_axi_bvalid),
        .m_axi_araddr   (mem_axi_araddr),
        .m_axi_arlen    (mem_axi_arlen),
        .m_axi_arsize   (mem_axi_arsize),
        .m_axi_arburst  (mem_axi_arburst),
        .m_axi_arready  (mem_axi_arready),
        .m_axi_arvalid  (mem_axi_arvalid),
        .m_axi_rdata    (mem_axi_rdata),
        .m_axi_rready   (mem_axi_rready),
        .m_axi_rresp    (mem_axi_rresp),
        .m_axi_rlast    (mem_axi_rlast),
        .m_axi_rvalid   (mem_axi_rvalid)
    );

    // 外设悬空
    assign led     = 16'h0;
    assign dig_en  = 8'h0;
    assign dig_seg = 8'h0;
    assign dig_seg1 = 8'h0;
    assign tx      = 1'b1;

`endif

endmodule
