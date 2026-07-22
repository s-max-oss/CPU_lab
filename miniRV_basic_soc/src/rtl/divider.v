// ============================================================================
// divider.v — 恢复余数除法器（多周期）
// ============================================================================
// 【算法】恢复余数除法（restoring division），每次迭代 1 位商
// 【时序】1 周期加载 + WIDTH 周期迭代 + 1 周期写回
//   - 除零 / 有符号溢出：2 周期完成（special_pending）
//   - start 脉冲启动（1 拍有效）
//   - busy 有效期间表示正在计算
//   - busy 下降沿表示结果 z/r 有效
// 【关键路径】1 次 WIDTH+1 位减法 ≈ 3-4ns，轻松满足 25-50MHz
// 【符号处理】内部用绝对值做无符号除法，最后按 RISC-V 规范调整符号
//   - 除零：商 = -1，余数 = 被除数
//   - 有符号溢出（MIN_INT / -1）：商 = MIN_INT，余数 = 0
// ============================================================================

`timescale 1ns / 1ps

module divider #(
    parameter WIDTH = 32
)(
    input  wire                 clk,
    input  wire                 rst,
    input  wire [WIDTH-1:0]     x,          // 被除数
    input  wire [WIDTH-1:0]     y,          // 除数
    input  wire                 start,      // 启动信号
    output reg  [WIDTH-1:0]     z,          // 商（quotient）
    output reg  [WIDTH-1:0]     r,          // 余数（remainder）
    output reg                  busy        // 忙标志
);

    localparam COUNT_W = WIDTH <= 2 ? 1 : $clog2(WIDTH);

    reg [WIDTH-1:0] divisor_r;
    reg [WIDTH-1:0] quotient_r;
    reg [WIDTH:0]   remainder_r;
    reg [COUNT_W-1:0] count;
    reg             quotient_negative;
    reg             remainder_negative;
    reg             special_pending;

    wire [WIDTH-1:0] x_magnitude = x[WIDTH-1] ? (~x + {{WIDTH-1{1'b0}}, 1'b1}) : x;
    wire [WIDTH-1:0] y_magnitude = y[WIDTH-1] ? (~y + {{WIDTH-1{1'b0}}, 1'b1}) : y;
    wire [WIDTH:0]   remainder_shift = {remainder_r[WIDTH-1:0], quotient_r[WIDTH-1]};
    wire             can_subtract = remainder_shift >= {1'b0, divisor_r};
    wire [WIDTH:0]   remainder_next = can_subtract
                        ? remainder_shift - {1'b0, divisor_r}
                        : remainder_shift;
    wire [WIDTH-1:0] quotient_next = {quotient_r[WIDTH-2:0], can_subtract};
    wire             signed_overflow = x == {1'b1, {WIDTH-1{1'b0}}}
                        && y == {WIDTH{1'b1}};

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            z                  <= {WIDTH{1'b0}};
            r                  <= {WIDTH{1'b0}};
            divisor_r          <= {WIDTH{1'b0}};
            quotient_r         <= {WIDTH{1'b0}};
            remainder_r        <= {(WIDTH+1){1'b0}};
            count              <= {COUNT_W{1'b0}};
            quotient_negative  <= 1'b0;
            remainder_negative <= 1'b0;
            special_pending    <= 1'b0;
            busy               <= 1'b0;
        end else if (start && !busy) begin
            busy <= 1'b1;
            count <= {COUNT_W{1'b0}};

            if (y == {WIDTH{1'b0}}) begin
                // 除零：商 = -1（全F），余数 = 被除数
                z <= {WIDTH{1'b1}};
                r <= x;
                special_pending <= 1'b1;
            end else if (signed_overflow) begin
                // 有符号溢出：-2^(WIDTH-1) / -1
                z <= x;
                r <= {WIDTH{1'b0}};
                special_pending <= 1'b1;
            end else begin
                divisor_r          <= y_magnitude;
                quotient_r         <= x_magnitude;
                remainder_r        <= {(WIDTH+1){1'b0}};
                quotient_negative  <= x[WIDTH-1] ^ y[WIDTH-1];
                remainder_negative <= x[WIDTH-1];
                special_pending    <= 1'b0;
            end
        end else if (busy) begin
            if (special_pending) begin
                special_pending <= 1'b0;
                busy <= 1'b0;
            end else if (count == WIDTH - 1) begin
                z <= quotient_negative
                    ? (~quotient_next + {{WIDTH-1{1'b0}}, 1'b1})
                    : quotient_next;
                r <= remainder_negative
                    ? (~remainder_next[WIDTH-1:0] + {{WIDTH-1{1'b0}}, 1'b1})
                    : remainder_next[WIDTH-1:0];
                busy <= 1'b0;
            end else begin
                quotient_r  <= quotient_next;
                remainder_r <= remainder_next;
                count       <= count + 1'b1;
            end
        end
    end

endmodule
