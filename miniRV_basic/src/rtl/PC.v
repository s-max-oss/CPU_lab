// ============================================================================
// PC.v — 程序计数器模块
// ============================================================================
// 【功能】保存当前指令的地址。每个时钟周期：
//   - 复位时：pc = 0（CPU从0地址开始执行）
//   - 正常时：若 fetch 信号有效，则更新为 npc（下一条指令地址），否则保持
// 【理解重点】
//   fetch 信号来自 cpu_core 中的 inst_finished，即"当前指令执行完毕才取下一条"
//   这就实现了"单周期CPU"的节奏控制——指令未完成时PC保持不变（阻塞取指）
// ============================================================================

`timescale 1ns / 1ps

module PC (
    input  wire         clk,         // 时钟
    input  wire         rst,         // 复位（高有效）
    input  wire [31:0]  npc,         // Next PC — 下一条指令地址（由NPC模块计算）
    input  wire         fetch,       // 取指使能 — 为1时PC才能更新
    output reg  [31:0]  pc          // 当前指令地址
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            pc <= 32'h0;             // 复位后从地址0开始执行
        else
            pc <= fetch ? npc : pc;  // fetch=1 → 更新PC；fetch=0 → 保持（CPU在处理多周期指令）
    end

endmodule
