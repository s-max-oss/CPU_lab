// ============================================================================
// pipeline_muldiv_tb.v — M-extension 流水线测试
// ============================================================================
// 测试 MUL, MULH, MULHU, DIV, DIVU, REM, REMU 指令在流水线中的执行
// 注意: 本设计使用多周期乘除法器，需要充足等待时间让结果写回
// ============================================================================

`timescale 1ns / 1ps

`include "defines.vh"

module pipeline_muldiv_tb;
    reg clk = 1'b0;
    reg rst = 1'b1;
    wire if_req;
    wire [31:0] if_addr;
    reg if_valid = 1'b0;
    reg [31:0] if_inst = 32'h0000_0013;
    wire [3:0] d_ren;
    wire [31:0] d_addr;
    reg d_valid = 1'b0;
    reg [31:0] d_rdata = 32'h0;
    wire [3:0] d_wen;
    wire [31:0] d_wdata;
    reg d_wresp = 1'b0;
    reg [31:0] imem [0:255];
    reg [31:0] dmem [0:255];
    integer i;

    always #5 clk = ~clk;

    cpu_core DUT (
        .cpu_rst        (rst), .cpu_clk        (clk),
        .ifetch_req     (if_req), .ifetch_addr  (if_addr),
        .ifetch_valid   (if_valid), .ifetch_inst(if_inst),
        .daccess_ren    (d_ren), .daccess_addr (d_addr),
        .daccess_rvalid (d_valid), .daccess_stall(1'b0),
        .daccess_rdata  (d_rdata),
        .daccess_wen    (d_wen), .daccess_wdata(d_wdata),
        .daccess_wresp  (d_wresp)
    );

    function [31:0] enc_i;
        input integer imm; input [4:0] rs1; input [4:0] rd;
        begin enc_i = {imm[11:0], rs1, 3'b000, rd, 7'b0010011}; end
    endfunction
    function [31:0] enc_r;
        input [6:0] funct7; input [2:0] funct3;
        input [4:0] rs2; input [4:0] rs1; input [4:0] rd;
        begin enc_r = {funct7, rs2, rs1, funct3, rd, 7'b0110011}; end
    endfunction

    always @(posedge clk) begin
        if (rst) begin
            if_valid <= 1'b0; if_inst <= 32'h0000_0013;
            d_valid <= 1'b0; d_wresp <= 1'b0; d_rdata <= 32'h0;
        end else begin
            if_valid <= if_req;
            if_inst  <= imem[if_addr[9:2]];
            d_valid  <= |d_ren;
            d_wresp  <= |d_wen;
            d_rdata  <= dmem[d_addr[9:2]];
        end
    end

    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            imem[i] = 32'h0000_0013;
            dmem[i] = 32'h0;
        end

        // 乘除法测试序列（多周期 M-extension）
        imem[ 0] = enc_i(-26, 0, 1);                      // x1 = -26 (0xffffffe6)
        imem[ 1] = enc_i(5,    0, 2);                     // x2 = 5
        imem[ 2] = enc_r(7'b0000001, 3'b000, 2, 1, 3);   // mul  x3,x1,x2  = -130
        imem[ 3] = enc_r(7'b0000001, 3'b001, 2, 1, 4);   // mulh x4,x1,x2  = -1
        imem[ 4] = enc_r(7'b0000001, 3'b011, 2, 1, 5);   // mulhu x5,x1,x2 = 4
        imem[ 5] = enc_r(7'b0000001, 3'b100, 2, 1, 6);   // div  x6,x1,x2  = -5
        imem[ 6] = enc_r(7'b0000001, 3'b110, 2, 1, 7);   // rem  x7,x1,x2  = -1
        imem[ 7] = enc_r(7'b0000001, 3'b101, 2, 1, 8);   // divu x8,x1,x2  = 0x3333332e
        imem[ 8] = enc_r(7'b0000001, 3'b111, 2, 1, 9);   // remu x9,x1,x2  = 0
        imem[ 9] = enc_i(1, 3, 10);                      // addi x10,x3,1 = -129
        imem[10] = 32'h0000_0073;                        // ecall 标记

        #12 rst = 1'b0;
        for (i = 0; i < 1000; i = i + 1) begin
            @(posedge clk);
            if (if_valid && if_inst == 32'h0000_0073) begin
                // 等待多周期乘除法全部完成（REMU 最慢 ~35 周期）
                repeat (500) @(posedge clk);
                if (DUT.U_RF.regs[1] !== 32'hffff_ffe6 ||
                    DUT.U_RF.regs[2] !== 32'd5 ||
                    DUT.U_RF.regs[3] !== 32'hffff_ff7e ||
                    DUT.U_RF.regs[4] !== 32'hffff_ffff ||
                    DUT.U_RF.regs[5] !== 32'd4 ||
                    DUT.U_RF.regs[6] !== 32'hffff_fffb ||
                    DUT.U_RF.regs[7] !== 32'hffff_ffff ||
                    DUT.U_RF.regs[8] !== 32'h3333_332e ||
                    DUT.U_RF.regs[9] !== 32'd0 ||
                    DUT.U_RF.regs[10] !== 32'hffff_ff7f) begin
                    $display("PIPELINE_MULDIV_TEST_FAILED x1=%h x2=%h x3=%h x4=%h x5=%h x6=%h x7=%h x8=%h x9=%h x10=%h",
                        DUT.U_RF.regs[1], DUT.U_RF.regs[2], DUT.U_RF.regs[3],
                        DUT.U_RF.regs[4], DUT.U_RF.regs[5], DUT.U_RF.regs[6],
                        DUT.U_RF.regs[7], DUT.U_RF.regs[8], DUT.U_RF.regs[9],
                        DUT.U_RF.regs[10]);
                    $finish;
                end
                $display("PIPELINE_MULDIV_TEST_PASSED");
                $finish;
            end
        end
        $display("PIPELINE_MULDIV_TEST_TIMEOUT pc=%h if_req=%b if_valid=%b inst=%h",
            DUT.pc, if_req, if_valid, if_inst);
        $finish;
    end
endmodule
