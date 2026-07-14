`timescale 1ns / 1ps

`include "defines.vh"

module Controller (
    input  wire [ 6:0]  opcode,
    input  wire [ 2:0]  funct3,
    input  wire [ 6:0]  funct7,
    output wire [ 1:0]  npc_op,
    output wire [ 2:0]  sext_op,
    output wire         alua_sel,
    output wire         alub_sel,
    output wire [ 4:0]  alu_op,
    output wire         is_mul,
    output wire         is_div,
    output wire [ 2:0]  ram_r_op,
    output wire [ 3:0]  ram_w_op,
    output wire         rf_we,
    output wire [ 1:0]  rf_wsel
);

    // ============================================
    // Instruction Decode
    // ============================================

    // R-type (opcode = 0110011)
    wire ADD  = (opcode == 7'b0110011) && (funct3 == 3'b000) && (funct7 == 7'b0000000);
    wire SUB  = (opcode == 7'b0110011) && (funct3 == 3'b000) && (funct7 == 7'b0100000);
    wire MUL  = (opcode == 7'b0110011) && (funct3 == 3'b000) && (funct7 == 7'b0000001);
    wire SLL  = (opcode == 7'b0110011) && (funct3 == 3'b001) && (funct7 == 7'b0000000);
    wire MULH = (opcode == 7'b0110011) && (funct3 == 3'b001) && (funct7 == 7'b0000001);
    wire SLT  = (opcode == 7'b0110011) && (funct3 == 3'b010) && (funct7 == 7'b0000000);
    wire SLTU = (opcode == 7'b0110011) && (funct3 == 3'b011) && (funct7 == 7'b0000000);
    wire MULHU= (opcode == 7'b0110011) && (funct3 == 3'b011) && (funct7 == 7'b0000001);
    wire XOR  = (opcode == 7'b0110011) && (funct3 == 3'b100) && (funct7 == 7'b0000000);
    wire DIV  = (opcode == 7'b0110011) && (funct3 == 3'b100) && (funct7 == 7'b0000001);
    wire SRL  = (opcode == 7'b0110011) && (funct3 == 3'b101) && (funct7 == 7'b0000000);
    wire SRA  = (opcode == 7'b0110011) && (funct3 == 3'b101) && (funct7 == 7'b0100000);
    wire DIVU = (opcode == 7'b0110011) && (funct3 == 3'b101) && (funct7 == 7'b0000001);
    wire OR   = (opcode == 7'b0110011) && (funct3 == 3'b110) && (funct7 == 7'b0000000);
    wire REM  = (opcode == 7'b0110011) && (funct3 == 3'b110) && (funct7 == 7'b0000001);
    wire AND  = (opcode == 7'b0110011) && (funct3 == 3'b111) && (funct7 == 7'b0000000);
    wire REMU = (opcode == 7'b0110011) && (funct3 == 3'b111) && (funct7 == 7'b0000001);

    // I-type ALU (opcode = 0010011)
    wire ADDI  = (opcode == 7'b0010011) && (funct3 == 3'b000);
    wire SLLI  = (opcode == 7'b0010011) && (funct3 == 3'b001) && (funct7 == 7'b0000000);
    wire SLTI  = (opcode == 7'b0010011) && (funct3 == 3'b010);
    wire SLTIU = (opcode == 7'b0010011) && (funct3 == 3'b011);
    wire XORI  = (opcode == 7'b0010011) && (funct3 == 3'b100);
    wire SRLI  = (opcode == 7'b0010011) && (funct3 == 3'b101) && (funct7 == 7'b0000000);
    wire SRAI  = (opcode == 7'b0010011) && (funct3 == 3'b101) && (funct7 == 7'b0100000);
    wire ORI   = (opcode == 7'b0010011) && (funct3 == 3'b110);
    wire ANDI  = (opcode == 7'b0010011) && (funct3 == 3'b111);

    // I-type Load (opcode = 0000011)
    wire LB  = (opcode == 7'b0000011) && (funct3 == 3'b000);
    wire LH  = (opcode == 7'b0000011) && (funct3 == 3'b001);
    wire LW  = (opcode == 7'b0000011) && (funct3 == 3'b010);
    wire LBU = (opcode == 7'b0000011) && (funct3 == 3'b100);
    wire LHU = (opcode == 7'b0000011) && (funct3 == 3'b101);

    // I-type Jump (opcode = 1100111)
    wire JALR = (opcode == 7'b1100111) && (funct3 == 3'b000);

    // S-type Store (opcode = 0100011)
    wire SB = (opcode == 7'b0100011) && (funct3 == 3'b000);
    wire SH = (opcode == 7'b0100011) && (funct3 == 3'b001);
    wire SW = (opcode == 7'b0100011) && (funct3 == 3'b010);

    // B-type Branch (opcode = 1100011)
    wire BEQ  = (opcode == 7'b1100011) && (funct3 == 3'b000);
    wire BNE  = (opcode == 7'b1100011) && (funct3 == 3'b001);
    wire BLT  = (opcode == 7'b1100011) && (funct3 == 3'b100);
    wire BGE  = (opcode == 7'b1100011) && (funct3 == 3'b101);
    wire BLTU = (opcode == 7'b1100011) && (funct3 == 3'b110);
    wire BGEU = (opcode == 7'b1100011) && (funct3 == 3'b111);

    // U-type
    wire LUI   = (opcode == 7'b0110111);
    wire AUIPC = (opcode == 7'b0010111);

    // J-type
    wire JAL   = (opcode == 7'b1101111);

    // ============================================
    // Control Signal Groups
    // ============================================

    // npc_op
    wire BRANCH = BEQ | BNE | BLT | BGE | BLTU | BGEU;
    wire NPC_OP_PC4  = !BRANCH & !JAL & !JALR;
    wire NPC_OP_BRA  = BRANCH;
    wire NPC_OP_JMP  = JAL;
    wire NPC_OP_JALR = JALR;

    // rf_we
    wire STORE = SW | SB | SH;
    wire RF_OP_WE = !STORE & !BRANCH;

    // rf_wsel
    wire LOAD = LW | LB | LBU | LH | LHU;
    wire WB_OP_ALU = ADDI | ORI | SLLI | XORI | ANDI | SLTI | SLTIU | SRLI | SRAI
                   | ADD | SUB | XOR | SLL | SRL | SRA | AND | OR | SLT | SLTU | AUIPC
                   | MUL | MULH | MULHU | DIV | DIVU | REM | REMU;
    wire WB_OP_RAM = LOAD;
    wire WB_OP_PC4 = JAL | JALR;
    wire WB_OP_EXT = LUI;

    // sext_op
    wire I_ALU  = ADDI | ORI | SLLI | XORI | ANDI | SLTI | SLTIU | SRLI | SRAI;
    wire EXT_OP_I = I_ALU | LOAD | JALR;
    wire EXT_OP_S = STORE;
    wire EXT_OP_B = BRANCH;
    wire EXT_OP_U = LUI | AUIPC;
    wire EXT_OP_J = JAL;

    // alu_op
    wire ADDR_CALC = LOAD | STORE | JALR | AUIPC;
    wire ALU_OP_ADD   = ADDI | ADDR_CALC;
    wire ALU_OP_SUB   = SUB;
    wire ALU_OP_OR    = ORI | OR;
    wire ALU_OP_XOR   = XORI | XOR;
    wire ALU_OP_AND   = ANDI | AND;
    wire ALU_OP_SLL   = SLLI | SLL;
    wire ALU_OP_SRL   = SRLI | SRL;
    wire ALU_OP_SRA   = SRAI | SRA;
    wire ALU_OP_SLT   = SLTI | SLT;
    wire ALU_OP_SLTU  = SLTIU | SLTU;
    wire ALU_OP_EQ    = BEQ;
    wire ALU_OP_NE    = BNE;
    wire ALU_OP_LT    = BLT;
    wire ALU_OP_GE    = BGE;
    wire ALU_OP_LTU   = BLTU;
    wire ALU_OP_GEU   = BGEU;
    wire ALU_OP_MUL   = MUL;
    wire ALU_OP_MULH  = MULH;
    wire ALU_OP_MULHU = MULHU;
    wire ALU_OP_DIV   = DIV;
    wire ALU_OP_DIVU  = DIVU;
    wire ALU_OP_REM   = REM;
    wire ALU_OP_REMU  = REMU;

    // alua_sel
    wire ALU_A_SEL_PC  = AUIPC;
    wire ALU_A_SEL_RS1 = !AUIPC;

    // alub_sel
    wire R_TYPE = ADD | SUB | XOR | SLL | SRL | SRA | AND | OR | SLT | SLTU
                | MUL | MULH | MULHU | DIV | DIVU | REM | REMU;
    wire ALU_B_SEL_RS2 = R_TYPE | BRANCH;
    wire ALU_B_SEL_EXT = !R_TYPE & !BRANCH;

    // ram_r_op
    wire RAM_EXT_B  = LB;
    wire RAM_EXT_BU = LBU;
    wire RAM_EXT_H  = LH;
    wire RAM_EXT_HU = LHU;
    wire RAM_EXT_W  = LW;

    // ram_w_op
    wire RAM_W_B = SB;
    wire RAM_W_H = SH;
    wire RAM_W_W = SW;

    // is_mul / is_div
    wire IS_MUL = MUL | MULH | MULHU;
    wire IS_DIV = DIV | DIVU | REM | REMU;

    // ============================================
    // Output Assignments
    // ============================================

    assign npc_op = {2{NPC_OP_PC4 }} & `NPC_PC4
                  | {2{NPC_OP_BRA }} & `NPC_BRA
                  | {2{NPC_OP_JMP }} & `NPC_JMP
                  | {2{NPC_OP_JALR}} & `NPC_JALR;

    assign rf_we = RF_OP_WE;

    assign rf_wsel = {2{WB_OP_ALU}} & `WB_ALU
                   | {2{WB_OP_RAM}} & `WB_RAM
                   | {2{WB_OP_PC4}} & `WB_PC4
                   | {2{WB_OP_EXT}} & `WB_EXT;

    assign sext_op = {3{EXT_OP_I}} & `EXT_I
                   | {3{EXT_OP_S}} & `EXT_S
                   | {3{EXT_OP_B}} & `EXT_B
                   | {3{EXT_OP_U}} & `EXT_U
                   | {3{EXT_OP_J}} & `EXT_J;

    assign alu_op = {5{ALU_OP_ADD  }} & `ALU_ADD
                  | {5{ALU_OP_SUB  }} & `ALU_SUB
                  | {5{ALU_OP_OR   }} & `ALU_OR
                  | {5{ALU_OP_XOR  }} & `ALU_XOR
                  | {5{ALU_OP_AND  }} & `ALU_AND
                  | {5{ALU_OP_SLL  }} & `ALU_SLL
                  | {5{ALU_OP_SRL  }} & `ALU_SRL
                  | {5{ALU_OP_SRA  }} & `ALU_SRA
                  | {5{ALU_OP_EQ   }} & `ALU_EQ
                  | {5{ALU_OP_NE   }} & `ALU_NE
                  | {5{ALU_OP_SLT  }} & `ALU_SLT
                  | {5{ALU_OP_SLTU }} & `ALU_SLTU
                  | {5{ALU_OP_LT   }} & `ALU_LT
                  | {5{ALU_OP_GE   }} & `ALU_GE
                  | {5{ALU_OP_LTU  }} & `ALU_LTU
                  | {5{ALU_OP_GEU  }} & `ALU_GEU
                  | {5{ALU_OP_MUL  }} & `ALU_MUL
                  | {5{ALU_OP_MULH }} & `ALU_MULH
                  | {5{ALU_OP_MULHU}} & `ALU_MULHU
                  | {5{ALU_OP_DIV  }} & `ALU_DIV
                  | {5{ALU_OP_DIVU }} & `ALU_DIVU
                  | {5{ALU_OP_REM  }} & `ALU_REM
                  | {5{ALU_OP_REMU }} & `ALU_REMU;

    assign alua_sel = ALU_A_SEL_PC  & `ALU_A_PC
                    | ALU_A_SEL_RS1 & `ALU_A_RS1;

    assign alub_sel = ALU_B_SEL_RS2 & `ALU_B_RS2
                    | ALU_B_SEL_EXT & `ALU_B_EXT;

    assign ram_r_op = {3{RAM_EXT_B }} & `RAM_EXT_B
                    | {3{RAM_EXT_BU}} & `RAM_EXT_BU
                    | {3{RAM_EXT_H }} & `RAM_EXT_H
                    | {3{RAM_EXT_HU}} & `RAM_EXT_HU
                    | {3{RAM_EXT_W }} & `RAM_EXT_W;

    assign ram_w_op = {4{RAM_W_B}} & `RAM_WE_B
                    | {4{RAM_W_H}} & `RAM_WE_H
                    | {4{RAM_W_W}} & `RAM_WE_W;

    assign is_mul = IS_MUL;
    assign is_div = IS_DIV;

endmodule
