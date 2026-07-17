// ============================================================================
// IF_ID_Reg.v — IF/ID 流水线寄存器
// ============================================================================
// 连接 IF（取指）和 ID（译码）阶段。每拍锁存 PC 和指令字。
//
// flush=1 → 输出清零（inst 强制为 NOP），用于分支跳转时废弃已取指令
// stall=1 → 输出保持，用于 load-use 冒险阻塞
// ============================================================================

`timescale 1ns / 1ps

module IF_ID_Reg (
    input  wire         clk,
    input  wire         rst,
    input  wire         flush,       // 分支跳转时清空（转为 NOP）
    input  wire         stall,       // load-use 冒险时保持

    input  wire [31:0]  pc_in,
    input  wire [31:0]  inst_in,

    output reg  [31:0]  pc_out,
    output reg  [31:0]  inst_out
);

    always @(posedge clk or posedge rst) begin
        if (rst || flush) begin
            pc_out   <= 32'h0;
            inst_out <= 32'h00000013;   // NOP: addi x0, x0, 0
        end else if (!stall) begin
            pc_out   <= pc_in;
            inst_out <= inst_in;
        end
    end

endmodule
