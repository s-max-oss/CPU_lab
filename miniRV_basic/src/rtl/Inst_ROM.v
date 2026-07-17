// ============================================================================
// Inst_ROM.v — 指令存储器封装模块
// ============================================================================
// 【功能】封装 Vivado Block Memory Generator IP 核（IROM），
//   为 CPU 提供"组合逻辑读+1拍valid延迟"的指令读取接口。
//
// 【接口时序】
//   T0: cpu设置 inst_rreq=1, inst_addr=地址
//   T1: IROM读取，inst_valid=1, inst_out=指令字（有效1拍）
//   注意：inst_valid 就是把 inst_rreq 打了一拍
//
// 【地址映射】CPU 给出的地址是字节地址，IROM 需要字地址（4字节对齐），
//   所以取 inst_addr[31:2]（去掉低2位）连接到 IROM 的 addra。
//
// 【IROM 是什么？】由 Vivado 的 Block Memory Generator 生成的片上 ROM，
//   内容在综合时由 .coe 文件指定，存的是编译好的RISC-V机器码。
// ============================================================================

`timescale 1ns / 1ps

`include "defines.vh"

module Inst_ROM (
    input  wire         cpu_clk,         // 时钟
    input  wire         cpu_rst,         // 复位（高有效）

    // CPU 接口
    input  wire         inst_rreq,       // 取指请求
    input  wire [31:0]  inst_addr,       // 取指地址（字节地址）
    output reg          inst_valid,      // 指令有效（= inst_rreq 的打拍）
    output wire [31:0]  inst_out         // 读出的32位指令字
);

    // inst_valid = inst_rreq 延迟1拍
    always @(posedge cpu_clk or posedge cpu_rst) begin
        inst_valid <= cpu_rst ? 1'b0 : inst_rreq;
    end

    // IROM IP核实例 — Block Memory Generator 生成的原语
    IROM U_irom (
        .clka   (cpu_clk),               // 时钟
        .addra  (inst_addr[31:2]),       // 字地址（去掉低2位字节偏移）
        .douta  (inst_out)               // 读出的指令
    );

endmodule
