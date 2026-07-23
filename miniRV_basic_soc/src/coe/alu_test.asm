# ALU single-cycle test
# Outputs results to 0xFFFF1000, then hits end marker 0x73

.text
MAIN:
    lui  a7, 0xFFFF1       # a7 = 0xFFFF_1000 (output address)

    # === ADD/SUB ===
    addi t0, zero, 100
    addi t1, zero, 30
    add  a0, t0, t1         # 100 + 30 = 130
    sw   a0, 0(a7)
    sub  a0, t0, t1         # 100 - 30 = 70
    sw   a0, 0(a7)

    # === XOR/OR/AND ===
    addi t0, zero, 0x555
    addi t1, zero, 0x333
    xor  a0, t0, t1         # 0x555 ^ 0x333 = 0x666
    sw   a0, 0(a7)
    or   a0, t0, t1         # 0x555 | 0x333 = 0x777
    sw   a0, 0(a7)
    and  a0, t0, t1         # 0x555 & 0x333 = 0x111
    sw   a0, 0(a7)

    # === SLL/SRL/SRA ===
    addi t0, zero, -100     # 0xFFFF_FF9C
    addi t1, zero, 4
    sll  a0, t0, t1         # -100 << 4 = -1600
    sw   a0, 0(a7)
    srl  a0, t0, t1         # -100 >> 4 (logical) = 0x0FFF_FFF9
    sw   a0, 0(a7)
    sra  a0, t0, t1         # -100 >> 4 (arithmetic) = -7 = 0xFFFF_FFF9
    sw   a0, 0(a7)

    # === SLT/SLTU ===
    addi t0, zero, -5       # signed: -5, unsigned: huge
    addi t1, zero, 10
    slt  a0, t0, t1         # -5 < 10 signed → 1
    sw   a0, 0(a7)
    sltu a0, t0, t1         # huge < 10 unsigned → 0
    sw   a0, 0(a7)

    # === Immediate ALU ops ===
    addi t0, zero, 50
    xori a0, t0, 0xFF       # 50 ^ 255 = 205
    sw   a0, 0(a7)
    andi a0, t0, 0x1F       # 50 & 31 = 18
    sw   a0, 0(a7)
    slti a0, t0, 100        # 50 < 100 → 1
    sw   a0, 0(a7)
    sltiu a0, t0, 20        # 50 < 20 → 0
    sw   a0, 0(a7)

    # === End marker ===
    addi zero, zero, 0       # NOP, assembled to 0x00000013
    # .word 0x00000073       # ECALL = end marker

END_LOOP:
    addi zero, zero, 0
    jal  zero, END_LOOP
