// ============================================================================
// basic_rtype_tb.v — R-type 指令功能测试（Controller + ALU 组合逻辑）
// ============================================================================
// 直接测试 Controller + 组合逻辑 ALU：给定指令机器码，检查 ALU 计算结果
// 覆盖: ADD, SUB, AND (ALU 计算), Controller 控制信号
// 注意: 本设计使用组合逻辑 ALU（无 clk/rst/busy），MUL/DIV 单周期完成
// ============================================================================

`timescale 1ns / 1ps

`include "defines.vh"

module basic_rtype_tb;

    reg         clk = 1'b0;
    reg         rst = 1'b1;
    reg  [ 6:0] opcode = 7'b0;
    reg  [ 2:0] funct3 = 3'b0;
    reg  [ 6:0] funct7 = 7'b0;
    reg  [31:0] a = 32'b0;
    reg  [31:0] b = 32'b0;

    wire [ 1:0] npc_op;
    wire [ 2:0] sext_op;
    wire        alua_sel;
    wire        alub_sel;
    wire [ 4:0] alu_op;
    wire [ 2:0] ram_r_op;
    wire [ 3:0] ram_w_op;
    wire        rf_we;
    wire [ 1:0] rf_wsel;
    wire [31:0] alu_c;
    wire        alu_br;

    integer errors = 0;

    always #5 clk = ~clk;

    Controller U_controller (
        .opcode   (opcode),
        .funct3   (funct3),
        .funct7   (funct7),
        .npc_op   (npc_op),
        .sext_op  (sext_op),
        .alua_sel (alua_sel),
        .alub_sel (alub_sel),
        .alu_op   (alu_op),
        .ram_r_op (ram_r_op),
        .ram_w_op (ram_w_op),
        .rf_we    (rf_we),
        .rf_wsel  (rf_wsel)
    );

    // 多周期 ALU（含 clk/rst/busy 端口）
    wire alu_busy;
    wire alu_done;
    ALU U_alu (
        .rst  (rst),
        .clk  (clk),
        .op   (alu_op),
        .a    (a),
        .b    (b),
        .c    (alu_c),
        .br   (alu_br),
        .busy (alu_busy),
        .done (alu_done)
    );

    task check_result;
        input [8*8-1:0] name;
        input [31:0] expected_c;
        input [ 4:0] expected_alu_op;
        begin
            #1;
            if (alu_c !== expected_c) begin
                $display("FAIL %0s: result=%h expected=%h", name, alu_c, expected_c);
                errors = errors + 1;
            end
            if (alu_op !== expected_alu_op) begin
                $display("FAIL %0s: alu_op=%h expected=%h", name, alu_op, expected_alu_op);
                errors = errors + 1;
            end
            if (npc_op !== `NPC_PC4 || rf_we !== 1'b1 || rf_wsel !== `WB_ALU) begin
                $display("FAIL %0s: npc_op=%h rf_we=%b rf_wsel=%h", name, npc_op, rf_we, rf_wsel);
                errors = errors + 1;
            end
            if (alua_sel !== `ALU_A_RS1 || alub_sel !== `ALU_B_RS2) begin
                $display("FAIL %0s: alua_sel=%b alub_sel=%b", name, alua_sel, alub_sel);
                errors = errors + 1;
            end
            if (ram_r_op !== `RAM_EXT_N || ram_w_op !== `RAM_WE_N) begin
                $display("FAIL %0s: unexpected memory control", name);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        #12;
        rst = 1'b0;

        opcode = 7'b0110011;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        a = 32'h7fff_ffff;
        b = 32'h0000_0001;
        check_result("ADD", 32'h8000_0000, `ALU_ADD);

        opcode = 7'b0110011;
        funct3 = 3'b000;
        funct7 = 7'b0100000;
        a = 32'h0000_0003;
        b = 32'h0000_0005;
        check_result("SUB", 32'hffff_fffe, `ALU_SUB);

        opcode = 7'b0110011;
        funct3 = 3'b111;
        funct7 = 7'b0000000;
        a = 32'hf0f0_aa55;
        b = 32'h0ff0_0f0f;
        check_result("AND", 32'h00f0_0a05, `ALU_AND);

        if (errors == 0)
            $display("BASIC_RTYPE_TEST_PASSED");
        else
            $display("BASIC_RTYPE_TEST_FAILED: %0d error(s)", errors);

        $finish;
    end

endmodule
