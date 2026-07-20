// ============================================================================
// axi_crossbar.v — AXI4 Crossbar: 1 Master → 6 Slaves
// ============================================================================
// Address map:
//   0x0000_0000 ~ 0x0FFF_FFFF → slave 0: bram_axi (main memory)
//   0xFFFF_0000              → slave 1: switch
//   0xFFFF_1000              → slave 2: led
//   0xFFFF_2000              → slave 3: digled
//   0xFFFF_3000              → slave 4: uart
//   0xFFFF_4000              → slave 5: timer
//
// Upper 16 bits determine the slave:
//   != 0xFFFF → slave 0 (memory)
//   == 0xFFFF → slave selected by addr[15:12]

`timescale 1ns / 1ps

module axi_crossbar (
    input  wire         aclk,
    input  wire         areset,

    // ------ Master (from cpu_top_axi) ------
    // Write address
    input  wire [31:0]  s_axi_awaddr,
    input  wire [ 7:0]  s_axi_awlen,
    input  wire [ 2:0]  s_axi_awsize,
    input  wire [ 1:0]  s_axi_awburst,
    input  wire         s_axi_awvalid,
    output wire         s_axi_awready,
    // Write data
    input  wire [31:0]  s_axi_wdata,
    input  wire [ 3:0]  s_axi_wstrb,
    input  wire         s_axi_wlast,
    input  wire         s_axi_wvalid,
    output wire         s_axi_wready,
    // Write response
    input  wire         s_axi_bready,
    output wire [ 1:0]  s_axi_bresp,
    output wire         s_axi_bvalid,
    // Read address
    input  wire [31:0]  s_axi_araddr,
    input  wire [ 7:0]  s_axi_arlen,
    input  wire [ 2:0]  s_axi_arsize,
    input  wire [ 1:0]  s_axi_arburst,
    input  wire         s_axi_arvalid,
    output wire         s_axi_arready,
    // Read data
    output wire [31:0]  s_axi_rdata,
    input  wire         s_axi_rready,
    output wire [ 1:0]  s_axi_rresp,
    output wire         s_axi_rlast,
    output wire         s_axi_rvalid,

    // ------ Slave 0: bram_axi (memory) ------
    output wire [31:0]  m0_axi_awaddr,
    output wire [ 7:0]  m0_axi_awlen,
    output wire [ 2:0]  m0_axi_awsize,
    output wire [ 1:0]  m0_axi_awburst,
    output wire         m0_axi_awvalid,
    input  wire         m0_axi_awready,
    output wire [31:0]  m0_axi_wdata,
    output wire [ 3:0]  m0_axi_wstrb,
    output wire         m0_axi_wlast,
    output wire         m0_axi_wvalid,
    input  wire         m0_axi_wready,
    output wire         m0_axi_bready,
    input  wire [ 1:0]  m0_axi_bresp,
    input  wire         m0_axi_bvalid,
    output wire [31:0]  m0_axi_araddr,
    output wire [ 7:0]  m0_axi_arlen,
    output wire [ 2:0]  m0_axi_arsize,
    output wire [ 1:0]  m0_axi_arburst,
    output wire         m0_axi_arvalid,
    input  wire         m0_axi_arready,
    input  wire [31:0]  m0_axi_rdata,
    output wire         m0_axi_rready,
    input  wire [ 1:0]  m0_axi_rresp,
    input  wire         m0_axi_rlast,
    input  wire         m0_axi_rvalid,

    // ------ Slaves 1-5: Peripherals ------
    // Each peripheral uses a simplified AXI interface:
    //   awvalid/awaddr + wvalid/wdata/wstrb → wready; bvalid → bready
    //   arvalid/araddr → arready; rvalid/rdata → rready

    // Slave 1: switch
    output wire [31:0]  m1_axi_awaddr,
    output wire         m1_axi_awvalid,
    input  wire         m1_axi_awready,
    output wire [31:0]  m1_axi_wdata,
    output wire [ 3:0]  m1_axi_wstrb,
    output wire         m1_axi_wvalid,
    input  wire         m1_axi_wready,
    input  wire         m1_axi_bvalid,
    output wire         m1_axi_bready,
    output wire [31:0]  m1_axi_araddr,
    output wire         m1_axi_arvalid,
    input  wire         m1_axi_arready,
    input  wire [31:0]  m1_axi_rdata,
    input  wire         m1_axi_rvalid,
    output wire         m1_axi_rready,

    // Slave 2: led
    output wire [31:0]  m2_axi_awaddr,
    output wire         m2_axi_awvalid,
    input  wire         m2_axi_awready,
    output wire [31:0]  m2_axi_wdata,
    output wire [ 3:0]  m2_axi_wstrb,
    output wire         m2_axi_wvalid,
    input  wire         m2_axi_wready,
    input  wire         m2_axi_bvalid,
    output wire         m2_axi_bready,
    output wire [31:0]  m2_axi_araddr,
    output wire         m2_axi_arvalid,
    input  wire         m2_axi_arready,
    input  wire [31:0]  m2_axi_rdata,
    input  wire         m2_axi_rvalid,
    output wire         m2_axi_rready,

    // Slave 3: digled
    output wire [31:0]  m3_axi_awaddr,
    output wire         m3_axi_awvalid,
    input  wire         m3_axi_awready,
    output wire [31:0]  m3_axi_wdata,
    output wire [ 3:0]  m3_axi_wstrb,
    output wire         m3_axi_wvalid,
    input  wire         m3_axi_wready,
    input  wire         m3_axi_bvalid,
    output wire         m3_axi_bready,
    output wire [31:0]  m3_axi_araddr,
    output wire         m3_axi_arvalid,
    input  wire         m3_axi_arready,
    input  wire [31:0]  m3_axi_rdata,
    input  wire         m3_axi_rvalid,
    output wire         m3_axi_rready,

    // Slave 4: uart
    output wire [31:0]  m4_axi_awaddr,
    output wire         m4_axi_awvalid,
    input  wire         m4_axi_awready,
    output wire [31:0]  m4_axi_wdata,
    output wire [ 3:0]  m4_axi_wstrb,
    output wire         m4_axi_wvalid,
    input  wire         m4_axi_wready,
    input  wire         m4_axi_bvalid,
    output wire         m4_axi_bready,
    output wire [31:0]  m4_axi_araddr,
    output wire         m4_axi_arvalid,
    input  wire         m4_axi_arready,
    input  wire [31:0]  m4_axi_rdata,
    input  wire         m4_axi_rvalid,
    output wire         m4_axi_rready,

    // Slave 5: timer
    output wire [31:0]  m5_axi_awaddr,
    output wire         m5_axi_awvalid,
    input  wire         m5_axi_awready,
    output wire [31:0]  m5_axi_wdata,
    output wire [ 3:0]  m5_axi_wstrb,
    output wire         m5_axi_wvalid,
    input  wire         m5_axi_wready,
    input  wire         m5_axi_bvalid,
    output wire         m5_axi_bready,
    output wire [31:0]  m5_axi_araddr,
    output wire         m5_axi_arvalid,
    input  wire         m5_axi_arready,
    input  wire [31:0]  m5_axi_rdata,
    input  wire         m5_axi_rvalid,
    output wire         m5_axi_rready
);

    // ------ Address decode ------
    // slave 0: upper 16 bits != 0xFFFF
    // slave 1-5: upper 16 bits == 0xFFFF, selected by addr[15:12]
    wire is_periph_aw = (s_axi_awaddr[31:16] == 16'hFFFF);
    wire is_periph_ar = (s_axi_araddr[31:16] == 16'hFFFF);

    wire [2:0] aw_sel = is_periph_aw ? s_axi_awaddr[15:12] : 3'd0;
    wire [2:0] ar_sel = is_periph_ar ? s_axi_araddr[15:12] : 3'd0;

    // Map addr[15:12] to slave index:
    //   0x0 → slave 1 (switch)
    //   0x1 → slave 2 (led)
    //   0x2 → slave 3 (digled)
    //   0x3 → slave 4 (uart)
    //   0x4 → slave 5 (timer)
    //   others → slave 0 (invalid, route to memory)
    wire aw_to_mem = !is_periph_aw || (aw_sel > 3'd4);
    wire ar_to_mem = !is_periph_ar || (ar_sel > 3'd4);

    // Latch slave selection at handshake — prevents misrouting when
    // awaddr changes between AW handshake and W channel transfer.
    reg        w_to_mem;
    reg [2:0]  w_sel;
    always @(posedge aclk or posedge areset)
        if (areset) begin
            w_to_mem <= 1'b1;
            w_sel    <= 3'd0;
        end else if (s_axi_awvalid && s_axi_awready) begin
            w_to_mem <= aw_to_mem;
            w_sel    <= aw_sel;
        end

    reg        r_to_mem;
    reg [2:0]  r_sel;
    always @(posedge aclk or posedge areset)
        if (areset) begin
            r_to_mem <= 1'b1;
            r_sel    <= 3'd0;
        end else if (s_axi_arvalid && s_axi_arready) begin
            r_to_mem <= ar_to_mem;
            r_sel    <= ar_sel;
        end

    // ------ Write address channel ------
    assign s_axi_awready = aw_to_mem ? m0_axi_awready :
                           (aw_sel == 3'd0) ? m1_axi_awready :
                           (aw_sel == 3'd1) ? m2_axi_awready :
                           (aw_sel == 3'd2) ? m3_axi_awready :
                           (aw_sel == 3'd3) ? m4_axi_awready : m5_axi_awready;

    assign m0_axi_awaddr  = aw_to_mem ? s_axi_awaddr  : 32'h0;
    assign m0_axi_awlen   = aw_to_mem ? s_axi_awlen   : 8'h0;
    assign m0_axi_awsize  = aw_to_mem ? s_axi_awsize  : 3'h0;
    assign m0_axi_awburst = aw_to_mem ? s_axi_awburst : 2'h0;
    assign m0_axi_awvalid = aw_to_mem ? s_axi_awvalid : 1'b0;

    assign m1_axi_awaddr  = (!aw_to_mem && aw_sel == 3'd0) ? s_axi_awaddr  : 32'h0;
    assign m1_axi_awvalid = (!aw_to_mem && aw_sel == 3'd0) ? s_axi_awvalid : 1'b0;
    assign m2_axi_awaddr  = (!aw_to_mem && aw_sel == 3'd1) ? s_axi_awaddr  : 32'h0;
    assign m2_axi_awvalid = (!aw_to_mem && aw_sel == 3'd1) ? s_axi_awvalid : 1'b0;
    assign m3_axi_awaddr  = (!aw_to_mem && aw_sel == 3'd2) ? s_axi_awaddr  : 32'h0;
    assign m3_axi_awvalid = (!aw_to_mem && aw_sel == 3'd2) ? s_axi_awvalid : 1'b0;
    assign m4_axi_awaddr  = (!aw_to_mem && aw_sel == 3'd3) ? s_axi_awaddr  : 32'h0;
    assign m4_axi_awvalid = (!aw_to_mem && aw_sel == 3'd3) ? s_axi_awvalid : 1'b0;
    assign m5_axi_awaddr  = (!aw_to_mem && aw_sel == 3'd4) ? s_axi_awaddr  : 32'h0;
    assign m5_axi_awvalid = (!aw_to_mem && aw_sel == 3'd4) ? s_axi_awvalid : 1'b0;

    // ------ Write data channel (uses latched w_sel) ------
    assign s_axi_wready = w_to_mem ? m0_axi_wready :
                          (w_sel == 3'd0) ? m1_axi_wready :
                          (w_sel == 3'd1) ? m2_axi_wready :
                          (w_sel == 3'd2) ? m3_axi_wready :
                          (w_sel == 3'd3) ? m4_axi_wready : m5_axi_wready;

    assign m0_axi_wdata  = w_to_mem ? s_axi_wdata  : 32'h0;
    assign m0_axi_wstrb  = w_to_mem ? s_axi_wstrb  : 4'h0;
    assign m0_axi_wlast  = w_to_mem ? s_axi_wlast  : 1'b0;
    assign m0_axi_wvalid = w_to_mem ? s_axi_wvalid : 1'b0;

    assign m1_axi_wdata  = s_axi_wdata;
    assign m1_axi_wstrb  = s_axi_wstrb;
    assign m1_axi_wvalid = (!w_to_mem && w_sel == 3'd0) ? s_axi_wvalid : 1'b0;
    assign m2_axi_wdata  = s_axi_wdata;
    assign m2_axi_wstrb  = s_axi_wstrb;
    assign m2_axi_wvalid = (!w_to_mem && w_sel == 3'd1) ? s_axi_wvalid : 1'b0;
    assign m3_axi_wdata  = s_axi_wdata;
    assign m3_axi_wstrb  = s_axi_wstrb;
    assign m3_axi_wvalid = (!w_to_mem && w_sel == 3'd2) ? s_axi_wvalid : 1'b0;
    assign m4_axi_wdata  = s_axi_wdata;
    assign m4_axi_wstrb  = s_axi_wstrb;
    assign m4_axi_wvalid = (!w_to_mem && w_sel == 3'd3) ? s_axi_wvalid : 1'b0;
    assign m5_axi_wdata  = s_axi_wdata;
    assign m5_axi_wstrb  = s_axi_wstrb;
    assign m5_axi_wvalid = (!w_to_mem && w_sel == 3'd4) ? s_axi_wvalid : 1'b0;

    // ------ Write response channel (uses latched w_sel) ------
    assign m0_axi_bready = w_to_mem ? s_axi_bready : 1'b0;
    assign s_axi_bvalid  = w_to_mem ? m0_axi_bvalid :
                           (w_sel == 3'd0) ? m1_axi_bvalid :
                           (w_sel == 3'd1) ? m2_axi_bvalid :
                           (w_sel == 3'd2) ? m3_axi_bvalid :
                           (w_sel == 3'd3) ? m4_axi_bvalid : m5_axi_bvalid;
    assign s_axi_bresp   = w_to_mem ? m0_axi_bresp : 2'b00;

    assign m1_axi_bready = (!w_to_mem && w_sel == 3'd0) ? s_axi_bready : 1'b0;
    assign m2_axi_bready = (!w_to_mem && w_sel == 3'd1) ? s_axi_bready : 1'b0;
    assign m3_axi_bready = (!w_to_mem && w_sel == 3'd2) ? s_axi_bready : 1'b0;
    assign m4_axi_bready = (!w_to_mem && w_sel == 3'd3) ? s_axi_bready : 1'b0;
    assign m5_axi_bready = (!w_to_mem && w_sel == 3'd4) ? s_axi_bready : 1'b0;

    // ------ Read address channel ------
    assign s_axi_arready = ar_to_mem ? m0_axi_arready :
                           (ar_sel == 3'd0) ? m1_axi_arready :
                           (ar_sel == 3'd1) ? m2_axi_arready :
                           (ar_sel == 3'd2) ? m3_axi_arready :
                           (ar_sel == 3'd3) ? m4_axi_arready : m5_axi_arready;

    assign m0_axi_araddr  = ar_to_mem ? s_axi_araddr  : 32'h0;
    assign m0_axi_arlen   = ar_to_mem ? s_axi_arlen   : 8'h0;
    assign m0_axi_arsize  = ar_to_mem ? s_axi_arsize  : 3'h0;
    assign m0_axi_arburst = ar_to_mem ? s_axi_arburst : 2'h0;
    assign m0_axi_arvalid = ar_to_mem ? s_axi_arvalid : 1'b0;

    assign m1_axi_araddr  = (!ar_to_mem && ar_sel == 3'd0) ? s_axi_araddr  : 32'h0;
    assign m1_axi_arvalid = (!ar_to_mem && ar_sel == 3'd0) ? s_axi_arvalid : 1'b0;
    assign m2_axi_araddr  = (!ar_to_mem && ar_sel == 3'd1) ? s_axi_araddr  : 32'h0;
    assign m2_axi_arvalid = (!ar_to_mem && ar_sel == 3'd1) ? s_axi_arvalid : 1'b0;
    assign m3_axi_araddr  = (!ar_to_mem && ar_sel == 3'd2) ? s_axi_araddr  : 32'h0;
    assign m3_axi_arvalid = (!ar_to_mem && ar_sel == 3'd2) ? s_axi_arvalid : 1'b0;
    assign m4_axi_araddr  = (!ar_to_mem && ar_sel == 3'd3) ? s_axi_araddr  : 32'h0;
    assign m4_axi_arvalid = (!ar_to_mem && ar_sel == 3'd3) ? s_axi_arvalid : 1'b0;
    assign m5_axi_araddr  = (!ar_to_mem && ar_sel == 3'd4) ? s_axi_araddr  : 32'h0;
    assign m5_axi_arvalid = (!ar_to_mem && ar_sel == 3'd4) ? s_axi_arvalid : 1'b0;

    // ------ Read data channel (uses latched r_sel) ------
    assign m0_axi_rready = r_to_mem ? s_axi_rready : 1'b0;
    assign s_axi_rdata   = r_to_mem ? m0_axi_rdata :
                           (r_sel == 3'd0) ? m1_axi_rdata :
                           (r_sel == 3'd1) ? m2_axi_rdata :
                           (r_sel == 3'd2) ? m3_axi_rdata :
                           (r_sel == 3'd3) ? m4_axi_rdata : m5_axi_rdata;
    assign s_axi_rresp   = r_to_mem ? m0_axi_rresp : 2'b00;
    assign s_axi_rlast   = r_to_mem ? m0_axi_rlast : 1'b1;   // peripherals: single beat
    assign s_axi_rvalid  = r_to_mem ? m0_axi_rvalid :
                           (r_sel == 3'd0) ? m1_axi_rvalid :
                           (r_sel == 3'd1) ? m2_axi_rvalid :
                           (r_sel == 3'd2) ? m3_axi_rvalid :
                           (r_sel == 3'd3) ? m4_axi_rvalid : m5_axi_rvalid;

    assign m1_axi_rready = (!r_to_mem && r_sel == 3'd0) ? s_axi_rready : 1'b0;
    assign m2_axi_rready = (!r_to_mem && r_sel == 3'd1) ? s_axi_rready : 1'b0;
    assign m3_axi_rready = (!r_to_mem && r_sel == 3'd2) ? s_axi_rready : 1'b0;
    assign m4_axi_rready = (!r_to_mem && r_sel == 3'd3) ? s_axi_rready : 1'b0;
    assign m5_axi_rready = (!r_to_mem && r_sel == 3'd4) ? s_axi_rready : 1'b0;

endmodule
