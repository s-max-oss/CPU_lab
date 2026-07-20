// ============================================================================
// Controller.v — 指令译码/控制器模块 ★★★ 核心模块 ★★★
// ============================================================================
// 【功能】根据32位指令的 opcode/funct3/funct7 字段，生成所有数据通路所需的控制信号
// 【在CPU中的角色】Controller 是CPU的"大脑"——它不处理数据，只告诉其他模块"做什么"
//
// 【指令格式回顾(RISC-V RV32I)】
//   R-type: [funct7:7][rs2:5][rs1:5][funct3:3][rd:5][opcode:7]
//   I-type: [imm[11:0]:12][rs1:5][funct3:3][rd:5][opcode:7]
//   S-type: [imm[11:5]:7][rs2:5][rs1:5][funct3:3][imm[4:0]:5][opcode:7]
//   B-type: [imm[12,10:5]:7][rs2:5][rs1:5][funct3:3][imm[4:1,11]:5][opcode:7]
//   U-type: [imm[31:12]:20][rd:5][opcode:7]
//   J-type: [imm[20,10:1,11,19:12]:20][rd:5][opcode:7]
//
// 【控制信号生成方法 — 两级译码（AND-OR编码模式）】
//   第1级：根据 opcode+funct3+funct7 识别具体指令（如 ADD = opcode==0110011 && funct3==000 && funct7==0000000）
//   第2级：将同类指令的控制信号分组（如所有做加法的指令共享同一 ALU_OP_ADD 信号）
//   最后通过"独热信号 & 编码常量 | 独热信号 & 编码常量"方式输出最终编码
//   这种写法的优点是：清晰、可综合为多路选择器、易于添加新指令
//
// 【理解重点】
//   1. "独热 & 编码 | 独热 & 编码"的组合逻辑不会产生优先级问题（独热信号互斥）
//   2. 所有控制信号都是纯组合逻辑输出，无时序，无状态
//   3. 读本文件时建议对照 defines.vh 和 RISC-V 指令集手册
// ============================================================================

`timescale 1ns / 1ps

`include "defines.vh"

module Controller (
    // 来自指令字的字段（由 cpu_core 顶层切割后传入）
    input  wire [ 6:0]  opcode,      // inst[6:0]   — 操作码：区分指令大类
    input  wire [ 2:0]  funct3,      // inst[14:12] — 功能码3：细分操作
    input  wire [ 6:0]  funct7,      // inst[31:25] — 功能码7：进一步区分（R-type内部）

    // 输出控制信号 — 每个信号的含义参考 defines.vh
    output wire [ 1:0]  npc_op,      // NPC操作：PC4 / BRA / JMP / JALR
    output wire [ 2:0]  sext_op,     // 立即数扩展类型
    output wire         alua_sel,    // ALU端口A选择：0=RS1 / 1=PC
    output wire         alub_sel,    // ALU端口B选择：0=RS2 / 1=EXT
    output wire [ 4:0]  alu_op,      // ALU运算类型
    output wire [ 2:0]  ram_r_op,    // 内存读取类型：字节/半字/字 + 符号/零扩展
    output wire [ 3:0]  ram_w_op,    // 内存写入类型：字节/半字/字
    output wire         rf_we,       // 寄存器写使能
    output wire [ 1:0]  rf_wsel      // 写回数据选择：ALU结果/内存数据/PC+4/立即数
);


    // ============================================
    // 第一级译码：指令识别（Instruction Decode）
    // ============================================
    // 每条 wire 对应一条指令，高电平表示"当前指令是这条指令"
    // 命名规则：直接使用RISC-V汇编助记符大写

    // --- R-type 算术逻辑指令 (opcode = 011_0011, 0x33) ---
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

    // --- I-type ALU 立即数指令 (opcode = 001_0011, 0x13) ---
    // 注意：I-type 指令 funct7 字段通常是立即数的一部分，只有移位指令才用它区分 SLLI/SRLI/SRAI
    wire ADDI  = (opcode == 7'b0010011) && (funct3 == 3'b000);
    wire SLLI  = (opcode == 7'b0010011) && (funct3 == 3'b001) && (funct7 == 7'b0000000);
    wire SLTI  = (opcode == 7'b0010011) && (funct3 == 3'b010);
    wire SLTIU = (opcode == 7'b0010011) && (funct3 == 3'b011);
    wire XORI  = (opcode == 7'b0010011) && (funct3 == 3'b100);
    wire SRLI  = (opcode == 7'b0010011) && (funct3 == 3'b101) && (funct7 == 7'b0000000);
    wire SRAI  = (opcode == 7'b0010011) && (funct3 == 3'b101) && (funct7 == 7'b0100000);
    wire ORI   = (opcode == 7'b0010011) && (funct3 == 3'b110);
    wire ANDI  = (opcode == 7'b0010011) && (funct3 == 3'b111);

    // --- I-type Load 访存指令 (opcode = 000_0011, 0x03) ---
    wire LB  = (opcode == 7'b0000011) && (funct3 == 3'b000);
    wire LH  = (opcode == 7'b0000011) && (funct3 == 3'b001);
    wire LW  = (opcode == 7'b0000011) && (funct3 == 3'b010);
    wire LBU = (opcode == 7'b0000011) && (funct3 == 3'b100);
    wire LHU = (opcode == 7'b0000011) && (funct3 == 3'b101);

    // --- I-type JALR 跳转指令 (opcode = 110_0111, 0x67) ---
    wire JALR = (opcode == 7'b1100111) && (funct3 == 3'b000);

    // --- S-type Store 存储指令 (opcode = 010_0011, 0x23) ---
    wire SB = (opcode == 7'b0100011) && (funct3 == 3'b000);
    wire SH = (opcode == 7'b0100011) && (funct3 == 3'b001);
    wire SW = (opcode == 7'b0100011) && (funct3 == 3'b010);

    // --- B-type Branch 分支指令 (opcode = 110_0011, 0x63) ---
    wire BEQ  = (opcode == 7'b1100011) && (funct3 == 3'b000);
    wire BNE  = (opcode == 7'b1100011) && (funct3 == 3'b001);
    wire BLT  = (opcode == 7'b1100011) && (funct3 == 3'b100);
    wire BGE  = (opcode == 7'b1100011) && (funct3 == 3'b101);
    wire BLTU = (opcode == 7'b1100011) && (funct3 == 3'b110);
    wire BGEU = (opcode == 7'b1100011) && (funct3 == 3'b111);

    // --- U-type 指令 (opcode = 011_0111 LUI, 001_0111 AUIPC) ---
    wire LUI   = (opcode == 7'b0110111);     // rd = imm[31:12] << 12
    wire AUIPC = (opcode == 7'b0010111);     // rd = pc + (imm[31:12] << 12)

    // --- J-type JAL 跳转并链接 (opcode = 110_1111, 0x6F) ---
    wire JAL   = (opcode == 7'b1101111);


    // ============================================
    // 第二级译码：控制信号分组（Control Signal Groups）
    // ============================================
    // 将执行相同操作的不同指令归并为一个"功能组"信号
    // 例如 ADD、ADDI、LW、SW 都需要 ALU 做加法 → 它们共享 ALU_OP_ADD

    // --- npc_op: 下一条指令地址选择 ---
    wire BRANCH = BEQ | BNE | BLT | BGE | BLTU | BGEU;
    wire NPC_OP_PC4  = !BRANCH & !JAL & !JALR;     // 默认：pc+4
    wire NPC_OP_BRA  = BRANCH;                      // 条件分支
    wire NPC_OP_JMP  = JAL;                         // JAL跳转
    wire NPC_OP_JALR = JALR;                        // JALR跳转

    // --- rf_we: 是否要写寄存器 ---
    // 除了 S-type(Store) 和 B-type(Branch)，其他指令都要写寄存器
    wire STORE = SW | SB | SH;
    wire RF_OP_WE = !STORE & !BRANCH;

    // --- rf_wsel: 写回数据来源 ---
    // ALU类: 所有算术/逻辑/移位/比较/AUIPC/乘除 → 写 ALU 结果
    // RAM类: 所有 LOAD → 写内存数据
    // PC4类:  JAL/JALR → 写返回地址 PC+4
    // EXT类:  LUI → 写立即数（高位拼接0）
    wire LOAD = LW | LB | LBU | LH | LHU;
    wire WB_OP_ALU = ADDI | ORI | SLLI | XORI | ANDI | SLTI | SLTIU | SRLI | SRAI
                   | ADD | SUB | XOR | SLL | SRL | SRA | AND | OR | SLT | SLTU | AUIPC
                   | MUL | MULH | MULHU | DIV | DIVU | REM | REMU;
    wire WB_OP_RAM = LOAD;
    wire WB_OP_PC4 = JAL | JALR;
    wire WB_OP_EXT = LUI;

    // --- sext_op: 立即数格式 ---
    wire I_ALU  = ADDI | ORI | SLLI | XORI | ANDI | SLTI | SLTIU | SRLI | SRAI;
    wire EXT_OP_I = I_ALU | LOAD | JALR;    // I-type: ALU立即数指令 + LOAD + JALR
    wire EXT_OP_S = STORE;                  // S-type: 存储指令
    wire EXT_OP_B = BRANCH;                 // B-type: 分支指令
    wire EXT_OP_U = LUI | AUIPC;            // U-type: LUI + AUIPC
    wire EXT_OP_J = JAL;                    // J-type: JAL

    // --- alu_op: ALU具体操作 ---
    // 注意 "ADDR_CALC" 把 LOAD/STORE/JALR/AUIPC 归并 — 它们都做加法计算地址
    wire ADDR_CALC = LOAD | STORE | JALR | AUIPC;
    wire ALU_OP_ADD   = ADDI | ADDR_CALC;       // 所有需要加法的：ADDI/LOAD/STORE/JALR/AUIPC
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

    // --- alua_sel: ALU A口来源 ---
    wire ALU_A_SEL_PC  = AUIPC;     // 只有 AUIPC 需要 ALU 计算 PC+offset
    wire ALU_A_SEL_RS1 = !AUIPC;    // 其他所有指令都读寄存器 rs1

    // --- alub_sel: ALU B口来源 ---
    // R-type 和 Branch 用 rs2，其他用立即数
    wire R_TYPE = ADD | SUB | XOR | SLL | SRL | SRA | AND | OR | SLT | SLTU
                | MUL | MULH | MULHU | DIV | DIVU | REM | REMU;
    wire ALU_B_SEL_RS2 = R_TYPE | BRANCH;
    wire ALU_B_SEL_EXT = !R_TYPE & !BRANCH;

    // --- ram_r_op: 内存读取类型 ---
    wire RAM_EXT_B  = LB;
    wire RAM_EXT_BU = LBU;
    wire RAM_EXT_H  = LH;
    wire RAM_EXT_HU = LHU;
    wire RAM_EXT_W  = LW;

    // --- ram_w_op: 内存写入类型 ---
    wire RAM_W_B = SB;
    wire RAM_W_H = SH;
    wire RAM_W_W = SW;


    // ============================================
    // 输出信号：独热(one-hot) → 编码(encoded) 转换
    // ============================================
    // 使用 {N{独热信号}} & 编码 的复制-掩码模式：
    //   - 当独热信号=1时，输出编码值
    //   - 当独热信号=0时，输出全0
    //   - 多个信号按位或 (|) 合并（因为各信号互斥）
    // 优点：清晰无歧义，易于扩展新指令

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

endmodule
