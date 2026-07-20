// ============================================================================
// defines.vh — 单周期 RISC-V CPU 全局宏定义
// ============================================================================
// 【理解重点】
// 本文件定义了所有控制信号的编码。Verilog中使用 `define 宏名 值
// 相当于C语言的 #define，在编译预处理阶段会进行文本替换。
// 理解本文件是理解 Controller.v 和所有模块间信号含义的前提。
//
// 关键信号概览：
//   alu_op[4:0]  → 告诉ALU做什么运算（加减乘除、比较、移位）
//   npc_op[1:0]  → 告诉NPC如何计算下一条指令地址
//   sext_op[2:0] → 告诉SEXT如何从32位指令中提取并扩展立即数
//   rf_wsel[1:0] → 告诉写回MUX选择哪个来源写入寄存器
//   ram_rop/ram_wop → 告诉MREQ/MEXT如何访问内存（字节/半字/字）
// ============================================================================

// `define RUN_TRACE        // 【调试用】开启后输出执行trace，综合时应注释掉

// `define ENABLE_ICACHE     // 【未实现】I-Cache使能，当前版本不支持
// `define ENABLE_DCACHE     // 【未实现】D-Cache使能，当前版本不支持

// ---------------------------------------------------------------------------
// 一、程序计数器初始值
// ---------------------------------------------------------------------------
`define PC_INIT_VAL 32'h0        // CPU复位后从地址 0x00000000 开始取指

// ---------------------------------------------------------------------------
// 二、ALU 运算类型编码 [4:0]
// ---------------------------------------------------------------------------
// 单周期操作（组合逻辑，1拍出结果）：
`define ALU_ADD     5'h00        // 加法  c = a + b
`define ALU_SUB     5'h01        // 减法  c = a - b
`define ALU_XOR     5'h02        // 异或  c = a ^ b
`define ALU_OR      5'h03        // 或    c = a | b
`define ALU_AND     5'h04        // 与    c = a & b
`define ALU_SLL     5'h05        // 逻辑左移  c = a << b[4:0]
`define ALU_SRL     5'h06        // 逻辑右移  c = a >> b[4:0]
`define ALU_SRA     5'h07        // 算术右移  c = $signed(a) >>> b[4:0]
`define ALU_EQ      5'h08        // 等于比较 (beq)  br = (a == b)
`define ALU_NE      5'h09        // 不等比较 (bne)  br = (a != b)
`define ALU_SLT     5'h0A        // 有符号小于比较 (blt/slt)  br/c = (a < b)
`define ALU_SLTU    5'h0B        // 无符号小于比较 (bltu/sltu)
`define ALU_LT      5'h0C        // 有符号小于 (blt专用)
`define ALU_GE      5'h0D        // 有符号大于等于 (bge专用)
`define ALU_LTU     5'h0E        // 无符号小于 (bltu专用)
`define ALU_GEU     5'h0F        // 无符号大于等于 (bgeu专用)

// 多周期操作（需要多个时钟周期才能完成，由mul_div_flag/Busy控制）：
`define ALU_MUL     5'h10        // 有符号乘法低32位  c = (a*b)[31:0]
`define ALU_MULH    5'h11        // 有符号乘法高32位  c = (a*b)[63:32]
`define ALU_MULHU   5'h12        // 无符号乘法高32位
`define ALU_DIV     5'h13        // 有符号除法商
`define ALU_DIVU    5'h14        // 无符号除法商
`define ALU_REM     5'h15        // 有符号除法余数
`define ALU_REMU    5'h16        // 无符号除法余数

// ---------------------------------------------------------------------------
// 三、NPC (Next PC) 操作编码 [1:0]  — 决定 pc_next 的来源
// ---------------------------------------------------------------------------
`define NPC_PC4     2'b00        // pc + 4  (顺序执行，默认)
`define NPC_JALR    2'b01        // JALR 跳转  pc = rs1 + offset（最低位清零对齐半字）
`define NPC_BRA     2'b10        // 条件分支  pc = br ? (pc+offset) : (pc+4)
`define NPC_JMP     2'b11        // JAL 跳转  pc = pc + offset

// ---------------------------------------------------------------------------
// 四、SEXT (Sign Extension) 操作编码 [2:0]
// ---------------------------------------------------------------------------
// RISC-V 五种立即数格式，SEXT 负责从 inst[31:7] 中提取并符号扩展到32位
`define EXT_I       3'b000        // I-type: inst[31:20]（ADDI/LW/JALR等）
`define EXT_S       3'b001        // S-type: inst[31:25] + inst[11:7]（SW等）
`define EXT_B       3'b010        // B-type: inst[31]+inst[7]+inst[30:25]+inst[11:8]（BEQ等分支）
`define EXT_U       3'b011        // U-type: inst[31:12]（LUI/AUIPC）
`define EXT_J       3'b100        // J-type: inst[31]+inst[19:12]+inst[20]+inst[30:21]（JAL）

// ---------------------------------------------------------------------------
// 五、写回数据选择 (WB MUX) 编码 [1:0]
// ---------------------------------------------------------------------------
// 决定写入寄存器rd的数据来源于哪里
`define WB_ALU      2'b00        // 来自ALU计算结果（算术逻辑指令）
`define WB_RAM      2'b01        // 来自内存读取  （LOAD指令）
`define WB_PC4      2'b10        // 来自PC+4       （JAL/JALR保存返回地址）
`define WB_EXT      2'b11        // 来自SEXT       （LUI加载立即数）

// ---------------------------------------------------------------------------
// 六、ALU 操作数选择
// ---------------------------------------------------------------------------
`define ALU_A_RS1   1'b0         // ALU端口A = 寄存器rs1的值（绝大多数指令）
`define ALU_A_PC    1'b1         // ALU端口A = PC值        （AUIPC专用）

`define ALU_B_RS2   1'b0         // ALU端口B = 寄存器rs2的值（R-type和B-type）
`define ALU_B_EXT   1'b1         // ALU端口B = 立即数扩展值（I-type/S-type/U-type/J-type）

// ---------------------------------------------------------------------------
// 七、内存读取结果扩展类型 (MEXT) 编码 [2:0]
// ---------------------------------------------------------------------------
`define RAM_EXT_N   3'b000        // 不读内存
`define RAM_EXT_W   3'b001        // LW：字读取，无扩展
`define RAM_EXT_B   3'b010        // LB：字节读取，符号扩展到32位
`define RAM_EXT_BU  3'b011        // LBU：字节读取，零扩展到32位
`define RAM_EXT_H   3'b100        // LH：半字读取，符号扩展
`define RAM_EXT_HU  3'b101        // LHU：半字读取，零扩展

// ---------------------------------------------------------------------------
// 八、内存写入字节使能编码 [3:0]
// ---------------------------------------------------------------------------
`define RAM_WE_N    4'b0000       // 不写内存
`define RAM_WE_B    4'b0001       // SB：写1字节
`define RAM_WE_H    4'b0011       // SH：写2字节（半字）
`define RAM_WE_W    4'b1111       // SW：写4字节（全字）

// ---------------------------------------------------------------------------
// 九、地址空间映射
// ---------------------------------------------------------------------------
`define MEM_BLOCK_MEMORY    32'h0000_0000   // 块内存 512KB (0x0000_0000 ~ 0x0007_FFFF)
`define MEM_DDR3            32'h2000_0000   // DDR3   512MB (0x2000_0000 ~ 0x3FFF_FFFF)
`define PERI_ADDR_SWITCH    32'hFFFF_0000   // 外设：拨码开关
`define PERI_ADDR_LED       32'hFFFF_1000   // 外设：LED灯
`define PERI_ADDR_DIGLED    32'hFFFF_2000   // 外设：数码管
`define PERI_ADDR_UART      32'hFFFF_3000   // 外设：串口
`define PERI_ADDR_TIMER     32'hFFFF_4000   // 外设：定时器

// ---------------------------------------------------------------------------
// 十、缓存块大小配置（当前默认关闭缓存，块大小 = 1×32bit）
// ---------------------------------------------------------------------------
`ifdef ENABLE_ICACHE
    `define IC_BLK_LEN  4
    `define IC_BLK_SIZE (`IC_BLK_LEN*32)
`else
    `define IC_BLK_LEN  1
    `define IC_BLK_SIZE (`IC_BLK_LEN*32)
`endif

`ifdef ENABLE_DCACHE
    `define DC_BLK_LEN  4
    `define DC_BLK_SIZE (`DC_BLK_LEN*32)
`else
    `define DC_BLK_LEN  1
    `define DC_BLK_SIZE (`DC_BLK_LEN*32)
`endif
