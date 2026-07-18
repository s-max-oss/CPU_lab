#!/usr/bin/env python3
"""Generate Phase 2 forwarding test — dense back-to-back dependent instructions."""

# RISC-V instruction encoding functions
def rtype(funct7, rs2, rs1, funct3, rd, opcode):
    return (funct7 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode

def itype(imm12, rs1, funct3, rd, opcode):
    return ((imm12 & 0xFFF) << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode

def stype(imm12, rs2, rs1, funct3, opcode):
    imm_11_5 = (imm12 >> 5) & 0x7F
    imm_4_0 = imm12 & 0x1F
    return (imm_11_5 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (imm_4_0 << 7) | opcode

def utype(imm20, rd, opcode):
    return (imm20 << 12) | (rd << 7) | opcode

# Registers
x0 = 0; x1 = 1; x5 = 5; x6 = 6; x7 = 7; x8 = 8; x9 = 9
x10 = 10; x11 = 11; x12 = 12; x13 = 13; x14 = 14; x15 = 15
x16 = 16; x17 = 17; x18 = 18; x19 = 19; x20 = 20

# Opcodes
OP_LUI   = 0b0110111
OP_LOAD  = 0b0000011
OP_STORE = 0b0100011
OP_IMM   = 0b0010011
OP_OP    = 0b0110011
OP_SYSTEM= 0b1110011

# Funct3
F3_ADD = 0b000; F3_SW = 0b010; F3_LW = 0b010; F3_XOR = 0b100
F3_OR = 0b110; F3_AND = 0b111; F3_SLL = 0b001; F3_SRL = 0b101

# Funct7
F7_ADD = 0b0000000; F7_SUB = 0b0100000; F7_XOR = 0b0000000
F7_OR = 0b0000000; F7_AND = 0b0000000; F7_SLL = 0b0000000; F7_SRL = 0b0000000

NOP = itype(0, x0, F3_ADD, x0, OP_IMM)

program = []

def emit(inst, comment=""):
    program.append((inst, comment))

# ================================================================
# Phase 2 Forwarding Test — 验证 EX/MEM 和 MEM/WB 转发路径
# ================================================================
# 指令间无 NOP，依赖转发解决数据冒险
# Load-use 仍需要 1 个 NOP（Phase 3 才做 stall）

# --- Test 1: EX/MEM forwarding (back-to-back) ---
# ADDI x5,0,10 → 下一拍 x5=10 在 EX/MEM → 转发给 ADDI x5,x5,1 的 EX
emit(itype(10, x0, F3_ADD, x5, OP_IMM),   "T1: ADDI x5, x0, 10    -> x5 = 10")
emit(itype(1, x5, F3_ADD, x5, OP_IMM),    "    ADDI x5, x5, 1     -> x5 = 11 (EX/MEM fwd rs1)")

# ADDI x6,0,20 → ADDI x6,x6,2
emit(itype(20, x0, F3_ADD, x6, OP_IMM),   "T1: ADDI x6, x0, 20    -> x6 = 20")
emit(itype(2, x6, F3_ADD, x6, OP_IMM),    "    ADDI x6, x6, 2     -> x6 = 22 (EX/MEM fwd rs1)")

# ADD x10,x5,x6 — both operands forwarded from different sources
emit(rtype(F7_ADD, x6, x5, F3_ADD, x10, OP_OP), "T1: ADD x10, x5, x6  -> x10 = 33 (dual fwd)")

# --- Test 2: MEM/WB forwarding (1 instruction gap) ---
# x7 = 100, then unrelated inst, then use x7
emit(itype(100, x0, F3_ADD, x7, OP_IMM),  "T2: ADDI x7, x0, 100   -> x7 = 100")
emit(itype(3, x0, F3_ADD, x8, OP_IMM),    "    ADDI x8, x0, 3     -> x8 = 3 (unrelated)")
emit(itype(7, x7, F3_ADD, x9, OP_IMM),    "    ADDI x9, x7, 7     -> x9 = 107 (MEM/WB fwd rs1)")

# x11=50, unrelated (x12), ADD x13,x11,x12 — one MEM/WB, one no fwd needed
emit(itype(50, x0, F3_ADD, x11, OP_IMM),  "T2: ADDI x11, x0, 50   -> x11 = 50")
emit(itype(30, x0, F3_ADD, x12, OP_IMM),  "    ADDI x12, x0, 30   -> x12 = 30")
emit(rtype(F7_ADD, x12, x11, F3_ADD, x13, OP_OP), "T2: ADD x13, x11, x12 -> x13 = 80 (MEM/WB+none)")

# --- Test 3: Store forwarding (rs2 forwarded to SW) ---
emit(itype(0x100, x0, F3_ADD, x17, OP_IMM), "T3: ADDI x17, x0, 0x100 -> base")
emit(itype(0x42, x0, F3_ADD, x14, OP_IMM), "    ADDI x14, x0, 0x42  -> x14 = 66 (store data)")
emit(stype(0x0, x14, x17, F3_SW, OP_STORE), "    SW x14, 0(x17)    -> mem[0x100] = 66 (EX/MEM fwd rs2)")

# Store with ALU-computed value
emit(itype(0x99, x0, F3_ADD, x15, OP_IMM), "    ADDI x15, x0, 0x99  -> x15 = 153")
emit(itype(0x11, x15, F3_ADD, x16, OP_IMM), "    ADDI x16, x15, 0x11 -> x16 = 170 (EX/MEM fwd)")
emit(stype(0x4, x16, x17, F3_SW, OP_STORE), "    SW x16, 4(x17)    -> mem[0x104] = 170 (EX/MEM fwd)")

# Store x10 (computed earlier, should be in WB now with RF write)
emit(itype(0x55, x0, F3_ADD, x18, OP_IMM),  "    ADDI x18, x0, 0x55 -> x18 = 85")
emit(stype(0x8, x10, x17, F3_SW, OP_STORE), "    SW x10, 8(x17)    -> mem[0x108] = 33 (x10 from RF)")

# --- Test 4: Load-use (still needs 1 NOP) ---
emit(stype(0xC, x13, x17, F3_SW, OP_STORE), "T4: SW x13, 12(x17)  -> mem[0x10C] = 80")
emit(itype(0xC, x17, F3_LW, x19, OP_LOAD),  "    LW x19, 12(x17)  -> x19 = 80")
emit(NOP,                                     "    NOP (load-use gap)")
emit(itype(1, x19, F3_ADD, x19, OP_IMM),    "    ADDI x19, x19, 1  -> x19 = 81 (MEM/WB fwd from load)")

# --- Test 5: Various ALU ops with forwarding ---
emit(itype(0xF, x0, F3_ADD, x5, OP_IMM),   "T5: ADDI x5, x0, 15    -> x5 = 15")
emit(itype(0x8, x5, F3_XOR, x6, OP_IMM),   "    XORI x6, x5, 8     -> x6 = 7 (EX/MEM fwd)")
emit(rtype(F7_OR, x6, x5, F3_OR, x7, OP_OP), "    OR x7, x5, x6     -> x7 = 15|7 = 15 (dual fwd)")
emit(rtype(F7_AND, x7, x6, F3_AND, x8, OP_OP), "   AND x8, x7, x6     -> x8 = 15&7 = 7 (dual fwd)")
emit(rtype(F7_SUB, x8, x7, F3_ADD, x9, OP_OP), "   SUB x9, x7, x8     -> x9 = 15-7 = 8 (dual fwd)")

# Store final results
emit(itype(0x100, x0, F3_ADD, x17, OP_IMM), "    ADDI x17, x0, 0x100")
emit(stype(0x10, x19, x17, F3_SW, OP_STORE),"    SW x19, 16(x17)   -> mem[0x110] = 81")
emit(stype(0x14, x9, x17, F3_SW, OP_STORE), "    SW x9, 20(x17)    -> mem[0x114] = 8")

# --- ecall ---
emit(itype(1, x0, 0, x1, OP_IMM),          "ADDI x1, x0, 1   -> trigger")
emit(itype(0x5D, x0, 0, x17, OP_IMM),       "ADDI x17, x0, 93")
emit(itype(0, x0, 0, x10, OP_IMM),          "ADDI x10, x0, 0")
emit(itype(0, x0, 0, x0, OP_SYSTEM),        "ecall")

# ================================================================
# Generate output
# ================================================================

import os
os.makedirs("D:/HuaweiMoveData/Users/20805/Desktop/homework/CPU_lab/tests/pipeline_phase2", exist_ok=True)

print(f"Total instructions: {len(program)}")

# COE format
with open("pipe_phase2_test.coe", "w") as f:
    f.write("memory_initialization_radix=16;\nmemory_initialization_vector=\n")
    for i, (inst, comment) in enumerate(program):
        comma = "" if i == len(program) - 1 else ","
        f.write(f"{inst:08x}{comma}\n")
        if comment:
            f.write(f"// {comment}\n")
    f.write(";\n")

# MIF format
with open("pipe_phase2_test.mif", "w") as f:
    for inst, comment in program:
        f.write(f"{inst:032b}\n")
        if comment:
            f.write(f"-- {comment}\n")

# BIN format
import struct
with open("pipe_phase2_test.bin", "wb") as f:
    for inst, comment in program:
        f.write(struct.pack("<I", inst))

print(f"Generated: pipe_phase2_test.coe, pipe_phase2_test.mif, pipe_phase2_test.bin")
print("Done.")
