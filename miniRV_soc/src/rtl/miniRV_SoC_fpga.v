`timescale 1ns / 1ps

`include "defines.vh"

module miniRV_SoC_fpga (
    input  wire         fpga_clk,
    input  wire         fpga_rst,       // Low Active
    input  wire [15:0]  sw,
    output wire [15:0]  led,
    output wire [ 7:0]  dig_en,
    output wire [ 7:0]  dig_seg,
    output wire [ 7:0]  dig_seg1,
    input  wire         rx,
    output wire         tx
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

    wire [31:0]  mem_axi_awaddr;
    wire [ 7:0]  mem_axi_awlen;
    wire [ 2:0]  mem_axi_awsize;
    wire [ 1:0]  mem_axi_awburst;
    wire         mem_axi_awvalid;
    wire         mem_axi_awready;
    wire [31:0]  mem_axi_wdata;
    wire [ 3:0]  mem_axi_wstrb;
    wire         mem_axi_wlast;
    wire         mem_axi_wvalid;
    wire         mem_axi_wready;
    wire         mem_axi_bready;
    wire [ 1:0]  mem_axi_bresp;
    wire         mem_axi_bvalid;
    wire [31:0]  mem_axi_araddr;
    wire [ 7:0]  mem_axi_arlen;
    wire [ 2:0]  mem_axi_arsize;
    wire [ 1:0]  mem_axi_arburst;
    wire         mem_axi_arvalid;
    wire         mem_axi_arready;
    wire [31:0]  mem_axi_rdata;
    wire         mem_axi_rready;
    wire [ 1:0]  mem_axi_rresp;
    wire         mem_axi_rlast;
    wire         mem_axi_rvalid;

    miniRV_SoC U_soc (
        .fpga_clk       (fpga_clk),
        .fpga_rst       (fpga_rst),
        .sw             (sw),
        .led            (led),
        .dig_en         (dig_en),
        .dig_seg        (dig_seg),
        .dig_seg1       (dig_seg1),
        .rx             (rx),
        .tx             (tx),

        .mem_axi_awaddr (mem_axi_awaddr),
        .mem_axi_awlen  (mem_axi_awlen),
        .mem_axi_awsize (mem_axi_awsize),
        .mem_axi_awburst(mem_axi_awburst),
        .mem_axi_awready(mem_axi_awready),
        .mem_axi_awvalid(mem_axi_awvalid),
        .mem_axi_wdata  (mem_axi_wdata),
        .mem_axi_wready (mem_axi_wready),
        .mem_axi_wstrb  (mem_axi_wstrb),
        .mem_axi_wlast  (mem_axi_wlast),
        .mem_axi_wvalid (mem_axi_wvalid),
        .mem_axi_bready (mem_axi_bready),
        .mem_axi_bresp  (mem_axi_bresp),
        .mem_axi_bvalid (mem_axi_bvalid),
        .mem_axi_araddr (mem_axi_araddr),
        .mem_axi_arlen  (mem_axi_arlen),
        .mem_axi_arsize (mem_axi_arsize),
        .mem_axi_arburst(mem_axi_arburst),
        .mem_axi_arready(mem_axi_arready),
        .mem_axi_arvalid(mem_axi_arvalid),
        .mem_axi_rdata  (mem_axi_rdata),
        .mem_axi_rready (mem_axi_rready),
        .mem_axi_rresp  (mem_axi_rresp),
        .mem_axi_rlast  (mem_axi_rlast),
        .mem_axi_rvalid (mem_axi_rvalid)
    );

    bram_axi_synth #(
        .DATA_WIDTH (32),
        .DATA_DEPTH (32768),
        .MEM_HEX    ("program.hex")
    ) U_bram (
        .s_aclk         (sys_clk),
        .s_aresetn      (~sys_rst),

        .s_axi_awaddr   (mem_axi_awaddr),
        .s_axi_awlen    (mem_axi_awlen),
        .s_axi_awsize   (mem_axi_awsize),
        .s_axi_awburst  (mem_axi_awburst),
        .s_axi_awvalid  (mem_axi_awvalid),
        .s_axi_awready  (mem_axi_awready),
        .s_axi_wdata    (mem_axi_wdata),
        .s_axi_wstrb    (mem_axi_wstrb),
        .s_axi_wlast    (mem_axi_wlast),
        .s_axi_wvalid   (mem_axi_wvalid),
        .s_axi_wready   (mem_axi_wready),
        .s_axi_bready   (mem_axi_bready),
        .s_axi_bresp    (mem_axi_bresp),
        .s_axi_bvalid   (mem_axi_bvalid),
        .s_axi_araddr   (mem_axi_araddr),
        .s_axi_arlen    (mem_axi_arlen),
        .s_axi_arsize   (mem_axi_arsize),
        .s_axi_arburst  (mem_axi_arburst),
        .s_axi_arvalid  (mem_axi_arvalid),
        .s_axi_arready  (mem_axi_arready),
        .s_axi_rdata    (mem_axi_rdata),
        .s_axi_rready   (mem_axi_rready),
        .s_axi_rresp    (mem_axi_rresp),
        .s_axi_rlast    (mem_axi_rlast),
        .s_axi_rvalid   (mem_axi_rvalid)
    );

endmodule
