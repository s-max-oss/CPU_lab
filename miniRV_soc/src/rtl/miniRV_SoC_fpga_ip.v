// ============================================================================
// miniRV_SoC_fpga_ip.v — FPGA 综合顶层 (使用 Vivado IP 核版本)
// ============================================================================
// 架构 (实验指导 Lab 2 B-6 标准实现):
//   cpu_top_axi → axi_crossbar_0 (IP) → 6 slaves:
//     Slave 0: bram_axi_synth    (主存)
//     Slave 1: switch_wrap_ip    (拨码开关, AXI GPIO IP)
//     Slave 2: led_wrap_ip       (LED, AXI GPIO IP)
//     Slave 3: digled_wrap_ip    (数码管, AXI GPIO IP dual-channel)
//     Slave 4: uart_wrap_ip      (UART, AXI Uartlite IP)
//     Slave 5: timer_wrap_ip     (计时器, AXI GPIO IP dual-channel)
//
// 与手写版 miniRV_SoC_fpga.v 的区别:
//   - 用 Vivado IP 替代手写 wrapper
//   - 用 AXI Protocol Converter 处理 AXI4 → AXI4-Lite
//   - 必须先运行 create_ips.tcl 生成 .xci 文件
//
// 时钟: 100MHz 外部输入 → clk_wiz_0 PLL → 50MHz 系统时钟

`timescale 1ns / 1ps

`include "defines.vh"

module miniRV_SoC_fpga_ip (
    input  wire         fpga_clk,        // 100MHz
    input  wire         fpga_rst,        // Low Active
    input  wire [15:0]  sw,
    output wire [15:0]  led,
    output wire [ 7:0]  dig_en,
    output wire [ 7:0]  dig_seg,
    output wire [ 7:0]  dig_seg1,
    input  wire         rx,
    output wire         tx
);

    // ------------------------------------------------------------------
    // 时钟与复位
    // ------------------------------------------------------------------
`ifdef RUN_TRACE
    wire sys_clk = fpga_clk;
    wire sys_rst = fpga_rst;
`else
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
`endif

    // AXI 信号 (low-active reset for IP)
    wire sys_rstn = !sys_rst;

    // ------------------------------------------------------------------
    // CPU AXI Master 接口
    // ------------------------------------------------------------------
    wire [31:0]  cpu_awaddr;
    wire [ 7:0]  cpu_awlen;
    wire [ 2:0]  cpu_awsize;
    wire [ 1:0]  cpu_awburst;
    wire         cpu_awvalid, cpu_awready;
    wire [31:0]  cpu_wdata;
    wire [ 3:0]  cpu_wstrb;
    wire         cpu_wlast, cpu_wvalid, cpu_wready;
    wire         cpu_bready;
    wire [ 1:0]  cpu_bresp;
    wire         cpu_bvalid;
    wire [31:0]  cpu_araddr;
    wire [ 7:0]  cpu_arlen;
    wire [ 2:0]  cpu_arsize;
    wire [ 1:0]  cpu_arburst;
    wire         cpu_arvalid, cpu_arready;
    wire [31:0]  cpu_rdata;
    wire         cpu_rready;
    wire [ 1:0]  cpu_rresp;
    wire         cpu_rlast, cpu_rvalid;

    cpu_top_axi U_cpu (
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

    // ------------------------------------------------------------------
    // AXI Crossbar IP — 1 Master → 6 Slaves
    // ------------------------------------------------------------------
    // Slave 0: Memory (AXI4)
    wire [31:0]  s0_awaddr, s0_araddr;
    wire [ 7:0]  s0_awlen,  s0_arlen;
    wire [ 2:0]  s0_awsize, s0_arsize;
    wire [ 1:0]  s0_awburst, s0_arburst;
    wire         s0_awvalid, s0_awready, s0_arvalid, s0_arready;
    wire [31:0]  s0_wdata;
    wire [ 3:0]  s0_wstrb;
    wire         s0_wlast, s0_wvalid, s0_wready;
    wire         s0_bready, s0_bvalid;
    wire [ 1:0]  s0_bresp;
    wire [31:0]  s0_rdata;
    wire         s0_rready, s0_rvalid;
    wire [ 1:0]  s0_rresp;
    wire         s0_rlast;

    // Slave 1-5: Peripherals (AXI4)
    wire [31:0]  sN_awaddr   [1:5];
    wire [ 7:0]  sN_awlen    [1:5];
    wire [ 2:0]  sN_awsize   [1:5];
    wire [ 1:0]  sN_awburst  [1:5];
    wire         sN_awvalid  [1:5], sN_awready [1:5];
    wire [31:0]  sN_wdata    [1:5];
    wire [ 3:0]  sN_wstrb    [1:5];
    wire         sN_wlast    [1:5], sN_wvalid  [1:5], sN_wready [1:5];
    wire         sN_bvalid   [1:5], sN_bready  [1:5];
    wire [ 1:0]  sN_bresp    [1:5];
    wire [31:0]  sN_araddr   [1:5];
    wire [ 7:0]  sN_arlen    [1:5];
    wire [ 2:0]  sN_arsize   [1:5];
    wire [ 1:0]  sN_arburst  [1:5];
    wire         sN_arvalid  [1:5], sN_arready [1:5];
    wire [31:0]  sN_rdata    [1:5];
    wire         sN_rvalid   [1:5], sN_rready  [1:5];
    wire [ 1:0]  sN_rresp    [1:5];
    wire         sN_rlast    [1:5];

    axi_crossbar_0 U_crossbar (
        .aclk          (sys_clk),
        .aresetn       (sys_rstn),

        // S00_AXI: Master (from CPU)
        .s_axi_awaddr  (cpu_awaddr),  .s_axi_awlen  (cpu_awlen),
        .s_axi_awsize  (cpu_awsize),  .s_axi_awburst(cpu_awburst),
        .s_axi_awvalid (cpu_awvalid), .s_axi_awready(cpu_awready),
        .s_axi_awlock  (1'b0),        .s_axi_awcache(4'h0),
        .s_axi_awprot  (3'h0),        .s_axi_awqos  (4'h0),
        .s_axi_wdata   (cpu_wdata),   .s_axi_wstrb  (cpu_wstrb),
        .s_axi_wlast   (cpu_wlast),   .s_axi_wvalid (cpu_wvalid),
        .s_axi_wready  (cpu_wready),
        .s_axi_bready  (cpu_bready),  .s_axi_bresp  (cpu_bresp),
        .s_axi_bvalid  (cpu_bvalid),
        .s_axi_araddr  (cpu_araddr),  .s_axi_arlen  (cpu_arlen),
        .s_axi_arsize  (cpu_arsize),  .s_axi_arburst(cpu_arburst),
        .s_axi_arvalid (cpu_arvalid), .s_axi_arready(cpu_arready),
        .s_axi_arlock  (1'b0),        .s_axi_arcache(4'h0),
        .s_axi_arprot  (3'h0),        .s_axi_arqos  (4'h0),
        .s_axi_rdata   (cpu_rdata),   .s_axi_rresp  (cpu_rresp),
        .s_axi_rlast   (cpu_rlast),   .s_axi_rvalid (cpu_rvalid),
        .s_axi_rready  (cpu_rready),

        // M00_AXI → Slave 0: Memory (AXI4)
        .m_axi_awaddr  ({sN_awaddr[5],   sN_awaddr[4],   sN_awaddr[3],
                          sN_awaddr[2],   sN_awaddr[1],   s0_awaddr}),
        .m_axi_awlen   ({sN_awlen[5],    sN_awlen[4],    sN_awlen[3],
                          sN_awlen[2],    sN_awlen[1],    s0_awlen}),
        .m_axi_awsize  ({sN_awsize[5],   sN_awsize[4],   sN_awsize[3],
                          sN_awsize[2],   sN_awsize[1],   s0_awsize}),
        .m_axi_awburst ({sN_awburst[5],  sN_awburst[4],  sN_awburst[3],
                          sN_awburst[2],  sN_awburst[1],  s0_awburst}),
        .m_axi_awvalid ({sN_awvalid[5],  sN_awvalid[4],  sN_awvalid[3],
                          sN_awvalid[2],  sN_awvalid[1],  s0_awvalid}),
        .m_axi_awready ({sN_awready[5],  sN_awready[4],  sN_awready[3],
                          sN_awready[2],  sN_awready[1],  s0_awready}),
        .m_axi_wdata   ({sN_wdata[5],    sN_wdata[4],    sN_wdata[3],
                          sN_wdata[2],    sN_wdata[1],    s0_wdata}),
        .m_axi_wstrb   ({sN_wstrb[5],    sN_wstrb[4],    sN_wstrb[3],
                          sN_wstrb[2],    sN_wstrb[1],    s0_wstrb}),
        .m_axi_wlast   ({sN_wlast[5],    sN_wlast[4],    sN_wlast[3],
                          sN_wlast[2],    sN_wlast[1],    s0_wlast}),
        .m_axi_wvalid  ({sN_wvalid[5],   sN_wvalid[4],   sN_wvalid[3],
                          sN_wvalid[2],   sN_wvalid[1],   s0_wvalid}),
        .m_axi_wready  ({sN_wready[5],   sN_wready[4],   sN_wready[3],
                          sN_wready[2],   sN_wready[1],   s0_wready}),
        .m_axi_bresp   ({sN_bresp[5],    sN_bresp[4],    sN_bresp[3],
                          sN_bresp[2],    sN_bresp[1],    s0_bresp}),
        .m_axi_bvalid  ({sN_bvalid[5],   sN_bvalid[4],   sN_bvalid[3],
                          sN_bvalid[2],   sN_bvalid[1],   s0_bvalid}),
        .m_axi_bready  ({sN_bready[5],   sN_bready[4],   sN_bready[3],
                          sN_bready[2],   sN_bready[1],   s0_bready}),
        .m_axi_araddr  ({sN_araddr[5],   sN_araddr[4],   sN_araddr[3],
                          sN_araddr[2],   sN_araddr[1],   s0_araddr}),
        .m_axi_arlen   ({sN_arlen[5],    sN_arlen[4],    sN_arlen[3],
                          sN_arlen[2],    sN_arlen[1],    s0_arlen}),
        .m_axi_arsize  ({sN_arsize[5],   sN_arsize[4],   sN_arsize[3],
                          sN_arsize[2],   sN_arsize[1],   s0_arsize}),
        .m_axi_arburst ({sN_arburst[5],  sN_arburst[4],  sN_arburst[3],
                          sN_arburst[2],  sN_arburst[1],  s0_arburst}),
        .m_axi_arvalid ({sN_arvalid[5],  sN_arvalid[4],  sN_arvalid[3],
                          sN_arvalid[2],  sN_arvalid[1],  s0_arvalid}),
        .m_axi_arready ({sN_arready[5],  sN_arready[4],  sN_arready[3],
                          sN_arready[2],  sN_arready[1],  s0_arready}),
        .m_axi_rdata   ({sN_rdata[5],    sN_rdata[4],    sN_rdata[3],
                          sN_rdata[2],    sN_rdata[1],    s0_rdata}),
        .m_axi_rresp   ({sN_rresp[5],    sN_rresp[4],    sN_rresp[3],
                          sN_rresp[2],    sN_rresp[1],    s0_rresp}),
        .m_axi_rlast   ({sN_rlast[5],    sN_rlast[4],    sN_rlast[3],
                          sN_rlast[2],    sN_rlast[1],    s0_rlast}),
        .m_axi_rvalid  ({sN_rvalid[5],   sN_rvalid[4],   sN_rvalid[3],
                          sN_rvalid[2],   sN_rvalid[1],   s0_rvalid}),
        .m_axi_rready  ({sN_rready[5],   sN_rready[4],   sN_rready[3],
                          sN_rready[2],   sN_rready[1],   s0_rready})
    );

    // ------------------------------------------------------------------
    // Slave 0: BRAM 主存 (128KB, 可综合)
    // ------------------------------------------------------------------
    bram_axi_synth #(
        .DATA_WIDTH (32),
        .DATA_DEPTH (32768),
        .MEM_HEX    ("program.hex")
    ) U_bram (
        .s_aclk         (sys_clk),
        .s_aresetn      (sys_rstn),
        .s_axi_awaddr   (s0_awaddr),
        .s_axi_awlen    (s0_awlen),
        .s_axi_awsize   (s0_awsize),
        .s_axi_awburst  (s0_awburst),
        .s_axi_awvalid  (s0_awvalid),
        .s_axi_awready  (s0_awready),
        .s_axi_wdata    (s0_wdata),
        .s_axi_wstrb    (s0_wstrb),
        .s_axi_wlast    (s0_wlast),
        .s_axi_wvalid   (s0_wvalid),
        .s_axi_wready   (s0_wready),
        .s_axi_bready   (s0_bready),
        .s_axi_bresp    (s0_bresp),
        .s_axi_bvalid   (s0_bvalid),
        .s_axi_araddr   (s0_araddr),
        .s_axi_arlen    (s0_arlen),
        .s_axi_arsize   (s0_arsize),
        .s_axi_arburst  (s0_arburst),
        .s_axi_arvalid  (s0_arvalid),
        .s_axi_arready  (s0_arready),
        .s_axi_rdata    (s0_rdata),
        .s_axi_rready   (s0_rready),
        .s_axi_rresp    (s0_rresp),
        .s_axi_rlast    (s0_rlast),
        .s_axi_rvalid   (s0_rvalid)
    );

    // ------------------------------------------------------------------
    // Slave 1: Switch (AXI GPIO IP)
    // ------------------------------------------------------------------
    switch_wrap_ip U_switch (
        .aclk          (sys_clk),
        .aresetn       (sys_rstn),
        .s_axi_awaddr  (sN_awaddr[1]),  .s_axi_awlen  (sN_awlen[1]),
        .s_axi_awsize  (sN_awsize[1]), .s_axi_awburst(sN_awburst[1]),
        .s_axi_awvalid (sN_awvalid[1]), .s_axi_awready(sN_awready[1]),
        .s_axi_wdata   (sN_wdata[1]),   .s_axi_wstrb  (sN_wstrb[1]),
        .s_axi_wlast   (sN_wlast[1]),  .s_axi_wvalid (sN_wvalid[1]),
        .s_axi_wready  (sN_wready[1]),
        .s_axi_bresp   (sN_bresp[1]),   .s_axi_bvalid (sN_bvalid[1]),
        .s_axi_bready  (sN_bready[1]),
        .s_axi_araddr  (sN_araddr[1]),  .s_axi_arlen  (sN_arlen[1]),
        .s_axi_arsize  (sN_arsize[1]), .s_axi_arburst(sN_arburst[1]),
        .s_axi_arvalid (sN_arvalid[1]), .s_axi_arready(sN_arready[1]),
        .s_axi_rdata   (sN_rdata[1]),   .s_axi_rresp  (sN_rresp[1]),
        .s_axi_rlast   (sN_rlast[1]),   .s_axi_rvalid (sN_rvalid[1]),
        .s_axi_rready  (sN_rready[1]),
        .sw            (sw)
    );

    // ------------------------------------------------------------------
    // Slave 2: LED (AXI GPIO IP)
    // ------------------------------------------------------------------
    led_wrap_ip U_led (
        .aclk          (sys_clk),
        .aresetn       (sys_rstn),
        .s_axi_awaddr  (sN_awaddr[2]),  .s_axi_awlen  (8'h0),
        .s_axi_awsize  (3'h2),         .s_axi_awburst(2'h0),
        .s_axi_awvalid (sN_awvalid[2]), .s_axi_awready(sN_awready[2]),
        .s_axi_wdata   (sN_wdata[2]),   .s_axi_wstrb  (sN_wstrb[2]),
        .s_axi_wlast   (sN_wlast[2]),  .s_axi_wvalid (sN_wvalid[2]),
        .s_axi_wready  (sN_wready[2]),
        .s_axi_bresp   (sN_bresp[2]),   .s_axi_bvalid (sN_bvalid[2]),
        .s_axi_bready  (sN_bready[2]),
        .s_axi_araddr  (sN_araddr[2]),  .s_axi_arlen  (sN_arlen[2]),
        .s_axi_arsize  (sN_arsize[2]), .s_axi_arburst(sN_arburst[2]),
        .s_axi_arvalid (sN_arvalid[2]), .s_axi_arready(sN_arready[2]),
        .s_axi_rdata   (sN_rdata[2]),   .s_axi_rresp  (sN_rresp[2]),
        .s_axi_rlast   (sN_rlast[2]),   .s_axi_rvalid (sN_rvalid[2]),
        .s_axi_rready  (sN_rready[2]),
        .led           (led)
    );

    // ------------------------------------------------------------------
    // Slave 3: DigLED (AXI GPIO IP dual-channel)
    // ------------------------------------------------------------------
    digled_wrap_ip U_digled (
        .aclk          (sys_clk),
        .aresetn       (sys_rstn),
        .s_axi_awaddr  (sN_awaddr[3]),  .s_axi_awlen  (8'h0),
        .s_axi_awsize  (3'h2),         .s_axi_awburst(2'h0),
        .s_axi_awvalid (sN_awvalid[3]), .s_axi_awready(sN_awready[3]),
        .s_axi_wdata   (sN_wdata[3]),   .s_axi_wstrb  (sN_wstrb[3]),
        .s_axi_wlast   (sN_wlast[3]),  .s_axi_wvalid (sN_wvalid[3]),
        .s_axi_wready  (sN_wready[3]),
        .s_axi_bresp   (sN_bresp[3]),   .s_axi_bvalid (sN_bvalid[3]),
        .s_axi_bready  (sN_bready[3]),
        .s_axi_araddr  (sN_araddr[3]),  .s_axi_arlen  (sN_arlen[3]),
        .s_axi_arsize  (sN_arsize[3]), .s_axi_arburst(sN_arburst[3]),
        .s_axi_arvalid (sN_arvalid[3]), .s_axi_arready(sN_arready[3]),
        .s_axi_rdata   (sN_rdata[3]),   .s_axi_rresp  (sN_rresp[3]),
        .s_axi_rlast   (sN_rlast[3]),   .s_axi_rvalid (sN_rvalid[3]),
        .s_axi_rready  (sN_rready[3]),
        .dig_en        (dig_en),
        .dig_seg       (dig_seg)
    );
    assign dig_seg1 = dig_seg;

    // ------------------------------------------------------------------
    // Slave 4: UART (AXI Uartlite IP)
    // ------------------------------------------------------------------
    uart_wrap_ip U_uart (
        .aclk          (sys_clk),
        .aresetn       (sys_rstn),
        .s_axi_awaddr  (sN_awaddr[4]),  .s_axi_awlen  (8'h0),
        .s_axi_awsize  (3'h2),         .s_axi_awburst(2'h0),
        .s_axi_awvalid (sN_awvalid[4]), .s_axi_awready(sN_awready[4]),
        .s_axi_wdata   (sN_wdata[4]),   .s_axi_wstrb  (sN_wstrb[4]),
        .s_axi_wlast   (sN_wlast[4]),  .s_axi_wvalid (sN_wvalid[4]),
        .s_axi_wready  (sN_wready[4]),
        .s_axi_bresp   (sN_bresp[4]),   .s_axi_bvalid (sN_bvalid[4]),
        .s_axi_bready  (sN_bready[4]),
        .s_axi_araddr  (sN_araddr[4]),  .s_axi_arlen  (sN_arlen[4]),
        .s_axi_arsize  (sN_arsize[4]), .s_axi_arburst(sN_arburst[4]),
        .s_axi_arvalid (sN_arvalid[4]), .s_axi_arready(sN_arready[4]),
        .s_axi_rdata   (sN_rdata[4]),   .s_axi_rresp  (sN_rresp[4]),
        .s_axi_rlast   (sN_rlast[4]),   .s_axi_rvalid (sN_rvalid[4]),
        .s_axi_rready  (sN_rready[4]),
        .rx            (rx),
        .tx            (tx)
    );

    // ------------------------------------------------------------------
    // Slave 5: Timer (AXI GPIO IP dual-channel)
    // ------------------------------------------------------------------
    timer_wrap_ip U_timer (
        .aclk          (sys_clk),
        .aresetn       (sys_rstn),
        .s_axi_awaddr  (sN_awaddr[5]),  .s_axi_awlen  (8'h0),
        .s_axi_awsize  (3'h2),         .s_axi_awburst(2'h0),
        .s_axi_awvalid (sN_awvalid[5]), .s_axi_awready(sN_awready[5]),
        .s_axi_wdata   (sN_wdata[5]),   .s_axi_wstrb  (sN_wstrb[5]),
        .s_axi_wlast   (sN_wlast[5]),  .s_axi_wvalid (sN_wvalid[5]),
        .s_axi_wready  (sN_wready[5]),
        .s_axi_bresp   (sN_bresp[5]),   .s_axi_bvalid (sN_bvalid[5]),
        .s_axi_bready  (sN_bready[5]),
        .s_axi_araddr  (sN_araddr[5]),  .s_axi_arlen  (sN_arlen[5]),
        .s_axi_arsize  (sN_arsize[5]), .s_axi_arburst(sN_arburst[5]),
        .s_axi_arvalid (sN_arvalid[5]), .s_axi_arready(sN_arready[5]),
        .s_axi_rdata   (sN_rdata[5]),   .s_axi_rresp  (sN_rresp[5]),
        .s_axi_rlast   (sN_rlast[5]),   .s_axi_rvalid (sN_rvalid[5]),
        .s_axi_rready  (sN_rready[5])
    );

endmodule