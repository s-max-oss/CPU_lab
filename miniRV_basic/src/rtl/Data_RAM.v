// ============================================================================
// Data_RAM.v — 数据存储器封装模块
// ============================================================================
// 【功能】封装 Vivado Block Memory Generator IP 核（DRAM），
//   为 CPU 提供带字节使能的读写接口。
//
// 【接口说明】
//   读通道: data_ren(字节使能) + data_addr(地址) → data_valid(延迟1拍) + data_rdata(数据)
//   写通道: data_wen(字节使能) + data_addr(地址) + data_wdata(数据) → data_wresp(延迟1拍)
//
// 【时序】
//   - valid 和 wresp 都是请求信号的1拍延迟
//   - 读返回32位数据，DRAM内部处理字节使能
//   - 写wresp只是确认"已写入"，无错误信号（BRAM不会出错）
//
// 【与 Inst_ROM 的对照】
//   - Inst_ROM: 只读，无字节使能
//   - Data_RAM: 可读写，有字节使能
//   两者都是对 Vivado Block Memory IP 的薄封装
// ============================================================================

`timescale 1ns / 1ps

`include "defines.vh"

module Data_RAM (
    input  wire         cpu_clk,         // 时钟
    input  wire         cpu_rst,         // 复位（高有效）

    // CPU 读接口
    input  wire [ 3:0]  data_ren,        // 字节读使能（哪几个字节有效）
    input  wire [31:0]  data_addr,       // 读地址（字节地址）
    output reg          data_valid,      // 读数据有效（= |data_ren 的延迟1拍）
    output wire [31:0]  data_rdata,      // 读出数据

    // CPU 写接口
    input  wire [ 3:0]  data_wen,        // 字节写使能（哪几个字节要写）
    input  wire [31:0]  data_wdata,      // 写入数据
    output reg          data_wresp       // 写响应（= |data_wen 的延迟1拍）
);

    // data_valid 和 data_wresp 是相应请求的1拍延迟
    // |data_ren 表示"有读请求吗"（data_ren任一位为1就是有）
    // |data_wen 表示"有写请求吗"
    always @(posedge cpu_clk or posedge cpu_rst) begin
        data_valid <= cpu_rst ? 1'b0 : |data_ren;
        data_wresp <= cpu_rst ? 1'b0 : |data_wen;
    end

    // DRAM IP核实例 — Block Memory Generator 生成的原语
    // 支持字节使能（wea[3:0]），可以按字节/半字/字粒度写入
    DRAM U_dram (
        .clka   (cpu_clk),               // 时钟
        .addra  (data_addr[31:2]),       // 字地址（去掉低2位字节偏移）
        .douta  (data_rdata),            // 读数据
        .wea    (data_wen),              // 字节写使能
        .dina   (data_wdata)             // 写数据
    );

endmodule
