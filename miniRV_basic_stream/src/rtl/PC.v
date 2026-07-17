// ============================================================================
// PC.v — 程序计数器模块（流水线版本）
// ============================================================================
// 【功能】保存当前指令地址，流水线模式下每拍更新。
//   - 复位时：pc = 0
//   - stall=0 → pc <= npc（正常流水，每拍取一条）
//   - stall=1 → pc 保持（load-use 冒险阻塞）
// 【与单周期版本的区别】
//   - 单周期：fetch(=inst_finished) 控制更新，指令未完成则阻塞
//   - 流水线：stall 控制更新，只有 load-use 冒险才阻塞（每拍都在取指）
// ============================================================================

`timescale 1ns / 1ps

module PC (
    input  wire         clk,
    input  wire         rst,
    input  wire [31:0]  npc,
    input  wire         stall,       // 阻塞信号：1=PC保持（load-use时），0=正常更新
    output reg  [31:0]  pc
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            pc <= 32'h0;
        else if (!stall)
            pc <= npc;
    end

endmodule
