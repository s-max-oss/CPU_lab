#!/usr/bin/env python3
"""Generate Phase 3 test — load-use stall (no NOP after LW)."""

import os, struct

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
x0=0; x1=1; x5=5; x6=6; x7=7; x8=8; x9=9
x10=10; x11=11; x12=12; x13=13; x14=14; x15=15
x16=16; x17=17; x18=18; x19=19; x20=20

OP_LUI=0b0110111; OP_LOAD=0b0000011; OP_STORE=0b0100011
OP_IMM=0b0010011; OP_OP=0b0110011; OP_SYSTEM=0b1110011
F3_ADD=0b000; F3_SW=0b010; F3_LW=0b010
F7_ADD=0b0000000; F7_SUB=0b0100000

NOP = itype(0, x0, F3_ADD, x0, OP_IMM)

program = []
def emit(inst, comment=""):
    program.append((inst, comment))

# ================================================================
# Phase 3 — Load-use Stall Test
# ================================================================
# 不再手动插 NOP，依赖硬件 stall 自动处理 load-use 冒险

# --- Setup: store known values to memory ---
emit(itype(0x100, x0, F3_ADD, x17, OP_IMM), "ADDI x17, x0, 0x100  -> base addr")

# Store test patterns
emit(itype(0xAB, x0, F3_ADD, x5, OP_IMM),  "ADDI x5, x0, 0xAB    -> x5 = 171")
emit(stype(0x0, x5, x17, F3_SW, OP_STORE), "SW x5, 0(x17)        -> mem[0x100] = 171")
emit(itype(0xCD, x0, F3_ADD, x6, OP_IMM),  "ADDI x6, x0, 0xCD    -> x6 = 205")
emit(stype(0x4, x6, x17, F3_SW, OP_STORE), "SW x6, 4(x17)        -> mem[0x104] = 205")

# --- Test 1: Load → ALU (use loaded value immediately, NO NOP) ---
emit(itype(0x0, x17, F3_LW, x7, OP_LOAD),  "T1: LW x7, 0(x17)   -> x7 = 171")
emit(itype(1, x7, F3_ADD, x7, OP_IMM),     "    ADDI x7, x7, 1   -> x7 = 172 (stall!)")
emit(itype(2, x7, F3_ADD, x8, OP_IMM),     "    ADDI x8, x7, 2   -> x8 = 174 (fwd)")

# --- Test 2: Load → Store (store loaded value) ---
emit(itype(0x4, x17, F3_LW, x9, OP_LOAD),  "T2: LW x9, 4(x17)   -> x9 = 205")
emit(stype(0x8, x9, x17, F3_SW, OP_STORE), "    SW x9, 8(x17)    -> mem[0x108] = 205 (stall!)")

# --- Test 3: Load → Load (loaded value used as address) ---
emit(itype(0x10, x0, F3_ADD, x18, OP_IMM), "    ADDI x18, x0, 16 -> x18 = 16")
emit(itype(0x55, x0, F3_ADD, x19, OP_IMM), "    ADDI x19, x0, 0x55")
emit(stype(0x10, x19, x17, F3_SW, OP_STORE),"   SW x19, 16(x17)   -> mem[0x110] = 85")
emit(itype(0x10, x17, F3_LW, x10, OP_LOAD),"T3: LW x10, 16(x17) -> x10 = 85")
emit(itype(0x10, x17, F3_LW, x11, OP_LOAD),"    LW x11, 16(x17) -> x11 = 85 (addr reuse, no stall)")

# --- Test 4: Load then 2 instructions gap (forwarding) ---
emit(itype(0x0, x17, F3_LW, x12, OP_LOAD), "T4: LW x12, 0(x17)  -> x12 = 171")
emit(itype(1, x0, F3_ADD, x13, OP_IMM),    "    ADDI x13, x0, 1  -> x13 = 1 (unrelated)")
emit(rtype(F7_ADD, x12, x13, F3_ADD, x14, OP_OP), "ADD x14, x12, x13  -> x14 = 172 (fwd)")

# --- Test 5: Back-to-back ALU (no stall, just forwarding) ---
emit(itype(10, x0, F3_ADD, x15, OP_IMM),   "T5: ADDI x15, x0, 10 -> x15 = 10")
emit(itype(5, x15, F3_ADD, x16, OP_IMM),   "    ADDI x16, x15, 5 -> x16 = 15 (fwd)")

# --- Verify: store results ---
emit(stype(0x14, x7, x17, F3_SW, OP_STORE), "   SW x7, 20(x17)   -> mem[0x114] = 172")
emit(stype(0x18, x8, x17, F3_SW, OP_STORE), "   SW x8, 24(x17)   -> mem[0x118] = 174")
emit(stype(0x1C, x14, x17, F3_SW, OP_STORE),"   SW x14, 28(x17)  -> mem[0x11C] = 172")
emit(stype(0x20, x16, x17, F3_SW, OP_STORE),"   SW x16, 32(x17)  -> mem[0x120] = 15")

# --- ecall ---
emit(itype(1, x0, 0, x1, OP_IMM))
emit(itype(0x5D, x0, 0, x17, OP_IMM))
emit(itype(0, x0, 0, x10, OP_IMM))
emit(itype(0, x0, 0, x0, OP_SYSTEM))

# ================================================================
# Generate
# ================================================================
print(f"Total instructions: {len(program)}")

with open("pipe_phase3_test.coe", "w") as f:
    f.write("memory_initialization_radix=16;\nmemory_initialization_vector=\n")
    for i, (inst, comment) in enumerate(program):
        comma = "" if i == len(program) - 1 else ","
        f.write(f"{inst:08x}{comma}\n")
        if comment:
            f.write(f"// {comment}\n")
    f.write(";\n")

with open("pipe_phase3_test.mif", "w") as f:
    for inst, comment in program:
        f.write(f"{inst:032b}\n")
        if comment:
            f.write(f"-- {comment}\n")

with open("pipe_phase3_test.bin", "wb") as f:
    for inst, comment in program:
        f.write(struct.pack("<I", inst))

print("Generated: pipe_phase3_test.coe, pipe_phase3_test.mif, pipe_phase3_test.bin")
print("Done.")
