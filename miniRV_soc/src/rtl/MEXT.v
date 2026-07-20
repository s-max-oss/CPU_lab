// ============================================================================
// MEXT.v — 内存读取数据扩展模块 (Memory Extension)
// ============================================================================
// 【功能】从 DRAM 读回的 32 位数据中提取所需的字节/半字，并做符号/零扩展
//
// 【为什么需要这个模块？】
//   DRAM 总是返回完整的 32 位数据。但是 LB 只需要其中1个字节，
//   LH 需要其中2个字节。MEXT 负责：
//     第1步：字节对齐（real_din）— 根据地址偏移将有效数据右移到低位
//     第2步：符号/零扩展（ext）  — 扩展到32位
//
// 【两阶段处理示例】
//   LB 指令, 地址=0x03, DRAM返回=0x12345678, 要读地址0x03的字节(=0x12)
//     第1步 byte_offs=3 → real_din = {24'h0, din[31:24]} = 0x00000012 ✓
//     第2步 op=RAM_EXT_B → ext = {{24{0}}, 0x12} = 0x00000012 (符号扩展，因0x12[7]=0)
//
//   LBU 指令, 地址=0x03, 数据=0x89 (即读回0x89000000)
//     第1步 byte_offs=3 → real_din = 0x00000089
//     第2步 op=RAM_EXT_BU → ext = {24'h0, 0x89} = 0x00000089 (零扩展)
//
//   LH 指令, 地址=0x02, 数据=0x0000FF9C → 半字=0xFF9C(负数)
//     第1步 byte_offs=2 → real_din = {16'h0, din[31:16]} = 0x0000FF9C
//     第2步 op=RAM_EXT_H → ext = {{16{1'b1}}, 0xFF9C} = 0xFFFFFF9C (符号扩展) ✓
//
// 【理解重点】
//   - byte_offs 来自 alu_c_r[1:0]，即 ALU 计算地址的低2位（缓存了一个周期等DRAM返回）
//   - 对于 LW：real_din直接等于din（不位移），ext直接等于real_din（不扩展）
// ============================================================================

`timescale 1ns / 1ps

`include "defines.vh"

module MEXT (
    input  wire [ 2:0]  op,            // 扩展操作类型（ram_rop_r，缓存的读操作码）
    input  wire [31:0]  din,           // 从DRAM读回的原始32位数据
    input  wire [ 1:0]  byte_offs,     // 地址低2位（alu_c_r[1:0]），指示有效数据在哪个字节位置
    output reg  [31:0]  ext            // 扩展完成的32位数据，送给写回MUX
);

    // ===== 第1步：字节对齐 =====
    // 原理：DRAM总是返回从"对齐地址"开始的32位数据，
    // 例如读地址0x03时，DRAM返回地址0x00开始的4字节(0x00,0x01,0x02,0x03)，
    // 真正需要的是第3字节(bit[31:24])，所以要右移3字节。
    reg [31:0] real_din;
    always @(*) begin
        case (byte_offs)
            2'b01  : real_din = { 8'h0, din[31: 8]};   // 有效数据在 bit[15:8]，右移1字节
            2'b10  : real_din = {16'h0, din[31:16]};   // 有效数据在 bit[23:16]，右移2字节
            2'b11  : real_din = {24'h0, din[31:24]};   // 有效数据在 bit[31:24]，右移3字节
            default: real_din = din;                    // byte_offs=0，直接使用（LW情况）
        endcase
    end

    // ===== 第2步：符号/零扩展 =====
    always @(*) begin
        case (op)
            // LB: 取 real_din[7:0]，符号位=bit[7]，复制24份填满高位
            `RAM_EXT_B : ext = {{24{real_din[7]}}, real_din[7:0]};

            // LBU: 取 real_din[7:0]，高位补0
            `RAM_EXT_BU: ext = {24'h0, real_din[7:0]};

            // LH: 取 real_din[15:0]，符号位=bit[15]
            `RAM_EXT_H : ext = {{16{real_din[15]}}, real_din[15:0]};

            // LHU: 取 real_din[15:0]，高位补0
            `RAM_EXT_HU: ext = {16'h0, real_din[15:0]};

            // LW: 不做任何扩展，直接输出
            default    : ext = real_din;
        endcase
    end

endmodule
