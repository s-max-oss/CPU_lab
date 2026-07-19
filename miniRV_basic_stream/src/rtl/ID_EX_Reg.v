// ============================================================================
// ID_EX_Reg.v — ID/EX 流水线寄存器
// ============================================================================
// 连接 ID（译码/寄存器读）和 EX（执行）阶段。
// 锁存寄存器读值、立即数、目标寄存器号以及全部控制信号。
//
// flush=1 → 控制信号清零（插入气泡/Bubble）— 分支跳转、load-use stall
// stall=1 → 保持当前值（Hold）— 多周期乘除法阻塞
// ============================================================================

`timescale 1ns / 1ps

module ID_EX_Reg (
    input  wire         clk,
    input  wire         rst,
    input  wire         flush,
    input  wire         stall,

    // 数据通路
    input  wire [31:0]  pc_in,
    input  wire [31:0]  rD1_in,
    input  wire [31:0]  rD2_in,
    input  wire [31:0]  ext_in,
    input  wire [31:0]  pc4_in,
    input  wire [ 4:0]  rs1_addr_in,
    input  wire [ 4:0]  rs2_addr_in,
    input  wire [ 4:0]  rd_addr_in,

    // 控制信号 — 来自 Controller（译码时产生）
    input  wire [ 1:0]  npc_op_in,
    input  wire [ 4:0]  alu_op_in,
    input  wire         alua_sel_in,
    input  wire         alub_sel_in,
    input  wire [ 2:0]  sext_op_in,
    input  wire [ 2:0]  ram_rop_in,
    input  wire [ 3:0]  ram_wop_in,
    input  wire         rf_we_in,
    input  wire [ 1:0]  rf_wsel_in,
    input  wire         is_mul_in,
    input  wire         is_div_in,

    // 输出（打一拍）
    output reg  [31:0]  pc_out,
    output reg  [31:0]  rD1_out,
    output reg  [31:0]  rD2_out,
    output reg  [31:0]  ext_out,
    output reg  [31:0]  pc4_out,
    output reg  [ 4:0]  rs1_addr_out,
    output reg  [ 4:0]  rs2_addr_out,
    output reg  [ 4:0]  rd_addr_out,

    output reg  [ 1:0]  npc_op_out,
    output reg  [ 4:0]  alu_op_out,
    output reg          alua_sel_out,
    output reg          alub_sel_out,
    output reg  [ 2:0]  sext_op_out,
    output reg  [ 2:0]  ram_rop_out,
    output reg  [ 3:0]  ram_wop_out,
    output reg          rf_we_out,
    output reg  [ 1:0]  rf_wsel_out,
    output reg          is_mul_out,
    output reg          is_div_out
);

    always @(posedge clk or posedge rst) begin
        if (rst || flush) begin
            // 气泡：控制信号全部清零 = NOP（不写寄存器、不访存、顺序执行）
            pc_out        <= 32'h0;
            rD1_out       <= 32'h0;
            rD2_out       <= 32'h0;
            ext_out       <= 32'h0;
            pc4_out       <= 32'h0;
            rs1_addr_out  <= 5'h0;
            rs2_addr_out  <= 5'h0;
            rd_addr_out   <= 5'h0;
            npc_op_out    <= 2'b00;   // PC4
            alu_op_out    <= 5'h0;    // ADD
            alua_sel_out  <= 1'b0;
            alub_sel_out  <= 1'b0;
            sext_op_out   <= 3'b0;
            ram_rop_out   <= 3'b0;    // N
            ram_wop_out   <= 4'b0;    // N
            rf_we_out     <= 1'b0;
            rf_wsel_out   <= 2'b0;
            is_mul_out    <= 1'b0;
            is_div_out    <= 1'b0;
        end else if (!stall) begin
            pc_out        <= pc_in;
            rD1_out       <= rD1_in;
            rD2_out       <= rD2_in;
            ext_out       <= ext_in;
            pc4_out       <= pc4_in;
            rs1_addr_out  <= rs1_addr_in;
            rs2_addr_out  <= rs2_addr_in;
            rd_addr_out   <= rd_addr_in;
            npc_op_out    <= npc_op_in;
            alu_op_out    <= alu_op_in;
            alua_sel_out  <= alua_sel_in;
            alub_sel_out  <= alub_sel_in;
            sext_op_out   <= sext_op_in;
            ram_rop_out   <= ram_rop_in;
            ram_wop_out   <= ram_wop_in;
            rf_we_out     <= rf_we_in;
            rf_wsel_out   <= rf_wsel_in;
            is_mul_out    <= is_mul_in;
            is_div_out    <= is_div_in;
        end
    end

endmodule
