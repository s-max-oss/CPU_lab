// ============================================================================
// cpu_top.v — SoC 顶层模块（单周期 CPU + ICache + DCache + AXI 总线控制器）
// ============================================================================
// 【架构】
//   ┌──────────┐   取指    ┌──────────┐   读总线   ┌────────────┐
//   │ cpu_core │ ←──────→ │  ICache  │ ←───────→ │            │
//   │          │  inst    └──────────┘           │            │
//   │ 单周期   │                                 │ axi_master │ → AXI4 Master
//   │          │   访存    ┌──────────┐  读写总线  │            │   对外接口
//   │          │ ←──────→ │  DCache  │ ←───────→ │            │
//   └──────────┘  data    └──────────┘           └────────────┘
//
// 【模式】
//   未定义 ENABLE_ICACHE/ENABLE_DCACHE: ICache/DCache 工作在直通模式
//   定义了 ENABLE_ICACHE/ENABLE_DCACHE: 工作在缓存模式（直接映射，4-word block）
// ============================================================================

`timescale 1ns / 1ps

`include "defines.vh"

module cpu_top(
    input  wire         cpu_clk,       // 系统时钟
    input  wire         cpu_rst,       // 系统复位（高有效）

    // ================= AXI4 Master 存储器接口 =================
    // Write Address
    output wire [31:0]  m_axi_awaddr,
    output wire [ 7:0]  m_axi_awlen,
    output wire [ 2:0]  m_axi_awsize,
    output wire [ 1:0]  m_axi_awburst,
    output wire         m_axi_awvalid,
    input  wire         m_axi_awready,
    // Write Data
    output wire [31:0]  m_axi_wdata,
    output wire [ 3:0]  m_axi_wstrb,
    output wire         m_axi_wlast,
    output wire         m_axi_wvalid,
    input  wire         m_axi_wready,
    // Write Response
    input  wire [ 1:0]  m_axi_bresp,
    input  wire         m_axi_bvalid,
    output wire         m_axi_bready,
    // Read Address
    output wire [31:0]  m_axi_araddr,
    output wire [ 7:0]  m_axi_arlen,
    output wire [ 2:0]  m_axi_arsize,
    output wire [ 1:0]  m_axi_arburst,
    output wire         m_axi_arvalid,
    input  wire         m_axi_arready,
    // Read Data
    input  wire [31:0]  m_axi_rdata,
    input  wire [ 1:0]  m_axi_rresp,
    input  wire         m_axi_rlast,
    input  wire         m_axi_rvalid,
    output wire         m_axi_rready
);

    // ------ CPU ↔ ICache 信号 ------
    wire        cpu_ifetch_req;
    wire [31:0] cpu_ifetch_addr;
    wire        ic_inst_valid;
    wire [31:0] ic_inst_out;

    // ------ CPU ↔ DCache 信号 ------
    wire [ 3:0] cpu_daccess_ren;
    wire [31:0] cpu_daccess_addr;
    wire        dc_data_valid;
    wire [31:0] dc_data_rdata;
    wire [ 3:0] cpu_daccess_wen;
    wire [31:0] cpu_daccess_wdata;
    wire        dc_data_wresp;

    // ------ ICache ↔ AXI Read Bus 信号 ------
    wire        axi_ic_dev_rrdy;
    wire [ 3:0] ic_cpu_ren;
    wire [31:0] ic_cpu_raddr;
    wire        axi_ic_dev_rvalid;
    wire [`IC_BLK_SIZE-1:0] axi_ic_dev_rdata;

    // ------ DCache ↔ AXI Write Bus 信号 ------
    wire        axi_dc_dev_wrdy;
    wire [ 3:0] dc_cpu_wen;
    wire [31:0] dc_cpu_waddr;
    wire [31:0] dc_cpu_wdata;

    // ------ DCache ↔ AXI Read Bus 信号 ------
    wire        axi_dc_dev_rrdy;
    wire [ 3:0] dc_cpu_ren;
    wire [31:0] dc_cpu_raddr;
    wire        axi_dc_dev_rvalid;
    wire [`DC_BLK_SIZE-1:0] axi_dc_dev_rdata;

    // ================================================================
    // CPU 核心（单周期，保留原接口不变）
    // ================================================================
    cpu_core U_core (
        .cpu_clk        (cpu_clk),
        .cpu_rst        (cpu_rst),
        // 指令接口
        .ifetch_req     (cpu_ifetch_req),
        .ifetch_addr    (cpu_ifetch_addr),
        .ifetch_valid   (ic_inst_valid),
        .ifetch_inst    (ic_inst_out),
        // 数据接口
        .daccess_ren    (cpu_daccess_ren),
        .daccess_addr   (cpu_daccess_addr),
        .daccess_rvalid (dc_data_valid),
        .daccess_rdata  (dc_data_rdata),
        .daccess_wen    (cpu_daccess_wen),
        .daccess_wdata  (cpu_daccess_wdata),
        .daccess_wresp  (dc_data_wresp)
    );

    // ================================================================
    // ICache — 指令缓存（直通模式 或 直接映射缓存模式）
    // ================================================================
    ICache U_icache (
        .cpu_clk        (cpu_clk),
        .cpu_rst        (cpu_rst),
        .inst_rreq      (cpu_ifetch_req),
        .inst_addr      (cpu_ifetch_addr),
        .inst_valid     (ic_inst_valid),
        .inst_out       (ic_inst_out),
        .dev_rrdy       (axi_ic_dev_rrdy),
        .cpu_ren        (ic_cpu_ren),
        .cpu_raddr      (ic_cpu_raddr),
        .dev_rvalid     (axi_ic_dev_rvalid),
        .dev_rdata      (axi_ic_dev_rdata)
    );

    // ================================================================
    // DCache — 数据缓存（直通模式 或 直接映射缓存模式）
    // ================================================================
    DCache U_dcache (
        .cpu_clk        (cpu_clk),
        .cpu_rst        (cpu_rst),
        .data_ren       (cpu_daccess_ren),
        .data_addr      (cpu_daccess_addr),
        .data_valid     (dc_data_valid),
        .data_rdata     (dc_data_rdata),
        .data_wen       (cpu_daccess_wen),
        .data_wdata     (cpu_daccess_wdata),
        .data_wresp     (dc_data_wresp),
        .dev_wrdy       (axi_dc_dev_wrdy),
        .cpu_wen        (dc_cpu_wen),
        .cpu_waddr      (dc_cpu_waddr),
        .cpu_wdata      (dc_cpu_wdata),
        .dev_rrdy       (axi_dc_dev_rrdy),
        .cpu_ren        (dc_cpu_ren),
        .cpu_raddr      (dc_cpu_raddr),
        .dev_rvalid     (axi_dc_dev_rvalid),
        .dev_rdata      (axi_dc_dev_rdata)
    );

    // ================================================================
    // AXI Master — 总线控制器（ICache/DCache 请求仲裁 → AXI4）
    // ================================================================
    // ICache/DCache 输出的 cpu_ren 是 4-bit 字节使能，OR-reduce 为单 bit 请求
    wire ic_ren_req = |ic_cpu_ren;
    wire dc_ren_req = |dc_cpu_ren;

    axi_master U_axi (
        .aclk           (cpu_clk),
        .areset         (cpu_rst),
        // ICache 读接口
        .ic_dev_rrdy    (axi_ic_dev_rrdy),
        .ic_cpu_ren     (ic_ren_req),
        .ic_cpu_raddr   (ic_cpu_raddr),
        .ic_dev_rvalid  (axi_ic_dev_rvalid),
        .ic_dev_rdata   (axi_ic_dev_rdata),
        // DCache 写接口
        .dc_dev_wrdy    (axi_dc_dev_wrdy),
        .dc_cpu_wen     (dc_cpu_wen),
        .dc_cpu_waddr   (dc_cpu_waddr),
        .dc_cpu_wdata   (dc_cpu_wdata),
        // DCache 读接口
        .dc_dev_rrdy    (axi_dc_dev_rrdy),
        .dc_cpu_ren     (dc_ren_req),
        .dc_cpu_raddr   (dc_cpu_raddr),
        .dc_dev_rvalid  (axi_dc_dev_rvalid),
        .dc_dev_rdata   (axi_dc_dev_rdata),
        // AXI4 Master
        .m_axi_awaddr   (m_axi_awaddr),
        .m_axi_awlen    (m_axi_awlen),
        .m_axi_awsize   (m_axi_awsize),
        .m_axi_awburst  (m_axi_awburst),
        .m_axi_awvalid  (m_axi_awvalid),
        .m_axi_awready  (m_axi_awready),
        .m_axi_wdata    (m_axi_wdata),
        .m_axi_wstrb    (m_axi_wstrb),
        .m_axi_wlast    (m_axi_wlast),
        .m_axi_wvalid   (m_axi_wvalid),
        .m_axi_wready   (m_axi_wready),
        .m_axi_bready   (m_axi_bready),
        .m_axi_bresp    (m_axi_bresp),
        .m_axi_bvalid   (m_axi_bvalid),
        .m_axi_araddr   (m_axi_araddr),
        .m_axi_arlen    (m_axi_arlen),
        .m_axi_arsize   (m_axi_arsize),
        .m_axi_arburst  (m_axi_arburst),
        .m_axi_arvalid  (m_axi_arvalid),
        .m_axi_arready  (m_axi_arready),
        .m_axi_rready   (m_axi_rready),
        .m_axi_rdata    (m_axi_rdata),
        .m_axi_rresp    (m_axi_rresp),
        .m_axi_rlast    (m_axi_rlast),
        .m_axi_rvalid   (m_axi_rvalid)
    );

endmodule
