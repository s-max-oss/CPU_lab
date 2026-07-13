`timescale 1ns / 1ps

module multiplier (
    input            clk,
    input            rst,
    input  [31:0]    x,      // 被乘数（32位补码）
    input  [31:0]    y,      // 乘数（32位补码）
    input            start,  // 启动信号，仅有效一个时钟周期
    output reg [63:0] z,     // 乘积（64位补码）
    output wire       busy   // 忙标志（组合逻辑，start 有效即刻拉高）
);

    // 状态编码（去除 DONE 状态）
    localparam IDLE = 2'b00, EXEC = 2'b01;
    reg [1:0] state, next_state;

    // Booth 算法内部寄存器（带符号）
    reg signed [32:0] M;     // 被乘数符号扩展为 33 位
    reg signed [32:0] A;     // 部分积，33 位
    reg [31:0] Q;            // 乘数寄存器
    reg        Q_1;          // 附加位
    reg [5:0] cnt;           // 迭代计数 0～32（共 32 次）

    // 组合逻辑：根据 Q[0] 与 Q_1 决定操作
    wire [1:0] sel = {Q[0], Q_1};
    wire signed [32:0] M_neg = ~M + 1'b1;              // M 的补码
    wire signed [32:0] A_add = (sel == 2'b01) ? (A + M) :
                               (sel == 2'b10) ? (A + M_neg) :
                                                 A;

    // 算术右移：符号位保持，A[0] 移入 Q 最高位
    wire [32:0] A_next = {A_add[32], A_add[32:1]};
    wire [31:0] Q_next = {A_add[0], Q[31:1]};
    wire       Q_1_next = Q[0];

    // 组合逻辑输出 busy：非复位且 (IDLE+start 或 EXEC) 为忙
    assign busy = !rst && ((state == IDLE && start) || (state == EXEC));

    // 状态寄存器更新
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    // 下一状态组合逻辑（修改：EXEC 完成 32 次后直接回 IDLE）
    always @(*) begin
        next_state = state;
        case (state)
            IDLE : if (start) next_state = EXEC;
            EXEC : if (cnt == 6'd32) next_state = IDLE;   // 32 次完成后回 IDLE
            default: next_state = IDLE;
        endcase
    end

    // 数据通路与输出控制（修改：在 EXEC 计满 32 时直接输出乘积）
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            M    <= 33'sd0;
            A    <= 33'sd0;
            Q    <= 32'd0;
            Q_1  <= 1'b0;
            cnt  <= 6'd0;
            z    <= 64'd0;
        end else begin
            case (state)
                IDLE: begin
                    if (start) begin          // 锁存输入操作数
                        M   <= {x[31], x};    // 符号扩展
                        A   <= 33'sd0;
                        Q   <= y;
                        Q_1 <= 1'b0;
                        cnt <= 6'd0;
                    end
                end

                EXEC: begin
                    if (cnt < 6'd32) begin    // 前 32 次：移位更新
                        A    <= A_next;
                        Q    <= Q_next;
                        Q_1  <= Q_1_next;
                        cnt  <= cnt + 1'b1;
                    end else begin            // cnt == 32：输出最终乘积，不额外耗时
                        // 注意拼接顺序：高 32 位为 Q，低 32 位为 A[31:0]
                        z <= {A[31:0], Q};
                    end
                end

                default: ;
            endcase
        end
    end

endmodule