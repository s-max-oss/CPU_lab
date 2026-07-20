// ============================================================================
// timer_wrap.v — 定时器/计数器外设 (AXI4-Lite Slave)
// ============================================================================
// 地址: 0xFFFF_4000, 只读 64-bit 自由运行计数器
//   偏移 0x0: counter[31:0]  低 32 位
//   偏移 0x4: counter[63:32] 高 32 位
// 写操作被忽略

`timescale 1ns / 1ps

module timer_wrap (
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
    input  wire         rready
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

    // 64-bit free-running counter
    reg [63:0] counter;
    always @(posedge aclk or posedge areset)
        if (areset) counter <= 64'h0;
        else counter <= counter + 1;

    // Read response
    reg [31:0] rdata_reg;
    reg        rvalid_reg;
    always @(posedge aclk or posedge areset)
        if (areset) begin
            rvalid_reg <= 1'b0;
            rdata_reg  <= 32'h0;
        end else if (arvalid && !rvalid_reg) begin
            rvalid_reg <= 1'b1;
            // araddr[2] selects low/high 32 bits
            rdata_reg  <= araddr[2] ? counter[63:32] : counter[31:0];
        end else if (rready) begin
            rvalid_reg <= 1'b0;
        end
    assign rdata  = rdata_reg;
    assign rvalid = rvalid_reg;

endmodule
