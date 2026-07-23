`timescale 1ns / 1ps

module multiplier #(
    parameter WIDTH = 32
)(
    input  wire        clk,
    input  wire        rst,
    input  wire [WIDTH-1:0] x,
    input  wire [WIDTH-1:0] y,
    input  wire        start,
    output reg  [2*WIDTH-1:0] z,
    output wire        busy
);

    assign busy = 1'b0;

    always @(posedge clk or posedge rst) begin
        if (rst)
            z <= 0;
        else if (start)

            z <= {{WIDTH{x[WIDTH-1]}}, x} * {{WIDTH{y[WIDTH-1]}}, y};
    end

endmodule
