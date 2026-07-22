// ============================================================================
// pipeline_hazard_tb.v — 流水线冒险综合测试
// ============================================================================
// 直接连接 cpu_core，测试:
//   1. EX/MEM → EX 转发 (RAW hazard)
//   2. MEM/WB → ID 转发 (WB 同周期读)
//   3. Load-use 阻塞检测 (load 后跟使用者)
//   4. Load-store 数据转发
//   5. 分支冲刷 (branch flush)
//   6. JAL 跳转冲刷
//   7. 访存停顿中转发保持
// ============================================================================

`timescale 1ns / 1ps

`include "defines.vh"

module pipeline_hazard_tb;
    reg clk = 1'b0;
    reg rst = 1'b1;

    wire        if_req;
    wire [31:0] if_addr;
    reg         if_valid = 1'b0;
    reg  [31:0] if_inst  = 32'h0000_0013;

    wire [3:0]  d_ren;
    wire [31:0] d_addr;
    reg         d_valid = 1'b0;
    reg  [31:0] d_rdata = 32'h0;
    wire [3:0]  d_wen;
    wire [31:0] d_wdata;
    reg         d_wresp = 1'b0;

    reg [31:0] imem [0:255];
    reg [31:0] dmem [0:255];
    integer i;

    always #5 clk = ~clk;

    cpu_core DUT (
        .cpu_rst        (rst),
        .cpu_clk        (clk),
        .ifetch_req     (if_req),
        .ifetch_addr    (if_addr),
        .ifetch_valid   (if_valid),
        .ifetch_inst    (if_inst),
        .daccess_ren    (d_ren),
        .daccess_addr   (d_addr),
        .daccess_rvalid (d_valid),
        .daccess_stall  (1'b0),
        .daccess_rdata  (d_rdata),
        .daccess_wen    (d_wen),
        .daccess_wdata  (d_wdata),
        .daccess_wresp  (d_wresp)
    );

    function [31:0] enc_i;
        input integer imm;
        input [4:0] rs1;
        input [4:0] rd;
        input [2:0] funct3;
        input [6:0] opcode;
        begin enc_i = {imm[11:0], rs1, funct3, rd, opcode}; end
    endfunction

    function [31:0] enc_r;
        input [6:0] funct7;
        input [4:0] rs2;
        input [4:0] rs1;
        input [2:0] funct3;
        input [4:0] rd;
        begin enc_r = {funct7, rs2, rs1, funct3, rd, 7'b0110011}; end
    endfunction

    function [31:0] enc_s;
        input integer imm;
        input [4:0] rs2;
        input [4:0] rs1;
        input [2:0] funct3;
        begin enc_s = {imm[11:5], rs2, rs1, funct3, imm[4:0], 7'b0100011}; end
    endfunction

    function [31:0] enc_b;
        input integer imm;
        input [4:0] rs2;
        input [4:0] rs1;
        input [2:0] funct3;
        begin enc_b = {imm[12], imm[10:5], rs2, rs1, funct3,
                       imm[4:1], imm[11], 7'b1100011}; end
    endfunction

    function [31:0] enc_j;
        input integer imm;
        input [4:0] rd;
        begin enc_j = {imm[20], imm[10:1], imm[11], imm[19:12], rd, 7'b1101111}; end
    endfunction

    always @(posedge clk) begin
        if (rst) begin
            if_valid <= 1'b0;
            if_inst  <= 32'h0000_0013;
            d_valid  <= 1'b0;
            d_wresp  <= 1'b0;
            d_rdata  <= 32'h0;
        end else begin
            if_valid <= if_req;
            if_inst  <= imem[if_addr[9:2]];
            d_valid  <= |d_ren;
            d_wresp  <= |d_wen;
            d_rdata  <= dmem[d_addr[9:2]];
            if (|d_wen) begin
                if (d_wen[0]) dmem[d_addr[9:2]][ 7: 0] <= d_wdata[ 7: 0];
                if (d_wen[1]) dmem[d_addr[9:2]][15: 8] <= d_wdata[15: 8];
                if (d_wen[2]) dmem[d_addr[9:2]][23:16] <= d_wdata[23:16];
                if (d_wen[3]) dmem[d_addr[9:2]][31:24] <= d_wdata[31:24];
            end
        end
    end

    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            imem[i] = 32'h0000_0013;
            dmem[i] = 32'h0;
        end

        // 测试序列（覆盖所有流水线冒险场景）
        imem[ 0] = enc_i(5,  0, 1, 3'b000, 7'b0010011);  // addi x1,x0,5
        imem[ 1] = enc_i(3,  1, 2, 3'b000, 7'b0010011);  // addi x2,x1,3  ← ID阶段需转发x1
        imem[ 2] = enc_r(7'b0, 2, 1, 3'b000, 3);          // add x3,x1,x2  ← 双操作数转发
        imem[ 3] = enc_s(0,  3, 0, 3'b010);               // sw x3,0(x0)   ← store数据转发
        imem[ 4] = enc_i(0,  0, 4, 3'b010, 7'b0000011);   // lw x4,0(x0)
        imem[ 5] = enc_i(1,  4, 5, 3'b000, 7'b0010011);   // addi x5,x4,1  ← load-use阻塞
        imem[ 6] = enc_b(8,  3, 5, 3'b000);               // beq x5,x3,+8  (不跳转)
        imem[ 7] = enc_i(2,  5, 6, 3'b000, 7'b0010011);   // addi x6,x5,2
        imem[ 8] = enc_b(8,  6, 6, 3'b000);               // beq x6,x6,+8  (跳转)
        imem[ 9] = enc_i(99, 0, 7, 3'b000, 7'b0010011);   // ← 被冲刷
        imem[10] = enc_i(42, 0, 8, 3'b000, 7'b0010011);   // 跳转目标
        imem[11] = enc_j(8,  0);                          // jal x0,+8
        imem[12] = enc_i(1,  0, 8, 3'b000, 7'b0010011);   // ← 被冲刷
        imem[13] = enc_i(1,  8, 9, 3'b000, 7'b0010011);   // addi x9,x8,1
        // 访存停顿中转发保持: EX/MEM→ID 的旁路值在访存暂停后不能丢失
        imem[14] = enc_i(0,  0, 10, 3'b000, 7'b0010011);  // addi x10,x0,0
        imem[15] = enc_i(77, 0, 11, 3'b000, 7'b0010011);  // addi x11,x0,77
        imem[16] = enc_s(16, 11, 0, 3'b010);              // sw x11,16(x0)
        imem[17] = enc_i(16, 10, 10, 3'b000, 7'b0010011); // addi x10,x0,16
        imem[18] = enc_i(0,  0, 13, 3'b010, 7'b0000011);  // lw x13,0(x0) (无关load)
        imem[19] = enc_i(0, 10, 12, 3'b010, 7'b0000011);  // lw x12,0(x10) ← base转发
        // ALU结果→store地址→load地址 的转发链
        imem[20] = enc_i(0,  0, 14, 3'b000, 7'b0010011);  // addi x14,x0,0
        imem[21] = enc_i(88, 0, 15, 3'b000, 7'b0010011);  // addi x15,x0,88
        imem[22] = enc_i(32, 14, 14, 3'b000, 7'b0010011); // addi x14,x0,32
        imem[23] = enc_s(0, 15, 14, 3'b010);              // sw x15,0(x14)
        imem[24] = enc_i(0, 14, 16, 3'b010, 7'b0000011);  // lw x16,0(x14)
        imem[25] = 32'h0000_0073;                         // ecall 标记

        #12 rst = 1'b0;
        for (i = 0; i < 2000; i = i + 1) begin
            @(posedge clk);
            if (if_valid && if_inst == 32'h0000_0073) begin
                repeat (20) @(posedge clk);
                if (DUT.U_RF.regs[1] !== 32'd5 ||
                    DUT.U_RF.regs[2] !== 32'd8 ||
                    DUT.U_RF.regs[3] !== 32'd13 ||
                    DUT.U_RF.regs[4] !== 32'd13 ||
                    DUT.U_RF.regs[5] !== 32'd14 ||
                    DUT.U_RF.regs[6] !== 32'd16 ||
                    DUT.U_RF.regs[7] === 32'd99 ||
                    DUT.U_RF.regs[8] !== 32'd42 ||
                    DUT.U_RF.regs[9] !== 32'd43 ||
                    DUT.U_RF.regs[12] !== 32'd77 ||
                    DUT.U_RF.regs[16] !== 32'd88 ||
                    dmem[0] !== 32'd13 || dmem[4] !== 32'd77 ||
                    dmem[8] !== 32'd88) begin
                    $display("PIPELINE_HAZARD_TEST_FAILED x1=%h x2=%h x3=%h x4=%h x5=%h x6=%h x7=%h x8=%h x9=%h x12=%h x16=%h mem0=%h mem16=%h mem32=%h",
                        DUT.U_RF.regs[1], DUT.U_RF.regs[2], DUT.U_RF.regs[3],
                        DUT.U_RF.regs[4], DUT.U_RF.regs[5], DUT.U_RF.regs[6],
                        DUT.U_RF.regs[7], DUT.U_RF.regs[8], DUT.U_RF.regs[9],
                        DUT.U_RF.regs[12], DUT.U_RF.regs[16], dmem[0],
                        dmem[4], dmem[8]);
                    $finish;
                end
                $display("PIPELINE_HAZARD_TEST_PASSED");
                $finish;
            end
        end
        $display("PIPELINE_HAZARD_TEST_TIMEOUT pc=%h if_req=%b if_valid=%b inst=%h",
            DUT.pc, if_req, if_valid, if_inst);
        $finish;
    end
endmodule
