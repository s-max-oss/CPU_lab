`timescale 1ns / 1ps

module led_wrap_ip (
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

    output wire [15:0]  led
);

    wire [31:0] led_awaddr;
    wire        led_awvalid, led_awready;
    wire [31:0] led_wdata;
    wire [ 3:0] led_wstrb;
    wire        led_wvalid, led_wready;
    wire [ 1:0] led_bresp;
    wire        led_bvalid, led_bready;
    wire [31:0] led_araddr;
    wire        led_arvalid, led_arready;
    wire [31:0] led_rdata;
    wire [ 1:0] led_rresp;
    wire        led_rvalid, led_rready;

    axi_protocol_converter_2 U_led_converter (
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
        .m_axi_awaddr  (led_awaddr),   .m_axi_awprot (),
        .m_axi_awvalid (led_awvalid),  .m_axi_awready(led_awready),
        .m_axi_wdata   (led_wdata),    .m_axi_wstrb  (led_wstrb),
        .m_axi_wvalid  (led_wvalid),   .m_axi_wready (led_wready),
        .m_axi_bresp   (led_bresp),    .m_axi_bvalid (led_bvalid),
        .m_axi_bready  (led_bready),
        .m_axi_araddr  (led_araddr),   .m_axi_arprot (),
        .m_axi_arvalid (led_arvalid),  .m_axi_arready(led_arready),
        .m_axi_rdata   (led_rdata),    .m_axi_rresp  (led_rresp),
        .m_axi_rvalid  (led_rvalid),   .m_axi_rready (led_rready)
    );

    axi_gpio_2 U_led (
        .s_axi_aclk    (aclk),
        .s_axi_aresetn (aresetn),
        .s_axi_awaddr  (led_awaddr[8:0]),
        .s_axi_awready (led_awready),
        .s_axi_awvalid (led_awvalid),
        .s_axi_wdata   (led_wdata),
        .s_axi_wready  (led_wready),
        .s_axi_wstrb   (led_wstrb),
        .s_axi_wvalid  (led_wvalid),
        .s_axi_bready  (led_bready),
        .s_axi_bresp   (led_bresp),
        .s_axi_bvalid  (led_bvalid),
        .s_axi_araddr  (led_araddr[8:0]),
        .s_axi_arready (led_arready),
        .s_axi_arvalid (led_arvalid),
        .s_axi_rdata   (led_rdata),
        .s_axi_rready  (led_rready),
        .s_axi_rresp   (led_rresp),
        .s_axi_rvalid  (led_rvalid),
        .gpio_io_o     (led)
    );

endmodule
