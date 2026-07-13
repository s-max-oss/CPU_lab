`timescale 1ns / 1ps

module mac (
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] x,
    input  wire [31:0] y,
    input  wire        start,
    output wire [31:0] z,
    output wire        busy 
);

    // 四个乘法器的乘积（64位）与忙标志
    wire [63:0] p0, p1, p2, p3;
    wire        busy0, busy1, busy2, busy3;

    // 实例化四个乘法器，分别处理四个8位有符号数
    // 输入需要进行符号扩展至32位，与你的 multiplier 接口匹配
    multiplier mul0 (
        .clk  (clk),
        .rst  (rst),
        .x    ( {{24{x[ 7]}}, x[ 7:0]} ),
        .y    ( {{24{y[ 7]}}, y[ 7:0]} ),
        .start(start),
        .z    (p0),
        .busy (busy0)
    );

    multiplier mul1 (
        .clk  (clk),
        .rst  (rst),
        .x    ( {{24{x[15]}}, x[15:8]} ),
        .y    ( {{24{y[15]}}, y[15:8]} ),
        .start(start),
        .z    (p1),
        .busy (busy1)
    );

    multiplier mul2 (
        .clk  (clk),
        .rst  (rst),
        .x    ( {{24{x[23]}}, x[23:16]} ),
        .y    ( {{24{y[23]}}, y[23:16]} ),
        .start(start),
        .z    (p2),
        .busy (busy2)
    );

    multiplier mul3 (
        .clk  (clk),
        .rst  (rst),
        .x    ( {{24{x[31]}}, x[31:24]} ),
        .y    ( {{24{y[31]}}, y[31:24]} ),
        .start(start),
        .z    (p3),
        .busy (busy3)
    );

    // 忙标志：任意一个乘法器在工作，整个 mac 就处于忙状态
    assign busy = busy0 | busy1 | busy2 | busy3;

    // 组合输出：四个16位有符号乘积的低32位直接相加
    // 乘积的有效位为低16位，高位均为符号扩展，直接取 [31:0] 即可
    assign z = p0[31:0] + p1[31:0] + p2[31:0] + p3[31:0];

endmodule