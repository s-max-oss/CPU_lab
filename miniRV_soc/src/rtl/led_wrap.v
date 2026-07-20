// ============================================================================
// led_wrap.v — LED 外设 (AXI4-Lite Slave)
// ============================================================================
// 地址: 0xFFFF_1000, 读写 16-bit
// 写入 wdata[15:0] 控制 LED, 读取返回当前 LED 状态

`timescale 1ns / 1ps

module led_wrap (
    input  wire         aclk,
    input  wire         areset,         // high active

    // AXI4-Lite Slave
    input  wire [31:0]  awaddr,
    input  wire         awvalid,
    output wire         awready,
    input  wire [31:0]  wdata,
    input  wire [ 3:0]  wstrb,
    input  wire         wvalid,
    output wire         wready,
    output wire         bvalid,
    input  wire         bready,
    input  wire [31:0]  araddr,
    input  wire         arvalid,
    output wire         arready,
    output wire [31:0]  rdata,
    output wire         rvalid,
    input  wire         rready,

    // FPGA I/O
    output wire [15:0]  led
);

    assign awready = 1'b1;
    assign wready  = 1'b1;
    assign arready = 1'b1;

    // LED register
    reg [15:0] led_reg;
    always @(posedge aclk or posedge areset)
        if (areset) led_reg <= 16'h0;
        else if (awvalid && wvalid) led_reg <= wdata[15:0];
    assign led = led_reg;

    // Write response
    reg bvalid_reg;
    always @(posedge aclk or posedge areset)
        if (areset) bvalid_reg <= 1'b0;
        else if (awvalid && wvalid) bvalid_reg <= 1'b1;
        else if (bready) bvalid_reg <= 1'b0;
    assign bvalid = bvalid_reg;

    // Read response
    reg [31:0] rdata_reg;
    reg        rvalid_reg;
    always @(posedge aclk or posedge areset)
        if (areset) begin
            rvalid_reg <= 1'b0;
            rdata_reg  <= 32'h0;
        end else if (arvalid && !rvalid_reg) begin
            rvalid_reg <= 1'b1;
            rdata_reg  <= {16'h0, led_reg};
        end else if (rready) begin
            rvalid_reg <= 1'b0;
        end
    assign rdata  = rdata_reg;
    assign rvalid = rvalid_reg;

endmodule
