`timescale 1ns / 1ps

`include "defines.vh"

module ALU (
    input  wire         rst,
    input  wire         clk,

    input  wire [ 4:0]  op,
    input  wire [31:0]  a,
    input  wire [31:0]  b,

    output reg  [31:0]  c,
    output reg           br,
    output wire          busy
);

    assign busy = 1'b0;

    function [63:0] booth_mul;
        input [31:0] x, y;
        integer i;
        reg signed [32:0] A;
        reg [31:0] Q;
        reg Q_1;
        reg signed [32:0] M;
        reg [1:0] sel;
        reg signed [32:0] A_add;
        begin
            M = {x[31], x};
            A = 33'sd0;
            Q = y;
            Q_1 = 1'b0;
            for (i = 0; i < 32; i = i + 1) begin
                sel = {Q[0], Q_1};
                case (sel)
                    2'b01: A_add = A + M;
                    2'b10: A_add = A - M;
                    default: A_add = A;
                endcase

                A = {A_add[32], A_add[32:1]};
                {Q, Q_1} = {A_add[0], Q[31:1], Q[0]};
            end
            booth_mul = {A[31:0], Q};
        end
    endfunction

    function [63:0] restore_div;
        input [31:0] dividend, divisor;
        integer i;
        reg [32:0] A;
        reg [31:0] Q;
        reg [32:0] A_sub;
        begin
            A = 33'd0;
            Q = dividend;
            for (i = 0; i < 32; i = i + 1) begin

                A = {A[31:0], Q[31]};
                Q = {Q[30:0], 1'b0};

                A_sub = A - {1'b0, divisor};
                if (A_sub[32]) begin

                end else begin

                    A = A_sub;
                    Q[0] = 1'b1;
                end
            end
            restore_div = {Q, A[31:0]};
        end
    endfunction

    wire [63:0] booth_result;
    assign booth_result = booth_mul(a, b);

    wire [31:0] mulhu_correction = (a[31] ? b : 32'd0) + (b[31] ? a : 32'd0);
    wire [31:0] mulhu_hi = booth_result[63:32] + mulhu_correction;

    wire [31:0] a_abs = a[31] ? (~a + 1'b1) : a;
    wire [31:0] b_abs = b[31] ? (~b + 1'b1) : b;

    wire div_by_zero = (b_abs == 32'd0);

    wire [63:0] div_result;
    assign div_result = restore_div(a_abs, b_abs);

    wire [31:0] quo_abs = div_by_zero ? 32'hFFFFFFFF : div_result[63:32];
    wire [31:0] rem_abs = div_by_zero ? a_abs      : div_result[31:0];

    wire quo_sign = a[31] ^ b[31];

    wire rem_sign = a[31];

    wire [31:0] quo_signed = div_by_zero ? 32'hFFFFFFFF : (quo_sign ? (~quo_abs + 1'b1) : quo_abs);
    wire [31:0] rem_signed = div_by_zero ? a             : (rem_sign ? (~rem_abs + 1'b1) : rem_abs);

    wire [63:0] divu_result;
    assign divu_result = (b == 32'd0) ? {32'hFFFFFFFF, a} : restore_div(a, b);
    wire [31:0] divu_quo = divu_result[63:32];
    wire [31:0] divu_rem = divu_result[31:0];

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

            `ALU_MUL  : c = booth_result[31:0];
            `ALU_MULH : c = booth_result[63:32];
            `ALU_MULHU: c = mulhu_hi;
            `ALU_DIV  : c = quo_signed;
            `ALU_DIVU : c = divu_quo;
            `ALU_REM  : c = rem_signed;
            `ALU_REMU : c = divu_rem;

            default   : c = 32'h0;
        endcase
    end

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
