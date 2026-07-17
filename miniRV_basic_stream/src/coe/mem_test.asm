# Memory access test: sb/sh/sw + lb/lbu/lh/lhu/lw + EXT_S
# Uses 0x100 (DRAM) for store/load, 0xFFFF1000 (LED) for output

.text
MAIN:
    lui  a7, 0xFFFF1       # a7 = 0xFFFF_1000 (output)

    # === Test 1: sb + lb (sign-extend) ===
    addi t0, zero, -86     # t0 = 0xFFFF_FFAA
    sw   t0, 0(a7)         # output reference: 0xFFFF_FFAA
    sb   t0, 0x100(zero)   # store byte to [0x100]
    lb   a0, 0x100(zero)   # load signed byte → 0xFFFF_FFAA
    sw   a0, 0(a7)

    # === Test 2: sb + lbu (zero-extend) ===
    addi t0, zero, 0xAA    # t0 = 0x0000_00AA
    sb   t0, 0x100(zero)
    lbu  a0, 0x100(zero)   # load unsigned byte → 0x0000_00AA
    sw   a0, 0(a7)

    # === Test 3: sh + lh (sign-extend) ===
    lui  t0, 0x8           # t0 = 0x0000_8000
    addi t0, t0, 0x765     # t0 = 0x0000_8765
    sh   t0, 0x100(zero)   # store halfword (lower 16 bits)
    lh   a0, 0x100(zero)   # load signed half → 0xFFFF_8765
    sw   a0, 0(a7)

    # === Test 4: sh + lhu (zero-extend) ===
    addi t0, zero, 0x765   # t0 = 0x0000_0765
    sh   t0, 0x100(zero)
    lhu  a0, 0x100(zero)   # load unsigned half → 0x0000_0765
    sw   a0, 0(a7)

    # === Test 5: sw + lw ===
    lui  t0, 0x12345
    addi t0, t0, 0x678     # t0 = 0x1234_5678
    sw   t0, 0x100(zero)
    lw   a0, 0x100(zero)   # → 0x1234_5678
    sw   a0, 0(a7)

    # === Test 6: EXT_S — sw with non-zero offset ===
    # S-type: imm[11:5]=inst[31:25], imm[4:0]=inst[11:7]
    addi t0, zero, 0x7FF
    sw   t0, 0x4(zero)      # store to [0x4], EXT_S needed for imm=4
    lw   a0, 0x4(zero)      # read back → 0x7FF
    sw   a0, 0(a7)

    # === Test 7: lh with offset !== 0 (halfword alignment) ===
    addi t0, zero, 0x333
    sh   t0, 0x2(zero)      # store halfword at offset 2
    lhu  a0, 0x2(zero)      # load halfword unsigned → 0x333
    sw   a0, 0(a7)

    # === Test 8: lb with offset !== 0 ===
    addi t0, zero, 0x7F
    sb   t0, 0x3(zero)      # store byte at offset 3
    lbu  a0, 0x3(zero)      # load byte → 0x7F
    sw   a0, 0(a7)

END_LOOP:
    addi zero, zero, 0
    jal  zero, END_LOOP
