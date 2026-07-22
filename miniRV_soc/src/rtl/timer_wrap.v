// ============================================================================
// timer_wrap.v — 定时器/计数器外设 (AXI4-Lite Slave)
// ============================================================================
// 地址: 0xFFFF_4000, 只读 64-bit 自由运行计数器
//   偏移 0x0: counter[31:0]  低 32 位
//   偏移 0x4: counter[63:32] 高 32 位
//   写操作被忽略 (但仍需正确完成 B 通道握手, 见下方注释)
//
// AXI4-Lite 写协议 — 关键修复:
//   虽然是只读设备, 但 AXI 写事务仍必须正确完成 B 通道握手,
//   否则 axi_master 会在 DC_WR_B 状态永久等待 bvalid.
//   修复: aw_hs/w_hs 独立跟踪 AW/W 握手, bvalid = aw_hs && w_hs

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

    // ========================================================================
    // AXI4-Lite 写通道握手跟踪
    // ========================================================================
    // 虽然是只读外设, 但仍需正确完成 B 通道握手.
    // aw_hs/w_hs 分别记录 AW/W 通道握手, 两者都完成后拉高 bvalid.
    reg aw_hs, w_hs;
    always @(posedge aclk or posedge areset) begin
        if (areset) begin
            aw_hs <= 1'b0;
            w_hs  <= 1'b0;
        end else begin
            if (awvalid && awready) aw_hs <= 1'b1;
            else if (bvalid && bready) aw_hs <= 1'b0;
            if (wvalid && wready) w_hs <= 1'b1;
            else if (bvalid && bready) w_hs <= 1'b0;
        end
    end

    // Write response (assert after BOTH AW and W handshakes complete)
    reg bvalid_reg;
    always @(posedge aclk or posedge areset)
        if (areset) bvalid_reg <= 1'b0;
        else if (bvalid && bready) bvalid_reg <= 1'b0;
        else if (aw_hs && w_hs) bvalid_reg <= 1'b1;
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
