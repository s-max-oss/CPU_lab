






`timescale 1ns / 1ps

`include "defines.vh"

module datapath_units_tb;

    reg clk = 1'b0;
    reg rst = 1'b1;
    integer errors = 0;

    reg [31:0] sext_inst = 32'b0;
    reg [ 2:0] sext_op = `EXT_I;
    wire [31:0] ext;

    reg [ 1:0] npc_op = `NPC_PC4;
    reg [31:0] npc_pc = 32'b0;
    reg [31:0] npc_offset = 32'b0;
    reg [31:0] npc_jmp_target = 32'b0;
    reg npc_br = 1'b0;
    wire [31:0] npc;
    wire [31:0] pc4;

    reg [ 4:0] alu_op = `ALU_ADD;
    reg [31:0] alu_a = 32'b0;
    reg [31:0] alu_b = 32'b0;
    wire [31:0] alu_c;
    wire alu_br;

    reg [31:0] ram_addr = 32'b0;
    reg [ 2:0] ram_rop = `RAM_EXT_N;
    reg [ 3:0] ram_wop = `RAM_WE_N;
    reg [31:0] ram_wdata = 32'b0;
    wire [ 3:0] da_ren;
    wire [31:0] da_addr;
    wire [ 3:0] da_wen;
    wire [31:0] da_wdata;

    reg [ 2:0] mext_op = `RAM_EXT_N;
    reg [31:0] mext_din = 32'b0;
    reg [ 1:0] mext_offset = 2'b0;
    wire [31:0] mext_value;

    always #5 clk = ~clk;

    SEXT U_sext (
        .op  (sext_op),
        .imm (sext_inst[31:7]),
        .ext (ext)
    );

    NPC U_npc (
        .op         (npc_op),
        .pc         (npc_pc),
        .offset     (npc_offset),
        .br         (npc_br),
        .jmp_target (npc_jmp_target),
        .npc        (npc),
        .pc4        (pc4)
    );


    wire alu_busy;
    wire alu_done;
    ALU U_alu (
        .rst  (rst),
        .clk  (clk),
        .op   (alu_op),
        .a    (alu_a),
        .b    (alu_b),
        .c    (alu_c),
        .br   (alu_br),
        .busy (alu_busy),
        .done (alu_done)
    );

    MREQ U_mreq (
        .ram_addr  (ram_addr),
        .ram_rop   (ram_rop),
        .da_ren    (da_ren),
        .da_addr   (da_addr),
        .ram_wop   (ram_wop),
        .ram_wdata (ram_wdata),
        .da_wen    (da_wen),
        .da_wdata  (da_wdata)
    );

    MEXT U_mext (
        .op        (mext_op),
        .din       (mext_din),
        .byte_offs (mext_offset),
        .ext       (mext_value)
    );

    task check_alu;
        input [8*8-1:0] name;
        input [ 4:0] operation;
        input [31:0] a;
        input [31:0] b;
        input [31:0] expected;
        begin

            alu_op = `ALU_ADD;
            alu_a = a;
            alu_b = b;
            @(posedge clk);

            alu_op = operation;
            #1;
            if (alu_c !== expected) begin
                $display("ALU_FAIL %0s got=%h expected=%h", name, alu_c, expected);
                errors = errors + 1;
            end
        end
    endtask

    task check_store;
        input [8*8-1:0] name;
        input [31:0] address;
        input [ 3:0] operation;
        input [31:0] data;
        input [ 3:0] expected_wen;
        input [31:0] expected_data;
        begin
            ram_addr = address;
            ram_rop = `RAM_EXT_N;
            ram_wop = operation;
            ram_wdata = data;
            #1;
            if (da_wen !== expected_wen || da_wdata !== expected_data) begin
                $display("STORE_FAIL %0s wen=%h data=%h expected_wen=%h expected_data=%h",
                    name, da_wen, da_wdata, expected_wen, expected_data);
                errors = errors + 1;
            end
        end
    endtask

    task check_load_request;
        input [8*8-1:0] name;
        input [31:0] address;
        input [ 2:0] operation;
        input [ 3:0] expected_ren;
        begin
            ram_addr = address;
            ram_wop = `RAM_WE_N;
            ram_rop = operation;
            #1;
            if (da_ren !== expected_ren) begin
                $display("LOAD_REQ_FAIL %0s ren=%h expected=%h", name, da_ren, expected_ren);
                errors = errors + 1;
            end
        end
    endtask

    task check_mext;
        input [8*8-1:0] name;
        input [ 2:0] operation;
        input [ 1:0] offset;
        input [31:0] expected;
        begin
            mext_op = operation;
            mext_offset = offset;
            #1;
            if (mext_value !== expected) begin
                $display("MEXT_FAIL %0s got=%h expected=%h", name, mext_value, expected);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        #12;
        rst = 1'b0;


        sext_op = `EXT_I;
        sext_inst = 32'hf800_0013;
        #1;
        if (ext !== 32'hffff_ff80) begin $display("SEXT_FAIL I"); errors = errors + 1; end

        sext_op = `EXT_S;
        sext_inst = {7'h7f, 5'd0, 5'd0, 3'b010, 5'h10, 7'h23};
        #1;
        if (ext !== 32'hffff_fff0) begin $display("SEXT_FAIL S"); errors = errors + 1; end

        sext_op = `EXT_B;
        sext_inst = {1'b1, 6'h3f, 5'd0, 5'd0, 3'b000, 4'he, 1'b1, 7'h63};
        #1;
        if (ext !== 32'hffff_fffc) begin $display("SEXT_FAIL B"); errors = errors + 1; end

        sext_op = `EXT_U;
        sext_inst = 32'h1234_5037;
        #1;
        if (ext !== 32'h1234_5000) begin $display("SEXT_FAIL U"); errors = errors + 1; end

        sext_op = `EXT_J;
        sext_inst = 32'h0080_00ef;
        #1;
        if (ext !== 32'h0000_0008) begin $display("SEXT_FAIL J"); errors = errors + 1; end


        npc_pc = 32'h0000_1000;
        npc_offset = 32'h0000_0008;
        npc_br = 1'b0;
        npc_op = `NPC_PC4;
        #1;
        if (npc !== 32'h0000_1004 || pc4 !== 32'h0000_1004) begin $display("NPC_FAIL PC4"); errors = errors + 1; end

        npc_op = `NPC_JMP;
        #1;
        if (npc !== 32'h0000_1008) begin $display("NPC_FAIL JAL"); errors = errors + 1; end

        npc_op = `NPC_JALR;
        npc_jmp_target = 32'h0000_1007;  // rs1+offset, NPC aligns to half-word
        #1;
        if (npc !== 32'h0000_1006) begin $display("NPC_FAIL JALR"); errors = errors + 1; end

        npc_op = `NPC_BRA;
        npc_offset = 32'hffff_fffc;
        npc_br = 1'b0;
        #1;
        if (npc !== 32'h0000_1004) begin $display("NPC_FAIL BR_NOT_TAKEN"); errors = errors + 1; end
        npc_br = 1'b1;
        #1;
        if (npc !== 32'h0000_0ffc) begin $display("NPC_FAIL BR_TAKEN"); errors = errors + 1; end


        check_alu("ADD",  `ALU_ADD,  32'h7fff_ffff, 32'h1, 32'h8000_0000);
        check_alu("SUB",  `ALU_SUB,  32'h3, 32'h5, 32'hffff_fffe);
        check_alu("AND",  `ALU_AND,  32'hf0f0_aa55, 32'h0ff0_0f0f, 32'h00f0_0a05);
        check_alu("OR",   `ALU_OR,   32'hf000_00f0, 32'h0f00_0f00, 32'hff00_0ff0);
        check_alu("XOR",  `ALU_XOR,  32'hffff_0000, 32'h0f0f_0f0f, 32'hf0f0_0f0f);
        check_alu("SLL",  `ALU_SLL,  32'h1, 32'h1f, 32'h8000_0000);
        check_alu("SRL",  `ALU_SRL,  32'h8000_0000, 32'h4, 32'h0800_0000);
        check_alu("SRA",  `ALU_SRA,  32'h8000_0000, 32'h4, 32'hf800_0000);
        check_alu("SLT",  `ALU_SLT,  32'hffff_ffff, 32'h1, 32'h1);
        check_alu("SLTU", `ALU_SLTU, 32'hffff_ffff, 32'h1, 32'h0);


        alu_a = 32'hffff_ffff;
        alu_b = 32'h0000_0001;
        alu_op = `ALU_SLT;
        #1;
        if (alu_br !== 1'b1) begin $display("BR_FAIL BLT"); errors = errors + 1; end
        alu_op = `ALU_GE;
        #1;
        if (alu_br !== 1'b0) begin $display("BR_FAIL BGE"); errors = errors + 1; end
        alu_op = `ALU_SLTU;
        #1;
        if (alu_br !== 1'b0) begin $display("BR_FAIL BLTU"); errors = errors + 1; end
        alu_op = `ALU_GEU;
        #1;
        if (alu_br !== 1'b1) begin $display("BR_FAIL BGEU"); errors = errors + 1; end


        check_store("SB0", 32'h2000, `RAM_WE_B, 32'hffff_ffaa, 4'b0001, 32'h0000_00aa);
        check_store("SB1", 32'h2001, `RAM_WE_B, 32'hffff_ffaa, 4'b0010, 32'h0000_aa00);
        check_store("SB2", 32'h2002, `RAM_WE_B, 32'hffff_ffaa, 4'b0100, 32'h00aa_0000);
        check_store("SB3", 32'h2003, `RAM_WE_B, 32'hffff_ffaa, 4'b1000, 32'haa00_0000);
        check_store("SH0", 32'h2000, `RAM_WE_H, 32'h1234_5678, 4'b0011, 32'h0000_5678);
        check_store("SH2", 32'h2002, `RAM_WE_H, 32'h1234_5678, 4'b1100, 32'h5678_0000);
        check_store("SH1_BAD", 32'h2001, `RAM_WE_H, 32'h1234_5678, 4'b0000, 32'h0000_5678);
        check_store("SW0", 32'h2000, `RAM_WE_W, 32'h1234_5678, 4'b1111, 32'h1234_5678);
        check_store("SW2_BAD", 32'h2002, `RAM_WE_W, 32'h1234_5678, 4'b0000, 32'h1234_5678);


        check_load_request("LB3", 32'h2003, `RAM_EXT_B, 4'hf);
        check_load_request("LHU2", 32'h2002, `RAM_EXT_HU, 4'hf);
        check_load_request("LH1_BAD", 32'h2001, `RAM_EXT_H, 4'h0);
        check_load_request("LW0", 32'h2000, `RAM_EXT_W, 4'hf);
        check_load_request("LW2_BAD", 32'h2002, `RAM_EXT_W, 4'h0);


        mext_din = 32'h80ff_7f01;
        check_mext("LB0",  `RAM_EXT_B,  2'd0, 32'h0000_0001);
        check_mext("LB2",  `RAM_EXT_B,  2'd2, 32'hffff_ffff);
        check_mext("LBU3", `RAM_EXT_BU, 2'd3, 32'h0000_0080);
        check_mext("LH0",  `RAM_EXT_H,  2'd0, 32'h0000_7f01);
        check_mext("LH2",  `RAM_EXT_H,  2'd2, 32'hffff_80ff);
        check_mext("LHU2", `RAM_EXT_HU, 2'd2, 32'h0000_80ff);
        check_mext("LW",   `RAM_EXT_W,  2'd0, 32'h80ff_7f01);

        if (errors == 0)
            $display("DATAPATH_UNITS_TEST_PASSED");
        else
            $display("DATAPATH_UNITS_TEST_FAILED errors=%0d", errors);
        $finish;
    end

endmodule
