// ============================================================================
// cpu_core.v — 5级流水线 CPU 核心（流水线版本）
// ============================================================================
// 【架构】经典 5 级流水线: IF → ID → EX → MEM → WB
//
//    IF: PC → Inst_ROM         → IF_ID_Reg
//    ID: Controller + RF + SEXT → ID_EX_Reg
//    EX: ALU + Branch resolve   → EX_MEM_Reg
//   MEM: DRAM + MEXT            → MEM_WB_Reg
//    WB: Writeback MUX → RF
//
// 【与单周期版本的关键区别】
//   1. 不再有 inst_finished / ld_st_flag / mul_div_flag 多周期控制
//   2. PC 每拍更新（stall 时除外）
//   3. 控制信号随指令沿流水线寄存器传播
//   4. 分支在 EX 阶段解析，跳转时 flush IF/ID 和 ID/EX
//
// 【已实现】
//   - 转发 (Forwarding): EX/MEM→EX, MEM/WB→EX, WB→ID （Phase 2）
//
// 【待实现（阶段三~四）】
//   - 阻塞 (Stall): Load-use 冒险检测
//   - 乘除法多周期处理
// ============================================================================

`timescale 1ns / 1ps

`include "defines.vh"

module cpu_core(
    input  wire         cpu_rst,
    input  wire         cpu_clk,

    // 指令取指接口
    output wire         ifetch_req    /* verilator public */,
    output wire [31:0]  ifetch_addr   /* verilator public */,
    input  wire         ifetch_valid  /* verilator public */,
    input  wire [31:0]  ifetch_inst,

    // 数据访问接口
    output reg  [ 3:0]  daccess_ren,
    output reg  [31:0]  daccess_addr,
    input  wire         daccess_rvalid,
    input  wire [31:0]  daccess_rdata,
    output reg  [ 3:0]  daccess_wen,
    output reg  [31:0]  daccess_wdata,
    input  wire         daccess_wresp
);

    // ================================================================
    // 一、全局信号
    // ================================================================

    // --- PC 和 NPC ---
    wire [31:0] pc;
    wire [31:0] npc;
    wire [31:0] pc4;                       // NPC 输出的 pc+4

    // --- 阻塞和冲刷 ---
    wire        stall;                      // Load-use 阻塞（阶段三，暂=0）
    wire        flush;                      // 分支跳转冲刷（EX 阶段产生）
    assign      stall = 1'b0;               // TODO: 阶段三

    // --- NPC 输入选择信号 ---
    wire [ 1:0] npc_op;
    wire [31:0] npc_pc;
    wire [31:0] npc_offset;
    wire        npc_br;
    wire [31:0] npc_jmp_target;

    // ================================================================
    // 二、IF (Instruction Fetch) 阶段
    // ================================================================
    // IROM 为同步 BRAM，地址→数据有 1 周期延迟:
    //   周期 N:  address = PC_N     → BRAM 锁存地址
    //   周期 N+1: data = inst(PC_N)  → IF_ID 锁存指令
    // PC 寄存器同样每个周期更新，因此 IF_ID 捕获的 PC 与指令
    // 始终相差 +4。此偏移通过以下方式补偿:
    //   - AUIPC/JAL/Branch: 在 EX 阶段使用 ex_pc，该值已通过流水线
    //     正确跟踪（ID 阶段的 pc+4 计算: ex_pc4 = ex_pc + 4 恰好正确）
    //   - 硬件综合后 BRAM clk-to-q 延迟确保时序收敛

    assign ifetch_req  = !cpu_rst;
    assign ifetch_addr = pc;

    PC U_PC (
        .clk    (cpu_clk),
        .rst    (cpu_rst),
        .npc    (npc),
        .stall  (stall),
        .pc     (pc)
    );

    NPC U_NPC (
        .op         (npc_op),
        .pc         (npc_pc),
        .offset     (npc_offset),
        .br         (npc_br),
        .jmp_target (npc_jmp_target),
        .npc        (npc),
        .pc4        (pc4)
    );

    // BRAM 为同步读（1 周期延迟），复位期间读出的 mem[0] 已就绪
    // ifetch_valid 在复位后第 1 拍为 0（NBA 滞后）→ 第 1 拍取 NOP
    // 这个 NOP 气泡恰好吸收 BRAM 冗余读出，避免指令重复捕获
    wire [31:0] if_inst = ifetch_valid ? ifetch_inst : 32'h00000013;

    wire [31:0] id_pc, id_inst;

    IF_ID_Reg U_IF_ID (
        .clk      (cpu_clk),
        .rst      (cpu_rst),
        .flush    (flush),
        .stall    (stall),
        .pc_in    (pc),
        .inst_in  (if_inst),
        .pc_out   (id_pc),
        .inst_out (id_inst)
    );

    // ================================================================
    // 三、ID (Instruction Decode) 阶段
    // ================================================================

    // --- Controller ---
    wire [ 1:0] id_npc_op;
    wire [ 4:0] id_alu_op;
    wire        id_alua_sel, id_alub_sel;
    wire [ 2:0] id_sext_op;
    wire [ 2:0] id_ram_rop;
    wire [ 3:0] id_ram_wop;
    wire        id_rf_we;
    wire [ 1:0] id_rf_wsel;
    wire        id_is_mul, id_is_div;

    Controller U_CU (
        .opcode     (id_inst[6:0]),
        .funct3     (id_inst[14:12]),
        .funct7     (id_inst[31:25]),
        .npc_op     (id_npc_op),
        .sext_op    (id_sext_op),
        .alu_op     (id_alu_op),
        .alua_sel   (id_alua_sel),
        .alub_sel   (id_alub_sel),
        .is_mul     (id_is_mul),
        .is_div     (id_is_div),
        .ram_r_op   (id_ram_rop),
        .ram_w_op   (id_ram_wop),
        .rf_we      (id_rf_we),
        .rf_wsel    (id_rf_wsel)
    );

    // --- RF ---
    wire [31:0] id_rD1, id_rD2;
    reg  [31:0] wb_wD;
    wire        wb_rf_we;
    wire [ 4:0] wb_rd_addr;

    RF U_RF (
        .clk    (cpu_clk),
        .rR1    (id_inst[19:15]),
        .rR2    (id_inst[24:20]),
        .rD1    (id_rD1),
        .rD2    (id_rD2),
        .we     (wb_rf_we),
        .wR     (wb_rd_addr),
        .wD     (wb_wD)
    );

    // WB→ID 转发: RF NBA 写在同一 posedge 不可见，若 WB 正在写目标寄存器
    // 则直通 wb_wD，避免 ID_EX 捕获旧值
    wire [31:0] id_rD1_fwd = (wb_rf_we && wb_rd_addr != 5'h0 && wb_rd_addr == id_inst[19:15]) ? wb_wD : id_rD1;
    wire [31:0] id_rD2_fwd = (wb_rf_we && wb_rd_addr != 5'h0 && wb_rd_addr == id_inst[24:20]) ? wb_wD : id_rD2;

    // --- SEXT ---
    wire [31:0] id_ext;

    SEXT U_SEXT (
        .op     (id_sext_op),
        .imm    (id_inst[31:7]),
        .ext    (id_ext)
    );

    wire [31:0] id_pc4 = id_pc + 32'h4;      // JAL/JALR 返回地址

    // --- ID/EX 流水线寄存器 ---
    wire [31:0] ex_pc, ex_rD1, ex_rD2, ex_ext, ex_pc4;
    wire [ 4:0] ex_rs1_addr, ex_rs2_addr, ex_rd_addr;
    wire [ 1:0] ex_npc_op;
    wire [ 4:0] ex_alu_op;
    wire        ex_alua_sel, ex_alub_sel;
    wire [ 2:0] ex_sext_op;
    wire [ 2:0] ex_ram_rop;
    wire [ 3:0] ex_ram_wop;
    wire        ex_rf_we;
    wire [ 1:0] ex_rf_wsel;
    wire        ex_is_mul, ex_is_div;

    ID_EX_Reg U_ID_EX (
        .clk            (cpu_clk),
        .rst            (cpu_rst),
        .flush          (flush),
        .stall          (stall),
        .pc_in          (id_pc),
        .rD1_in         (id_rD1_fwd),
        .rD2_in         (id_rD2_fwd),
        .ext_in         (id_ext),
        .pc4_in         (id_pc4),
        .rs1_addr_in    (id_inst[19:15]),
        .rs2_addr_in    (id_inst[24:20]),
        .rd_addr_in     (id_inst[11:7]),
        .npc_op_in      (id_npc_op),
        .alu_op_in      (id_alu_op),
        .alua_sel_in    (id_alua_sel),
        .alub_sel_in    (id_alub_sel),
        .sext_op_in     (id_sext_op),
        .ram_rop_in     (id_ram_rop),
        .ram_wop_in     (id_ram_wop),
        .rf_we_in       (id_rf_we),
        .rf_wsel_in     (id_rf_wsel),
        .is_mul_in      (id_is_mul),
        .is_div_in      (id_is_div),
        .pc_out         (ex_pc),
        .rD1_out        (ex_rD1),
        .rD2_out        (ex_rD2),
        .ext_out        (ex_ext),
        .pc4_out        (ex_pc4),
        .rs1_addr_out   (ex_rs1_addr),
        .rs2_addr_out   (ex_rs2_addr),
        .rd_addr_out    (ex_rd_addr),
        .npc_op_out     (ex_npc_op),
        .alu_op_out     (ex_alu_op),
        .alua_sel_out   (ex_alua_sel),
        .alub_sel_out   (ex_alub_sel),
        .sext_op_out    (ex_sext_op),
        .ram_rop_out    (ex_ram_rop),
        .ram_wop_out    (ex_ram_wop),
        .rf_we_out      (ex_rf_we),
        .rf_wsel_out    (ex_rf_wsel),
        .is_mul_out     (ex_is_mul),
        .is_div_out     (ex_is_div)
    );

    // ================================================================
    // 四、EX (Execute) 阶段
    // ================================================================

    // --- 转发 (Forwarding) 单元 — Phase 2 ---
    // 两条转发路径，EX/MEM 优先于 MEM/WB:
    //   EX/MEM → EX: 上一条指令的 ALU 结果（在 MEM 阶段）
    //   MEM/WB → EX: 上上条指令将写入 RF 的值（在 WB 阶段）
    //
    // 注意：Load-use 冒险不在此处理（待 Phase 3 stall 单元），
    //   load 后面跟使用指令仍需手动插 NOP。

    // EX/MEM 转发检测
    // rs2_raw: 不带 alub_sel 门控，供 store data 路径使用
    // rs2: 带 !ex_alub_sel 门控，防止 I-type 的 inst[24:20]（立即数位）被误判为 rs2
    wire fwd_ex_rs1 = mem_rf_we && (mem_rd_addr != 5'h0) && (mem_rd_addr == ex_rs1_addr);
    wire fwd_ex_rs2_raw = mem_rf_we && (mem_rd_addr != 5'h0) && (mem_rd_addr == ex_rs2_addr);
    wire fwd_ex_rs2 = fwd_ex_rs2_raw && !ex_alub_sel;

    // MEM/WB 转发检测（EX/MEM 优先）
    wire fwd_wb_rs1 = wb_rf_we && (wb_rd_addr != 5'h0) && (wb_rd_addr == ex_rs1_addr) && !fwd_ex_rs1;
    wire fwd_wb_rs2_raw = wb_rf_we && (wb_rd_addr != 5'h0) && (wb_rd_addr == ex_rs2_addr) && !fwd_ex_rs2_raw;
    wire fwd_wb_rs2 = fwd_wb_rs2_raw && !ex_alub_sel;

    // rs2 转发值（用于 store data，不受 alub_sel 影响）
    wire [31:0] ex_rD2_fwd = fwd_ex_rs2_raw ? mem_alu_c : (fwd_wb_rs2_raw ? wb_wD : ex_rD2);

    // ALU 操作数 MUX（含转发）
    wire [31:0] ex_alu_a_raw = ex_alua_sel ? ex_pc  : ex_rD1;
    wire [31:0] ex_alu_a     = fwd_ex_rs1 ? mem_alu_c : (fwd_wb_rs1 ? wb_wD : ex_alu_a_raw);

    wire [31:0] ex_alu_b_raw = ex_alub_sel ? ex_ext : ex_rD2;
    wire [31:0] ex_alu_b     = fwd_ex_rs2 ? mem_alu_c : (fwd_wb_rs2 ? wb_wD : ex_alu_b_raw);

    wire [31:0] ex_alu_c;
    wire        ex_br;
    wire        ex_busy;

    ALU U_ALU (
        .rst    (cpu_rst),
        .clk    (cpu_clk),
        .op     (ex_alu_op),
        .a      (ex_alu_a),
        .b      (ex_alu_b),
        .br     (ex_br),
        .c      (ex_alu_c),
        .busy   (ex_busy)
    );

    // 分支重定向
    wire ex_branch_taken = (ex_npc_op == `NPC_BRA) && ex_br;
    wire ex_is_jal       = (ex_npc_op == `NPC_JMP);
    wire ex_is_jalr      = (ex_npc_op == `NPC_JALR);
    assign flush = ex_branch_taken || ex_is_jal || ex_is_jalr;

    // NPC 信号：正常 → PC4，重定向 → 跳转目标
    assign npc_op        = flush ? ex_npc_op    : `NPC_PC4;
    assign npc_pc        = flush ? ex_pc        : pc;
    assign npc_offset    = flush ? ex_ext       : 32'h0;
    assign npc_br        = flush ? ex_br        : 1'b0;
    assign npc_jmp_target = flush ? ex_alu_c    : 32'h0;

    // --- MREQ（在 EX 阶段生成访存请求，MEM 阶段使用） ---
    wire [ 3:0] ex_da_ren;
    wire [ 3:0] ex_da_wen;
    wire [31:0] ex_da_wdata;

    MREQ U_MEM_REQ (
        .ram_addr   (ex_alu_c),
        .ram_rop    (ex_ram_rop),
        .da_ren     (ex_da_ren),
        .da_addr    (),                      // 直通，在 MEM 阶段用 alu_c
        .ram_wop    (ex_ram_wop),
        .ram_wdata  (ex_rD2_fwd),
        .da_wen     (ex_da_wen),
        .da_wdata   (ex_da_wdata)
    );

    // --- EX/MEM 流水线寄存器 ---
    wire [31:0] mem_alu_c, mem_rD2, mem_pc4;
    wire        mem_br;
    wire [ 4:0] mem_rd_addr;
    wire [ 1:0] mem_npc_op;
    wire [ 2:0] mem_ram_rop;
    wire [ 3:0] mem_ram_wop;
    wire        mem_rf_we;
    wire [ 1:0] mem_rf_wsel;

    EX_MEM_Reg U_EX_MEM (
        .clk            (cpu_clk),
        .rst            (cpu_rst),
        .flush          (1'b0),
        .alu_c_in       (ex_alu_c),
        .rD2_in         (ex_rD2),
        .pc4_in         (ex_pc4),
        .br_in          (ex_br),
        .rd_addr_in     (ex_rd_addr),
        .npc_op_in      (ex_npc_op),
        .ram_rop_in     (ex_ram_rop),
        .ram_wop_in     (ex_ram_wop),
        .rf_we_in       (ex_rf_we),
        .rf_wsel_in     (ex_rf_wsel),
        .alu_c_out      (mem_alu_c),
        .rD2_out        (mem_rD2),
        .pc4_out        (mem_pc4),
        .br_out         (mem_br),
        .rd_addr_out    (mem_rd_addr),
        .npc_op_out     (mem_npc_op),
        .ram_rop_out    (mem_ram_rop),
        .ram_wop_out    (mem_ram_wop),
        .rf_we_out      (mem_rf_we),
        .rf_wsel_out    (mem_rf_wsel)
    );

    // ================================================================
    // 五、MEM (Memory Access) 阶段
    // ================================================================

    // 总线接口（EX 阶段组合产生请求，打一拍后在 MEM 阶段输出）
    // 地址 ex_alu_c 与 ren/wen/wdata 必须来自同一条指令，否则地址滞后 1 拍
    always @(posedge cpu_clk or posedge cpu_rst) begin
        if (cpu_rst) begin
            daccess_ren   <= 4'h0;
            daccess_wen   <= 4'h0;
        end else begin
            daccess_ren   <= ex_da_ren;
            daccess_addr  <= ex_alu_c;
            daccess_wen   <= ex_da_wen;
            daccess_wdata <= ex_da_wdata;
        end
    end

    // --- MEM/WB 流水线寄存器 ---
    // 注意：MEXT 从 MEM 移到 WB，解决 BRAM 1 周期读延迟问题
    wire [31:0] wb_alu_c, wb_ram_ext, wb_pc4;
    wire [ 1:0] wb_rf_wsel;
    wire [ 2:0] wb_ram_rop;
    wire [ 1:0] wb_byte_offs;

    MEM_WB_Reg U_MEM_WB (
        .clk            (cpu_clk),
        .rst            (cpu_rst),
        .flush          (1'b0),
        .alu_c_in       (mem_alu_c),
        .ram_ext_in     (32'h0),                 // 未使用（MEXT 在 WB）
        .pc4_in         (mem_pc4),
        .rd_addr_in     (mem_rd_addr),
        .rf_we_in       (mem_rf_we),
        .rf_wsel_in     (mem_rf_wsel),
        .ram_rop_in     (mem_ram_rop),
        .byte_offs_in   (mem_alu_c[1:0]),
        .alu_c_out      (wb_alu_c),
        .ram_ext_out    (wb_ram_ext),
        .pc4_out        (wb_pc4),
        .rd_addr_out    (wb_rd_addr),
        .rf_we_out      (wb_rf_we),
        .rf_wsel_out    (wb_rf_wsel),
        .ram_rop_out    (wb_ram_rop),
        .byte_offs_out  (wb_byte_offs)
    );

    // ================================================================
    // 六、WB (Write Back) 阶段
    // ================================================================

    // MEXT 放在 WB 而非 MEM —— 补偿 BRAM 1 周期读延迟
    wire [31:0] wb_ram_data;

    MEXT U_MEM_EXT (
        .op         (wb_ram_rop),
        .din        (daccess_rdata),
        .byte_offs  (wb_byte_offs),
        .ext        (wb_ram_data)
    );

    always @(*) begin
        case (wb_rf_wsel)
            `WB_ALU: wb_wD = wb_alu_c;
            `WB_RAM: wb_wD = wb_ram_data;
            `WB_PC4: wb_wD = wb_pc4;
            `WB_EXT: wb_wD = wb_alu_c;       // LUI: ext << 12 经 ALU 旁路
            default: wb_wD = 32'h0;
        endcase
    end

    // ================================================================
    // 七、Debug 跟踪信号（cdp-tests 差分测试框架使用）
    // ================================================================
    // 写回通道（每组信号仅有效 1 个周期）
    wire [31:0] debug_wb_pc    /* verilator public */ ;
    wire        debug_wb_rf_we /* verilator public */ ;
    wire [ 4:0] debug_wb_rf_wR /* verilator public */ ;
    wire [31:0] debug_wb_rf_wD /* verilator public */ ;

    assign debug_wb_pc    = wb_pc4 - 32'd8;
    assign debug_wb_rf_we = wb_rf_we;
    assign debug_wb_rf_wR = wb_rd_addr;
    assign debug_wb_rf_wD = wb_wD;

    // 写内存通道
    wire [31:0] debug_mem_pc    /* verilator public */ ;
    wire [ 3:0] debug_mem_we    /* verilator public */ ;
    wire [31:0] debug_mem_waddr /* verilator public */ ;
    wire [31:0] debug_mem_wdata /* verilator public */ ;

    assign debug_mem_pc    = mem_pc4 - 32'd8;
    assign debug_mem_we    = daccess_wen;
    assign debug_mem_waddr = daccess_addr;
    assign debug_mem_wdata = daccess_wdata;

endmodule
