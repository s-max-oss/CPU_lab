// ============================================================================
// cpu_core.v — CPU 核心顶层模块 ★★★ 整个项目最重要的文件 ★★★
// ============================================================================
// 【模块职责】连接所有数据通路子模块（PC、NPC、Controller、RF、SEXT、ALU、MREQ、MEXT），
//   协调5级流水线的数据流动，处理多周期指令（访存/乘除）的等待和写回。
//
// 【总体架构 — 单周期CPU（访存指令多周期）】
//   本CPU核心是一个 单周期CPU（每条指令1拍完成），但增加了对访存指令的多周期支持：
//     - 访存指令（LOAD/STORE）：需要等 DRAM 返回数据
//   注意: 乘除法（MUL/DIV）已改为单周期组合逻辑（Booth + 恢复余数），当拍完成
//
//   ┌──────┐   ┌──────┐   ┌──────┐   ┌──────┐   ┌──────┐
//   │  IF  │ → │  ID  │ → │  EX  │ → │ MEM  │ → │  WB  │
//   │ 取指 │   │ 译码 │   │ 执行 │   │ 访存 │   │ 写回 │
//   └──────┘   └──────┘   └──────┘   └──────┘   └──────┘
//       ↑                                                    ↓
//       └──────────── inst_finished 控制节奏 ─────────────────┘
//
//   对于 ADD/ADDI/MUL/DIV 等ALU指令：IF→ID→EX→WB 在1拍内完成（无MEM阶段）
//   对于 LW 等访存指令：IF→ID→EX→MEM(等待DRAM) → WB（多拍）
//
// 【最关键的2个控制信号】
//   1. inst_finished: 指令执行完毕 → 允许PC更新取下一条
//   2. ld_st_flag:    正在执行访存指令 → 阻塞新的取指、走多周期写回路径
//   注意: 乘除法已改为单周期组合逻辑，不再需要 mul_div_flag 多周期控制
//
// 【多周期控制精要 — 理解重点！！！】
//   挑战：简单指令1拍完成，访存/乘除需要多拍。如何统一管理？
//   方案：用"标志位 + 等待条件"的有限状态机（分布式状态机）：
//
//   ld_st_flag:
//     SET:   当 is_ld_st = 1（指令译码发现是访存指令）
//     CLEAR: 当 ld_st_done = 1（DRAM返回数据 或 写入完成）
//     效果:  阻塞 inst_finished，PC不更新，写回走 ram_ext 路径
//
//   注意: mul_div_flag 已移除，乘除法现为单周期组合逻辑（Booth + 恢复余数），
//   与其他ALU指令一样当拍完成，无需多周期等待。
//
//   rf_wR_r / alu_c_r / ram_rop_r 缓存:
//     因为多周期指令需要跨越多个时钟周期，但 inst 只维持1拍（ifetch_valid仅1拍）
//     所以必须把目标寄存器号、地址、读操作类型"锁存"起来。
//
//   时序示例（以 LW 指令为例）：
//     T0: ifetch_valid=1, is_ld_st=1 → ld_st_flag置1, 锁存 rf_wR_r, alu_c_r, ram_rop_r
//         同时 inst_finished=0（因为ld_st_flag=1但ld_st_done=0）
//     T1: PC保持（fetch=0），daccess_rvalid还未回来，ld_st_done=0，inst_finished=0
//     T2: DRAM返回数据 daccess_rvalid=1 → ld_st_done=1 → inst_finished=1
//         rf_we1=1（写使能），rf_wD=ram_ext（写回DRAM数据）
//     T3: PC更新，取下一条指令
//
// 【关键时序约定】
//   - ifetch_valid 仅维持1拍！在 valid 无效后 ifetch_inst 可能变化
//   - 因此 cpu_core 在 ifetch_valid=1 时完成所有译码和单周期执行
//   - 多周期指令在 ifetch_valid=1 那拍锁存所有需要跨周期使用的信息
// ============================================================================

`timescale 1ns / 1ps

`include "defines.vh"

module cpu_core(
    input  wire         cpu_rst,          // CPU复位（高有效）
    input  wire         cpu_clk,          // CPU时钟

    // ================= 指令取指接口（连接 Inst_ROM） =================
    // CPU → IROM
    output wire         ifetch_req    /* verilator public */,       // 取指请求：告诉IROM"我要读指令"
    output wire [31:0]  ifetch_addr   /* verilator public */,      // 取指地址：PC值，传给IROM的地址端口
    // IROM → CPU
    input  wire         ifetch_valid  /* verilator public */,     // 取指有效：IROM说"数据准备好了，只有1拍！"
    input  wire [31:0]  ifetch_inst,      // 取指指令：32位指令字

    // ================= 数据访问接口（连接 Data_RAM） =================
    // CPU → DRAM（读通道）
    output reg  [ 3:0]  daccess_ren,      // 字节读使能
    output reg  [31:0]  daccess_addr,     // 读地址
    // DRAM → CPU（读通道）
    input  wire         daccess_rvalid,   // 读数据有效
    input  wire [31:0]  daccess_rdata,    // 读数据

    // CPU → DRAM（写通道）
    output reg  [ 3:0]  daccess_wen,      // 字节写使能
    output reg  [31:0]  daccess_wdata,    // 写数据
    // DRAM → CPU（写通道）
    input  wire         daccess_wresp     // 写响应（写完成确认）
);


    // ================================================================
    // 一、内部互联信号声明
    // ================================================================
    // 这些 wire/reg 连接了所有子模块，构成了完整的数据通路。
    // 每个信号的"来源→去向"在注释中标注。

    // --- PC 和 NPC 相关 ---
    wire [31:0] pc;         // PC模块→各模块: 当前指令地址
    wire [31:0] npc;        // NPC模块→PC模块: 下一条指令地址
    wire [31:0] pc4;        // NPC模块→写回MUX: PC+4（JAL/JALR的返回地址）
    wire [31:0] inst;       // ifetch_inst的"稳定版"，valid无效时强制为NOP

    // --- Controller 输出控制信号 ---
    wire [ 1:0] npc_op;     // Controller→NPC: 跳转类型
    wire [ 1:0] rf_wsel;    // Controller→写回MUX: 写回数据来源选择
    wire [ 2:0] sext_op;    // Controller→SEXT: 立即数格式
    wire [ 4:0] alu_op;     // Controller→ALU: 运算类型
    wire        alua_sel;   // Controller→ALU A MUX: 0=RS1 / 1=PC
    wire        alub_sel;   // Controller→ALU B MUX: 0=RS2 / 1=EXT
    wire [ 2:0] ram_rop;    // Controller→MREQ: 读类型
    reg  [ 2:0] ram_rop_r;  //   锁存版→MEXT: 跨周期读类型（LOAD多周期时要保持）
    wire [ 3:0] ram_wop;    // Controller→MREQ: 写类型
    wire        is_mul;     // Controller→core: 是否乘法
    wire        is_div;     // Controller→core: 是否除法
    wire        is_mul_div; // 组合: 译码发现是乘除法指令
    reg         mul_div_flag; // ★多周期标志★: 正在执行乘除法指令

    // --- 寄存器堆 ---
    wire [31:0] rf_rd1;     // RF→ALU A MUX: rs1的值
    wire [31:0] rf_rd2;     // RF→ALU B MUX + MREQ(写数据): rs2的值
    wire        rf_we;      // Controller→core: 寄存器写使能(Controller原始输出)
    wire        rf_we1;     // core→RF: 最终写使能(加了多周期条件)
    reg  [ 4:0] rf_wR_r;    // ★锁存★ 目标寄存器号（多周期时 inst 会消失，必须锁存）
    wire [ 4:0] rf_wR;      // RF写地址
    reg  [31:0] rf_wD;      // 写回数据（来自写回MUX的输出）

    // --- 立即数扩展 ---
    wire [31:0] ext;        // SEXT→ALU B MUX + 写回MUX(LUI): 扩展后的立即数

    // --- ALU ---
    wire [31:0] alu_a;      // ALU A MUX→ALU: 操作数A
    wire [31:0] alu_b;      // ALU B MUX→ALU: 操作数B
    wire [31:0] alu_c;      // ALU→MREQ + 写回MUX + NPC(JALR): 运算结果
    reg  [31:0] alu_c_r;    // ★锁存★ ALU结果(LOAD时锁存地址,多周期内存访问)
    wire        br;         // ALU→NPC: 分支条件
    wire        mul_div_busy;// ALU→core: 乘除法器忙标志(1=还在算)

    // --- 内存访问 ---
    wire [ 3:0] da_ren;     // MREQ→总线接口: 字节读使能
    wire [31:0] da_addr;    // MREQ→总线接口: 内存地址
    wire [ 3:0] da_wen;     // MREQ→总线接口: 字节写使能
    wire [31:0] da_wdata;   // MREQ→总线接口: 写数据
    wire [31:0] ram_ext;    // MEXT→写回MUX: 扩展后的读数据（LOAD时使用）
    wire        is_ld_st;   // 组合: 译码发现是访存指令
    reg         ld_st_flag; // ★多周期标志2★: 正在执行访存指令
    wire        ld_st_done; // 组合: 访存完成(daccess_rvalid | daccess_wresp)

    // --- 执行流控制 ---
    wire        inst_finished;     // ★最核心信号★ 指令执行完毕标志
    reg         inst_finished_r;   // inst_finished的1拍延迟，用于产生 ifetch_req


    // ================================================================
    // 二、IF (Instruction Fetch) — 指令取指阶段
    // ================================================================
    // 目标：从 IROM 读取一条指令，地址 = PC
    // 时序：inst_finished=1 → PC更新(npc) → 请求IROM → 下周期拿到指令

    // 复位释放后的首次取指：rst_r 是 rst 的1拍延迟，first_req 在 rst 下降沿产生脉冲
    reg rst_r;
    wire first_req = rst_r & !cpu_rst;
    always @(posedge cpu_clk) rst_r <= cpu_rst;

    // 取指请求 = 首次取指脉冲 OR 上一条指令已完成
    assign ifetch_req  = first_req | inst_finished_r;
    assign ifetch_addr = pc;               // 取指地址就是PC

    // --- NPC: 计算下一条指令的地址 ---
    NPC U_NPC (
        .op         (npc_op),              // 跳转类型
        .pc         (pc),                  // 当前PC
        .offset     (ext),                 // 立即数偏移（已扩展）
        .br         (br),                  // 分支条件
        .jmp_target (alu_c),               // JALR 目标地址（rs1+offset）
        .npc        (npc),                 // → 输出：下一条PC
        .pc4        (pc4)                  // → 输出：PC+4
    );

    // --- PC: 程序计数器 ---
    // fetch = inst_finished: 只有当前指令完成了，PC才更新
    PC U_PC (
        .clk        (cpu_clk),
        .rst        (cpu_rst),
        .npc        (npc),
        .fetch      (inst_finished),       // ★这个连接至关重要★
        .pc         (pc)
    );


    // ================================================================
    // 三、ID (Instruction Decode) — 指令译码 + 寄存器读取阶段
    // ================================================================
    // 目标：解析指令 → 产生控制信号 + 读寄存器 + 扩展立即数

    // ★重要★ ifetch_valid 只维持1拍，之后 ifetch_inst 可能变化。
    // 所以一旦 valid 消失，把 inst 强制替换为 NOP (ADDI x0,x0,0)
    // 防止译码出错误的控制信号导致CPU误动作。
    assign inst = ifetch_valid ? ifetch_inst : 32'h13 /* NOP */ ;

    // --- Controller: 指令译码 → 所有控制信号 ---
    Controller U_CU (
        .opcode         (inst[6:0]),       // 操作码
        .funct3         (inst[14:12]),     // 功能码3
        .funct7         (inst[31:25]),     // 功能码7
        // 输出 → 各模块
        .npc_op         (npc_op),          // NPC操作
        .sext_op        (sext_op),         // 立即数格式
        .alu_op         (alu_op),          // ALU操作
        .alua_sel       (alua_sel),        // ALU A口选择
        .alub_sel       (alub_sel),        // ALU B口选择
        .is_mul         (is_mul),          // 是乘法吗
        .is_div         (is_div),          // 是除法吗
        .ram_r_op       (ram_rop),         // 读内存类型
        .ram_w_op       (ram_wop),         // 写内存类型
        .rf_we          (rf_we),           // 写寄存器使能
        .rf_wsel        (rf_wsel)          // 写回来源选择
    );

    // --- RF: 寄存器堆 ---
    RF U_RF (
        .clk        (cpu_clk),
        .rR1        (inst[19:15]),         // rs1 字段
        .rR2        (inst[24:20]),         // rs2 字段
        .rD1        (rf_rd1),              // → rs1 的值
        .rD2        (rf_rd2),              // → rs2 的值
        .we         (rf_we1),              // 写使能（最终版）
        .wR         (rf_wR),               // 写地址（多周期时来自 rf_wR_r）
        .wD         (rf_wD)                // 写数据（来自写回MUX）
    );

    // --- SEXT: 立即数扩展 ---
    SEXT U_SEXT (
        .op         (sext_op),             // 立即数格式
        .imm        (inst[31:7]),          // 指令高位（含立即数字段）
        .ext        (ext)                  // → 32位扩展立即数
    );


    // ================================================================
    // 四、多周期控制 — 访存/乘除 标志位管理
    // ================================================================

    // ----- ld_st_flag: 访存指令标志位 -----
    // SET:   译码发现访存指令（读或写都算）
    // CLEAR: DRAM返回了数据(读)或写入完成(写)
    assign is_ld_st = (ram_rop != `RAM_EXT_N) | (ram_wop != `RAM_WE_N);
    always @(posedge cpu_clk or posedge cpu_rst) begin
        if      (cpu_rst)    ld_st_flag <= 1'b0;
        else if (is_ld_st)   ld_st_flag <= 1'b1;      // 进入访存等待
        else if (ld_st_done) ld_st_flag <= 1'b0;      // 访存完成，退出
    end

    // ----- mul_div_flag: 乘除法指令标志位 -----
    // SET:   译码发现乘除法指令
    // CLEAR: ALU 运算完成（busy 下降）
    assign is_mul_div = is_mul | is_div;
    always @(posedge cpu_clk or posedge cpu_rst) begin
        if      (cpu_rst)          mul_div_flag <= 1'b0;
        else if (is_mul_div)       mul_div_flag <= 1'b1;       // 进入乘除法等待
        else if (!mul_div_busy)    mul_div_flag <= 1'b0;       // 乘除法完成，退出
    end

    // ----- 锁存多周期所需信息 -----
    // 访存指令和乘除法指令都需要锁存（跨周期保持目标寄存器号）
    always @(posedge cpu_clk) begin
        if (is_ld_st | is_mul_div)
            rf_wR_r <= inst[11:7];          // 缓存目标寄存器号 rd
    end


    // ================================================================
    // 五、EX (Execute) — 执行阶段
    // ================================================================

    // --- ALU 操作数 MUX ---
    assign alu_a = alua_sel ? pc  : rf_rd1;     // A口: 0=RS1, 1=PC(AUIPC)
    assign alu_b = alub_sel ? ext : rf_rd2;     // B口: 0=RS2, 1=立即数

    // --- ALU ---
    ALU U_ALU (
        .rst        (cpu_rst),
        .clk        (cpu_clk),
        .op         (alu_op),
        .a          (alu_a),
        .b          (alu_b),
        .br         (br),                      // → 分支条件
        .c          (alu_c),                   // → 运算结果
        .busy       (mul_div_busy)             // → 乘除忙标志
    );


    // ================================================================
    // 六、MEM (Memory Access) — 访存阶段
    // ================================================================

    // --- MREQ: 生成读写请求 ---
    MREQ U_MEM_REQ (
        .ram_addr   (alu_c),                   // 内存地址 = ALU结果

        .ram_rop    (ram_rop),                 // 读类型
        .da_ren     (da_ren),                  // → 字节读使能
        .da_addr    (da_addr),                 // → 内存地址

        .ram_wop    (ram_wop),                 // 写类型
        .ram_wdata  (rf_rd2),                  // 写数据 = rs2
        .da_wen     (da_wen),                  // → 字节写使能
        .da_wdata   (da_wdata)                 // → 对齐后的写数据
    );

    // --- MEXT: 读回数据的字节提取和符号扩展 ---
    MEXT U_MEM_EXT (
        .op             (ram_rop_r),           // 缓存的读类型
        .din            (daccess_rdata),       // DRAM原始数据
        .byte_offs      (alu_c_r[1:0]),        // 缓存的地址低2位
        .ext            (ram_ext)              // → 扩展后的数据
    );

    // --- 锁存访存信息（跨多周期） ---
    // 地址 alu_c 和 读类型 ram_rop 在 LOAD 指令的 ifetch_valid 拍被锁存，
    // 因为它们需要等到 daccess_rvalid 回来时才使用（可能多拍）
    always @(posedge cpu_clk) if (is_ld_st) alu_c_r   <= alu_c;
    always @(posedge cpu_clk) if (is_ld_st) ram_rop_r <= ram_rop;

    // --- 总线接口寄存器 ---
    // 打一拍输出到外部总线（提高时序性能）
    always @(posedge cpu_clk or posedge cpu_rst) begin
        if (cpu_rst) begin
            daccess_ren   <= 4'h0;
            daccess_wen   <= 4'h0;
        end else begin
            daccess_ren   <= da_ren;
            daccess_addr  <= da_addr;
            daccess_wen   <= da_wen;
            daccess_wdata <= da_wdata;
        end
    end

    // 访存完成条件：读返回数据有效 OR 写响应确认
    assign ld_st_done = daccess_rvalid | daccess_wresp;


    // ================================================================
    // 七、WB (Write Back) — 写回阶段 ★★★ 重点理解 ★★★
    // ================================================================
    // 这里的核心挑战是：3种不同的指令完成时机，需要3种不同的写回时序。
    //
    //   指令类型     | 完成时机                | 写数据来源 | 目标寄存器来源
    //   -----------|------------------------|----------|-------------
    //   简单指令     | ifetch_valid=1 当拍    | alu_c    | inst[11:7]
    //              |                        | pc4/ext  |
    //   LOAD指令    | daccess_rvalid=1 时     | ram_ext  | rf_wR_r(锁存)
    //
    // 写使能 rf_we1 的逻辑（见下方assign）：
    //   - LOAD指令: 正在访存(ld_st_flag=1)且数据回来了(有效)
    //   - 其他指令: 取到指令即可写回（含乘除法，已改为单周期）

    // rf_we1: 最终的寄存器写使能
    //   LOAD指令: 等待DRAM返回(daccess_rvalid=1)
    //   乘除法指令: 等待ALU完成(!mul_div_busy)
    //   其他指令: 当拍完成
    assign rf_we1 = ld_st_flag   & daccess_rvalid                  // LOAD: 等待DRAM返回
                  | mul_div_flag & !mul_div_busy                   // 乘除法: 等待ALU完成
                  | ifetch_valid & rf_we & !is_ld_st & !is_mul_div;// 其他指令: 当拍完成

    // rf_wR: 目标寄存器号
    //   LOAD/乘除法指令 → 用锁存值 rf_wR_r（因为 inst 已经没了）
    //   其他指令 → 直接用 inst[11:7]（当拍完成）
    assign rf_wR  = (ld_st_flag | mul_div_flag) ? rf_wR_r : inst[11:7];

    // 写回数据MUX: 四选一
    //   {ld_st_flag, rf_wsel} 组合判断：
    //     0b0_00 (WB_ALU): alu_c  — 算术逻辑指令
    //     0b0_10 (WB_PC4): pc4    — JAL/JALR返回地址
    //     0b0_11 (WB_EXT): ext    — LUI加载立即数
    //     0b1_?? (LOAD)  : ram_ext— 从内存读回的数据（ld_st_flag=1 时覆盖rf_wsel）
    always @(*) begin
        casex ({ld_st_flag, rf_wsel})
            {1'b0, `WB_ALU}: rf_wD = alu_c;
            {1'b0, `WB_PC4}: rf_wD = pc4;
            {1'b0, `WB_EXT}: rf_wD = ext;
            {1'b1, 2'b??  }: rf_wD = ram_ext;    // ld_st_flag=1 时，无视 rf_wsel，强制取 ram_ext
            default        : rf_wD = 32'h0;
        endcase
    end


    // ================================================================
    // 八、执行流控制 — inst_finished 信号
    // ================================================================
    // ★★★★★ 这是整个CPU的"心跳"信号 ★★★★★
    //
    // inst_finished = 1 意味着:
    //   - 当前指令彻底执行完毕
    //   - PC可以更新到npc
    //   - 可以取下一条指令了
    //
    // 两种完成条件（任一满足即可）：
    //   1. 访存完成:   ld_st_flag=1 AND ld_st_done=1（DRAM返回了数据或写入完成）
    //   2. 其他指令:   ifetch_valid=1 AND 不是访存（当拍完成，含乘除法）

    assign inst_finished = ld_st_flag   & ld_st_done                  // 访存指令完成
                         | mul_div_flag & !mul_div_busy               // 乘除法指令完成
                         | ifetch_valid & !is_ld_st & !is_mul_div;    // 其他指令当拍完成

    // inst_finished_r: 延迟1拍，用于产生下一个 ifetch_req
    // 原因：inst_finished 在同一个周期既用于PC更新，又用于取指请求会产生时序问题
    always @(posedge cpu_clk or posedge cpu_rst) begin
        inst_finished_r <= cpu_rst ? 1'b0 : inst_finished;
    end


    // ================================================================
    // 九、调试 Trace 接口（`ifdef RUN_TRACE 开启）
    // ================================================================
    // 综合时 RUN_TRACE 是注释掉的，仿真时可以打开来监控CPU执行过程
    // 提供两个阶段的调试信息：
    //   WB阶段:  写寄存器的地址和数据
    //   MEM阶段: 写内存的地址和数据
    // 【warning】编译标记/* verilator public */ 用于 Verilator 仿真器可见性

`ifdef RUN_TRACE
    wire [31:0] debug_wb_pc    /* verilator public */ ;
    wire        debug_wb_rf_we /* verilator public */ ;
    wire [ 4:0] debug_wb_rf_wR /* verilator public */ ;
    wire [31:0] debug_wb_rf_wD /* verilator public */ ;

    wire [31:0] debug_mem_pc    /* verilator public */ ;
    wire [ 3:0] debug_mem_we    /* verilator public */ ;
    wire [31:0] debug_mem_waddr /* verilator public */ ;
    wire [31:0] debug_mem_wdata /* verilator public */ ;

    assign debug_wb_pc    = pc;
    assign debug_wb_rf_we = rf_we1;
    assign debug_wb_rf_wR = rf_wR;
    assign debug_wb_rf_wD = rf_wD;

    assign debug_mem_pc    = pc;
    assign debug_mem_we    = daccess_wen;
    assign debug_mem_waddr = daccess_addr;
    assign debug_mem_wdata = daccess_wdata;
`endif

endmodule
