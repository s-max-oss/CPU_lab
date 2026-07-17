// ============================================================================
// divider.v — 除法器（参数化位宽）
// ============================================================================
// 【功能】带除零保护的除法/取模运算
// 【实现方式】直接使用 Verilog 的 / 和 % 运算符
// 【除零处理】当除数 y=0 时：
//   - 商 = -1（全F，RISC-V规范要求）
//   - 余数 = 被除数 x
// 【注意】本设计中 busy 也用1拍完成，与 multiplier 不同，busy 在 start 当拍就是0
//   但为了统一的接口兼容性保留了 busy 输出
// ============================================================================

`timescale 1ns / 1ps

module divider #(
    parameter WIDTH = 32              // 操作数位宽，默认32
)(
    input  wire       clk,
    input  wire       rst,
    input  wire [WIDTH-1:0] x,        // 被除数
    input  wire [WIDTH-1:0] y,        // 除数
    input  wire       start,          // 启动信号
    output reg  [WIDTH-1:0] z,        // 商（quotient）
    output reg  [WIDTH-1:0] r,        // 余数（remainder）
    output reg        busy            // 忙标志
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            z    <= 0;
            r    <= 0;
            busy <= 1'b0;
        end else if (start) begin
            if (y != 0) begin
                // 正常除法：直接使用 Verilog 运算符
                z <= x / y;
                r <= x % y;
            end else begin
                // 除零：商 = -1，余数 = x（符合RISC-V M扩展规范）
                z <= -1;
                r <= x;
            end
            busy <= 1'b0;
        end else begin
            busy <= 1'b0;
        end
    end

endmodule
