// ============================================================================
// MREQ.v — 内存访问请求模块 (Memory Request)
// ============================================================================
// 【功能】将 CPU 内部的内存读写请求转换为外部总线的字节使能信号
//   - 读请求：根据 ram_rop 和地址偏移，生成 da_ren 字节使能
//   - 写请求：根据 ram_wop 和地址偏移，生成 da_wen + 数据对齐移位
//
// 【为什么需要这个模块？】
//   CPU 内部发出的是"语义级"请求（如"读一个半字，无符号扩展"），
//   而外部 DRAM 总线需要的是"物理级"信号（"哪几个字节有效"）。
//   MREQ 就是做这个语义→物理的转换。
//
// 【字节使能信号 da_ren / da_wen】
//   每个 bit 对应 data bus 的一个字节：
//     da_wen[0] = 1 → data[7:0]   写入DRAM
//     da_wen[1] = 1 → data[15:8]  写入DRAM
//     da_wen[2] = 1 → data[23:16] 写入DRAM
//     da_wen[3] = 1 → data[31:24] 写入DRAM
//
// 【SW 的对齐检查 — 理解重点！】
//   对于 SW（字写入），代码中只处理了 offset == 2'h0 的情况。
//   如果 offset != 0，da_wen = 4'h0（不写）。
//   这是为了检测非对齐访问：在真实CPU中应触发异常，这里简化处理为静默忽略。
// ============================================================================

`timescale 1ns / 1ps

`include "defines.vh"

module MREQ (
    input  wire [31:0]  ram_addr,      // 内存地址（即 ALU 计算的结果）

    // 读请求
    input  wire [ 2:0]  ram_rop,       // 读操作类型（B/BU/H/HU/W/N）
    output reg  [ 3:0]  da_ren,        // 输出：字节读使能
    output wire [31:0]  da_addr,       // 输出：地址直通

    // 写请求
    input  wire [ 3:0]  ram_wop,       // 写操作类型（B/H/W/N）
    input  wire [31:0]  ram_wdata,     // 写数据（来自 rs2）
    output reg  [ 3:0]  da_wen,        // 输出：字节写使能
    output reg  [31:0]  da_wdata       // 输出：对齐后的写数据
);

    wire [1:0] offset = ram_addr[1:0]; // 地址低2位，用于字节/半字对齐
    assign da_addr = ram_addr;

    // ====================== 写请求生成 ======================
    always @(*) begin
        da_wen   = 4'h0;                // 默认不写
        da_wdata = ram_wdata;           // 默认数据原样输出

        case (ram_wop)
            // SB: 写字节 — 根据地址偏移决定写哪个字节通道，同时数据移位到对应位置
            // 例如 offset=2 → da_wen=4'b0100（写第3个字节）, da_wdata = data << 16
            `RAM_WE_B: begin
                da_wen   = 4'b0001 << offset;
                da_wdata = ram_wdata << (offset * 8);
            end

            // SH: 写半字 — 地址对齐到2字节边界
            `RAM_WE_H: begin
                da_wen   = (offset[0] == 1'b0) ? ((offset[1] == 1'b0) ? 4'b0011 : 4'b1100) : 4'h0;
                da_wdata = ram_wdata << (offset[1] * 16);
            end

            // SW: 写字 — 要求4字节对齐，offset必须为0
            // 如果 offset != 0，da_wen 保持为 0（静默忽略非对齐访问）
            `RAM_WE_W:
                if (offset == 2'h0) begin
                    da_wen = ram_wop;   // ram_wop = 4'b1111
                end
            default: begin
                da_wen   = 4'h0;
                da_wdata = ram_wdata;
            end
        endcase
    end

    // ====================== 读请求生成 ======================
    always @(*) begin
        if (ram_rop != `RAM_EXT_N) begin   // ram_rop != N 表示有读请求
            case (ram_rop)
                // LB/LBU: 读字节 — 总是请求全部4字节（简化处理）
                // 后续 MEXT 再从中提取所需字节
                `RAM_EXT_B, `RAM_EXT_BU:
                    da_ren = 4'hF;

                // LH/LHU: 读半字 — 只在 offset[0]==0 时请求（半字对齐检查）
                // 如果不是半字对齐，da_ren=0，读回的数据无效
                `RAM_EXT_H, `RAM_EXT_HU:
                    da_ren = (offset[0] == 1'b0) ? 4'hF : 4'h0;

                // LW: 读字 — 只在 offset==0 时请求（4字节对齐检查）
                default:
                    da_ren = (offset == 2'h0) ? 4'hF : 4'h0;
            endcase
        end else
            da_ren = 4'h0;                // 无读请求
    end

endmodule
