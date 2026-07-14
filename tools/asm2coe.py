#!/usr/bin/env python3
"""miniRV assembler: .asm -> .coe machine code"""

import sys, re, struct

# Register name -> number
REGS = {f'x{i}': i for i in range(32)}
REGS.update({
    'zero':0, 'ra':1, 'sp':2, 'gp':3, 'tp':4,
    't0':5, 't1':6, 't2':7, 's0':8, 's1':9, 'fp':8,
    'a0':10, 'a1':11, 'a2':12, 'a3':13, 'a4':14, 'a5':15, 'a6':16, 'a7':17,
    's2':18, 's3':19, 's4':20, 's5':21, 's6':22, 's7':23,
    's8':24, 's9':25, 's10':26, 's11':27,
    't3':28, 't4':29, 't5':30, 't6':31,
})

# Instruction encodings: mnemonic -> (type, opcode, funct3, funct7)
# type: 'R','I','S','B','U','J', 'I_SHIFT' (shift with shamt), 'I_LOAD', 'I_JALR'
INST = {
    # R-type (funct7, funct3 depend on variant)
    'add':  ('R', 0b0110011, 0b000, 0b0000000),
    'sub':  ('R', 0b0110011, 0b000, 0b0100000),
    'mul':  ('R', 0b0110011, 0b000, 0b0000001),
    'sll':  ('R', 0b0110011, 0b001, 0b0000000),
    'mulh': ('R', 0b0110011, 0b001, 0b0000001),
    'slt':  ('R', 0b0110011, 0b010, 0b0000000),
    'sltu': ('R', 0b0110011, 0b011, 0b0000000),
    'mulhu':('R', 0b0110011, 0b011, 0b0000001),
    'xor':  ('R', 0b0110011, 0b100, 0b0000000),
    'div':  ('R', 0b0110011, 0b100, 0b0000001),
    'srl':  ('R', 0b0110011, 0b101, 0b0000000),
    'sra':  ('R', 0b0110011, 0b101, 0b0100000),
    'divu': ('R', 0b0110011, 0b101, 0b0000001),
    'or':   ('R', 0b0110011, 0b110, 0b0000000),
    'rem':  ('R', 0b0110011, 0b110, 0b0000001),
    'and':  ('R', 0b0110011, 0b111, 0b0000000),
    'remu': ('R', 0b0110011, 0b111, 0b0000001),

    # I-type ALU
    'addi': ('I', 0b0010011, 0b000, 0),
    'xori': ('I', 0b0010011, 0b100, 0),
    'ori':  ('I', 0b0010011, 0b110, 0),
    'andi': ('I', 0b0010011, 0b111, 0),
    'slti': ('I', 0b0010011, 0b010, 0),
    'sltiu':('I', 0b0010011, 0b011, 0),

    # I-type shift (upper bits = shamt)
    'slli': ('I_SHIFT', 0b0010011, 0b001, 0b0000000),
    'srli': ('I_SHIFT', 0b0010011, 0b101, 0b0000000),
    'srai': ('I_SHIFT', 0b0010011, 0b101, 0b0100000),

    # I-type load
    'lb':  ('I_LOAD', 0b0000011, 0b000, 0),
    'lh':  ('I_LOAD', 0b0000011, 0b001, 0),
    'lw':  ('I_LOAD', 0b0000011, 0b010, 0),
    'lbu': ('I_LOAD', 0b0000011, 0b100, 0),
    'lhu': ('I_LOAD', 0b0000011, 0b101, 0),

    # I-type JALR
    'jalr': ('I_JALR', 0b1100111, 0b000, 0),

    # S-type store
    'sb': ('S', 0b0100011, 0b000, 0),
    'sh': ('S', 0b0100011, 0b001, 0),
    'sw': ('S', 0b0100011, 0b010, 0),

    # B-type branch
    'beq':  ('B', 0b1100011, 0b000, 0),
    'bne':  ('B', 0b1100011, 0b001, 0),
    'blt':  ('B', 0b1100011, 0b100, 0),
    'bge':  ('B', 0b1100011, 0b101, 0),
    'bltu': ('B', 0b1100011, 0b110, 0),
    'bgeu': ('B', 0b1100011, 0b111, 0),

    # U-type
    'lui':   ('U', 0b0110111, 0, 0),
    'auipc': ('U', 0b0010111, 0, 0),

    # J-type
    'jal': ('J', 0b1101111, 0, 0),
}

def parse_reg(s):
    s = s.strip()
    if s in REGS: return REGS[s]
    raise ValueError(f"Unknown register: {s}")

def parse_imm(s):
    s = s.strip()
    if s.lower().startswith('0x'):
        return int(s, 16) & 0xFFFFFFFF
    if s.lower().startswith('0b'):
        return int(s, 2) & 0xFFFFFFFF
    if s.startswith('-'):
        return int(s, 10) & 0xFFFFFFFF
    return int(s, 10) & 0xFFFFFFFF

def sext(val, bits):
    """Sign-extend to 32 bits"""
    mask = 1 << (bits - 1)
    val = val & ((1 << bits) - 1)
    return (val ^ mask) - mask

def encode_r(inst, rd, rs1, rs2):
    _, opc, f3, f7 = INST[inst]
    return (f7 << 25) | (rs2 << 20) | (rs1 << 15) | (f3 << 12) | (rd << 7) | opc

def encode_i(inst, rd, rs1, imm):
    _, opc, f3, _ = INST[inst]
    imm12 = imm & 0xFFF
    return (imm12 << 20) | (rs1 << 15) | (f3 << 12) | (rd << 7) | opc

def encode_i_shift(inst, rd, rs1, shamt):
    _, opc, f3, f7 = INST[inst]
    return (f7 << 25) | (shamt << 20) | (rs1 << 15) | (f3 << 12) | (rd << 7) | opc

def encode_i_load(inst, rd, rs1, imm):
    _, opc, f3, _ = INST[inst]
    imm12 = imm & 0xFFF
    return (imm12 << 20) | (rs1 << 15) | (f3 << 12) | (rd << 7) | opc

def encode_i_jalr(inst, rd, rs1, imm):
    _, opc, f3, _ = INST[inst]
    imm12 = imm & 0xFFF
    return (imm12 << 20) | (rs1 << 15) | (f3 << 12) | (rd << 7) | opc

def encode_s(inst, rs1, rs2, imm):
    _, opc, f3, _ = INST[inst]
    imm12 = imm & 0xFFF
    imm_hi = (imm12 >> 5) & 0x7F
    imm_lo = imm12 & 0x1F
    return (imm_hi << 25) | (rs2 << 20) | (rs1 << 15) | (f3 << 12) | (imm_lo << 7) | opc

def encode_b(inst, rs1, rs2, imm):
    _, opc, f3, _ = INST[inst]
    imm12 = imm & 0x1FFE  # 13-bit signed offset, LSB always 0
    b12   = (imm12 >> 12) & 1
    b11   = (imm12 >> 11) & 1
    b10_5 = (imm12 >> 5) & 0x3F
    b4_1  = (imm12 >> 1) & 0xF
    imm_enc = (b12 << 12) | (b11 << 11) | (b10_5 << 5) | (b4_1 << 1)
    return (imm_enc << 20) | (rs2 << 20) | (rs1 << 15) | (f3 << 12) | (imm_enc & 0xFFF) | opc
    # Let me redo this properly:

def encode_b_proper(inst, rs1, rs2, imm):
    _, opc, f3, _ = INST[inst]
    imm = imm & 0x1FFE
    bits = ( (imm & 0x1000) << 19 |    # imm[12]  → bit 31
             (imm & 0x07E0) << 20 |     # imm[10:5]→ bits 30:25
             (rs2 & 0x1F) << 20 |
             (rs1 & 0x1F) << 15 |
             (f3  & 0x7)  << 12 |
             (imm & 0x001E) << 7 |      # imm[4:1] → bits 11:8
             (imm & 0x0800) >> 4 |      # imm[11]  → bit 7
             opc )
    return bits

def encode_u(inst, rd, imm):
    _, opc, _, _ = INST[inst]
    return ((imm & 0xFFFFF) << 12) | (rd << 7) | opc

def encode_j(inst, rd, imm):
    _, opc, _, _ = INST[inst]
    imm = imm & 0x1FFFFE
    bits = ( (imm & 0x100000) << 11 |    # imm[20] → bit 31
             (imm & 0x0007FE) << 20 |     # imm[10:1]→ bits 30:21
             (imm & 0x000800) << 9  |     # imm[11]  → bit 20
             (imm & 0x0FF000) << 0  |     # imm[19:12]→ bits 19:12
             (rd  & 0x1F)   << 7  |
             opc )
    return bits

def assemble_line(line, labels, pc):
    """Parse one assembly line, return 32-bit instruction word"""
    # Remove comments
    line = re.sub(r'#.*', '', line).strip()
    if not line: return None

    # Label?
    m = re.match(r'^(\w+):\s*(.*)', line)
    if m:
        labels[m.group(1)] = pc
        line = m.group(2).strip()
        if not line: return None

    # Split mnemonic and operands
    parts = line.replace(',', ' ').split()
    if not parts: return None
    mnemonic = parts[0].lower()
    args = parts[1:]

    if mnemonic not in INST:
        if mnemonic in ('.text', '.data', '.word', '.globl', '.section'):
            if mnemonic == '.word':
                return int(args[0], 0) & 0xFFFFFFFF
            return None
        raise ValueError(f"Unknown instruction at PC={pc:#x}: {mnemonic}")

    inst_type, opc, f3, f7 = INST[mnemonic]

    if inst_type == 'R':
        rd, rs1, rs2 = parse_reg(args[0]), parse_reg(args[1]), parse_reg(args[2])
        return encode_r(mnemonic, rd, rs1, rs2)

    elif inst_type == 'I':
        rd, rs1, imm = parse_reg(args[0]), parse_reg(args[1]), parse_imm(args[2])
        return encode_i(mnemonic, rd, rs1, imm)

    elif inst_type == 'I_SHIFT':
        rd, rs1, shamt = parse_reg(args[0]), parse_reg(args[1]), parse_imm(args[2])
        return encode_i_shift(mnemonic, rd, rs1, shamt & 0x1F)

    elif inst_type == 'I_LOAD':
        # lw rd, offset(rs1)
        rd = parse_reg(args[0])
        m = re.match(r'(-?[\w]+)\((\w+)\)', args[1])
        if m:
            imm = parse_imm(m.group(1))
            rs1 = parse_reg(m.group(2))
        else:
            rs1 = parse_reg(args[1])
            imm = parse_imm(args[2]) if len(args) > 2 else 0
        return encode_i_load(mnemonic, rd, rs1, imm)

    elif inst_type == 'I_JALR':
        rd, rs1, imm = parse_reg(args[0]), parse_reg(args[1]), parse_imm(args[2])
        return encode_i_jalr(mnemonic, rd, rs1, imm)

    elif inst_type == 'S':
        # sw rs2, offset(rs1)  OR  sw rs2, rs1, imm
        rs2 = parse_reg(args[0])
        m = re.match(r'(-?[\w]+)\((\w+)\)', args[1])
        if m:
            imm = parse_imm(m.group(1))
            rs1 = parse_reg(m.group(2))
        elif len(args) >= 2:
            # Try offset(rs1) or rs1, imm
            if '(' in args[1]:
                m2 = re.match(r'(-?[\w]+)\((\w+)\)', args[1])
                imm = parse_imm(m2.group(1))
                rs1 = parse_reg(m2.group(2))
            else:
                rs1 = REGS.get(args[1].strip(), 0)
                imm = parse_imm(args[2]) if len(args) > 2 else 0
        else:
            rs1, imm = 0, 0
        return encode_s(mnemonic, rs1, rs2, imm)

    elif inst_type == 'B':
        rs1, rs2 = parse_reg(args[0]), parse_reg(args[1])
        label = args[2]
        if label in labels:
            offset = labels[label] - pc
        else:
            offset = parse_imm(label)
        return encode_b_proper(mnemonic, rs1, rs2, offset)

    elif inst_type == 'U':
        rd, imm = parse_reg(args[0]), parse_imm(args[1])
        return encode_u(mnemonic, rd, imm)

    elif inst_type == 'J':
        rd = parse_reg(args[0])
        label = args[1]
        if label in labels:
            offset = labels[label] - pc
        else:
            offset = parse_imm(label)
        return encode_j(mnemonic, rd, offset)

    return None

def assemble(text):
    """Assemble text, return list of 32-bit words"""
    labels = {}
    words = []

    # Pass 1: collect labels and assemble
    for line in text.strip().split('\n'):
        line = re.sub(r'#.*', '', line).strip()
        if not line: continue
        m = re.match(r'^(\w+):\s*(.*)', line)
        if m:
            labels[m.group(1)] = len(words) * 4
            line = m.group(2).strip()
            if not line: continue
        parts = line.replace(',', ' ').split()
        if not parts: continue
        if parts[0].lower() in INST or parts[0].lower().startswith('.'):
            words.append(None)  # placeholder

    # Pass 2: encode
    result = []
    pc = 0
    idx = 0
    for line in text.strip().split('\n'):
        w = assemble_line(line, labels, pc)
        if w is not None:
            result.append(w)
            pc += 4
    return result

def to_coe(words, output_path):
    with open(output_path, 'w') as f:
        f.write("MEMORY_INITIALIZATION_RADIX=16;\n")
        f.write("MEMORY_INITIALIZATION_VECTOR=\n")
        for i, w in enumerate(words):
            comma = "," if i < len(words) - 1 else ";"
            f.write(f"{w:08x}{comma}\n")
    print(f"Written {len(words)} words to {output_path}")

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: python asm2coe.py <input.asm> [output.coe]")
        sys.exit(1)

    asm_path = sys.argv[1]
    coe_path = sys.argv[2] if len(sys.argv) > 2 else asm_path.replace('.asm', '.coe')

    with open(asm_path, 'r', encoding='utf-8') as f:
        text = f.read()

    words = assemble(text)
    if not words:
        print("Error: no instructions assembled")
        sys.exit(1)

    print(f"Assembled {len(words)} instructions:")
    for i, w in enumerate(words):
        print(f"  [{i*4:04x}] {w:08x}")

    to_coe(words, coe_path)
