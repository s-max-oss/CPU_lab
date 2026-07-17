#!/usr/bin/env python3
"""Generate pipeline-safe test program with addresses within 64KB range."""

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

def jtype(imm20, rd, opcode):
    # imm20 is the jump offset (signed, 21-bit, LSB=0)
    # Encoding: imm[20|10:1|11|19:12]
    b20 = (imm20 >> 20) & 1
    b10_1 = (imm20 >> 1) & 0x3FF
    b11 = (imm20 >> 11) & 1
    b19_12 = (imm20 >> 12) & 0xFF
    encoded = (b20 << 31) | (b10_1 << 21) | (b11 << 20) | (b19_12 << 12) | (rd << 7) | opcode
    return encoded

# Registers
x0 = 0; x1 = 1; x2 = 2; x3 = 3; x4 = 4; x5 = 5; x6 = 6; x7 = 7
x8 = 8; x9 = 9; x10 = 10; x11 = 11; x12 = 12; x13 = 13; x14 = 14; x15 = 15
x16 = 16; x17 = 17; x18 = 18; x19 = 19; x20 = 20; x21 = 21
x22 = 22; x23 = 23; x24 = 24; x25 = 25; x26 = 26; x27 = 27
x28 = 28; x29 = 29; x30 = 30; x31 = 31

# Opcodes
OP_LUI   = 0b0110111
OP_AUIPC = 0b0010111
OP_JAL   = 0b1101111
OP_JALR  = 0b1100111
OP_BRANCH= 0b1100011
OP_LOAD  = 0b0000011
OP_STORE = 0b0100011
OP_IMM   = 0b0010011
OP_OP    = 0b0110011
OP_SYSTEM= 0b1110011

# Funct3
F3_ADD  = 0b000; F3_SLL  = 0b001; F3_SLT  = 0b010; F3_SLTU = 0b011
F3_XOR  = 0b100; F3_SRL  = 0b101; F3_OR   = 0b110; F3_AND  = 0b111
F3_SW   = 0b010; F3_LW   = 0b010; F3_SUB  = 0b000
F3_BEQ  = 0b000

# Funct7
F7_ADD = 0b0000000; F7_SUB = 0b0100000

NOP = itype(0, x0, F3_ADD, x0, OP_IMM)  # ADDI x0, x0, 0

def NOP3():
    """Return 3 NOPs for pipeline padding."""
    return [NOP, NOP, NOP]

program = []

def emit(inst, comment=""):
    program.append((inst, comment))

def emit_nop_padded(inst, comment=""):
    """Emit instruction followed by 3 NOPs for pipeline safety."""
    emit(inst, comment)
    for _ in range(3):
        emit(NOP)

# ============================================================
# Pipeline-safe test program
# ============================================================
# All memory accesses use addresses 0x100-0x1FF (within 64KB)

# --- ALU tests ---
emit_nop_padded(itype(10, x0, F3_ADD, x5, OP_IMM),   "ADDI x5, x0, 10    -> x5 = 10")
emit_nop_padded(itype(20, x0, F3_ADD, x6, OP_IMM),   "ADDI x6, x0, 20    -> x6 = 20")
emit_nop_padded(rtype(F7_ADD, x6, x5, F3_ADD, x10, OP_OP), "ADD x10, x5, x6    -> x10 = 30")
emit_nop_padded(itype(5, x0, F3_ADD, x7, OP_IMM),    "ADDI x7, x0, 5     -> x7 = 5")
emit_nop_padded(rtype(F7_SUB, x7, x10, F3_ADD, x11, OP_OP), "SUB x11, x10, x7   -> x11 = 25")
emit_nop_padded(utype(0x12345, x12, OP_LUI),          "LUI x12, 0x12345   -> x12 = 0x12345000")

# --- Memory tests: use base_addr = 0x100 (safe within 64KB) ---
emit_nop_padded(itype(0x100, x0, F3_ADD, x17, OP_IMM), "ADDI x17, x0, 0x100 -> x17 = 0x100 (base)")

# Store ALU results
emit_nop_padded(stype(0x0,  x10, x17, F3_SW, OP_STORE), "SW x10, 0(x17)   -> mem[0x100] = 30")
emit_nop_padded(stype(0x4,  x11, x17, F3_SW, OP_STORE), "SW x11, 4(x17)   -> mem[0x104] = 25")
emit_nop_padded(stype(0x8,  x12, x17, F3_SW, OP_STORE), "SW x12, 8(x17)   -> mem[0x108] = 0x12345000")

# Load back and verify
emit_nop_padded(itype(0x0, x17, F3_LW, x13, OP_LOAD), "LW x13, 0(x17)   -> x13 = mem[0x100]")
emit_nop_padded(itype(0x4, x17, F3_LW, x14, OP_LOAD), "LW x14, 4(x17)   -> x14 = mem[0x104]")
emit_nop_padded(itype(0x8, x17, F3_LW, x15, OP_LOAD), "LW x15, 8(x17)   -> x15 = mem[0x108]")

# ALU ops on loaded values
emit_nop_padded(rtype(F7_ADD, x14, x13, F3_ADD, x16, OP_OP), "ADD x16, x13, x14 -> x16 = 30 + 25 = 55")
emit_nop_padded(rtype(F7_SUB, x13, x12, F3_ADD, x8, OP_OP),  "SUB x8, x12, x13  -> x8 = 0x12345000 - 30")

# --- ecall to end ---
emit(itype(1, x0, 0, x1, OP_IMM),   "ADDI x1, x0, 1   -> x1 = 1 (trigger)")
emit(itype(0x5D, x0, 0, x17, OP_IMM), "ADDI x17, x0, 93 -> x17 = 93")
emit(itype(0, x0, 0, x10, OP_IMM),  "ADDI x10, x0, 0  -> x10 = 0")
emit(itype(0, x0, 0, x0, OP_SYSTEM), "ecall")

# ============================================================
# Generate output
# ============================================================

print(f"Total instructions: {len(program)}")

# Generate COE format
with open("pipe_phase1_test.coe", "w") as f:
    f.write("memory_initialization_radix=16;\nmemory_initialization_vector=\n")
    for i, (inst, comment) in enumerate(program):
        comma = "" if i == len(program) - 1 else ","
        f.write(f"{inst:08x}{comma}\n")
        if comment:
            f.write(f"// {comment}\n")
    f.write(";\n")

# Generate MIF format
with open("pipe_phase1_test.mif", "w") as f:
    for inst, comment in program:
        # 32-bit binary string
        f.write(f"{inst:032b}\n")
        if comment:
            f.write(f"-- {comment}\n")

# Generate BIN format (raw 32-bit little-endian words)
import struct
with open("pipe_phase1_test.bin", "wb") as f:
    for inst, comment in program:
        f.write(struct.pack("<I", inst))

print("Generated: pipe_phase1_test.coe, pipe_phase1_test.mif, pipe_phase1_test.bin")
print("Done.")
