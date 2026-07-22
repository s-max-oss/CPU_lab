// ============================================================================
// timer_wrap_ip.v -- Timer peripheral (AXI4 -> AXI4-Lite + AXI GPIO)
// ============================================================================
// Address: 0xFFFF_4000, read-only 64-bit free-running counter
//   offset 0x0: counter[31:0]  low 32 bits  (GPIO channel 1)
//   offset 0x4: counter[63:32] high 32 bits (GPIO channel 2)
//
// Architecture (per Lab 2 B-6 spec):
//   AXI4 Slave (from crossbar) -> axi_protocol_converter_0 -> axi_gpio_0

`timescale 1ns / 1ps

module timer_wrap_ip (
    // AXI4 Slave (from AXI Crossbar)
    input  wire         aclk,
    input  wire         aresetn,         // Low Active

    input  wire [31:0]  s_axi_awaddr,
    input  wire [ 7:0]  s_axi_awlen,
    input  wire [ 2:0]  s_axi_awsize,
    input  wire [ 1:0]  s_axi_awburst,
    input  wire         s_axi_awvalid,
    output wire         s_axi_awready,
    input  wire [31:0]  s_axi_wdata,
    input  wire [ 3:0]  s_axi_wstrb,
    input  wire         s_axi_wlast,
    input  wire         s_axi_wvalid,
    output wire         s_axi_wready,
    output wire [ 1:0]  s_axi_bresp,
    output wire         s_axi_bvalid,
    input  wire         s_axi_bready,
    input  wire [31:0]  s_axi_araddr,
    input  wire [ 7:0]  s_axi_arlen,
    input  wire [ 2:0]  s_axi_arsize,
    input  wire [ 1:0]  s_axi_arburst,
    input  wire         s_axi_arvalid,
    output wire         s_axi_arready,
    output wire [31:0]  s_axi_rdata,
    output wire [ 1:0]  s_axi_rresp,
    output wire         s_axi_rlast,
    output wire         s_axi_rvalid,
    input  wire         s_axi_rready
);

    // ------------------------------------------------------------------
    // 64-bit free-running counter
    // ------------------------------------------------------------------
    reg [63:0] timer;
    always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) timer <= 64'h0;
        else          timer <= timer + 64'h1;
    end

    // ------------------------------------------------------------------
    // AXI Protocol Converter (AXI4 -> AXI4-Lite)
    // ------------------------------------------------------------------
    wire [31:0] tim_awaddr;
    wire        tim_awvalid, tim_awready;
    wire [31:0] tim_wdata;
    wire [ 3:0] tim_wstrb;
    wire        tim_wvalid, tim_wready;
    wire [ 1:0] tim_bresp;
    wire        tim_bvalid, tim_bready;
    wire [31:0] tim_araddr;
    wire        tim_arvalid, tim_arready;
    wire [31:0] tim_rdata;
    wire [ 1:0] tim_rresp;
    wire        tim_rvalid, tim_rready;

    axi_protocol_converter_0 U_timer_converter (
        .aclk          (aclk),
        .aresetn       (aresetn),

        // S_AXI: full AXI4 from crossbar
        .s_axi_awaddr  (s_axi_awaddr),
        .s_axi_awlen   (s_axi_awlen),
        .s_axi_awsize  (s_axi_awsize),
        .s_axi_awburst (s_axi_awburst),
        .s_axi_awlock  (1'b0),
        .s_axi_awcache (4'b0),
        .s_axi_awprot  (3'b0),
        .s_axi_awregion(4'b0),
        .s_axi_awqos   (4'b0),
        .s_axi_awvalid (s_axi_awvalid),
        .s_axi_awready (s_axi_awready),
        .s_axi_wdata   (s_axi_wdata),
        .s_axi_wstrb   (s_axi_wstrb),
        .s_axi_wlast   (s_axi_wlast),
        .s_axi_wvalid  (s_axi_wvalid),
        .s_axi_wready  (s_axi_wready),
        .s_axi_bresp   (s_axi_bresp),
        .s_axi_bvalid  (s_axi_bvalid),
        .s_axi_bready  (s_axi_bready),
        .s_axi_araddr  (s_axi_araddr),
        .s_axi_arlen   (s_axi_arlen),
        .s_axi_arsize  (s_axi_arsize),
        .s_axi_arburst (s_axi_arburst),
        .s_axi_arlock  (1'b0),
        .s_axi_arcache (4'b0),
        .s_axi_arprot  (3'b0),
        .s_axi_arregion(4'b0),
        .s_axi_arqos   (4'b0),
        .s_axi_arvalid (s_axi_arvalid),
        .s_axi_arready (s_axi_arready),
        .s_axi_rdata   (s_axi_rdata),
        .s_axi_rresp   (s_axi_rresp),
        .s_axi_rlast   (s_axi_rlast),
        .s_axi_rvalid  (s_axi_rvalid),
        .s_axi_rready  (s_axi_rready),

        // M_AXI: AXI4-Lite to GPIO IP
        .m_axi_awaddr  (tim_awaddr),
        .m_axi_awprot  (),
        .m_axi_awvalid (tim_awvalid),
        .m_axi_awready (tim_awready),
        .m_axi_wdata   (tim_wdata),
        .m_axi_wstrb   (tim_wstrb),
        .m_axi_wvalid  (tim_wvalid),
        .m_axi_wready  (tim_wready),
        .m_axi_bresp   (tim_bresp),
        .m_axi_bvalid  (tim_bvalid),
        .m_axi_bready  (tim_bready),
        .m_axi_araddr  (tim_araddr),
        .m_axi_arprot  (),
        .m_axi_arvalid (tim_arvalid),
        .m_axi_arready (tim_arready),
        .m_axi_rdata   (tim_rdata),
        .m_axi_rresp   (tim_rresp),
        .m_axi_rvalid  (tim_rvalid),
        .m_axi_rready  (tim_rready)
    );

    // ------------------------------------------------------------------
    // AXI GPIO IP -- Timer (2-channel, all inputs)
    // ------------------------------------------------------------------
    axi_gpio_0 U_timer (
        .s_axi_aclk    (aclk),
        .s_axi_aresetn (aresetn),
        .s_axi_awaddr  (tim_awaddr[8:0]),  // truncate to 9 bits
        .s_axi_awready (tim_awready),
        .s_axi_awvalid (tim_awvalid),
        .s_axi_wdata   (tim_wdata),
        .s_axi_wready  (tim_wready),
        .s_axi_wstrb   (tim_wstrb),
        .s_axi_wvalid  (tim_wvalid),
        .s_axi_bready  (tim_bready),
        .s_axi_bresp   (tim_bresp),
        .s_axi_bvalid  (tim_bvalid),
        .s_axi_araddr  (tim_araddr[8:0]),  // truncate to 9 bits
        .s_axi_arready (tim_arready),
        .s_axi_arvalid (tim_arvalid),
        .s_axi_rdata   (tim_rdata),
        .s_axi_rready  (tim_rready),
        .s_axi_rresp   (tim_rresp),
        .s_axi_rvalid  (tim_rvalid),
        .gpio2_io_i    (timer[63:32]),  // high 32 bits
        .gpio_io_i     (timer[31:0]),   // low 32 bits
        .gpio2_io_o    (),
        .gpio2_io_t    ()
    );

endmodule