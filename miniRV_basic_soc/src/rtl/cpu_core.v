`timescale 1ns / 1ps

`include "defines.vh"

module cpu_core(
    input  wire         cpu_rst,
    input  wire         cpu_clk,

    output wire         ifetch_req    /* verilator public */,
    output wire [31:0]  ifetch_addr   /* verilator public */,

    input  wire         ifetch_valid  /* verilator public */,
    input  wire [31:0]  ifetch_inst,

    output reg  [ 3:0]  daccess_ren,
    output reg  [31:0]  daccess_addr,

    input  wire         daccess_rvalid,
    input  wire [31:0]  daccess_rdata,

    output reg  [ 3:0]  daccess_wen,
    output reg  [31:0]  daccess_wdata,

    input  wire         daccess_wresp
);

    wire [31:0] pc;
    wire [31:0] npc;
    wire [31:0] pc4;
    wire [31:0] inst;

    wire [ 1:0] npc_op;
    wire [ 1:0] rf_wsel;
    wire [ 2:0] sext_op;
    wire [ 4:0] alu_op;
    wire        alua_sel;
    wire        alub_sel;
    wire [ 2:0] ram_rop;
    reg  [ 2:0] ram_rop_r;
    wire [ 3:0] ram_wop;
    wire        is_mul;
    wire        is_div;
    wire        is_mul_div;
    reg         mul_div_flag;

    wire [31:0] rf_rd1;
    wire [31:0] rf_rd2;
    wire        rf_we;
    wire        rf_we1;
    reg  [ 4:0] rf_wR_r;
    wire [ 4:0] rf_wR;
    reg  [31:0] rf_wD;

    wire [31:0] ext;

    wire [31:0] alu_a;
    wire [31:0] alu_b;
    wire [31:0] alu_c;
    reg  [31:0] alu_c_r;
    wire        br;
    wire        mul_div_busy;

    wire [ 3:0] da_ren;
    wire [31:0] da_addr;
    wire [ 3:0] da_wen;
    wire [31:0] da_wdata;
    wire [31:0] ram_ext;
    wire        is_ld_st;
    reg         ld_st_flag;
    wire        ld_st_done;

    wire        inst_finished;
    reg         inst_finished_r;

    reg rst_r;
    wire first_req = rst_r & !cpu_rst;
    always @(posedge cpu_clk) rst_r <= cpu_rst;

    assign ifetch_req  = first_req | inst_finished_r;
    assign ifetch_addr = pc;

    NPC U_NPC (
        .op         (npc_op),
        .pc         (pc),
        .offset     (ext),
        .br         (br),
        .jmp_target (alu_c),
        .npc        (npc),
        .pc4        (pc4)
    );

    PC U_PC (
        .clk        (cpu_clk),
        .rst        (cpu_rst),
        .npc        (npc),
        .fetch      (inst_finished),
        .pc         (pc)
    );

    assign inst = ifetch_valid ? ifetch_inst : 32'h13 /* NOP */ ;

    Controller U_CU (
        .opcode         (inst[6:0]),
        .funct3         (inst[14:12]),
        .funct7         (inst[31:25]),

        .npc_op         (npc_op),
        .sext_op        (sext_op),
        .alu_op         (alu_op),
        .alua_sel       (alua_sel),
        .alub_sel       (alub_sel),
        .is_mul         (is_mul),
        .is_div         (is_div),
        .ram_r_op       (ram_rop),
        .ram_w_op       (ram_wop),
        .rf_we          (rf_we),
        .rf_wsel        (rf_wsel)
    );

    RF U_RF (
        .clk        (cpu_clk),
        .rR1        (inst[19:15]),
        .rR2        (inst[24:20]),
        .rD1        (rf_rd1),
        .rD2        (rf_rd2),
        .we         (rf_we1),
        .wR         (rf_wR),
        .wD         (rf_wD)
    );

    SEXT U_SEXT (
        .op         (sext_op),
        .imm        (inst[31:7]),
        .ext        (ext)
    );

    assign is_ld_st = (ram_rop != `RAM_EXT_N) | (ram_wop != `RAM_WE_N);
    always @(posedge cpu_clk or posedge cpu_rst) begin
        if      (cpu_rst)    ld_st_flag <= 1'b0;
        else if (is_ld_st)   ld_st_flag <= 1'b1;
        else if (ld_st_done) ld_st_flag <= 1'b0;
    end

    assign is_mul_div = is_mul | is_div;
    always @(posedge cpu_clk or posedge cpu_rst) begin
        if      (cpu_rst)          mul_div_flag <= 1'b0;
        else if (is_mul_div)       mul_div_flag <= 1'b1;
        else if (!mul_div_busy)    mul_div_flag <= 1'b0;
    end

    always @(posedge cpu_clk) begin
        if (is_ld_st | is_mul_div)
            rf_wR_r <= inst[11:7];
    end

    assign alu_a = alua_sel ? pc  : rf_rd1;
    assign alu_b = alub_sel ? ext : rf_rd2;

    ALU U_ALU (
        .rst        (cpu_rst),
        .clk        (cpu_clk),
        .op         (alu_op),
        .a          (alu_a),
        .b          (alu_b),
        .br         (br),
        .c          (alu_c),
        .busy       (mul_div_busy)
    );

    MREQ U_MEM_REQ (
        .ram_addr   (alu_c),

        .ram_rop    (ram_rop),
        .da_ren     (da_ren),
        .da_addr    (da_addr),

        .ram_wop    (ram_wop),
        .ram_wdata  (rf_rd2),
        .da_wen     (da_wen),
        .da_wdata   (da_wdata)
    );

    MEXT U_MEM_EXT (
        .op             (ram_rop_r),
        .din            (daccess_rdata),
        .byte_offs      (alu_c_r[1:0]),
        .ext            (ram_ext)
    );

    always @(posedge cpu_clk) if (is_ld_st) alu_c_r   <= alu_c;
    always @(posedge cpu_clk) if (is_ld_st) ram_rop_r <= ram_rop;

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

    assign ld_st_done = daccess_rvalid | daccess_wresp;

    assign rf_we1 = ld_st_flag   & daccess_rvalid
                  | mul_div_flag & !mul_div_busy
                  | ifetch_valid & rf_we & !is_ld_st & !is_mul_div;

    assign rf_wR  = (ld_st_flag | mul_div_flag) ? rf_wR_r : inst[11:7];

    always @(*) begin
        casex ({ld_st_flag, rf_wsel})
            {1'b0, `WB_ALU}: rf_wD = alu_c;
            {1'b0, `WB_PC4}: rf_wD = pc4;
            {1'b0, `WB_EXT}: rf_wD = ext;
            {1'b1, 2'b??  }: rf_wD = ram_ext;
            default        : rf_wD = 32'h0;
        endcase
    end

    assign inst_finished = ld_st_flag   & ld_st_done
                         | mul_div_flag & !mul_div_busy
                         | ifetch_valid & !is_ld_st & !is_mul_div;

    always @(posedge cpu_clk or posedge cpu_rst) begin
        inst_finished_r <= cpu_rst ? 1'b0 : inst_finished;
    end

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
