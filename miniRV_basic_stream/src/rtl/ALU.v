// ============================================================================
// ALU.v — 算术逻辑单元 ★★★ 核心模块 ★★★
// ============================================================================
// 【功能】执行所有算术、逻辑、移位、比较运算，以及乘除法（多周期）
// 【运算分类】
//   单周期操作（组合逻辑，1拍完成）：ADD/SUB/XOR/OR/AND/SLL/SRL/SRA/SLT/SLTU + 分支比较
//   多周期操作（时序逻辑，多拍完成）：MUL/MULH/MULHU/DIV/DIVU/REM/REMU
//
// 【多周期机制 — 理解重点！】
//   cpu_core 中有一个 mul_div_flag，当遇到乘除法指令时拉高，CPU阻塞等待。
//   ALU 内部：op_r 寄存器保存原始操作码，busy 信号表示运算未完成。
//   为什么需要 op_r？因为单周期指令的 op 只维持1拍，而乘除法需要多拍，
//   op_r 锁存住原始操作码，在 busy 期间持续指示乘法器/除法器工作。
//
// 【有符号除法的符号处理 — 理解重点！】
//   1. 输入 a, b 取绝对值（a_abs, b_abs），送入无符号除法器
//   2. 商的符号 = a_sign XOR b_sign（同号为正，异号为负）
//   3. 余数的符号 = a_sign（余数与被除数同号，满足 RISC-V 规范）
//   4. 符号在除法启动时锁存到 quo_sign_r / rem_sign_r
//   5. 结果 = 符号位 ? ~result+1 : result（即取补码恢复符号）
//   * 注意：这里用的是"先取绝对值，再恢复符号"的方式，而不是用 Verilog 的 $signed
//     因为 $signed 除法在不同工具中行为可能不一致
// ============================================================================

`timescale 1ns / 1ps

`include "defines.vh"

module ALU (
    input  wire         rst,         // 复位
    input  wire         clk,         // 时钟

    input  wire [ 4:0]  op,          // 操作码（来自Controller）
    input  wire [31:0]  a,           // 操作数A（来自ALU A MUX）
    input  wire [31:0]  b,           // 操作数B（来自ALU B MUX）

    output reg  [31:0]  c,           // 运算结果
    output reg          br,          // 分支条件（仅分支指令有效：EQ/NE/LT/GE/LTU/GEU）
    output wire         busy         // 乘除法运算忙标志（=1表示还在算，CPU应等待）
);

    // =============== 乘除法器接口信号 ===============

    // 有符号乘法器
    wire        mul_start, mulu_start;
    wire [63:0] mul_res, mulu_res;
    wire        mul_busy, mulu_busy;

    // 有符号除法器（注意：接收到的是取绝对值后的操作数）
    wire        div_start, divu_start;
    wire [31:0] div_quo, divu_quo;    // 商（quotient）
    wire [31:0] div_rem, divu_rem;    // 余数（remainder）
    wire        div_busy, divu_busy;

    // =============== 有符号除法预处理：取绝对值 ===============
    // 为什么取绝对值？本设计用无符号除法器实现有符号除法，
    // 先对操作数取绝对值 → 无符号运算 → 结果再恢复符号
    // a[31] 即符号位：负数 = ~a + 1，正数不变
    wire [31:0] a_abs = a[31] ? (~a + 32'd1) : a;
    wire [31:0] b_abs = b[31] ? (~b + 32'd1) : b;

    // 符号计算（仅对有符号除法有意义）
    //   quo_sign = a_sign XOR b_sign   → 商：同号得正，异号得负
    //   rem_sign = a_sign              → 余数：与被除数同号
    wire        quo_sign = a[31] ^ b[31];
    wire        rem_sign = a[31];
    reg         quo_sign_r, rem_sign_r;  // 锁存符号（除法需要多拍，符号必须保存）

    // 在除法启动时锁存符号位
    always @(posedge clk) begin
        if (rst) begin
            quo_sign_r <= 1'b0;
            rem_sign_r <= 1'b0;
        end else if (div_start) begin
            quo_sign_r <= quo_sign;
            rem_sign_r <= rem_sign;
        end
    end

    // 恢复符号：如果符号位为1，取补码（~x+1）
    wire [31:0] div_quo_signed = quo_sign_r ? (~div_quo + 32'd1) : div_quo;
    wire [31:0] div_rem_signed = rem_sign_r ? (~div_rem + 32'd1) : div_rem;

    // =============== 结果输出 ===============

    reg  [ 4:0] op_r;  // ★关键★ 锁存的操作码，在乘除法多周期运算期间保持不变

    // 组合乘除结果 — 绕过 multiplier/divider 模块的寄存输出
    // （模块有 1 周期延迟，但流水线 EX 阶段需要当拍组合结果）
    wire [63:0] mul_comb  = {{32{a[31]}}, a} * {{32{b[31]}}, b};
    wire [65:0] mulu_comb = {33'd0, a} * {33'd0, b};

    wire [31:0] div_quo_abs = (b_abs != 0) ? a_abs / b_abs : 32'hFFFFFFFF;
    wire [31:0] div_rem_abs = (b_abs != 0) ? a_abs % b_abs : a_abs;
    wire [31:0] div_quo_signed_comb = quo_sign ? (~div_quo_abs + 32'd1) : div_quo_abs;
    wire [31:0] div_rem_signed_comb = rem_sign ? (~div_rem_abs + 32'd1) : div_rem_abs;

    wire [31:0] divu_quo_comb = (b != 0) ? a / b : 32'hFFFFFFFF;
    wire [31:0] divu_rem_comb = (b != 0) ? a % b : a;

    // 结果MUX：op_r 非零说明乘除法正在进行，优先用 op_r；否则用当拍的 op
    always @(*) begin
        case (op_r != 4'h0 ? op_r : op)
            // --- 单周期运算 ---
            `ALU_ADD  : c = a + b;
            `ALU_SUB  : c = a - b;
            `ALU_XOR  : c = a ^ b;
            `ALU_OR   : c = a | b;
            `ALU_AND  : c = a & b;
            `ALU_SLL  : c = a << b[4:0];                    // 移位量只取低5位（0-31）
            `ALU_SRL  : c = a >> b[4:0];                    // 逻辑右移
            `ALU_SRA  : c = $signed(a) >>> b[4:0];          // 算术右移（高位补符号位）
            `ALU_SLT  : c = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            `ALU_SLTU : c = (a < b) ? 32'd1 : 32'd0;

            // --- 乘除法运算（组合逻辑，当拍出结果） ---
            `ALU_MUL  : c = mul_comb[31:0];
            `ALU_MULH : c = mul_comb[63:32];
            `ALU_MULHU: c = mulu_comb[63:32];
            `ALU_DIV  : c = div_quo_signed_comb;
            `ALU_DIVU : c = divu_quo_comb;
            `ALU_REM  : c = div_rem_signed_comb;
            `ALU_REMU : c = divu_rem_comb;

            default   : c = 32'h0;
        endcase
    end

    // =============== 分支条件输出 ===============
    // 注意：br 仅当 op 是分支比较码（EQ/NE/LT/GE/LTU/GEU）时才有意义
    // 其他指令下 br=0（恒不跳转）
    always @(*) begin
        case (op)
            `ALU_EQ  : br = (a == b);
            `ALU_NE  : br = (a != b);
            `ALU_LT  : br = ($signed(a) < $signed(b));
            `ALU_GE  : br = ($signed(a) >= $signed(b));
            `ALU_LTU : br = (a < b);
            `ALU_GEU : br = (a >= b);
            default  : br = 1'b0;          // 非分支指令，br=0
        endcase
    end

    // =============== 多周期控制 ===============

    // 启动信号：当 op 是乘除操作码时，对应子模块开始运算
    assign mul_start  = (op == `ALU_MUL) | (op == `ALU_MULH);
    assign mulu_start = (op == `ALU_MULHU);
    assign div_start  = (op == `ALU_DIV) | (op == `ALU_REM);
    assign divu_start = (op == `ALU_DIVU) | (op == `ALU_REMU);

    // busy：任一子模块还在运算中 → CPU 等待
    assign busy = mul_busy | mulu_busy | div_busy | divu_busy;

    // op_r 的维护：
    //   启动时 → 锁存操作码
    //   运算结束（!busy）→ 清零（恢复到默认ADD状态）
    always @(posedge clk) begin
        if (mul_start | mulu_start | div_start | divu_start)
            op_r <= op;
        else if (!busy)
            op_r <= 5'h00;            // 运算完成，清零
    end

    // =============== 乘法器实例化 ===============
    // 有符号乘法器：32位输入 → 64位积
    multiplier #(32) U_mul (
        .clk    (clk),
        .rst    (rst),
        .x      (a),
        .y      (b),
        .start  (mul_start),
        .z      (mul_res),
        .busy   (mul_busy)
    );

    // 无符号乘法器：33位输入 → 66位积
    // 为什么是33位？最高位补0，强制无符号运算（$signed 对 * 的行为与符号扩展有关）
    multiplier #(33) U_mulu (
        .clk    (clk),
        .rst    (rst),
        .x      ({1'b0, a}),          // 高位补0 → 强制无符号
        .y      ({1'b0, b}),
        .start  (mulu_start),
        .z      (mulu_res),
        .busy   (mulu_busy)
    );

    // =============== 除法器实例化 ===============
    // 有符号除法器：接收的是绝对值，输出的是无符号商/余数（上层恢复符号）
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

    // 无符号除法器：高位补0，强制无符号
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
