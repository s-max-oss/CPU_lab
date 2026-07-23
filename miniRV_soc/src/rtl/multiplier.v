`timescale 1ns / 1ps

module multiplier #(
    parameter WIDTH = 32,
    parameter O_WID = 2 * WIDTH
)(
    input  wire                 clk,
    input  wire                 rst,
    input  wire [WIDTH-1:0]     x,
    input  wire [WIDTH-1:0]     y,
    input  wire                 start,
    output reg  [O_WID-1:0]     z,
    output wire                 busy,
    output reg                  done
);

    localparam COUNT_W = WIDTH <= 2 ? 1 : $clog2(WIDTH);

    reg [O_WID-1:0]     multiplicand;
    reg [WIDTH-1:0]     multiplier_r;
    reg [O_WID-1:0]     accumulator;
    reg [COUNT_W-1:0]   count;
    reg                 result_negative;
    reg                 busy_r;

    wire [WIDTH-1:0]    x_magnitude = x[WIDTH-1] ? (~x + {{WIDTH-1{1'b0}}, 1'b1}) : x;
    wire [WIDTH-1:0]    y_magnitude = y[WIDTH-1] ? (~y + {{WIDTH-1{1'b0}}, 1'b1}) : y;
    wire [O_WID-1:0]    accumulator_next = accumulator
                            + (multiplier_r[0] ? multiplicand : {O_WID{1'b0}});

    assign busy = busy_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            z               <= {O_WID{1'b0}};
            multiplicand    <= {O_WID{1'b0}};
            multiplier_r    <= {WIDTH{1'b0}};
            accumulator     <= {O_WID{1'b0}};
            count           <= {COUNT_W{1'b0}};
            result_negative <= 1'b0;
            busy_r          <= 1'b0;
            done            <= 1'b0;
        end else begin
            done <= 1'b0;
            if (start && !busy_r && !done) begin
                multiplicand    <= {{WIDTH{1'b0}}, x_magnitude};
                multiplier_r    <= y_magnitude;
                accumulator     <= {O_WID{1'b0}};
                count           <= {COUNT_W{1'b0}};
                result_negative <= x[WIDTH-1] ^ y[WIDTH-1];
                busy_r          <= 1'b1;
            end else if (busy_r) begin
                if (count == WIDTH - 1) begin
                    z <= result_negative
                        ? (~accumulator_next + {{O_WID-1{1'b0}}, 1'b1})
                        : accumulator_next;
                    busy_r <= 1'b0;
                    done   <= 1'b1;
                end else begin
                    accumulator  <= accumulator_next;
                    multiplicand <= multiplicand << 1;
                    multiplier_r <= multiplier_r >> 1;
                    count        <= count + 1'b1;
                end
            end
        end
    end

endmodule
