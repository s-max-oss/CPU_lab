








`timescale 1ns / 1ps

`include "defines.vh"

module pipeline_control_mem_tb;
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
        .cpu_rst(rst), .cpu_clk(clk),
        .ifetch_req(if_req), .ifetch_addr(if_addr),
        .ifetch_valid(if_valid), .ifetch_inst(if_inst),
        .daccess_ren(d_ren), .daccess_addr(d_addr),
        .daccess_rvalid(d_valid), .daccess_stall(1'b0),
        .daccess_rdata(d_rdata),
        .daccess_wen(d_wen), .daccess_wdata(d_wdata),
        .daccess_wresp(d_wresp)
    );

    function [31:0] enc_i;
        input integer imm; input [4:0] rs1; input [2:0] funct3;
        input [4:0] rd; input [6:0] opcode;
        begin enc_i = {imm[11:0], rs1, funct3, rd, opcode}; end
    endfunction
    function [31:0] enc_s;
        input integer imm; input [4:0] rs2; input [4:0] rs1;
        input [2:0] funct3;
        begin enc_s = {imm[11:5], rs2, rs1, funct3, imm[4:0], 7'b0100011}; end
    endfunction
    function [31:0] enc_j;
        input integer imm; input [4:0] rd;
        begin enc_j = {imm[20], imm[10:1], imm[11], imm[19:12], rd, 7'b1101111}; end
    endfunction

    always @(posedge clk) begin
        if (rst) begin
            if_valid <= 1'b0; if_inst <= 32'h0000_0013;
            d_valid <= 1'b0; d_wresp <= 1'b0; d_rdata <= 32'h0;
        end else begin
            if_valid <= if_req;
            if_inst <= imem[if_addr[9:2]];
            d_valid <= |d_ren;
            d_wresp <= |d_wen;
            d_rdata <= dmem[d_addr[9:2]];
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

        imem[ 0] = {20'h12345, 5'd1, 7'b0110111};          // lui x1,0x12345
        imem[ 1] = {20'h00000, 5'd2, 7'b0010111};          // auipc x2,0 (x2=PC+4=4)
        imem[ 2] = enc_i(64, 0, 3'b000, 3, 7'b0010011);    // addi x3,x0,64
        imem[ 3] = enc_i(0,  3, 3'b000, 4, 7'b1100111);

        imem[16] = enc_i(-128, 0, 3'b000, 5, 7'b0010011);  // addi x5,x0,-128
        imem[17] = enc_s(1, 5, 0, 3'b000);
        imem[18] = enc_i(1, 0, 3'b100, 6, 7'b0000011);
        imem[19] = enc_i(1, 0, 3'b000, 7, 7'b0000011);
        imem[20] = enc_i(-2, 0, 3'b000, 8, 7'b0010011);    // addi x8,x0,-2
        imem[21] = enc_s(2, 8, 0, 3'b001);
        imem[22] = enc_i(2, 0, 3'b101, 9, 7'b0000011);
        imem[23] = enc_i(2, 0, 3'b001, 10, 7'b0000011);
        imem[24] = enc_j(8, 11);                           // jal x11,+8
        imem[25] = enc_i(99, 0, 3'b000, 12, 7'b0010011);
        imem[26] = enc_i(12, 0, 3'b000, 12, 7'b0010011);
        imem[27] = 32'h0000_0073;

        #12 rst = 1'b0;
        for (i = 0; i < 3000; i = i + 1) begin
            @(posedge clk);
            if (if_valid && if_inst == 32'h0000_0073) begin
                repeat (20) @(posedge clk);
                if (DUT.U_RF.regs[1] !== 32'h1234_5000 ||
                    DUT.U_RF.regs[2] !== 32'h0000_0004 ||
                    DUT.U_RF.regs[3] !== 32'h0000_0040 ||
                    DUT.U_RF.regs[4] !== 32'h0000_0010 ||
                    DUT.U_RF.regs[6] !== 32'h0000_0080 ||
                    DUT.U_RF.regs[7] !== 32'hffff_ff80 ||
                    DUT.U_RF.regs[9] !== 32'h0000_fffe ||
                    DUT.U_RF.regs[10] !== 32'hffff_fffe ||
                    DUT.U_RF.regs[11] !== 32'h0000_0064 ||
                    DUT.U_RF.regs[12] !== 32'h0000_000c ||
                    dmem[0] !== 32'hfffe_8000) begin
                    $display("PIPELINE_CONTROL_MEM_TEST_FAILED x1=%h x2=%h x3=%h x4=%h x6=%h x7=%h x9=%h x10=%h x11=%h x12=%h mem0=%h",
                        DUT.U_RF.regs[1], DUT.U_RF.regs[2], DUT.U_RF.regs[3],
                        DUT.U_RF.regs[4], DUT.U_RF.regs[6], DUT.U_RF.regs[7],
                        DUT.U_RF.regs[9], DUT.U_RF.regs[10], DUT.U_RF.regs[11],
                        DUT.U_RF.regs[12], dmem[0]);
                    $finish;
                end
                $display("PIPELINE_CONTROL_MEM_TEST_PASSED");
                $finish;
            end
        end
        $display("PIPELINE_CONTROL_MEM_TEST_TIMEOUT pc=%h", DUT.pc);
        $finish;
    end
endmodule
