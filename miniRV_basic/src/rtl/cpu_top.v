// ============================================================================
// cpu_top.v — SoC 顶层模块
// ============================================================================
// 【功能】将 CPU 核心（cpu_core）、指令存储器（Inst_ROM）、数据存储器（Data_RAM）
//   三个大模块连接在一起，形成完整的片上系统（SoC）。
//
// 【架构】
//   ┌──────────┐   取指    ┌──────────┐
//   │ Inst_ROM │ ←──────→ │          │
//   │  (IROM)  │  inst    │          │
//   └──────────┘          │ cpu_core │
//                         │          │
//   ┌──────────┐   访存   │          │
//   │ Data_RAM │ ←──────→ │          │
//   │  (DRAM)  │  data    └──────────┘
//   └──────────┘
//
// 【理解重点】本模块非常简单——只有连线（wire声明+端口连接），没有逻辑。
//   这是典型的"结构描述"(Structural Verilog)，类似画电路图。
//
// 【端口说明】
//   对外只有两个信号：cpu_clk(时钟)和cpu_rst(复位)。
//   在真实 SoC 中还会有 GPIO、UART、SPI 等外设接口，但本实验只到 CPU 核心。
// ============================================================================

`timescale 1ns / 1ps

`include "defines.vh"

module cpu_top(
    input  wire         cpu_clk,       // 系统时钟
    input  wire         cpu_rst        // 系统复位（高有效）
);

    // ------ 指令接口信号（CPU ↔ Inst_ROM） ------
    wire        cpu2ic_rreq;           // CPU → IROM: 取指请求
    wire [31:0] cpu2ic_addr;           // CPU → IROM: 取指地址
    wire        ic2cpu_valid;          // IROM → CPU: 指令有效
    wire [31:0] ic2cpu_inst;           // IROM → CPU: 指令字

    // ------ 数据接口信号（CPU ↔ Data_RAM） ------
    wire [ 3:0] cpu2dc_ren;            // CPU → DRAM: 字节读使能
    wire [31:0] cpu2dc_addr;           // CPU → DRAM: 地址
    wire        dc2cpu_valid;          // DRAM → CPU: 读数据有效
    wire [31:0] dc2cpu_rdata;          // DRAM → CPU: 读数据
    wire [ 3:0] cpu2dc_wen;            // CPU → DRAM: 字节写使能
    wire [31:0] cpu2dc_wdata;          // CPU → DRAM: 写数据
    wire        dc2cpu_wresp;          // DRAM → CPU: 写响应

    // ------ CPU 核心 ------
    cpu_core U_core (
        .cpu_clk        (cpu_clk),
        .cpu_rst        (cpu_rst),
        // 指令接口
        .ifetch_req     (cpu2ic_rreq),
        .ifetch_addr    (cpu2ic_addr),
        .ifetch_valid   (ic2cpu_valid),
        .ifetch_inst    (ic2cpu_inst),
        // 数据接口
        .daccess_ren    (cpu2dc_ren),
        .daccess_addr   (cpu2dc_addr),
        .daccess_rvalid (dc2cpu_valid),
        .daccess_rdata  (dc2cpu_rdata),
        .daccess_wen    (cpu2dc_wen),
        .daccess_wdata  (cpu2dc_wdata),
        .daccess_wresp  (dc2cpu_wresp)
    );

    // ------ 指令存储器（Block RAM, 由 IROM IP 核实现） ------
    Inst_ROM U_irom (
        .cpu_clk        (cpu_clk),
        .cpu_rst        (cpu_rst),
        .inst_rreq      (cpu2ic_rreq),
        .inst_addr      (cpu2ic_addr),
        .inst_valid     (ic2cpu_valid),
        .inst_out       (ic2cpu_inst)
    );

    // ------ 数据存储器（Block RAM, 由 DRAM IP 核实现） ------
    Data_RAM U_dram (
        .cpu_clk        (cpu_clk),
        .cpu_rst        (cpu_rst),
        .data_ren       (cpu2dc_ren),
        .data_addr      (cpu2dc_addr),
        .data_valid     (dc2cpu_valid),
        .data_rdata     (dc2cpu_rdata),
        .data_wen       (cpu2dc_wen),
        .data_wdata     (cpu2dc_wdata),
        .data_wresp     (dc2cpu_wresp)
    );

endmodule
