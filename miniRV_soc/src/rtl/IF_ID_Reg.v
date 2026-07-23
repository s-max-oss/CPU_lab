`timescale 1ns / 1ps

module IF_ID_Reg (
    input  wire         clk,
    input  wire         rst,
    input  wire         flush,
    input  wire         stall,
    input  wire         clear,

    input  wire [31:0]  pc_in,
    input  wire [31:0]  inst_in,

    output reg  [31:0]  pc_out,
    output reg  [31:0]  inst_out
);

    always @(posedge clk or posedge rst) begin
        if (rst || flush || clear) begin
            pc_out   <= 32'h0;
            inst_out <= 32'h00000013;   // NOP: addi x0, x0, 0
        end else if (!stall) begin
            pc_out   <= pc_in;
            inst_out <= inst_in;
        end
    end

endmodule
