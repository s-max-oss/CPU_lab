// ============================================================================
// digled_wrap_ip.v -- DigLED peripheral (AXI4 -> AXI4-Lite + AXI GPIO)
// ============================================================================
// Address: 0xFFFF_2000, write 8+8 bits
//   channel 1 = dig_en  (bit select)
//   channel 2 = dig_seg (segment select)

`timescale 1ns / 1ps

module digled_wrap_ip (
    input  wire         aclk,
    input  wire         aresetn,

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
    input  wire         s_axi_rready,

    output wire [ 7:0]  dig_en,
    output wire [ 7:0]  dig_seg
);

    wire [31:0] dig_awaddr;
    wire        dig_awvalid, dig_awready;
    wire [31:0] dig_wdata;
    wire [ 3:0] dig_wstrb;
    wire        dig_wvalid, dig_wready;
    wire [ 1:0] dig_bresp;
    wire        dig_bvalid, dig_bready;
    wire [31:0] dig_araddr;
    wire        dig_arvalid, dig_arready;
    wire [31:0] dig_rdata;
    wire [ 1:0] dig_rresp;
    wire        dig_rvalid, dig_rready;

    axi_protocol_converter_3 U_digled_converter (
        .aclk          (aclk),
        .aresetn       (aresetn),
        .s_axi_awaddr  (s_axi_awaddr), .s_axi_awlen  (s_axi_awlen),
        .s_axi_awsize  (s_axi_awsize), .s_axi_awburst(s_axi_awburst),
        .s_axi_awlock  (1'b0), .s_axi_awcache (4'b0),
        .s_axi_awprot  (3'b0), .s_axi_awregion(4'b0), .s_axi_awqos (4'b0),
        .s_axi_awvalid (s_axi_awvalid), .s_axi_awready(s_axi_awready),
        .s_axi_wdata   (s_axi_wdata),  .s_axi_wstrb  (s_axi_wstrb),
        .s_axi_wlast   (s_axi_wlast),  .s_axi_wvalid (s_axi_wvalid),
        .s_axi_wready  (s_axi_wready),
        .s_axi_bresp   (s_axi_bresp),  .s_axi_bvalid (s_axi_bvalid),
        .s_axi_bready  (s_axi_bready),
        .s_axi_araddr  (s_axi_araddr), .s_axi_arlen  (s_axi_arlen),
        .s_axi_arsize  (s_axi_arsize), .s_axi_arburst(s_axi_arburst),
        .s_axi_arlock  (1'b0), .s_axi_arcache (4'b0),
        .s_axi_arprot  (3'b0), .s_axi_arregion(4'b0), .s_axi_arqos (4'b0),
        .s_axi_arvalid (s_axi_arvalid), .s_axi_arready(s_axi_arready),
        .s_axi_rdata   (s_axi_rdata),  .s_axi_rresp  (s_axi_rresp),
        .s_axi_rlast   (s_axi_rlast),  .s_axi_rvalid (s_axi_rvalid),
        .s_axi_rready  (s_axi_rready),
        .m_axi_awaddr  (dig_awaddr),   .m_axi_awprot (),
        .m_axi_awvalid (dig_awvalid),  .m_axi_awready(dig_awready),
        .m_axi_wdata   (dig_wdata),    .m_axi_wstrb  (dig_wstrb),
        .m_axi_wvalid  (dig_wvalid),   .m_axi_wready (dig_wready),
        .m_axi_bresp   (dig_bresp),    .m_axi_bvalid (dig_bvalid),
        .m_axi_bready  (dig_bready),
        .m_axi_araddr  (dig_araddr),   .m_axi_arprot (),
        .m_axi_arvalid (dig_arvalid),  .m_axi_arready(dig_arready),
        .m_axi_rdata   (dig_rdata),    .m_axi_rresp  (dig_rresp),
        .m_axi_rvalid  (dig_rvalid),   .m_axi_rready (dig_rready)
    );

    axi_gpio_3 U_digled (
        .s_axi_aclk    (aclk),
        .s_axi_aresetn (aresetn),
        .s_axi_awaddr  (dig_awaddr[8:0]),
        .s_axi_awready (dig_awready),
        .s_axi_awvalid (dig_awvalid),
        .s_axi_wdata   (dig_wdata),
        .s_axi_wready  (dig_wready),
        .s_axi_wstrb   (dig_wstrb),
        .s_axi_wvalid  (dig_wvalid),
        .s_axi_bready  (dig_bready),
        .s_axi_bresp   (dig_bresp),
        .s_axi_bvalid  (dig_bvalid),
        .s_axi_araddr  (dig_araddr[8:0]),
        .s_axi_arready (dig_arready),
        .s_axi_arvalid (dig_arvalid),
        .s_axi_rdata   (dig_rdata),
        .s_axi_rready  (dig_rready),
        .s_axi_rresp   (dig_rresp),
        .s_axi_rvalid  (dig_rvalid),
        .gpio_io_o     (dig_en),       // channel 1 output
        .gpio2_io_i    (8'b0),         // unused (C_ALL_OUTPUTS=1)
        .gpio2_io_o    (dig_seg),      // channel 2 output
        .gpio2_io_t    ()              // unused
    );

endmodule