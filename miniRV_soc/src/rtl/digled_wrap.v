// ============================================================================
// digled_wrap.v — 数码管外设 (AXI4-Lite Slave)
// ============================================================================
// 地址: 0xFFFF_2000, 读写 16-bit
// wdata[15:8] = dig_en (位选), wdata[7:0] = dig_seg (段选)
// dig_seg = {CA, CB, CC, CD, CE, CF, CG, DP}

`timescale 1ns / 1ps

module digled_wrap (
    input  wire         aclk,
    input  wire         areset,         // high active

    // AXI4-Lite Slave
    input  wire [31:0]  awaddr,
    input  wire         awvalid,
    output wire         awready,
    input  wire [31:0]  wdata,
    input  wire [ 3:0]  wstrb,
    input  wire         wvalid,
    output wire         wready,
    output wire         bvalid,
    input  wire         bready,
    input  wire [31:0]  araddr,
    input  wire         arvalid,
    output wire         arready,
    output wire [31:0]  rdata,
    output wire         rvalid,
    input  wire         rready,

    // FPGA I/O
    output wire [ 7:0]  dig_en,
    output wire [ 7:0]  dig_seg
);

    assign awready = 1'b1;
    assign wready  = 1'b1;
    assign arready = 1'b1;

    // Segment register
    reg [15:0] seg_reg;
    always @(posedge aclk or posedge areset)
        if (areset) seg_reg <= 16'h0;
        else if (awvalid && wvalid) seg_reg <= wdata[15:0];
    assign dig_en  = seg_reg[15:8];
    assign dig_seg = seg_reg[7:0];

    // Write response
    reg bvalid_reg;
    always @(posedge aclk or posedge areset)
        if (areset) bvalid_reg <= 1'b0;
        else if (awvalid && wvalid) bvalid_reg <= 1'b1;
        else if (bready) bvalid_reg <= 1'b0;
    assign bvalid = bvalid_reg;

    // Read response
    reg [31:0] rdata_reg;
    reg        rvalid_reg;
    always @(posedge aclk or posedge areset)
        if (areset) begin
            rvalid_reg <= 1'b0;
            rdata_reg  <= 32'h0;
        end else if (arvalid && !rvalid_reg) begin
            rvalid_reg <= 1'b1;
            rdata_reg  <= {16'h0, seg_reg};
        end else if (rready) begin
            rvalid_reg <= 1'b0;
        end
    assign rdata  = rdata_reg;
    assign rvalid = rvalid_reg;

endmodule
