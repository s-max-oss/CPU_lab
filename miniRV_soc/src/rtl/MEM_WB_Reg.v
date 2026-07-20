// ============================================================================
// MEM_WB_Reg.v — MEM/WB 流水线寄存器
// ============================================================================
// 连接 MEM（访存）和 WB（写回）阶段。
// 锁存 ALU 结果、内存读数据、PC+4、目标寄存器号及写回控制信号。
// ============================================================================

`timescale 1ns / 1ps

module MEM_WB_Reg (
    input  wire         clk,
    input  wire         rst,
    input  wire         flush,

    // 数据通路
    input  wire [31:0]  alu_c_in,
    input  wire [31:0]  ram_ext_in,
    input  wire [31:0]  pc4_in,
    input  wire [ 4:0]  rd_addr_in,

    // 控制信号
    input  wire         rf_we_in,
    input  wire [ 1:0]  rf_wsel_in,
    input  wire [ 2:0]  ram_rop_in,     // MEXT 读类型（延迟到 WB 使用）
    input  wire [ 1:0]  byte_offs_in,   // 地址低 2 位字节偏移

    // 输出
    output reg  [31:0]  alu_c_out,
    output reg  [31:0]  ram_ext_out,
    output reg  [31:0]  pc4_out,
    output reg  [ 4:0]  rd_addr_out,
    output reg          rf_we_out,
    output reg  [ 1:0]  rf_wsel_out,
    output reg  [ 2:0]  ram_rop_out,
    output reg  [ 1:0]  byte_offs_out
);

    always @(posedge clk or posedge rst) begin
        if (rst || flush) begin
            alu_c_out     <= 32'h0;
            ram_ext_out   <= 32'h0;
            pc4_out       <= 32'h0;
            rd_addr_out   <= 5'h0;
            rf_we_out     <= 1'b0;
            rf_wsel_out   <= 2'b0;
            ram_rop_out   <= 3'b0;
            byte_offs_out <= 2'b0;
        end else begin
            alu_c_out     <= alu_c_in;
            ram_ext_out   <= ram_ext_in;
            pc4_out       <= pc4_in;
            rd_addr_out   <= rd_addr_in;
            rf_we_out     <= rf_we_in;
            rf_wsel_out   <= rf_wsel_in;
            ram_rop_out   <= ram_rop_in;
            byte_offs_out <= byte_offs_in;
        end
    end

endmodule
