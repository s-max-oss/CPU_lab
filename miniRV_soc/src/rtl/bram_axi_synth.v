// ============================================================================
// bram_axi_synth.v — 可综合的 AXI4 BRAM 存储器 (FPGA 用)
// ============================================================================
// 基于 cdp-tests/vsrc/bram_axi.v 简化, 移除 $display/$fopen/$fread,
// 改用 Vivado 支持的 $readmemh 进行 BRAM 初始化。
//
// 参数:
//   DATA_WIDTH  = 32    数据宽度
//   DATA_DEPTH  = 32768 存储深度 (128KB)
//   MEM_HEX     = "program.hex"  初始化文件 (相对于 Vivado 工程目录)
//
// AXI4 接口 (精简版, 仅支持单拍读写, burst 实际不支持):
//   - AW/W/B: 写地址/写数据/写响应通道
//   - AR/R:   读地址/读数据通道

`timescale 1ns / 1ps

module bram_axi_synth #(
    parameter DATA_WIDTH = 32,
    parameter DATA_DEPTH = 32768,
    parameter MEM_HEX    = "program.hex"
) (
    input  wire         s_aclk,
    input  wire         s_aresetn,     // low active

    // AXI Write Address
    input  wire [31:0]  s_axi_awaddr,
    input  wire [ 7:0]  s_axi_awlen,
    input  wire [ 2:0]  s_axi_awsize,
    input  wire [ 1:0]  s_axi_awburst,
    input  wire         s_axi_awvalid,
    output wire         s_axi_awready,

    // AXI Write Data
    input  wire [31:0]  s_axi_wdata,
    input  wire [ 3:0]  s_axi_wstrb,
    input  wire         s_axi_wlast,
    input  wire         s_axi_wvalid,
    output wire         s_axi_wready,

    // AXI Write Response
    output wire [ 1:0]  s_axi_bresp,
    output wire         s_axi_bvalid,
    input  wire         s_axi_bready,

    // AXI Read Address
    input  wire [31:0]  s_axi_araddr,
    input  wire [ 7:0]  s_axi_arlen,
    input  wire [ 2:0]  s_axi_arsize,
    input  wire [ 1:0]  s_axi_arburst,
    input  wire         s_axi_arvalid,
    output wire         s_axi_arready,

    // AXI Read Data
    output wire [31:0]  s_axi_rdata,
    output wire [ 1:0]  s_axi_rresp,
    output wire         s_axi_rlast,
    output wire         s_axi_rvalid,
    input  wire         s_axi_rready
);

    localparam ADDR_WIDTH = $clog2(DATA_DEPTH);

    // BRAM 存储体
    (* ram_style = "block" *)
    reg [DATA_WIDTH-1:0] mem [0:DATA_DEPTH-1];

    // ------ 上电初始化 ------
    // $readmemh 在 Vivado 综合时支持, 用于 BRAM 初始化
    initial begin
        $readmemh(MEM_HEX, mem);
    end

    // ------ 写通道 (组合逻辑 ready, 单周期完成) ------
    assign s_axi_awready = 1'b1;
    assign s_axi_wready  = 1'b1;

    wire aw_hs = s_axi_awvalid && s_axi_awready;
    wire w_hs  = s_axi_wvalid && s_axi_wready;

    // 写数据
    wire [ADDR_WIDTH-1:0] wr_addr = s_axi_awaddr[ADDR_WIDTH+1:2];
    integer i;
    always @(posedge s_aclk) begin
        if (w_hs) begin
            for (i = 0; i < 4; i = i + 1) begin
                if (s_axi_wstrb[i])
                    mem[wr_addr][i*8 +: 8] <= s_axi_wdata[i*8 +: 8];
            end
        end
    end

    // 写响应
    reg aw_done, w_done;
    always @(posedge s_aclk or negedge s_aresetn) begin
        if (!s_aresetn) begin
            aw_done <= 1'b0;
            w_done  <= 1'b0;
        end else begin
            if (aw_hs) aw_done <= 1'b1;
            else if (s_axi_bvalid && s_axi_bready) aw_done <= 1'b0;
            if (w_hs)  w_done  <= 1'b1;
            else if (s_axi_bvalid && s_axi_bready) w_done  <= 1'b0;
        end
    end

    reg bvalid_reg;
    always @(posedge s_aclk or negedge s_aresetn) begin
        if (!s_aresetn)
            bvalid_reg <= 1'b0;
        else if (s_axi_bvalid && s_axi_bready)
            bvalid_reg <= 1'b0;
        else if (aw_done && w_done)
            bvalid_reg <= 1'b1;
    end
    assign s_axi_bvalid = bvalid_reg;
    assign s_axi_bresp  = 2'b00;

    // ------ 读通道 ------
    assign s_axi_arready = 1'b1;

    wire [ADDR_WIDTH-1:0] rd_addr = s_axi_araddr[ADDR_WIDTH+1:2];

    reg [31:0] rdata_reg;
    reg        rvalid_reg;
    always @(posedge s_aclk or negedge s_aresetn) begin
        if (!s_aresetn) begin
            rdata_reg  <= 32'h0;
            rvalid_reg <= 1'b0;
        end else if (s_axi_arvalid && !rvalid_reg) begin
            rdata_reg  <= mem[rd_addr];
            rvalid_reg <= 1'b1;
        end else if (s_axi_rready) begin
            rvalid_reg <= 1'b0;
        end
    end
    assign s_axi_rdata  = rdata_reg;
    assign s_axi_rvalid = rvalid_reg;
    assign s_axi_rresp  = 2'b00;
    assign s_axi_rlast  = 1'b1;

endmodule
