// ============================================================================
// NPC.v — 下一条指令地址计算模块 (Next PC)
// ============================================================================
// 【功能】根据当前 pc 和控制信号 op，计算出下一条指令的地址 npc
// 【四种模式】
//   NPC_PC4  (00): pc + 4         — 顺序执行，默认跳转
//   NPC_BRA  (10): 条件分支        — br=1 则 pc+offset，否则 pc+4
//   NPC_JMP  (11): JAL 无条件跳转  — pc + offset（offset由J-type立即数扩展得到）
//   NPC_JALR (01): JALR 间接跳转   — (rs1+offset) 并清零最低位（对齐2字节边界）
// 【理解重点】
//   分支指令需要 ALU 先计算 br 信号（比较结果），再由此模块决定是否跳转
//   JALR 的 {target[31:1], 1'b0} 是为了确保目标地址是2字节对齐（RISC-V压缩指令要求）
// ============================================================================

`timescale 1ns / 1ps

`include "defines.vh"

module NPC (
    input  wire [ 1:0]  op,           // NPC操作类型（来自Controller）
    input  wire [31:0]  pc,           // 当前PC值
    input  wire [31:0]  offset,       // 偏移量（来自SEXT，即符号扩展后的立即数）
    input  wire         br,           // 分支条件（来自ALU的比较结果）
    input  wire [31:0]  jmp_target,   // JALR跳转目标地址（即ALU计算出的 rs1+offset）

    output reg  [31:0]  npc,          // 计算出的下一条指令地址
    output wire [31:0]  pc4           // pc+4，供JAL/JALR保存返回地址用
);

    assign pc4 = pc + 32'h4;

    always @(*) begin
        case (op)
            `NPC_PC4 : npc = pc4;                         // 默认：顺序执行
            `NPC_BRA : npc = br ? pc + offset : pc4;      // 条件分支：满足→跳转，不满足→顺序
            `NPC_JMP : npc = pc + offset;                 // JAL：无条件跳转
            `NPC_JALR: npc = {jmp_target[31:1], 1'b0};    // JALR：间接跳转，低位清零对齐
            default  : npc = pc4;                          // 保险：默认顺序执行
        endcase
    end

endmodule
