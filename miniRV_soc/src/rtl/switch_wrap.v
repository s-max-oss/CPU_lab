// ============================================================================
// switch_wrap.v — 拨码开关外设 (AXI4-Lite Slave)
// ============================================================================
// 地址: 0xFFFF_0000, 只读 16-bit
// 读取返回 {16'h0, sw[15:0]}, 写操作被忽略

`timescale 1ns / 1ps

module switch_wrap (
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
    input  wire [15:0]  sw
);

    assign awready = 1'b1;
    assign wready  = 1'b1;
    assign arready = 1'b1;

    // Write response (write data ignored)
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
            rdata_reg  <= {16'h0, sw};
        end else if (rready) begin
            rvalid_reg <= 1'b0;
        end
    assign rdata  = rdata_reg;
    assign rvalid = rvalid_reg;

endmodule
