# miniRV 单周期CPU — 数据通路表 & 控制信号取值表

基于课程"表格驱动设计"方法，依照 https://cpu-design.p.cs-lab.top/ 格式要求。

---

## 一、功能部件与信号定义

### 1.1 CPU 功能部件

| 部件 | 功能 | 关键端口 |
|------|------|----------|
| **PC** | 程序计数器 | clk_i, rst_i, npc_i, pc_o |
| **NPC** | 下址计算 | pc_i, imm_i, alu_c_i, npc_op_i, Branch_i → npc_o, pc4_o |
| **IMem** | 指令存储器 | pc_i → inst_o |
| **RF** | 寄存器堆 (32×32) | rR1_i(rs1), rR2_i(rs2), wR_i(rd), wD_i, rf_we_i → rD1_o, rD2_o |
| **SEXT** | 立即数扩展 | ins_i(inst[31:7]), sext_op → ext_o |
| **ALU** | 运算器 | A_i, B_i, alu_op → C_o, lt_0_o, eq_0_o |
| **DMem** | 数据存储器 | addr_i, wdata_i, ren_i, wen_i → rdata_o |
| **Ctrl** | 控制器 | opcode, funct3, funct7 → 全部控制信号 |

### 1.2 控制信号一览（10个）

| 信号 | 位宽 | 类型 | 说明 |
|------|------|------|------|
| `npc_op` | 1 | 操作选择 | 0=PC+4 / 1=ALU_C (JALR) |
| `rf_we` | 1 | 操作选择 | 0=不写 / 1=写寄存器 |
| `wd_sel` | 2 | 多路选择 | 00=WB_ALU / 01=WB_MEM / 10=WB_PC4 / 11=WB_EXT |
| `sext_op` | 3 | 操作选择 | 立即数扩展格式选择 (I/S/B/U/J) |
| `alu_op` | 5 | 操作选择 | ALU运算类型 |
| `alua_sel` | 1 | 多路选择 | 0=rs1 / 1=PC |
| `alub_sel` | 1 | 多路选择 | 0=rs2 / 1=ext (立即数) |
| `branch` | 3 | 操作选择 | 分支条件选择 (000=不分支) |
| `dram_we` | 1 | 操作选择 | 0=不写 / 1=写数据存储器 |
| `mul_div` | 1 | 操作选择 | 0=普通指令 / 1=乘除法指令 |

---

## 二、表4-1 数据通路表

> 注：表中 `X.y` 表示部件 `X` 的输出信号 `y`。`RF.rD1` = 读端口1数据，`RF.rD2` = 读端口2数据，`SEXT.ext` = 扩展后立即数，`ALU.C` = ALU运算结果，`DMem.rdata` = 读数据，`NPC.pc4` = PC+4，`NPC.imm` = PC+imm(Branch)。

### 2.1 指令级数据通路（完整37条指令）

| 指令 | PC→NPC | NPC→PC | RF读 | ALU.A | ALU.B | ALU 操作 | SEXT | DMem | RF写 (wD来源) | RF写 (wR) | 备注 |
|------|--------|--------|------|-------|-------|----------|------|------|---------------|-----------|------|
| **R型算逻** | | | | | | | | | | | |
| add | pc+4 | NPC.pc4 | rs1,rs2 | RF.rD1 | RF.rD2 | ADD | — | — | ALU.C | rd | |
| sub | pc+4 | NPC.pc4 | rs1,rs2 | RF.rD1 | RF.rD2 | SUB | — | — | ALU.C | rd | |
| and | pc+4 | NPC.pc4 | rs1,rs2 | RF.rD1 | RF.rD2 | AND | — | — | ALU.C | rd | |
| or | pc+4 | NPC.pc4 | rs1,rs2 | RF.rD1 | RF.rD2 | OR | — | — | ALU.C | rd | |
| xor | pc+4 | NPC.pc4 | rs1,rs2 | RF.rD1 | RF.rD2 | XOR | — | — | ALU.C | rd | |
| sll | pc+4 | NPC.pc4 | rs1,rs2 | RF.rD1 | RF.rD2 | SLL | — | — | ALU.C | rd | |
| srl | pc+4 | NPC.pc4 | rs1,rs2 | RF.rD1 | RF.rD2 | SRL | — | — | ALU.C | rd | |
| sra | pc+4 | NPC.pc4 | rs1,rs2 | RF.rD1 | RF.rD2 | SRA | — | — | ALU.C | rd | |
| slt | pc+4 | NPC.pc4 | rs1,rs2 | RF.rD1 | RF.rD2 | SLT | — | — | ALU.C | rd | |
| sltu | pc+4 | NPC.pc4 | rs1,rs2 | RF.rD1 | RF.rD2 | SLTU | — | — | ALU.C | rd | |
| **R型乘除** | | | | | | | | | | | |
| mul | pc+4 | NPC.pc4 | rs1,rs2 | RF.rD1 | RF.rD2 | MUL | — | — | ALU.C | rd | 多周期 |
| mulh | pc+4 | NPC.pc4 | rs1,rs2 | RF.rD1 | RF.rD2 | MULH | — | — | ALU.C | rd | 多周期 |
| mulhu | pc+4 | NPC.pc4 | rs1,rs2 | RF.rD1 | RF.rD2 | MULH | — | — | ALU.C | rd | 多周期 |
| div | pc+4 | NPC.pc4 | rs1,rs2 | RF.rD1 | RF.rD2 | DIV | — | — | ALU.C | rd | 多周期 |
| divu | pc+4 | NPC.pc4 | rs1,rs2 | RF.rD1 | RF.rD2 | DIV | — | — | ALU.C | rd | 多周期 |
| rem | pc+4 | NPC.pc4 | rs1,rs2 | RF.rD1 | RF.rD2 | REM | — | — | ALU.C | rd | 多周期 |
| remu | pc+4 | NPC.pc4 | rs1,rs2 | RF.rD1 | RF.rD2 | REM | — | — | ALU.C | rd | 多周期 |
| **I型算逻** | | | | | | | | | | | |
| addi | pc+4 | NPC.pc4 | rs1 | RF.rD1 | SEXT.ext | ADD | IMM_I | — | ALU.C | rd | |
| andi | pc+4 | NPC.pc4 | rs1 | RF.rD1 | SEXT.ext | AND | IMM_I | — | ALU.C | rd | |
| ori | pc+4 | NPC.pc4 | rs1 | RF.rD1 | SEXT.ext | OR | IMM_I | — | ALU.C | rd | |
| xori | pc+4 | NPC.pc4 | rs1 | RF.rD1 | SEXT.ext | XOR | IMM_I | — | ALU.C | rd | |
| slli | pc+4 | NPC.pc4 | rs1 | RF.rD1 | SEXT.ext | SLL | IMM_I | — | ALU.C | rd | shamt=imm[4:0] |
| srli | pc+4 | NPC.pc4 | rs1 | RF.rD1 | SEXT.ext | SRL | IMM_I | — | ALU.C | rd | shamt=imm[4:0] |
| srai | pc+4 | NPC.pc4 | rs1 | RF.rD1 | SEXT.ext | SRA | IMM_I | — | ALU.C | rd | shamt=imm[4:0] |
| slti | pc+4 | NPC.pc4 | rs1 | RF.rD1 | SEXT.ext | SLT | IMM_I | — | ALU.C | rd | |
| sltiu | pc+4 | NPC.pc4 | rs1 | RF.rD1 | SEXT.ext | SLTU | IMM_I | — | ALU.C | rd | |
| **I型访存** | | | | | | | | | | | |
| lb | pc+4 | NPC.pc4 | rs1 | RF.rD1 | SEXT.ext | ADD | IMM_I | 读 | DMem.rdata | rd | 多周期 |
| lbu | pc+4 | NPC.pc4 | rs1 | RF.rD1 | SEXT.ext | ADD | IMM_I | 读 | DMem.rdata | rd | 多周期 |
| lh | pc+4 | NPC.pc4 | rs1 | RF.rD1 | SEXT.ext | ADD | IMM_I | 读 | DMem.rdata | rd | 多周期 |
| lhu | pc+4 | NPC.pc4 | rs1 | RF.rD1 | SEXT.ext | ADD | IMM_I | 读 | DMem.rdata | rd | 多周期 |
| lw | pc+4 | NPC.pc4 | rs1 | RF.rD1 | SEXT.ext | ADD | IMM_I | 读 | DMem.rdata | rd | 多周期 |
| jalr | pc+4 | ALU.C | rs1 | RF.rD1 | SEXT.ext | ADD | IMM_I | — | NPC.pc4 | rd | |
| **S型存储** | | | | | | | | | | | |
| sb | pc+4 | NPC.pc4 | rs1,rs2 | RF.rD1 | SEXT.ext | ADD | IMM_S | 写 | — | — | 多周期 |
| sh | pc+4 | NPC.pc4 | rs1,rs2 | RF.rD1 | SEXT.ext | ADD | IMM_S | 写 | — | — | 多周期 |
| sw | pc+4 | NPC.pc4 | rs1,rs2 | RF.rD1 | SEXT.ext | ADD | IMM_S | 写 | — | — | 多周期 |
| **B型分支** | | | | | | | | | | | |
| beq | pc+4 | NPC.imm | rs1,rs2 | RF.rD1 | RF.rD2 | SUB | IMM_B | — | — | — | Branch=1 if eq_0=1 |
| bne | pc+4 | NPC.imm | rs1,rs2 | RF.rD1 | RF.rD2 | SUB | IMM_B | — | — | — | Branch=1 if eq_0=0 |
| blt | pc+4 | NPC.imm | rs1,rs2 | RF.rD1 | RF.rD2 | SUB | IMM_B | — | — | — | Branch=1 if lt_0=1 |
| bltu | pc+4 | NPC.imm | rs1,rs2 | RF.rD1 | RF.rD2 | SUB | IMM_B | — | — | — | Branch=1 if lt_0=1(U) |
| bge | pc+4 | NPC.imm | rs1,rs2 | RF.rD1 | RF.rD2 | SUB | IMM_B | — | — | — | Branch=1 if lt_0=0 |
| bgeu | pc+4 | NPC.imm | rs1,rs2 | RF.rD1 | RF.rD2 | SUB | IMM_B | — | — | — | Branch=1 if lt_0=0(U) |
| **U型** | | | | | | | | | | | |
| lui | pc+4 | NPC.pc4 | — | × | SEXT.ext | ADD(×) | IMM_U | — | SEXT.ext | rd | ALU未使用 |
| auipc | pc+4 | NPC.pc4 | — | PC | SEXT.ext | ADD | IMM_U | — | ALU.C | rd | |
| **J型** | | | | | | | | | | | |
| jal | pc+4 | NPC.imm | — | × | SEXT.ext | ADD(×) | IMM_J | — | NPC.pc4 | rd | |

> 符号：`—` = 不使用该部件/端口，`×` = 任意值（不影响结果），`(×)` = ALU结果被丢弃不用

### 2.2 综合行

将所有指令的数据通路综合，确定各部件输入端口的多路选择器需求。

| 部件.输入端口 | 输入源1 | 输入源2 | 输入源3 | 输入源4 | 选择信号 |
|-------------|---------|---------|---------|---------|----------|
| NPC.pc_i | PC.pc_o (固定) | — | — | — | — |
| NPC.imm_i | SEXT.ext (固定) | — | — | — | — |
| NPC.npc_op | PC4 | ALU_C | — | — | npc_op |
| NPC.Branch | 0 | Branch信号 | — | — | — |
| RF.rR1_i | inst[19:15] (固定) | — | — | — | — |
| RF.rR2_i | inst[24:20] (固定) | — | — | — | — |
| RF.wR_i | inst[11:7] (rd) | — | — | — | — |
| RF.wD_i | ALU.C | DMem.rdata | NPC.pc4 | SEXT.ext | wd_sel |
| RF.rf_we_i | 0 | 1 (或条件) | — | — | rf_we |
| ALU.A_i | RF.rD1 | PC | — | — | alua_sel |
| ALU.B_i | RF.rD2 | SEXT.ext | — | — | alub_sel |
| ALU.alu_op | ADD/SUB/... | (按指令) | — | — | alu_op[4:0] |
| SEXT.ins_i | inst[31:7] (固定) | — | — | — | — |
| SEXT.sext_op | IMM_I | IMM_S | IMM_B | IMM_U/IMM_J | sext_op[2:0] |
| DMem.addr_i | ALU.C (固定) | — | — | — | — |
| DMem.wdata_i | RF.rD2 (固定) | — | — | — | — |
| DMem.ren | 1 (load时) | 0 | — | — | (wd_sel==WB_MEM) |
| DMem.wen | 1 (store时) | 0 | — | — | dram_we |

---

## 三、表5-3 控制信号取值表

### 3.1 控制信号符号定义

#### npc_op（1位）
| 符号 | 值 | 含义 |
|------|-----|------|
| PC4 | 1'b0 | NPC = PC + 4（顺序执行） |
| ALU_C | 1'b1 | NPC = ALU.C（JALR跳转） |

#### rf_we（1位）
| 符号 | 值 | 含义 |
|------|-----|------|
| 1 | 1'b1 | 写寄存器 |
| 0 | 1'b0 | 不写寄存器 |

#### wd_sel（2位）
| 符号 | 值 | 含义 |
|------|-----|------|
| WB_ALU | 2'b00 | 写回ALU运算结果 |
| WB_MEM | 2'b01 | 写回数据存储器读数据 |
| WB_PC4 | 2'b10 | 写回PC+4（JAL/JALR） |
| WB_EXT | 2'b11 | 写回扩展后立即数（LUI） |

#### sext_op（3位）
| 符号 | 值 | 含义 |
|------|-----|------|
| IMM_I | 3'b000 | I型: {{20{inst[31]}}, inst[31:20]} |
| IMM_S | 3'b001 | S型: {{20{inst[31]}}, inst[31:25], inst[11:7]} |
| IMM_B | 3'b010 | B型: {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0} |
| IMM_U | 3'b011 | U型: {inst[31:12], 12'b0} |
| IMM_J | 3'b100 | J型: {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0} |

#### alu_op（5位）
| 符号 | 值 | 含义 |
|------|-----|------|
| ADD | 5'b00001 | C = A + B |
| SUB | 5'b00010 | C = A - B |
| AND | 5'b00011 | C = A & B |
| OR | 5'b00100 | C = A \| B |
| XOR | 5'b00101 | C = A ^ B |
| SLL | 5'b00110 | C = A << B[4:0] |
| SRL | 5'b00111 | C = A >> B[4:0] |
| SRA | 5'b01000 | C = $signed(A) >>> B[4:0] |
| SLT | 5'b01001 | C = ($signed(A) < $signed(B)) ? 1 : 0 |
| SLTU | 5'b01010 | C = (A < B) ? 1 : 0 |
| MUL | 5'b01011 | C = (A * B)[31:0] |
| MULH | 5'b01100 | C = ($signed(A) * $signed(B))[63:32] |
| DIV | 5'b01101 | C = A ÷ B (有符号) |
| REM | 5'b01110 | C = A % B (有符号) |

#### alua_sel（1位）
| 符号 | 值 | 含义 |
|------|-----|------|
| RS1 | 1'b0 | ALU.A = RF.rD1 |
| PC | 1'b1 | ALU.A = PC（仅AUIPC） |

#### alub_sel（1位）
| 符号 | 值 | 含义 |
|------|-----|------|
| RS2 | 1'b0 | ALU.B = RF.rD2 |
| IMM | 1'b1 | ALU.B = SEXT.ext |

#### branch（3位）
| 符号 | 值 | 含义 |
|------|-----|------|
| NONE | 3'b000 | 不分支 |
| BEQ | 3'b101 | 相等分支 (eq_0=1) |
| BNE | 3'b001 | 不等分支 (eq_0=0) |
| BLT | 3'b111 | 有符号小于分支 (lt_0=1) |
| BGE | 3'b011 | 有符号大于等于分支 (lt_0=0) |
| BLTU | 3'b111 | 无符号小于分支 |
| BGEU | 3'b011 | 无符号大于等于分支 |

> Branch逻辑: `Branch = branch[0] & ((branch[1] & (branch[2] ^ lt_0)) | (~branch[1] & (branch[2] ^ eq_0)))`

#### dram_we（1位）
| 符号 | 值 | 含义 |
|------|-----|------|
| 0 | 1'b0 | 不写数据存储器 |
| 1 | 1'b1 | 写数据存储器 |

#### mul_div（1位）
| 符号 | 值 | 含义 |
|------|-----|------|
| 0 | 1'b0 | 非乘除指令 |
| 1 | 1'b1 | 乘除指令（需多周期） |

### 3.2 完整控制信号取值表（37条指令）

| 指令 | npc_op | rf_we | wd_sel | sext_op | alua_sel | alub_sel | alu_op | branch | dram_we | mul_div |
|------|--------|-------|--------|---------|----------|----------|--------|--------|---------|---------|
| **R型算逻** | | | | | | | | | | |
| add | PC4 | 1 | WB_ALU | × | RS1 | RS2 | ADD | NONE | 0 | 0 |
| sub | PC4 | 1 | WB_ALU | × | RS1 | RS2 | SUB | NONE | 0 | 0 |
| and | PC4 | 1 | WB_ALU | × | RS1 | RS2 | AND | NONE | 0 | 0 |
| or | PC4 | 1 | WB_ALU | × | RS1 | RS2 | OR | NONE | 0 | 0 |
| xor | PC4 | 1 | WB_ALU | × | RS1 | RS2 | XOR | NONE | 0 | 0 |
| sll | PC4 | 1 | WB_ALU | × | RS1 | RS2 | SLL | NONE | 0 | 0 |
| srl | PC4 | 1 | WB_ALU | × | RS1 | RS2 | SRL | NONE | 0 | 0 |
| sra | PC4 | 1 | WB_ALU | × | RS1 | RS2 | SRA | NONE | 0 | 0 |
| slt | PC4 | 1 | WB_ALU | × | RS1 | RS2 | SLT | NONE | 0 | 0 |
| sltu | PC4 | 1 | WB_ALU | × | RS1 | RS2 | SLTU | NONE | 0 | 0 |
| **R型乘除** | | | | | | | | | | |
| mul | PC4 | 1 | WB_ALU | × | RS1 | RS2 | MUL | NONE | 0 | 1 |
| mulh | PC4 | 1 | WB_ALU | × | RS1 | RS2 | MULH | NONE | 0 | 1 |
| mulhu | PC4 | 1 | WB_ALU | × | RS1 | RS2 | MULH | NONE | 0 | 1 |
| div | PC4 | 1 | WB_ALU | × | RS1 | RS2 | DIV | NONE | 0 | 1 |
| divu | PC4 | 1 | WB_ALU | × | RS1 | RS2 | DIV | NONE | 0 | 1 |
| rem | PC4 | 1 | WB_ALU | × | RS1 | RS2 | REM | NONE | 0 | 1 |
| remu | PC4 | 1 | WB_ALU | × | RS1 | RS2 | REM | NONE | 0 | 1 |
| **I型算逻** | | | | | | | | | | |
| addi | PC4 | 1 | WB_ALU | IMM_I | RS1 | IMM | ADD | NONE | 0 | 0 |
| andi | PC4 | 1 | WB_ALU | IMM_I | RS1 | IMM | AND | NONE | 0 | 0 |
| ori | PC4 | 1 | WB_ALU | IMM_I | RS1 | IMM | OR | NONE | 0 | 0 |
| xori | PC4 | 1 | WB_ALU | IMM_I | RS1 | IMM | XOR | NONE | 0 | 0 |
| slli | PC4 | 1 | WB_ALU | IMM_I | RS1 | IMM | SLL | NONE | 0 | 0 |
| srli | PC4 | 1 | WB_ALU | IMM_I | RS1 | IMM | SRL | NONE | 0 | 0 |
| srai | PC4 | 1 | WB_ALU | IMM_I | RS1 | IMM | SRA | NONE | 0 | 0 |
| slti | PC4 | 1 | WB_ALU | IMM_I | RS1 | IMM | SLT | NONE | 0 | 0 |
| sltiu | PC4 | 1 | WB_ALU | IMM_I | RS1 | IMM | SLTU | NONE | 0 | 0 |
| **I型访存** | | | | | | | | | | |
| lb | PC4 | 1 | WB_MEM | IMM_I | RS1 | IMM | ADD | NONE | 0 | 0 |
| lbu | PC4 | 1 | WB_MEM | IMM_I | RS1 | IMM | ADD | NONE | 0 | 0 |
| lh | PC4 | 1 | WB_MEM | IMM_I | RS1 | IMM | ADD | NONE | 0 | 0 |
| lhu | PC4 | 1 | WB_MEM | IMM_I | RS1 | IMM | ADD | NONE | 0 | 0 |
| lw | PC4 | 1 | WB_MEM | IMM_I | RS1 | IMM | ADD | NONE | 0 | 0 |
| jalr | ALU_C | 1 | WB_PC4 | IMM_I | RS1 | IMM | ADD | NONE | 0 | 0 |
| **S型存储** | | | | | | | | | | |
| sb | PC4 | 0 | × | IMM_S | RS1 | IMM | ADD | NONE | 1 | 0 |
| sh | PC4 | 0 | × | IMM_S | RS1 | IMM | ADD | NONE | 1 | 0 |
| sw | PC4 | 0 | × | IMM_S | RS1 | IMM | ADD | NONE | 1 | 0 |
| **B型分支** | | | | | | | | | | |
| beq | PC4 | 0 | × | IMM_B | RS1 | RS2 | SUB | BEQ | 0 | 0 |
| bne | PC4 | 0 | × | IMM_B | RS1 | RS2 | SUB | BNE | 0 | 0 |
| blt | PC4 | 0 | × | IMM_B | RS1 | RS2 | SUB | BLT | 0 | 0 |
| bltu | PC4 | 0 | × | IMM_B | RS1 | RS2 | SUB | BLTU | 0 | 0 |
| bge | PC4 | 0 | × | IMM_B | RS1 | RS2 | SUB | BGE | 0 | 0 |
| bgeu | PC4 | 0 | × | IMM_B | RS1 | RS2 | SUB | BGEU | 0 | 0 |
| **U型** | | | | | | | | | | |
| lui | PC4 | 1 | WB_EXT | IMM_U | × | IMM | ADD | NONE | 0 | 0 |
| auipc | PC4 | 1 | WB_ALU | IMM_U | PC | IMM | ADD | NONE | 0 | 0 |
| **J型** | | | | | | | | | | |
| jal | PC4 | 1 | WB_PC4 | IMM_J | × | IMM | ADD | NONE | 0 | 0 |

> 符号：`×` = 任意值（当该信号不影响结果时，如 rf_we=0 时 wd_sel 为任意值；或 alu_op=ADD 但结果被丢弃时 alua_sel 为任意值）

---

## 四、控制信号逻辑（参考实现）

### 4.1 操作选择信号（按指令类别推导）

| 指令类型 (opcode) | npc_op | rf_we | sext_op | alu_op | branch | dram_we | mul_div |
|------|--------|-------|---------|--------|--------|---------|---------|
| R型算逻 (0110011, funct7[0]=0) | 0 | 1 | × | {funct7[5], funct3} | 000 | 0 | 0 |
| R型乘除 (0110011, funct7[0]=1) | 0 | 1 | × | {funct7[5], funct3} | 000 | 0 | 1 |
| I型算逻 (0010011) | 0 | 1 | 000 | {2'b00, funct3} | 000 | 0 | 0 |
| I型load (0000011) | 0 | 1 | 000 | ADD | 000 | 0 | 0 |
| I型jalr (1100111) | 1 | 1 | 000 | ADD | 000 | 0 | 0 |
| S型 (0100011) | 0 | 0 | 001 | ADD | 000 | 1 | 0 |
| B型 (1100011) | 0 | 0 | 010 | SUB | {1'b1, funct3[1], ~funct3[0]^funct3[2]} | 0 | 0 |
| LUI (0110111) | 0 | 1 | 011 | ADD | 000 | 0 | 0 |
| AUIPC (0010111) | 0 | 1 | 011 | ADD | 000 | 0 | 0 |
| JAL (1101111) | 0 | 1 | 100 | ADD | 000 | 0 | 0 |

### 4.2 多路选择信号

| 指令类型 | wd_sel | alua_sel | alub_sel |
|----------|--------|----------|----------|
| R型算逻 | 00 | 0 | 0 |
| R型乘除 | 00 | 0 | 0 |
| I型算逻 | 00 | 0 | 1 |
| I型load | 01 | 0 | 1 |
| I型jalr | 10 | 0 | 1 |
| S型 | ×× | 0 | 1 |
| B型 | ×× | 0 | 0 |
| LUI | 11 | × | 1 |
| AUIPC | 00 | 1 | 1 |
| JAL | 10 | × | 1 |

---

## 五、使用说明

### 5.1 如何在Verilog中使用

1. 创建 `defines.vh` 文件，将上述信号编码定义为宏
2. 在每个模块中 `include "defines.vh"`
3. 控制单元(Ctrl.v)根据 opcode/funct3/funct7 查表生成控制信号

### 5.2 多周期指令处理

- **访存指令** (lb/lbu/lh/lhu/lw/sb/sh/sw)：发出访存请求后需等待 `da_valid` / `da_wresp`
- **乘除指令** (mul/mulh/mulhu/div/divu/rem/remu)：需等待 `!mul_div_busy`

详见 `ref/course-site/lab1-multicycle.md`

### 5.3 Trace调试信号

```verilog
wire [31:0] debug_wb_pc;     // WB阶段PC
wire        debug_wb_rf_we;  // 寄存器写使能
wire [4:0]  debug_wb_rf_wR;  // 目标寄存器号
wire [31:0] debug_wb_rf_wD;  // 写入值

wire [31:0] debug_mem_pc;    // MEM阶段PC
wire [3:0]  debug_mem_we;    // 写使能
wire [31:0] debug_mem_waddr; // 写地址
wire [31:0] debug_mem_wdata; // 写数据
```
