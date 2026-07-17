// ============================================================================
// multiplier.v — 乘法器（参数化位宽）
// ============================================================================
// 【功能】带符号扩展的乘法运算
// 【实现方式】直接用 Verilog 的 * 运算符，让综合器自动推断乘法器
//   - 对于 FPGA: 综合为 DSP 硬核乘法器（高性能）或 LUT 乘法器（节省资源）
//   - 对于仿真: 直接调用仿真器的乘法运算
//
// 【符号处理技巧】
//   输入 x, y 先做符号扩展（重复最高位到 2*WIDTH），然后再做乘法
//   例如 WIDTH=32: x_s = { {32{x[31]}}, x }  → 扩展到64位
//   例如 WIDTH=33（无符号用法）: x_s = {1'b0, x} → 高位补0，强制无符号乘法
//   这样无论输入是 $signed 还是 $unsigned，都能得到正确结果
//
// 【注意】本设计中 busy 直接接0（单周期完成），但保留了 busy 接口以便
//   未来替换为多周期流水线乘法器（如果FPGA频率太高，DSP可能无法单周期完成）
// ============================================================================

`timescale 1ns / 1ps

module multiplier #(
    parameter WIDTH = 32              // 操作数位宽，默认32
)(
    input  wire        clk,
    input  wire        rst,
    input  wire [WIDTH-1:0] x,        // 被乘数
    input  wire [WIDTH-1:0] y,        // 乘数
    input  wire        start,         // 启动信号（上升沿触发）
    output reg  [2*WIDTH-1:0] z,      // 乘积（位宽 = 2*WIDTH）
    output wire        busy           // 忙标志（本设计恒为0）
);

    assign busy = 1'b0;               // 组合逻辑，不需要等待

    always @(posedge clk or posedge rst) begin
        if (rst)
            z <= 0;
        else if (start)
            // 符号扩展后相乘：
            //   { {WIDTH{x[WIDTH-1]}}, x } 意思是"用x的最高位重复WIDTH次，然后接x"
            //   例如 x=8'hFF(-1), WIDTH=8 → 扩展为 16'hFFFF
            z <= {{WIDTH{x[WIDTH-1]}}, x} * {{WIDTH{y[WIDTH-1]}}, y};
    end

endmodule
