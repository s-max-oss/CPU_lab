// ============================================================================
// multiplier.v — 参数化乘法器（多周期，移位相加）
// ============================================================================
// 【算法】移位相加乘法（shift-add），每次迭代 1 位
// 【时序】1 周期加载 + WIDTH 周期迭代 + 1 周期写回 ≈ WIDTH+2 周期
//   - start 脉冲启动（1 拍有效）
//   - busy 有效期间表示正在计算
//   - busy 下降沿表示结果 z 有效
// 【关键路径】1 次 WIDTH+1 位加法 ≈ 3-4ns，轻松满足 25-50MHz
// 【符号处理】取绝对值相乘，最后根据输入符号调整结果符号
//   - 有符号: x, y 均为补码，取绝对值后做无符号乘法，结果按符号位取反
//   - 无符号: 零扩展输入（MSB=0），绝对值不变，结果即为无符号积
// 【参数化】WIDTH 可配置，O_WID = 2*WIDTH
// ============================================================================

`timescale 1ns / 1ps

module multiplier #(
    parameter WIDTH = 32,
    parameter O_WID = 2 * WIDTH
)(
    input  wire                 clk,
    input  wire                 rst,
    input  wire [WIDTH-1:0]     x,
    input  wire [WIDTH-1:0]     y,
    input  wire                 start,
    output reg  [O_WID-1:0]     z,
    output wire                 busy
);

    localparam COUNT_W = WIDTH <= 2 ? 1 : $clog2(WIDTH);

    reg [O_WID-1:0]     multiplicand;
    reg [WIDTH-1:0]     multiplier_r;
    reg [O_WID-1:0]     accumulator;
    reg [COUNT_W-1:0]   count;
    reg                 result_negative;
    reg                 busy_r;

    wire [WIDTH-1:0]    x_magnitude = x[WIDTH-1] ? (~x + {{WIDTH-1{1'b0}}, 1'b1}) : x;
    wire [WIDTH-1:0]    y_magnitude = y[WIDTH-1] ? (~y + {{WIDTH-1{1'b0}}, 1'b1}) : y;
    wire [O_WID-1:0]    accumulator_next = accumulator
                            + (multiplier_r[0] ? multiplicand : {O_WID{1'b0}});

    assign busy = busy_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            z               <= {O_WID{1'b0}};
            multiplicand    <= {O_WID{1'b0}};
            multiplier_r    <= {WIDTH{1'b0}};
            accumulator     <= {O_WID{1'b0}};
            count           <= {COUNT_W{1'b0}};
            result_negative <= 1'b0;
            busy_r          <= 1'b0;
        end else if (start && !busy_r) begin
            multiplicand    <= {{WIDTH{1'b0}}, x_magnitude};
            multiplier_r    <= y_magnitude;
            accumulator     <= {O_WID{1'b0}};
            count           <= {COUNT_W{1'b0}};
            result_negative <= x[WIDTH-1] ^ y[WIDTH-1];
            busy_r          <= 1'b1;
        end else if (busy_r) begin
            if (count == WIDTH - 1) begin
                z <= result_negative
                    ? (~accumulator_next + {{O_WID-1{1'b0}}, 1'b1})
                    : accumulator_next;
                busy_r <= 1'b0;
            end else begin
                accumulator  <= accumulator_next;
                multiplicand <= multiplicand << 1;
                multiplier_r <= multiplier_r >> 1;
                count        <= count + 1'b1;
            end
        end
    end

endmodule
