`timescale 1ns / 1ps

`include "defines.vh"

module miniRV_SoC(
    input  wire         fpga_clk,
    input  wire         fpga_rst,   // Low Active
    input  wire [15:0]  sw,
    output wire [15:0]  led,
    output wire [ 7:0]  dig_en,
    output wire [ 7:0]  dig_seg,    // {CA, CB, ..., CG, DP}
    output wire [ 7:0]  dig_seg1,
    input  wire         rx,
    output wire         tx,

    // AXI4 Memory Interface (to MIG / bram_axi)
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

`ifdef USE_AXI
    // ========================================================================
    // AXI SoC 模式: cpu_top_axi → axi_crossbar → 6 slaves
    // ========================================================================

    // ------ Master AXI (cpu_top_axi → crossbar) ------
    wire [31:0]  m_axi_awaddr;
    wire [ 7:0]  m_axi_awlen;
    wire [ 2:0]  m_axi_awsize;
    wire [ 1:0]  m_axi_awburst;
    wire         m_axi_awvalid;
    wire         m_axi_awready;
    wire [31:0]  m_axi_wdata;
    wire [ 3:0]  m_axi_wstrb;
    wire         m_axi_wlast;
    wire         m_axi_wvalid;
    wire         m_axi_wready;
    wire         m_axi_bready;
    wire [ 1:0]  m_axi_bresp;
    wire         m_axi_bvalid;
    wire [31:0]  m_axi_araddr;
    wire [ 7:0]  m_axi_arlen;
    wire [ 2:0]  m_axi_arsize;
    wire [ 1:0]  m_axi_arburst;
    wire         m_axi_arvalid;
    wire         m_axi_arready;
    wire [31:0]  m_axi_rdata;
    wire         m_axi_rready;
    wire [ 1:0]  m_axi_rresp;
    wire         m_axi_rlast;
    wire         m_axi_rvalid;

    // ------ Slave 0: Memory (crossbar → MIG / bram_axi) ------
    wire [31:0]  s0_axi_awaddr;
    wire [ 7:0]  s0_axi_awlen;
    wire [ 2:0]  s0_axi_awsize;
    wire [ 1:0]  s0_axi_awburst;
    wire         s0_axi_awvalid;
    wire         s0_axi_awready;
    wire [31:0]  s0_axi_wdata;
    wire [ 3:0]  s0_axi_wstrb;
    wire         s0_axi_wlast;
    wire         s0_axi_wvalid;
    wire         s0_axi_wready;
    wire         s0_axi_bready;
    wire [ 1:0]  s0_axi_bresp;
    wire         s0_axi_bvalid;
    wire [31:0]  s0_axi_araddr;
    wire [ 7:0]  s0_axi_arlen;
    wire [ 2:0]  s0_axi_arsize;
    wire [ 1:0]  s0_axi_arburst;
    wire         s0_axi_arvalid;
    wire         s0_axi_arready;
    wire [31:0]  s0_axi_rdata;
    wire         s0_axi_rready;
    wire [ 1:0]  s0_axi_rresp;
    wire         s0_axi_rlast;
    wire         s0_axi_rvalid;

    // ------ Slaves 1-5: Peripherals ------
    // Slave 1: Switch
    wire [31:0]  s1_axi_awaddr,  s1_axi_wdata,  s1_axi_araddr,  s1_axi_rdata;
    wire         s1_axi_awvalid, s1_axi_awready;
    wire [ 3:0]  s1_axi_wstrb;
    wire         s1_axi_wvalid,  s1_axi_wready;
    wire         s1_axi_bvalid,  s1_axi_bready;
    wire         s1_axi_arvalid, s1_axi_arready;
    wire         s1_axi_rvalid,  s1_axi_rready;

    // Slave 2: LED
    wire [31:0]  s2_axi_awaddr,  s2_axi_wdata,  s2_axi_araddr,  s2_axi_rdata;
    wire         s2_axi_awvalid, s2_axi_awready;
    wire [ 3:0]  s2_axi_wstrb;
    wire         s2_axi_wvalid,  s2_axi_wready;
    wire         s2_axi_bvalid,  s2_axi_bready;
    wire         s2_axi_arvalid, s2_axi_arready;
    wire         s2_axi_rvalid,  s2_axi_rready;

    // Slave 3: DigLED
    wire [31:0]  s3_axi_awaddr,  s3_axi_wdata,  s3_axi_araddr,  s3_axi_rdata;
    wire         s3_axi_awvalid, s3_axi_awready;
    wire [ 3:0]  s3_axi_wstrb;
    wire         s3_axi_wvalid,  s3_axi_wready;
    wire         s3_axi_bvalid,  s3_axi_bready;
    wire         s3_axi_arvalid, s3_axi_arready;
    wire         s3_axi_rvalid,  s3_axi_rready;

    // Slave 4: UART
    wire [31:0]  s4_axi_awaddr,  s4_axi_wdata,  s4_axi_araddr,  s4_axi_rdata;
    wire         s4_axi_awvalid, s4_axi_awready;
    wire [ 3:0]  s4_axi_wstrb;
    wire         s4_axi_wvalid,  s4_axi_wready;
    wire         s4_axi_bvalid,  s4_axi_bready;
    wire         s4_axi_arvalid, s4_axi_arready;
    wire         s4_axi_rvalid,  s4_axi_rready;

    // Slave 5: Timer
    wire [31:0]  s5_axi_awaddr,  s5_axi_wdata,  s5_axi_araddr,  s5_axi_rdata;
    wire         s5_axi_awvalid, s5_axi_awready;
    wire [ 3:0]  s5_axi_wstrb;
    wire         s5_axi_wvalid,  s5_axi_wready;
    wire         s5_axi_bvalid,  s5_axi_bready;
    wire         s5_axi_arvalid, s5_axi_arready;
    wire         s5_axi_rvalid,  s5_axi_rready;

    // ------ CPU + Cache + AXI Master ------
    cpu_top_axi U_cpu (
        .cpu_clk        (sys_clk),
        .cpu_rst        (sys_rst),
        .m_axi_awaddr   (m_axi_awaddr),
        .m_axi_awlen    (m_axi_awlen),
        .m_axi_awsize   (m_axi_awsize),
        .m_axi_awburst  (m_axi_awburst),
        .m_axi_awready  (m_axi_awready),
        .m_axi_awvalid  (m_axi_awvalid),
        .m_axi_wdata    (m_axi_wdata),
        .m_axi_wready   (m_axi_wready),
        .m_axi_wstrb    (m_axi_wstrb),
        .m_axi_wlast    (m_axi_wlast),
        .m_axi_wvalid   (m_axi_wvalid),
        .m_axi_bready   (m_axi_bready),
        .m_axi_bresp    (m_axi_bresp),
        .m_axi_bvalid   (m_axi_bvalid),
        .m_axi_araddr   (m_axi_araddr),
        .m_axi_arlen    (m_axi_arlen),
        .m_axi_arsize   (m_axi_arsize),
        .m_axi_arburst  (m_axi_arburst),
        .m_axi_arready  (m_axi_arready),
        .m_axi_arvalid  (m_axi_arvalid),
        .m_axi_rdata    (m_axi_rdata),
        .m_axi_rready   (m_axi_rready),
        .m_axi_rresp    (m_axi_rresp),
        .m_axi_rlast    (m_axi_rlast),
        .m_axi_rvalid   (m_axi_rvalid)
    );

    // ------ AXI Crossbar ------
    axi_crossbar U_crossbar (
        .aclk           (sys_clk),
        .areset         (sys_rst),

        // Master
        .s_axi_awaddr   (m_axi_awaddr),
        .s_axi_awlen    (m_axi_awlen),
        .s_axi_awsize   (m_axi_awsize),
        .s_axi_awburst  (m_axi_awburst),
        .s_axi_awvalid  (m_axi_awvalid),
        .s_axi_awready  (m_axi_awready),
        .s_axi_wdata    (m_axi_wdata),
        .s_axi_wstrb    (m_axi_wstrb),
        .s_axi_wlast    (m_axi_wlast),
        .s_axi_wvalid   (m_axi_wvalid),
        .s_axi_wready   (m_axi_wready),
        .s_axi_bready   (m_axi_bready),
        .s_axi_bresp    (m_axi_bresp),
        .s_axi_bvalid   (m_axi_bvalid),
        .s_axi_araddr   (m_axi_araddr),
        .s_axi_arlen    (m_axi_arlen),
        .s_axi_arsize   (m_axi_arsize),
        .s_axi_arburst  (m_axi_arburst),
        .s_axi_arvalid  (m_axi_arvalid),
        .s_axi_arready  (m_axi_arready),
        .s_axi_rdata    (m_axi_rdata),
        .s_axi_rready   (m_axi_rready),
        .s_axi_rresp    (m_axi_rresp),
        .s_axi_rlast    (m_axi_rlast),
        .s_axi_rvalid   (m_axi_rvalid),

        // Slave 0: Memory
        .m0_axi_awaddr  (s0_axi_awaddr),
        .m0_axi_awlen   (s0_axi_awlen),
        .m0_axi_awsize  (s0_axi_awsize),
        .m0_axi_awburst (s0_axi_awburst),
        .m0_axi_awvalid (s0_axi_awvalid),
        .m0_axi_awready (s0_axi_awready),
        .m0_axi_wdata   (s0_axi_wdata),
        .m0_axi_wstrb   (s0_axi_wstrb),
        .m0_axi_wlast   (s0_axi_wlast),
        .m0_axi_wvalid  (s0_axi_wvalid),
        .m0_axi_wready  (s0_axi_wready),
        .m0_axi_bready  (s0_axi_bready),
        .m0_axi_bresp   (s0_axi_bresp),
        .m0_axi_bvalid  (s0_axi_bvalid),
        .m0_axi_araddr  (s0_axi_araddr),
        .m0_axi_arlen   (s0_axi_arlen),
        .m0_axi_arsize  (s0_axi_arsize),
        .m0_axi_arburst (s0_axi_arburst),
        .m0_axi_arvalid (s0_axi_arvalid),
        .m0_axi_arready (s0_axi_arready),
        .m0_axi_rdata   (s0_axi_rdata),
        .m0_axi_rready  (s0_axi_rready),
        .m0_axi_rresp   (s0_axi_rresp),
        .m0_axi_rlast   (s0_axi_rlast),
        .m0_axi_rvalid  (s0_axi_rvalid),

        // Slave 1: Switch
        .m1_axi_awaddr  (s1_axi_awaddr),
        .m1_axi_awvalid (s1_axi_awvalid),
        .m1_axi_awready (s1_axi_awready),
        .m1_axi_wdata   (s1_axi_wdata),
        .m1_axi_wstrb   (s1_axi_wstrb),
        .m1_axi_wvalid  (s1_axi_wvalid),
        .m1_axi_wready  (s1_axi_wready),
        .m1_axi_bvalid  (s1_axi_bvalid),
        .m1_axi_bready  (s1_axi_bready),
        .m1_axi_araddr  (s1_axi_araddr),
        .m1_axi_arvalid (s1_axi_arvalid),
        .m1_axi_arready (s1_axi_arready),
        .m1_axi_rdata   (s1_axi_rdata),
        .m1_axi_rvalid  (s1_axi_rvalid),
        .m1_axi_rready  (s1_axi_rready),

        // Slave 2: LED
        .m2_axi_awaddr  (s2_axi_awaddr),
        .m2_axi_awvalid (s2_axi_awvalid),
        .m2_axi_awready (s2_axi_awready),
        .m2_axi_wdata   (s2_axi_wdata),
        .m2_axi_wstrb   (s2_axi_wstrb),
        .m2_axi_wvalid  (s2_axi_wvalid),
        .m2_axi_wready  (s2_axi_wready),
        .m2_axi_bvalid  (s2_axi_bvalid),
        .m2_axi_bready  (s2_axi_bready),
        .m2_axi_araddr  (s2_axi_araddr),
        .m2_axi_arvalid (s2_axi_arvalid),
        .m2_axi_arready (s2_axi_arready),
        .m2_axi_rdata   (s2_axi_rdata),
        .m2_axi_rvalid  (s2_axi_rvalid),
        .m2_axi_rready  (s2_axi_rready),

        // Slave 3: DigLED
        .m3_axi_awaddr  (s3_axi_awaddr),
        .m3_axi_awvalid (s3_axi_awvalid),
        .m3_axi_awready (s3_axi_awready),
        .m3_axi_wdata   (s3_axi_wdata),
        .m3_axi_wstrb   (s3_axi_wstrb),
        .m3_axi_wvalid  (s3_axi_wvalid),
        .m3_axi_wready  (s3_axi_wready),
        .m3_axi_bvalid  (s3_axi_bvalid),
        .m3_axi_bready  (s3_axi_bready),
        .m3_axi_araddr  (s3_axi_araddr),
        .m3_axi_arvalid (s3_axi_arvalid),
        .m3_axi_arready (s3_axi_arready),
        .m3_axi_rdata   (s3_axi_rdata),
        .m3_axi_rvalid  (s3_axi_rvalid),
        .m3_axi_rready  (s3_axi_rready),

        // Slave 4: UART
        .m4_axi_awaddr  (s4_axi_awaddr),
        .m4_axi_awvalid (s4_axi_awvalid),
        .m4_axi_awready (s4_axi_awready),
        .m4_axi_wdata   (s4_axi_wdata),
        .m4_axi_wstrb   (s4_axi_wstrb),
        .m4_axi_wvalid  (s4_axi_wvalid),
        .m4_axi_wready  (s4_axi_wready),
        .m4_axi_bvalid  (s4_axi_bvalid),
        .m4_axi_bready  (s4_axi_bready),
        .m4_axi_araddr  (s4_axi_araddr),
        .m4_axi_arvalid (s4_axi_arvalid),
        .m4_axi_arready (s4_axi_arready),
        .m4_axi_rdata   (s4_axi_rdata),
        .m4_axi_rvalid  (s4_axi_rvalid),
        .m4_axi_rready  (s4_axi_rready),

        // Slave 5: Timer
        .m5_axi_awaddr  (s5_axi_awaddr),
        .m5_axi_awvalid (s5_axi_awvalid),
        .m5_axi_awready (s5_axi_awready),
        .m5_axi_wdata   (s5_axi_wdata),
        .m5_axi_wstrb   (s5_axi_wstrb),
        .m5_axi_wvalid  (s5_axi_wvalid),
        .m5_axi_wready  (s5_axi_wready),
        .m5_axi_bvalid  (s5_axi_bvalid),
        .m5_axi_bready  (s5_axi_bready),
        .m5_axi_araddr  (s5_axi_araddr),
        .m5_axi_arvalid (s5_axi_arvalid),
        .m5_axi_arready (s5_axi_arready),
        .m5_axi_rdata   (s5_axi_rdata),
        .m5_axi_rvalid  (s5_axi_rvalid),
        .m5_axi_rready  (s5_axi_rready)
    );

    // ------ Memory AXI port → top-level ------
    assign mem_axi_awaddr  = s0_axi_awaddr;
    assign mem_axi_awlen   = s0_axi_awlen;
    assign mem_axi_awsize  = s0_axi_awsize;
    assign mem_axi_awburst = s0_axi_awburst;
    assign mem_axi_awvalid = s0_axi_awvalid;
    assign mem_axi_wdata   = s0_axi_wdata;
    assign mem_axi_wstrb   = s0_axi_wstrb;
    assign mem_axi_wlast   = s0_axi_wlast;
    assign mem_axi_wvalid  = s0_axi_wvalid;
    assign mem_axi_bready  = s0_axi_bready;
    assign mem_axi_araddr  = s0_axi_araddr;
    assign mem_axi_arlen   = s0_axi_arlen;
    assign mem_axi_arsize  = s0_axi_arsize;
    assign mem_axi_arburst = s0_axi_arburst;
    assign mem_axi_arvalid = s0_axi_arvalid;
    assign mem_axi_rready  = s0_axi_rready;
    assign s0_axi_awready  = mem_axi_awready;
    assign s0_axi_wready   = mem_axi_wready;
    assign s0_axi_bresp    = mem_axi_bresp;
    assign s0_axi_bvalid   = mem_axi_bvalid;
    assign s0_axi_arready  = mem_axi_arready;
    assign s0_axi_rdata    = mem_axi_rdata;
    assign s0_axi_rresp    = mem_axi_rresp;
    assign s0_axi_rlast    = mem_axi_rlast;
    assign s0_axi_rvalid   = mem_axi_rvalid;

    // ------ Peripheral: Switch ------
    switch_wrap U_switch (
        .aclk       (sys_clk),
        .areset     (sys_rst),
        .awaddr     (s1_axi_awaddr),
        .awvalid    (s1_axi_awvalid),
        .awready    (s1_axi_awready),
        .wdata      (s1_axi_wdata),
        .wstrb      (s1_axi_wstrb),
        .wvalid     (s1_axi_wvalid),
        .wready     (s1_axi_wready),
        .bvalid     (s1_axi_bvalid),
        .bready     (s1_axi_bready),
        .araddr     (s1_axi_araddr),
        .arvalid    (s1_axi_arvalid),
        .arready    (s1_axi_arready),
        .rdata      (s1_axi_rdata),
        .rvalid     (s1_axi_rvalid),
        .rready     (s1_axi_rready),
        .sw         (sw)
    );

    // ------ Peripheral: LED ------
    led_wrap U_led (
        .aclk       (sys_clk),
        .areset     (sys_rst),
        .awaddr     (s2_axi_awaddr),
        .awvalid    (s2_axi_awvalid),
        .awready    (s2_axi_awready),
        .wdata      (s2_axi_wdata),
        .wstrb      (s2_axi_wstrb),
        .wvalid     (s2_axi_wvalid),
        .wready     (s2_axi_wready),
        .bvalid     (s2_axi_bvalid),
        .bready     (s2_axi_bready),
        .araddr     (s2_axi_araddr),
        .arvalid    (s2_axi_arvalid),
        .arready    (s2_axi_arready),
        .rdata      (s2_axi_rdata),
        .rvalid     (s2_axi_rvalid),
        .rready     (s2_axi_rready),
        .led        (led)
    );

    // ------ Peripheral: DigLED ------
    digled_wrap U_digled (
        .aclk       (sys_clk),
        .areset     (sys_rst),
        .awaddr     (s3_axi_awaddr),
        .awvalid    (s3_axi_awvalid),
        .awready    (s3_axi_awready),
        .wdata      (s3_axi_wdata),
        .wstrb      (s3_axi_wstrb),
        .wvalid     (s3_axi_wvalid),
        .wready     (s3_axi_wready),
        .bvalid     (s3_axi_bvalid),
        .bready     (s3_axi_bready),
        .araddr     (s3_axi_araddr),
        .arvalid    (s3_axi_arvalid),
        .arready    (s3_axi_arready),
        .rdata      (s3_axi_rdata),
        .rvalid     (s3_axi_rvalid),
        .rready     (s3_axi_rready),
        .dig_en     (dig_en),
        .dig_seg    (dig_seg)
    );

    assign dig_seg1 = dig_seg;

    // ------ Peripheral: UART ------
    uart_wrap #(
        .CLK_FREQ   (50_000_000),
        .BAUD       (115200)
    ) U_uart (
        .aclk       (sys_clk),
        .areset     (sys_rst),
        .awaddr     (s4_axi_awaddr),
        .awvalid    (s4_axi_awvalid),
        .awready    (s4_axi_awready),
        .wdata      (s4_axi_wdata),
        .wstrb      (s4_axi_wstrb),
        .wvalid     (s4_axi_wvalid),
        .wready     (s4_axi_wready),
        .bvalid     (s4_axi_bvalid),
        .bready     (s4_axi_bready),
        .araddr     (s4_axi_araddr),
        .arvalid    (s4_axi_arvalid),
        .arready    (s4_axi_arready),
        .rdata      (s4_axi_rdata),
        .rvalid     (s4_axi_rvalid),
        .rready     (s4_axi_rready),
        .rx         (rx),
        .tx         (tx)
    );

    // ------ Peripheral: Timer ------
    timer_wrap U_timer (
        .aclk       (sys_clk),
        .areset     (sys_rst),
        .awaddr     (s5_axi_awaddr),
        .awvalid    (s5_axi_awvalid),
        .awready    (s5_axi_awready),
        .wdata      (s5_axi_wdata),
        .wstrb      (s5_axi_wstrb),
        .wvalid     (s5_axi_wvalid),
        .wready     (s5_axi_wready),
        .bvalid     (s5_axi_bvalid),
        .bready     (s5_axi_bready),
        .araddr     (s5_axi_araddr),
        .arvalid    (s5_axi_arvalid),
        .arready    (s5_axi_arready),
        .rdata      (s5_axi_rdata),
        .rvalid     (s5_axi_rvalid),
        .rready     (s5_axi_rready)
    );

`else
    // ========================================================================
    // 基本模式: cpu_core 直连 Inst_ROM + Data_RAM
    // ========================================================================
    cpu_top U_cpu (
        .cpu_clk        (sys_clk),
        .cpu_rst        (sys_rst)
    );

    // Non-AXI: tie off memory port
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

    // Tie off peripheral outputs
    assign led     = 16'h0;
    assign dig_en  = 8'h0;
    assign dig_seg = 8'h0;
    assign dig_seg1 = 8'h0;
    assign tx      = 1'b1;
`endif

endmodule
