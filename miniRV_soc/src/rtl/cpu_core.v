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
    input  wire         daccess_stall,
    input  wire [31:0]  daccess_rdata,
    output reg  [ 3:0]  daccess_wen,
    output reg  [31:0]  daccess_wdata,
    input  wire         daccess_wresp
);

    wire [31:0] pc;
    wire [31:0] npc;
    wire [31:0] pc4;

    wire        stall;
    wire        flush;

    wire [31:0] id_inst;
    wire        ex_rf_we;
    wire [ 1:0] ex_rf_wsel;
    wire [ 4:0] ex_rd_addr;
    wire [ 3:0] ex_da_ren;
    wire        ex_is_lui;
    wire        mul_div_stall;
    reg         mul_div_flush;

    wire        mem_rf_we;
    wire [ 4:0] mem_rd_addr;
    wire [31:0] mem_alu_c;

    wire ex_is_load = ex_rf_we && (ex_rf_wsel == `WB_RAM);
    wire stall_load = ex_is_load && (ex_rd_addr != 5'h0) &&
                      ((ex_rd_addr == id_inst[19:15]) || (ex_rd_addr == id_inst[24:20]));

`ifdef USE_AXI

    reg flush_axi;
    always @(posedge cpu_clk or posedge cpu_rst) begin
        if (cpu_rst)
            flush_axi <= 1'b0;
        else if (flush)
            flush_axi <= 1'b1;
        else if (ifetch_valid)
            flush_axi <= 1'b0;
    end

    wire ifetch_ready = ifetch_valid && !flush_axi;

    reg ex_was_load;
    always @(posedge cpu_clk or posedge cpu_rst) begin
        if (cpu_rst)
            ex_was_load <= 1'b0;
        else if (!load_wait)
            ex_was_load <= |ex_da_ren;
        else if (daccess_stall)
            ex_was_load <= 1'b0;
    end
    wire load_wait = daccess_stall || ex_was_load;
    assign stall = (stall_load || !ifetch_ready || load_wait || mul_div_stall) && !flush;
    assign ifetch_addr = flush ? npc : ((stall_load || mul_div_stall) ? (pc - 32'd4) : (ifetch_ready ? npc : pc));
`else
    wire load_wait = 1'b0;
    assign stall = stall_load || mul_div_stall;
    assign ifetch_addr = stall ? (pc - 32'd4) : pc;
`endif

    wire id_ex_flush = flush || stall_load || mul_div_flush;

    wire [ 1:0] npc_op;
    wire [31:0] npc_pc;
    wire [31:0] npc_offset;
    wire        npc_br;
    wire [31:0] npc_jmp_target;

    assign ifetch_req  = !cpu_rst && !load_wait && !stall_load && !mul_div_stall;

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

`ifdef USE_AXI
    wire [31:0] if_inst = ifetch_ready ? ifetch_inst : 32'h00000013;
`else
    wire [31:0] if_inst = ifetch_valid ? ifetch_inst : 32'h00000013;
`endif

`ifdef USE_AXI
    wire if_clear = !stall_load && !ifetch_ready && !load_wait;
`else
    wire if_clear = 1'b0;
`endif

    reg flush_d1;
    always @(posedge cpu_clk or posedge cpu_rst)
        flush_d1 <= cpu_rst ? 1'b0 : flush;

    wire [31:0] id_pc;  // id_inst forward-declared at top for load-use detection

    IF_ID_Reg U_IF_ID (
        .clk      (cpu_clk),
        .rst      (cpu_rst),
        .flush    (flush || flush_d1 || mul_div_flush),
        .stall    (stall),
        .clear    (if_clear),
        .pc_in    (pc),
        .inst_in  (if_inst),
        .pc_out   (id_pc),
        .inst_out (id_inst)
    );

    wire [ 1:0] id_npc_op;
    wire [ 4:0] id_alu_op;
    wire        id_alua_sel, id_alub_sel;
    wire [ 2:0] id_sext_op;
    wire [ 2:0] id_ram_rop;
    wire [ 3:0] id_ram_wop;
    wire        id_rf_we;
    wire [ 1:0] id_rf_wsel;

    Controller U_CU (
        .opcode     (id_inst[6:0]),
        .funct3     (id_inst[14:12]),
        .funct7     (id_inst[31:25]),
        .npc_op     (id_npc_op),
        .sext_op    (id_sext_op),
        .alu_op     (id_alu_op),
        .alua_sel   (id_alua_sel),
        .alub_sel   (id_alub_sel),
        .ram_r_op   (id_ram_rop),
        .ram_w_op   (id_ram_wop),
        .rf_we      (id_rf_we),
        .rf_wsel    (id_rf_wsel)
    );

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

    wire [31:0] id_rD1_fwd = (wb_rf_we && wb_rd_addr != 5'h0 && wb_rd_addr == id_inst[19:15]) ? wb_wD : id_rD1;
    wire [31:0] id_rD2_fwd = (wb_rf_we && wb_rd_addr != 5'h0 && wb_rd_addr == id_inst[24:20]) ? wb_wD : id_rD2;

    wire [31:0] id_ext;

    SEXT U_SEXT (
        .op     (id_sext_op),
        .imm    (id_inst[31:7]),
        .ext    (id_ext)
    );

`ifdef USE_AXI
    wire [31:0] id_pc4 = id_pc + 32'd4;
`else
    wire [31:0] id_pc4 = id_pc;
`endif

    wire [31:0] ex_pc, ex_rD1, ex_rD2, ex_ext, ex_pc4;
    wire [ 4:0] ex_rs1_addr, ex_rs2_addr;
    wire [ 1:0] ex_npc_op;
    wire [ 4:0] ex_alu_op;
    wire        ex_alua_sel, ex_alub_sel;
    wire [ 2:0] ex_sext_op;
    wire [ 2:0] ex_ram_rop;
    wire [ 3:0] ex_ram_wop;

    ID_EX_Reg U_ID_EX (
        .clk            (cpu_clk),
        .rst            (cpu_rst),
        .flush          (id_ex_flush),
        .stall          (stall_load || load_wait || mul_div_stall),
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
        .rf_wsel_out    (ex_rf_wsel)
    );

    wire fwd_ex_rs1 = mem_rf_we && (mem_rd_addr != 5'h0) && (mem_rd_addr == ex_rs1_addr) && !ex_alua_sel && !ex_is_lui;
    wire fwd_ex_rs2_raw = mem_rf_we && (mem_rd_addr != 5'h0) && (mem_rd_addr == ex_rs2_addr);
    wire fwd_ex_rs2 = fwd_ex_rs2_raw && !ex_alub_sel;

    wire fwd_wb_rs1 = wb_rf_we && (wb_rd_addr != 5'h0) && (wb_rd_addr == ex_rs1_addr) && !fwd_ex_rs1 && !ex_alua_sel && !ex_is_lui;
    wire fwd_wb_rs2_raw = wb_rf_we && (wb_rd_addr != 5'h0) && (wb_rd_addr == ex_rs2_addr) && !fwd_ex_rs2_raw;
    wire fwd_wb_rs2 = fwd_wb_rs2_raw && !ex_alub_sel;

    wire [31:0] ex_rD2_fwd = fwd_ex_rs2_raw ? mem_alu_c : (fwd_wb_rs2_raw ? wb_wD : ex_rD2);

    assign ex_is_lui = (ex_rf_wsel == `WB_EXT);  // forward-declared at top
`ifdef USE_AXI
    wire [31:0] ex_alu_a_raw = ex_alua_sel ? ex_pc : (ex_is_lui ? 32'd0 : ex_rD1);
`else
    wire [31:0] ex_alu_a_raw = ex_alua_sel ? (ex_pc - 32'd4) : (ex_is_lui ? 32'd0 : ex_rD1);
`endif
    wire [31:0] ex_alu_a     = fwd_ex_rs1 ? mem_alu_c : (fwd_wb_rs1 ? wb_wD : ex_alu_a_raw);

    wire [31:0] ex_alu_b_raw = ex_alub_sel ? ex_ext : ex_rD2;
    wire [31:0] ex_alu_b     = fwd_ex_rs2 ? mem_alu_c : (fwd_wb_rs2 ? wb_wD : ex_alu_b_raw);

    wire [31:0] ex_alu_c;
    wire        ex_br;
    wire        ex_alu_busy;
    wire        ex_alu_done;

    ALU U_ALU (
        .rst    (cpu_rst),
        .clk    (cpu_clk),
        .op     (ex_alu_op),
        .a      (ex_alu_a),
        .b      (ex_alu_b),
        .br     (ex_br),
        .c      (ex_alu_c),
        .busy   (ex_alu_busy),
        .done   (ex_alu_done)
    );

    wire ex_is_mul_div = (ex_alu_op == `ALU_MUL)  || (ex_alu_op == `ALU_MULH) ||
                         (ex_alu_op == `ALU_MULHU) || (ex_alu_op == `ALU_DIV)  ||
                         (ex_alu_op == `ALU_DIVU)  || (ex_alu_op == `ALU_REM)  ||
                         (ex_alu_op == `ALU_REMU);

    wire ex_mul_div_starting = ex_is_mul_div && !ex_alu_busy && !ex_alu_done && !mul_div_flush;

    always @(posedge cpu_clk or posedge cpu_rst) begin
        if (cpu_rst)
            mul_div_flush <= 1'b0;
        else if (ex_alu_done)
            mul_div_flush <= 1'b1;
        else
            mul_div_flush <= 1'b0;
    end

    assign mul_div_stall = (ex_is_mul_div && ex_alu_busy) || ex_mul_div_starting || ex_alu_done || mul_div_flush;

    wire mem_stall = load_wait || (ex_is_mul_div && ex_alu_busy) || ex_mul_div_starting;

    wire ex_branch_taken = (ex_npc_op == `NPC_BRA) && ex_br;
    wire ex_is_jal       = (ex_npc_op == `NPC_JMP);
    wire ex_is_jalr      = (ex_npc_op == `NPC_JALR);
    assign flush = ex_branch_taken || ex_is_jal || ex_is_jalr;

`ifdef USE_AXI
    wire [31:0] ex_real_pc = ex_pc;
`else
    wire [31:0] ex_real_pc = ex_pc - 32'd4;
`endif

    assign npc_op        = flush ? ex_npc_op    : `NPC_PC4;
    assign npc_pc        = flush ? ex_real_pc   : pc;
    assign npc_offset    = flush ? ex_ext       : 32'h0;
    assign npc_br        = flush ? ex_br        : 1'b0;
    assign npc_jmp_target = flush ? ex_alu_c    : 32'h0;

    wire [ 3:0] ex_da_wen;
    wire [31:0] ex_da_wdata;

    MREQ U_MEM_REQ (
        .ram_addr   (ex_alu_c),
        .ram_rop    (ex_ram_rop),
        .da_ren     (ex_da_ren),
        .da_addr    (),
        .ram_wop    (ex_ram_wop),
        .ram_wdata  (ex_rD2_fwd),
        .da_wen     (ex_da_wen),
        .da_wdata   (ex_da_wdata)
    );

    wire [31:0] mem_rD2, mem_pc4;
    wire        mem_br;
    wire [ 1:0] mem_npc_op;
    wire [ 2:0] mem_ram_rop;
    wire [ 3:0] mem_ram_wop;
    wire [ 1:0] mem_rf_wsel;

    EX_MEM_Reg U_EX_MEM (
        .clk            (cpu_clk),
        .rst            (cpu_rst),
        .flush          (mul_div_flush),
        .stall          (mem_stall),
        .alu_c_in       (ex_alu_c),
        .rD2_in         (ex_rD2),
        .pc4_in         (ex_pc4),
        .br_in          (ex_br),
        .rd_addr_in     (ex_rd_addr),
        .npc_op_in      (ex_npc_op),
        .ram_rop_in     (ex_ram_rop),
        .ram_wop_in     (ex_ram_wop),
        .rf_we_in       (ex_rf_we && !mul_div_flush),
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

    always @(posedge cpu_clk or posedge cpu_rst) begin
        if (cpu_rst) begin
            daccess_ren   <= 4'h0;
            daccess_wen   <= 4'h0;
        end else if (!load_wait) begin
            daccess_ren   <= ex_da_ren;
            daccess_addr  <= ex_alu_c;
            daccess_wen   <= ex_da_wen;
            daccess_wdata <= ex_da_wdata;
        end
    end

    wire [31:0] wb_alu_c, wb_ram_ext, wb_pc4;
    wire [ 1:0] wb_rf_wsel;
    wire [ 2:0] wb_ram_rop;
    wire [ 1:0] wb_byte_offs;

    MEM_WB_Reg U_MEM_WB (
        .clk            (cpu_clk),
        .rst            (cpu_rst),
        .flush          (1'b0),
        .stall          (mem_stall),
        .alu_c_in       (mem_alu_c),
        .ram_ext_in     (32'h0),
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
            `WB_EXT: wb_wD = wb_alu_c;
            default: wb_wD = 32'h0;
        endcase
    end

    wire [31:0] debug_wb_pc    /* verilator public */ ;
    wire        debug_wb_rf_we /* verilator public */ ;
    wire [ 4:0] debug_wb_rf_wR /* verilator public */ ;
    wire [31:0] debug_wb_rf_wD /* verilator public */ ;

    assign debug_wb_pc    = wb_pc4 - 32'd4;
    assign debug_wb_rf_we = wb_rf_we && !mem_stall;
    assign debug_wb_rf_wR = wb_rd_addr;
    assign debug_wb_rf_wD = wb_wD;

    wire [31:0] debug_mem_pc    /* verilator public */ ;
    wire [ 3:0] debug_mem_we    /* verilator public */ ;
    wire [31:0] debug_mem_waddr /* verilator public */ ;
    wire [31:0] debug_mem_wdata /* verilator public */ ;

    assign debug_mem_pc    = mem_pc4 - 32'd4;
    assign debug_mem_we    = daccess_wen;
    assign debug_mem_waddr = daccess_addr;
    assign debug_mem_wdata = daccess_wdata;

endmodule
