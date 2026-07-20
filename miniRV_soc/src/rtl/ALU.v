// ============================================================================
// ALU.v — 算术逻辑单元
// ============================================================================
// 全组合逻辑，单周期完成所有运算（包括乘除法）

`timescale 1ns / 1ps

`include "defines.vh"

module ALU (
    input  wire [ 4:0]  op,
    input  wire [31:0]  a,
    input  wire [31:0]  b,

    output reg  [31:0]  c,
    output reg           br
);

    // =============== 有符号除法预处理：绝对值 + 符号 ===============
    wire [31:0] a_abs = a[31] ? (~a + 32'd1) : a;
    wire [31:0] b_abs = b[31] ? (~b + 32'd1) : b;

    wire        quo_sign = a[31] ^ b[31];
    wire        rem_sign = a[31];

    // =============== 组合运算 ===============
    wire [63:0] mul_comb  = {{32{a[31]}}, a} * {{32{b[31]}}, b};
    wire [65:0] mulu_comb = {33'd0, a} * {33'd0, b};

    wire [31:0] div_quo_abs = (b_abs != 0) ? a_abs / b_abs : 32'hFFFFFFFF;
    wire [31:0] div_rem_abs = (b_abs != 0) ? a_abs % b_abs : a_abs;
    wire [31:0] div_quo_signed = quo_sign ? (~div_quo_abs + 32'd1) : div_quo_abs;
    wire [31:0] div_rem_signed = rem_sign ? (~div_rem_abs + 32'd1) : div_rem_abs;

    wire [31:0] divu_quo = (b != 0) ? a / b : 32'hFFFFFFFF;
    wire [31:0] divu_rem = (b != 0) ? a % b : a;

    // =============== 结果输出 ===============
    always @(*) begin
        case (op)
            `ALU_ADD  : c = a + b;
            `ALU_SUB  : c = a - b;
            `ALU_XOR  : c = a ^ b;
            `ALU_OR   : c = a | b;
            `ALU_AND  : c = a & b;
            `ALU_SLL  : c = a << b[4:0];
            `ALU_SRL  : c = a >> b[4:0];
            `ALU_SRA  : c = $signed(a) >>> b[4:0];
            `ALU_SLT  : c = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            `ALU_SLTU : c = (a < b) ? 32'd1 : 32'd0;

            `ALU_MUL  : c = mul_comb[31:0];
            `ALU_MULH : c = mul_comb[63:32];
            `ALU_MULHU: c = mulu_comb[63:32];
            `ALU_DIV  : c = div_quo_signed;
            `ALU_DIVU : c = divu_quo;
            `ALU_REM  : c = div_rem_signed;
            `ALU_REMU : c = divu_rem;

            default   : c = 32'h0;
        endcase
    end

    // =============== 分支条件输出 ===============
    always @(*) begin
        case (op)
            `ALU_EQ  : br = (a == b);
            `ALU_NE  : br = (a != b);
            `ALU_LT  : br = ($signed(a) < $signed(b));
            `ALU_GE  : br = ($signed(a) >= $signed(b));
            `ALU_LTU : br = (a < b);
            `ALU_GEU : br = (a >= b);
            default  : br = 1'b0;
        endcase
    end

endmodule
