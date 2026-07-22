// ============================================================================
// digled_wrap.v — 数码管外设 (AXI4-Lite Slave)
// ============================================================================
// 地址: 0xFFFF_2000, 读写 16-bit
//   wdata[15:8] = dig_en  (位选, 高有效)
//   wdata[7:0]  = dig_seg (段选, {CA,CB,CC,CD,CE,CF,CG,DP}, 低有效)
//
// AXI4-Lite 写协议 — 关键修复:
//   AXI4-Lite 规范中 AW 通道和 W 通道是独立的, master 可以在不同周期先后
//   完成 AW 握手和 W 握手。本模块使用 aw_hs/w_hs 标志位分别跟踪两个通道
//   的握手完成状态, 在两者都完成后才拉高 bvalid 发送写响应。
//   原始实现: bvalid 条件为 `awvalid && wvalid` (要求两通道同时有效)
//   Bug: axi_master 先完成 AW 握手(awvalid 已清除)再发 W, bvalid 永远不拉高
//   修复: aw_hs/w_hs 独立跟踪握手, bvalid = aw_hs && w_hs
//
//   bvalid 清除也必须用 `bvalid && bready` 而非单独 `bready`,
//   因为 axi_master 持续保持 bready=1, 单独 bready 会立即清除刚置位的 bvalid.

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

    // ========================================================================
    // AXI4-Lite 写通道握手跟踪
    // ========================================================================
    // AW (地址写) 和 W (数据写) 是两个独立通道, master 可能:
    //   1) 同时发送 AW+W (awvalid && wvalid 同周期为高)
    //   2) 先发 AW 再发 W (awvalid 先握手, wvalid 后握手)
    //   3) 先发 W 再发 AW (wvalid 先握手, awvalid 后握手)
    // aw_hs/w_hs 分别记录各自通道的握手完成, B 通道响应在两个都完成后发送.
    // 握手完成后在 bvalid && bready 时清除 (B 通道握手完成), 准备下一次写.
    reg aw_hs, w_hs;

    // Segment register
    reg [15:0] seg_reg;
    always @(posedge aclk or posedge areset) begin
        if (areset) begin
            seg_reg <= 16'h0;
            aw_hs   <= 1'b0;
            w_hs    <= 1'b0;
        end else begin
            if (awvalid && awready) aw_hs <= 1'b1;
            else if (bvalid && bready) aw_hs <= 1'b0;
            if (wvalid && wready) w_hs <= 1'b1;
            else if (bvalid && bready) w_hs <= 1'b0;
            if (awvalid && wvalid) seg_reg <= wdata[15:0];
            else if (aw_hs && w_hs)  seg_reg <= wdata[15:0];  // accept on completed handshake
        end
    end
    assign dig_en  = seg_reg[15:8];
    assign dig_seg = seg_reg[7:0];

    // Write response (B channel) — assert after BOTH AW and W handshakes complete
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
            rdata_reg  <= {16'h0, seg_reg};
        end else if (rready) begin
            rvalid_reg <= 1'b0;
        end
    assign rdata  = rdata_reg;
    assign rvalid = rvalid_reg;

endmodule
