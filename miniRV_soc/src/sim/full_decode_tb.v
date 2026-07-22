// ============================================================================
// full_decode_tb.v — 全指令解码测试（44条指令全覆盖）
// ============================================================================
// 直接测试 Controller 模块：输入 32 位指令机器码，检查所有控制信号输出
// 覆盖: R-type(10) + M-type(7) + I-type(9) + Load(5) + Store(3)
//       + Branch(6) + LUI + AUIPC + JAL + JALR = 44 条
// ============================================================================

`timescale 1ns / 1ps

`include "defines.vh"

module full_decode_tb;

    reg  [31:0] inst = 32'h0000_0013;
    wire [ 1:0] npc_op;
    wire [ 2:0] sext_op;
    wire        alua_sel;
    wire        alub_sel;
    wire [ 4:0] alu_op;
    wire [ 2:0] ram_r_op;
    wire [ 3:0] ram_w_op;
    wire        rf_we;
    wire [ 1:0] rf_wsel;
    integer errors = 0;

    Controller U_controller (
        .opcode   (inst[6:0]),
        .funct3   (inst[14:12]),
        .funct7   (inst[31:25]),
        .npc_op   (npc_op),
        .sext_op  (sext_op),
        .alua_sel (alua_sel),
        .alub_sel (alub_sel),
        .alu_op   (alu_op),
        .ram_r_op (ram_r_op),
        .ram_w_op (ram_w_op),
        .rf_we    (rf_we),
        .rf_wsel  (rf_wsel)
    );

    function [31:0] enc_r;
        input [6:0] funct7;
        input [2:0] funct3;
        begin
            enc_r = {funct7, 5'd2, 5'd1, funct3, 5'd3, 7'b0110011};
        end
    endfunction

    function [31:0] enc_i;
        input [6:0] opcode;
        input [2:0] funct3;
        input [11:0] immediate;
        begin
            enc_i = {immediate, 5'd1, funct3, 5'd3, opcode};
        end
    endfunction

    function [31:0] enc_s;
        input [2:0] funct3;
        begin
            enc_s = {7'b0, 5'd2, 5'd1, funct3, 5'b0, 7'b0100011};
        end
    endfunction

    function [31:0] enc_b;
        input [2:0] funct3;
        begin
            enc_b = {7'b0, 5'd2, 5'd1, funct3, 5'b0, 7'b1100011};
        end
    endfunction

    task check_decode;
        input [8*8-1:0] name;
        input [31:0] instruction;
        input [ 1:0] expected_npc;
        input        expected_rf_we;
        input [ 1:0] expected_wsel;
        input [ 2:0] expected_ext;
        input [ 4:0] expected_alu;
        input        expected_alua;
        input        expected_alub;
        input [ 2:0] expected_rop;
        input [ 3:0] expected_wop;
        begin
            inst = instruction;
            #1;
            if (npc_op !== expected_npc || rf_we !== expected_rf_we
                    || rf_wsel !== expected_wsel || sext_op !== expected_ext
                    || alu_op !== expected_alu || alua_sel !== expected_alua
                    || alub_sel !== expected_alub || ram_r_op !== expected_rop
                    || ram_w_op !== expected_wop) begin
                $display("DECODE_FAIL %0s inst=%h", name, instruction);
                $display(" got npc=%h we=%b wsel=%h ext=%h alu=%h a=%b b=%b rop=%h wop=%h",
                    npc_op, rf_we, rf_wsel, sext_op, alu_op, alua_sel, alub_sel,
                    ram_r_op, ram_w_op);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        // R-type integer instructions
        check_decode("ADD",   enc_r(7'h00, 3'h0), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_ADD,  `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);
        check_decode("SUB",   enc_r(7'h20, 3'h0), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_SUB,  `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);
        check_decode("SLL",   enc_r(7'h00, 3'h1), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_SLL,  `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);
        check_decode("SLT",   enc_r(7'h00, 3'h2), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_SLT,  `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);
        check_decode("SLTU",  enc_r(7'h00, 3'h3), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_SLTU, `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);
        check_decode("XOR",   enc_r(7'h00, 3'h4), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_XOR,  `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);
        check_decode("SRL",   enc_r(7'h00, 3'h5), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_SRL,  `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);
        check_decode("SRA",   enc_r(7'h20, 3'h5), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_SRA,  `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);
        check_decode("OR",    enc_r(7'h00, 3'h6), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_OR,   `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);
        check_decode("AND",   enc_r(7'h00, 3'h7), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_AND,  `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);

        // M-extension instructions (hand-calculated combinational ALU)
        check_decode("MUL",   enc_r(7'h01, 3'h0), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_MUL,   `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);
        check_decode("MULH",  enc_r(7'h01, 3'h1), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_MULH,  `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);
        check_decode("MULHU", enc_r(7'h01, 3'h3), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_MULHU, `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);
        check_decode("DIV",   enc_r(7'h01, 3'h4), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_DIV,   `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);
        check_decode("DIVU",  enc_r(7'h01, 3'h5), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_DIVU,  `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);
        check_decode("REM",   enc_r(7'h01, 3'h6), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_REM,   `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);
        check_decode("REMU",  enc_r(7'h01, 3'h7), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_REMU,  `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);

        // I-type ALU instructions
        check_decode("ADDI",  enc_i(7'h13, 3'h0, 12'h123), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_ADD,  `ALU_A_RS1, `ALU_B_EXT, `RAM_EXT_N, `RAM_WE_N);
        check_decode("SLLI",  enc_i(7'h13, 3'h1, 12'h003), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_SLL,  `ALU_A_RS1, `ALU_B_EXT, `RAM_EXT_N, `RAM_WE_N);
        check_decode("SLTI",  enc_i(7'h13, 3'h2, 12'hfff), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_SLT,  `ALU_A_RS1, `ALU_B_EXT, `RAM_EXT_N, `RAM_WE_N);
        check_decode("SLTIU", enc_i(7'h13, 3'h3, 12'hfff), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_SLTU, `ALU_A_RS1, `ALU_B_EXT, `RAM_EXT_N, `RAM_WE_N);
        check_decode("XORI",  enc_i(7'h13, 3'h4, 12'h123), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_XOR,  `ALU_A_RS1, `ALU_B_EXT, `RAM_EXT_N, `RAM_WE_N);
        check_decode("SRLI",  enc_i(7'h13, 3'h5, 12'h003), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_SRL,  `ALU_A_RS1, `ALU_B_EXT, `RAM_EXT_N, `RAM_WE_N);
        check_decode("SRAI",  enc_i(7'h13, 3'h5, 12'h403), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_SRA,  `ALU_A_RS1, `ALU_B_EXT, `RAM_EXT_N, `RAM_WE_N);
        check_decode("ORI",   enc_i(7'h13, 3'h6, 12'h123), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_OR,   `ALU_A_RS1, `ALU_B_EXT, `RAM_EXT_N, `RAM_WE_N);
        check_decode("ANDI",  enc_i(7'h13, 3'h7, 12'h123), `NPC_PC4, 1, `WB_ALU, `EXT_I, `ALU_AND,  `ALU_A_RS1, `ALU_B_EXT, `RAM_EXT_N, `RAM_WE_N);

        // Load instructions
        check_decode("LB",  enc_i(7'h03, 3'h0, 12'h004), `NPC_PC4, 1, `WB_RAM, `EXT_I, `ALU_ADD, `ALU_A_RS1, `ALU_B_EXT, `RAM_EXT_B,  `RAM_WE_N);
        check_decode("LH",  enc_i(7'h03, 3'h1, 12'h004), `NPC_PC4, 1, `WB_RAM, `EXT_I, `ALU_ADD, `ALU_A_RS1, `ALU_B_EXT, `RAM_EXT_H,  `RAM_WE_N);
        check_decode("LW",  enc_i(7'h03, 3'h2, 12'h004), `NPC_PC4, 1, `WB_RAM, `EXT_I, `ALU_ADD, `ALU_A_RS1, `ALU_B_EXT, `RAM_EXT_W,  `RAM_WE_N);
        check_decode("LBU", enc_i(7'h03, 3'h4, 12'h004), `NPC_PC4, 1, `WB_RAM, `EXT_I, `ALU_ADD, `ALU_A_RS1, `ALU_B_EXT, `RAM_EXT_BU, `RAM_WE_N);
        check_decode("LHU", enc_i(7'h03, 3'h5, 12'h004), `NPC_PC4, 1, `WB_RAM, `EXT_I, `ALU_ADD, `ALU_A_RS1, `ALU_B_EXT, `RAM_EXT_HU, `RAM_WE_N);

        // Store instructions
        check_decode("SB", enc_s(3'h0), `NPC_PC4, 0, `WB_ALU, `EXT_S, `ALU_ADD, `ALU_A_RS1, `ALU_B_EXT, `RAM_EXT_N, `RAM_WE_B);
        check_decode("SH", enc_s(3'h1), `NPC_PC4, 0, `WB_ALU, `EXT_S, `ALU_ADD, `ALU_A_RS1, `ALU_B_EXT, `RAM_EXT_N, `RAM_WE_H);
        check_decode("SW", enc_s(3'h2), `NPC_PC4, 0, `WB_ALU, `EXT_S, `ALU_ADD, `ALU_A_RS1, `ALU_B_EXT, `RAM_EXT_N, `RAM_WE_W);

        // Branch instructions
        check_decode("BEQ",  enc_b(3'h0), `NPC_BRA, 0, `WB_ALU, `EXT_B, `ALU_EQ,   `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);
        check_decode("BNE",  enc_b(3'h1), `NPC_BRA, 0, `WB_ALU, `EXT_B, `ALU_NE,   `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);
        check_decode("BLT",  enc_b(3'h4), `NPC_BRA, 0, `WB_ALU, `EXT_B, `ALU_LT,   `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);
        check_decode("BGE",  enc_b(3'h5), `NPC_BRA, 0, `WB_ALU, `EXT_B, `ALU_GE,   `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);
        check_decode("BLTU", enc_b(3'h6), `NPC_BRA, 0, `WB_ALU, `EXT_B, `ALU_LTU,  `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);
        check_decode("BGEU", enc_b(3'h7), `NPC_BRA, 0, `WB_ALU, `EXT_B, `ALU_GEU,  `ALU_A_RS1, `ALU_B_RS2, `RAM_EXT_N, `RAM_WE_N);

        // Upper-immediate and jumps
        check_decode("LUI",   {20'h12345, 5'd3, 7'h37}, `NPC_PC4,  1, `WB_EXT, `EXT_U, `ALU_ADD, `ALU_A_RS1, `ALU_B_EXT, `RAM_EXT_N, `RAM_WE_N);
        check_decode("AUIPC", {20'h12345, 5'd3, 7'h17}, `NPC_PC4,  1, `WB_ALU, `EXT_U, `ALU_ADD, `ALU_A_PC,  `ALU_B_EXT, `RAM_EXT_N, `RAM_WE_N);
        check_decode("JAL",   32'h0080_01ef,             `NPC_JMP,  1, `WB_PC4, `EXT_J, `ALU_ADD, `ALU_A_RS1, `ALU_B_EXT, `RAM_EXT_N, `RAM_WE_N);
        check_decode("JALR",  enc_i(7'h67, 3'h0, 12'h004), `NPC_JALR, 1, `WB_PC4, `EXT_I, `ALU_ADD, `ALU_A_RS1, `ALU_B_EXT, `RAM_EXT_N, `RAM_WE_N);

        if (errors == 0)
            $display("FULL_DECODE_TEST_PASSED");
        else
            $display("FULL_DECODE_TEST_FAILED errors=%0d", errors);
        $finish;
    end

endmodule
