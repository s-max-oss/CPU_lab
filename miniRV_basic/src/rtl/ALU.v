`timescale 1ns / 1ps

`include "defines.vh"

module ALU (
    input  wire         rst,
    input  wire         clk,
    input  wire [ 4:0]  op,
    input  wire [31:0]  a,
    input  wire [31:0]  b,

    output reg  [31:0]  c,
    output reg          br,
    output wire         busy
);

    // Multiplier signals
    wire        mul_start, mulu_start;
    wire [63:0] mul_res, mulu_res;
    wire        mul_busy, mulu_busy;

    // Divider signals
    wire        div_start, divu_start;
    wire [31:0] div_quo, divu_quo;
    wire [31:0] div_rem, divu_rem;
    wire        div_busy, divu_busy;

    // Absolute values for signed divider
    wire [31:0] a_abs = a[31] ? (~a + 32'd1) : a;
    wire [31:0] b_abs = b[31] ? (~b + 32'd1) : b;

    // Sign correction for signed division
    wire        quo_sign = a[31] ^ b[31];
    wire        rem_sign = a[31];
    wire [31:0] div_quo_signed = quo_sign ? (~div_quo + 32'd1) : div_quo;
    wire [31:0] div_rem_signed = rem_sign ? (~div_rem + 32'd1) : div_rem;

    reg  [ 4:0] op_r;

    // ALU result (single-cycle + multi-cycle)
    always @(*) begin
        case (op_r != 4'h0 ? op_r : op)
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
            `ALU_MUL  : c = mul_res[31:0];
            `ALU_MULH : c = mul_res[63:32];
            `ALU_MULHU: c = mulu_res[63:32];
            `ALU_DIV  : c = div_quo_signed;
            `ALU_DIVU : c = divu_quo;
            `ALU_REM  : c = div_rem_signed;
            `ALU_REMU : c = divu_rem;
            default   : c = 32'h0;
        endcase
    end

    // Branch condition
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

    // Multi-cycle control
    assign mul_start  = (op == `ALU_MUL) | (op == `ALU_MULH);
    assign mulu_start = (op == `ALU_MULHU);
    assign div_start  = (op == `ALU_DIV) | (op == `ALU_REM);
    assign divu_start = (op == `ALU_DIVU) | (op == `ALU_REMU);

    assign busy = mul_busy | mulu_busy | div_busy | divu_busy;

    always @(posedge clk) begin
        if (mul_start | mulu_start | div_start | divu_start)
            op_r <= op;
        else if (!busy)
            op_r <= 5'h00;
    end

    // Multiplier (signed, 32-bit)
    multiplier #(32) U_mul (
        .clk    (clk),
        .rst    (rst),
        .x      (a),
        .y      (b),
        .start  (mul_start),
        .z      (mul_res),
        .busy   (mul_busy)
    );

    // Multiplier (unsigned, 33-bit)
    multiplier #(33) U_mulu (
        .clk    (clk),
        .rst    (rst),
        .x      ({1'b0, a}),
        .y      ({1'b0, b}),
        .start  (mulu_start),
        .z      (mulu_res),
        .busy   (mulu_busy)
    );

    // Divider (signed, 32-bit) — receives absolute values
    divider #(32) U_div (
        .clk    (clk),
        .rst    (rst),
        .x      (a_abs),
        .y      (b_abs),
        .start  (div_start),
        .z      (div_quo),
        .r      (div_rem),
        .busy   (div_busy)
    );

    // Divider (unsigned, 33-bit)
    divider #(33) U_divu (
        .clk    (clk),
        .rst    (rst),
        .x      ({1'b0, a}),
        .y      ({1'b0, b}),
        .start  (divu_start),
        .z      (divu_quo),
        .r      (divu_rem),
        .busy   (divu_busy)
    );

endmodule
