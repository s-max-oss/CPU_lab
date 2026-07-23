`timescale 1ns / 1ps

module divider #(
    parameter WIDTH = 32
)(
    input  wire                 clk,
    input  wire                 rst,
    input  wire [WIDTH-1:0]     x,
    input  wire [WIDTH-1:0]     y,
    input  wire                 start,
    output reg  [WIDTH-1:0]     z,
    output reg  [WIDTH-1:0]     r,
    output reg                  busy
);

    localparam COUNT_W = WIDTH <= 2 ? 1 : $clog2(WIDTH);

    reg [WIDTH-1:0] divisor_r;
    reg [WIDTH-1:0] quotient_r;
    reg [WIDTH:0]   remainder_r;
    reg [COUNT_W-1:0] count;
    reg             quotient_negative;
    reg             remainder_negative;
    reg             special_pending;

    wire [WIDTH-1:0] x_magnitude = x[WIDTH-1] ? (~x + {{WIDTH-1{1'b0}}, 1'b1}) : x;
    wire [WIDTH-1:0] y_magnitude = y[WIDTH-1] ? (~y + {{WIDTH-1{1'b0}}, 1'b1}) : y;
    wire [WIDTH:0]   remainder_shift = {remainder_r[WIDTH-1:0], quotient_r[WIDTH-1]};
    wire             can_subtract = remainder_shift >= {1'b0, divisor_r};
    wire [WIDTH:0]   remainder_next = can_subtract
                        ? remainder_shift - {1'b0, divisor_r}
                        : remainder_shift;
    wire [WIDTH-1:0] quotient_next = {quotient_r[WIDTH-2:0], can_subtract};
    wire             signed_overflow = x == {1'b1, {WIDTH-1{1'b0}}}
                        && y == {WIDTH{1'b1}};

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            z                  <= {WIDTH{1'b0}};
            r                  <= {WIDTH{1'b0}};
            divisor_r          <= {WIDTH{1'b0}};
            quotient_r         <= {WIDTH{1'b0}};
            remainder_r        <= {(WIDTH+1){1'b0}};
            count              <= {COUNT_W{1'b0}};
            quotient_negative  <= 1'b0;
            remainder_negative <= 1'b0;
            special_pending    <= 1'b0;
            busy               <= 1'b0;
        end else if (start && !busy) begin
            busy <= 1'b1;
            count <= {COUNT_W{1'b0}};

            if (y == {WIDTH{1'b0}}) begin

                z <= {WIDTH{1'b1}};
                r <= x;
                special_pending <= 1'b1;
            end else if (signed_overflow) begin

                z <= x;
                r <= {WIDTH{1'b0}};
                special_pending <= 1'b1;
            end else begin
                divisor_r          <= y_magnitude;
                quotient_r         <= x_magnitude;
                remainder_r        <= {(WIDTH+1){1'b0}};
                quotient_negative  <= x[WIDTH-1] ^ y[WIDTH-1];
                remainder_negative <= x[WIDTH-1];
                special_pending    <= 1'b0;
            end
        end else if (busy) begin
            if (special_pending) begin
                special_pending <= 1'b0;
                busy <= 1'b0;
            end else if (count == WIDTH - 1) begin
                z <= quotient_negative
                    ? (~quotient_next + {{WIDTH-1{1'b0}}, 1'b1})
                    : quotient_next;
                r <= remainder_negative
                    ? (~remainder_next[WIDTH-1:0] + {{WIDTH-1{1'b0}}, 1'b1})
                    : remainder_next[WIDTH-1:0];
                busy <= 1'b0;
            end else begin
                quotient_r  <= quotient_next;
                remainder_r <= remainder_next;
                count       <= count + 1'b1;
            end
        end
    end

endmodule
