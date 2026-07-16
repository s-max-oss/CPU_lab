`timescale 1ns / 1ps

module divider #(
    parameter WIDTH = 32
)(
    input  wire       clk,
    input  wire       rst,
    input  wire [WIDTH-1:0] x,
    input  wire [WIDTH-1:0] y,
    input  wire       start,
    output reg  [WIDTH-1:0] z,
    output reg  [WIDTH-1:0] r,
    output reg        busy
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            z    <= 0;
            r    <= 0;
            busy <= 1'b0;
        end else if (start) begin
            busy <= 1'b1;
            if (y != 0) begin
                z <= x / y;
                r <= x % y;
            end else begin
                z <= -1;
                r <= x;
            end
            busy <= 1'b0;
        end else begin
            busy <= 1'b0;
        end
    end

endmodule
