// ============================================================================
// EX_MEM_Reg.v — EX/MEM 流水线寄存器
// ============================================================================
// 连接 EX（执行）和 MEM（访存）阶段。
// 锁存 ALU 结果、写数据、分支条件、目标寄存器号及 MEM/WB 阶段需要的控制信号。
// ============================================================================

`timescale 1ns / 1ps

module EX_MEM_Reg (
    input  wire         clk,
    input  wire         rst,
    input  wire         flush,

    // 数据通路
    input  wire [31:0]  alu_c_in,
    input  wire [31:0]  rD2_in,        // 存数指令的数据（rs2 原值）
    input  wire [31:0]  pc4_in,
    input  wire         br_in,         // 分支条件
    input  wire [ 4:0]  rd_addr_in,

    // 控制信号 — MEM/WB 阶段使用
    input  wire [ 1:0]  npc_op_in,     // 分支判断
    input  wire [ 2:0]  ram_rop_in,
    input  wire [ 3:0]  ram_wop_in,
    input  wire         rf_we_in,
    input  wire [ 1:0]  rf_wsel_in,

    // 输出
    output reg  [31:0]  alu_c_out,
    output reg  [31:0]  rD2_out,
    output reg  [31:0]  pc4_out,
    output reg          br_out,
    output reg  [ 4:0]  rd_addr_out,

    output reg  [ 1:0]  npc_op_out,
    output reg  [ 2:0]  ram_rop_out,
    output reg  [ 3:0]  ram_wop_out,
    output reg          rf_we_out,
    output reg  [ 1:0]  rf_wsel_out
);

    always @(posedge clk or posedge rst) begin
        if (rst || flush) begin
            alu_c_out    <= 32'h0;
            rD2_out      <= 32'h0;
            pc4_out      <= 32'h0;
            br_out       <= 1'b0;
            rd_addr_out  <= 5'h0;
            npc_op_out   <= 2'b00;
            ram_rop_out  <= 3'b0;   // N
            ram_wop_out  <= 4'b0;   // N
            rf_we_out    <= 1'b0;
            rf_wsel_out  <= 2'b0;
        end else begin
            alu_c_out    <= alu_c_in;
            rD2_out      <= rD2_in;
            pc4_out      <= pc4_in;
            br_out       <= br_in;
            rd_addr_out  <= rd_addr_in;
            npc_op_out   <= npc_op_in;
            ram_rop_out  <= ram_rop_in;
            ram_wop_out  <= ram_wop_in;
            rf_we_out    <= rf_we_in;
            rf_wsel_out  <= rf_wsel_in;
        end
    end

endmodule
