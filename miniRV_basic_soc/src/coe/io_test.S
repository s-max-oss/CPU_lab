# ============================================================================
# io_test.S — 单周期 CPU I/O 外设测试
# ============================================================================
# 测试 5 个外设的读写:
#   0xFFFF_0000 = Switch (读)
#   0xFFFF_1000 = LED    (写)
#   0xFFFF_2000 = DigLED (写)
#   0xFFFF_3000 = UART   (写 TX)
#   0xFFFF_4000 = Timer  (读)
#
# 编译:
#   riscv32-unknown-elf-gcc -c -march=rv32i -mabi=ilp32 io_test.S -o io_test.o
#   riscv32-unknown-elf-objcopy -O verilog io_test.o io_test.hex
# ============================================================================

    .text
    .globl _start

_start:
    # ----------------------------------------------------------------
    # 1. LED 流水灯测试 — 向 0xFFFF_1000 写不同模式
    # ----------------------------------------------------------------
    lui  x1, 0xFFFF1      # x1 = 0xFFFF_1000 (LED base)

    addi x2, x0, 0x001    # x2 = 0x0001
    sw   x2, 0(x1)        # LED[0] on

    addi x2, x0, 0x003    # x2 = 0x0003
    sw   x2, 0(x1)

    addi x2, x0, 0x00F    # x2 = 0x000F
    sw   x2, 0(x1)

    addi x2, x0, 0x0FF    # x2 = 0x00FF
    sw   x2, 0(x1)

    lui  x2, 0x5555       # x2 = 0x5555_5000... wait, lui only loads upper bits
    # Actually for 0x5555 we need lui+addi but for simplicity use addi with direct value
    # 12-bit immediate can hold up to 0x7FF signed or 0xFFF with sign issues
    # Let me use simple patterns that fit in 12-bit signed immediate

    addi x2, x0, 0x555    # x2 = 0x0555
    slli x2, x2, 4        # x2 = 0x5550
    addi x2, x2, 0x005    # x2 = 0x5555
    sw   x2, 0(x1)

    addi x2, x0, 0x0AA    # x2 high part
    slli x2, x2, 4
    addi x2, x2, 0x00A    # x2 = 0x0AAA
    slli x2, x2, 4
    addi x2, x2, 0x00A    # x2 = 0xAAAA
    sw   x2, 0(x1)

    lui  x2, 0xFFFF0      # x2 = 0xFFFF_0000
    addi x2, x2, -1       # x2 = 0xFFFF_FFFF... wait, x2 = 0xFFFF_0000 - 1 = 0xFFFE_FFFF
    # Actually, let me just use simpler patterns
    # For 0xFFFF: use addi with -1 (0xFFF) and sign-extend
    addi x2, x0, -1       # x2 = 0xFFFF_FFFF (all bits set)
    srli x2, x2, 16       # x2 = 0x0000_FFFF
    sw   x2, 0(x1)        # All LEDs on

    # ----------------------------------------------------------------
    # 2. 数码管测试 — 向 0xFFFF_2000 写数据
    # ----------------------------------------------------------------
    lui  x3, 0xFFFF2      # x3 = 0xFFFF_2000 (DigLED base)

    addi x4, x0, 0x012    # digit pattern
    sw   x4, 0(x3)        # DigLED = 0x0012

    addi x4, x0, 0x034    # another pattern
    sw   x4, 0(x3)        # DigLED = 0x0034

    lui  x4, 0x00012      # x4 = 0x0001_2000
    addi x4, x4, 0x345    # x4 = 0x0001_2345
    srli x4, x4, 16       # x4 = 0x0000_0001
    slli x4, x4, 16       # x4 = 0x0001_0000
    addi x4, x4, 0x234    # x4 = 0x0001_0234
    sw   x4, 0(x3)        # DigLED = 0x1234 (digit enable + segment)

    # ----------------------------------------------------------------
    # 3. 拨码开关测试 — 从 0xFFFF_0000 读取并回显到 LED
    # ----------------------------------------------------------------
    lui  x5, 0xFFFF0      # x5 = 0xFFFF_0000 (Switch base)
    lw   x6, 0(x5)        # x6 = switch state
    sw   x6, 0(x1)        # LED = switch state (echo)

    # ----------------------------------------------------------------
    # 4. UART 测试 — 向 0xFFFF_3004 写字符
    # ----------------------------------------------------------------
    lui  x7, 0xFFFF3      # x7 = 0xFFFF_3000 (UART base)

    addi x8, x0, 0x041    # 'A'
    sw   x8, 4(x7)        # UART TX = 'A'

    addi x8, x0, 0x042    # 'B'
    sw   x8, 4(x7)        # UART TX = 'B'

    addi x8, x0, 0x043    # 'C'
    sw   x8, 4(x7)        # UART TX = 'C'

    # ----------------------------------------------------------------
    # 5. 定时器测试 — 从 0xFFFF_4000 读取 64 位计数器
    # ----------------------------------------------------------------
    lui  x9, 0xFFFF4      # x9 = 0xFFFF_4000 (Timer base)
    lw   x10, 0(x9)       # x10 = Timer[31:0] (low 32 bits)
    sw   x10, 0(x1)       # LED = Timer low bits

    lw   x11, 4(x9)       # x11 = Timer[63:32] (high 32 bits)
    sw   x11, 0(x1)       # LED = Timer high bits

    # ----------------------------------------------------------------
    # 6. 完成 — ECALL 退出
    # ----------------------------------------------------------------
    ecall                  # halt (inst = 0x0000_0073)
