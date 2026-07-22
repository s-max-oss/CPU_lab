// ============================================================================
// switch_wrap.v — 拨码开关外设 (AXI4-Lite Slave)
// ============================================================================
// 地址: 0xFFFF_0000, 只读 16-bit
//   读取返回 {16'h0, sw[15:0]}, 写操作被忽略 (但仍需正确完成 B 通道握手)
//
// AXI4-Lite 写协议 — 关键修复:
//   虽然是只读设备, 但 AXI 写事务仍必须正确完成 B 通道握手,
//   否则 axi_master 会在 DC_WR_B 状态永久等待 bvalid.
//   修复: aw_hs/w_hs 独立跟踪 AW/W 握手, bvalid = aw_hs && w_hs
//   (详见 digled_wrap.v 中的完整注释)

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

    // ========================================================================
    // AXI4-Lite 写通道握手跟踪
    // ========================================================================
    // 虽然是只读外设 (写数据被丢弃), 但仍需正确完成 B 通道握手,
    // 否则 axi_master 在 DC_WR_B 状态永久等待 bvalid → CPU 卡死.
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
