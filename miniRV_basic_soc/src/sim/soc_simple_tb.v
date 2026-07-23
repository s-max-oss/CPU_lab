





/*.v ../sim/soc_simple_tb.v
//   xelab -L xil_defaultlib soc_simple_tb -s sim_soc
//   xsim sim_soc --runall
// ============================================================================

`timescale 1ns / 1ps

`include "defines.vh"

module soc_simple_tb;

    reg         clk  = 1;
    reg         rst  = 1;     // HIGH active (trace test )
    reg  [15:0] sw   = 16'h0;
    reg         rx   = 1'b1;

    wire [15:0] led;
    wire [ 7:0] dig_en;
    wire [ 7:0] dig_seg;
    wire [ 7:0] dig_seg1;
    wire        tx;

    // AXI RUN_TRACE  bram_axi 
    wire [31:0] mem_awaddr;
    wire [ 7:0] mem_awlen;
    wire [ 2:0] mem_awsize;
    wire [ 1:0] mem_awburst;
    wire        mem_awready;
    wire        mem_awvalid;
    wire [31:0] mem_wdata;
    wire [ 3:0] mem_wstrb;
    wire        mem_wlast;
    wire        mem_wready;
    wire        mem_wvalid;
    wire [ 1:0] mem_bresp;
    wire        mem_bvalid;
    wire        mem_bready;
    wire [31:0] mem_araddr;
    wire [ 7:0] mem_arlen;
    wire [ 2:0] mem_arsize;
    wire [ 1:0] mem_arburst;
    wire        mem_arready;
    wire        mem_arvalid;
    wire [31:0] mem_rdata;
    wire [ 1:0] mem_rresp;
    wire        mem_rlast;
    wire        mem_rvalid;
    wire        mem_rready;

    integer cycle;

    always #5 clk = ~clk;

    // ================================================================
    // miniRV_SoC  RUN_TRACE 
    // ================================================================
    miniRV_SoC DUT (
        .fpga_clk        (clk),
        .fpga_rst        (rst),
        .sw              (sw),
        .led             (led),
        .dig_en          (dig_en),
        .dig_seg         (dig_seg),
        .dig_seg1        (dig_seg1),
        .rx              (rx),
        .tx              (tx),
        .mem_axi_awaddr  (mem_awaddr),
        .mem_axi_awlen   (mem_awlen),
        .mem_axi_awsize  (mem_awsize),
        .mem_axi_awburst (mem_awburst),
        .mem_axi_awready (mem_awready),
        .mem_axi_awvalid (mem_awvalid),
        .mem_axi_wdata   (mem_wdata),
        .mem_axi_wready  (mem_wready),
        .mem_axi_wstrb   (mem_wstrb),
        .mem_axi_wlast   (mem_wlast),
        .mem_axi_wvalid  (mem_wvalid),
        .mem_axi_bready  (mem_bready),
        .mem_axi_bresp   (mem_bresp),
        .mem_axi_bvalid  (mem_bvalid),
        .mem_axi_araddr  (mem_araddr),
        .mem_axi_arlen   (mem_arlen),
        .mem_axi_arsize  (mem_arsize),
        .mem_axi_arburst (mem_arburst),
        .mem_axi_arready (mem_arready),
        .mem_axi_arvalid (mem_arvalid),
        .mem_axi_rdata   (mem_rdata),
        .mem_axi_rready  (mem_rready),
        .mem_axi_rresp   (mem_rresp),
        .mem_axi_rlast   (mem_rlast),
        .mem_axi_rvalid  (mem_rvalid)
    );

    initial begin
        // : fpga_rst 
        // :  clk posedge , 
        rst = 1'b1;
        #203;
        rst = 1'b0;  // 

        //  ecall = 0x73
        for (cycle = 0; cycle < 50000; cycle = cycle + 1) begin
            @(posedge clk);
            if (DUT.U_cpu.U_core.ifetch_valid &&
                DUT.U_cpu.U_core.ifetch_inst == 32'h0000_0073) begin
                #100;
                $display("SOC_SIMPLE_TEST_PASSED (cycle=%0d)", cycle);
                $finish;
            end
        end

        $display("SOC_SIMPLE_TEST_TIMEOUT");
        $finish;
    end

endmodule
