`timescale 1ns / 1ps

`include "defines.vh"

module MREQ (
    input  wire [31:0]  ram_addr,

    input  wire [ 2:0]  ram_rop,
    output reg  [ 3:0]  da_ren,
    output wire [31:0]  da_addr,

    input  wire [ 3:0]  ram_wop,
    input  wire [31:0]  ram_wdata,
    output reg  [ 3:0]  da_wen,
    output reg  [31:0]  da_wdata
);

    wire [1:0] offset = ram_addr[1:0];
    assign da_addr = ram_addr;

    always @(*) begin
        da_wen   = 4'h0;
        da_wdata = ram_wdata;

        case (ram_wop)

            `RAM_WE_B: begin
                da_wen   = 4'b0001 << offset;
                da_wdata = ram_wdata << (offset * 8);
            end

            `RAM_WE_H: begin
                da_wen   = (offset[0] == 1'b0) ? ((offset[1] == 1'b0) ? 4'b0011 : 4'b1100) : 4'h0;
                da_wdata = ram_wdata << (offset[1] * 16);
            end

            `RAM_WE_W:
                if (offset == 2'h0) begin
                    da_wen = ram_wop;   // ram_wop = 4'b1111
                end
            default: begin
                da_wen   = 4'h0;
                da_wdata = ram_wdata;
            end
        endcase
    end

    always @(*) begin
        if (ram_rop != `RAM_EXT_N) begin
            case (ram_rop)

                `RAM_EXT_B, `RAM_EXT_BU:
                    da_ren = 4'hF;

                `RAM_EXT_H, `RAM_EXT_HU:
                    da_ren = (offset[0] == 1'b0) ? 4'hF : 4'h0;

                default:
                    da_ren = (offset == 2'h0) ? 4'hF : 4'h0;
            endcase
        end else
            da_ren = 4'h0;
    end

endmodule
