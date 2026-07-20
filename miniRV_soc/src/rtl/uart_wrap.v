// ============================================================================
// uart_wrap.v — UART 串口外设 (AXI4-Lite Slave)
// ============================================================================
// 地址: 0xFFFF_3000
//   偏移 0x0: STAT (只读)  — [0] rx_valid, [1] tx_ready
//   偏移 0x4: DATA (读=RX, 写=TX)
//
// 波特率: 115200 @ 50MHz, 位周期 = 434 clk
// 帧格式: 1 start + 8 data (LSB first) + 1 stop

`timescale 1ns / 1ps

module uart_wrap #(
    parameter CLK_FREQ  = 50_000_000,
    parameter BAUD      = 115200
) (
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

    // UART pins
    input  wire         rx,
    output wire         tx
);

    localparam BIT_PERIOD = CLK_FREQ / BAUD;   // 434

    assign awready = 1'b1;
    assign wready  = 1'b1;
    assign arready = 1'b1;

    // ========================================================================
    // Write response
    // ========================================================================
    reg bvalid_reg;
    wire wr_active = awvalid && wvalid;
    always @(posedge aclk or posedge areset)
        if (areset) bvalid_reg <= 1'b0;
        else if (wr_active) bvalid_reg <= 1'b1;
        else if (bready) bvalid_reg <= 1'b0;
    assign bvalid = bvalid_reg;

    // ========================================================================
    // TX path
    // ========================================================================
    reg        tx_busy;
    reg  [7:0] tx_shift;
    reg  [3:0] tx_bitcnt;      // 0..10: start+8data+stop
    reg [15:0] tx_timer;

    always @(posedge aclk or posedge areset) begin
        if (areset) begin
            tx_busy   <= 1'b0;
            tx_shift  <= 8'h0;
            tx_bitcnt <= 4'd0;
            tx_timer  <= 16'd0;
        end else begin
            if (wr_active && !tx_busy) begin
                tx_busy   <= 1'b1;
                tx_shift  <= wdata[7:0];
                tx_bitcnt <= 4'd0;
                tx_timer  <= 16'd0;
            end else if (tx_busy) begin
                if (tx_timer == BIT_PERIOD - 1) begin
                    tx_timer  <= 16'd0;
                    tx_bitcnt <= tx_bitcnt + 1;
                    if (tx_bitcnt < 4'd9)
                        tx_shift <= {1'b0, tx_shift[7:1]};  // shift out LSB first
                    if (tx_bitcnt == 4'd10) begin
                        tx_busy <= 1'b0;
                    end
                end else begin
                    tx_timer <= tx_timer + 1;
                end
            end
        end
    end

    // TX output: start=0, stop=1, data bits from shift[0]
    assign tx = tx_busy ? ((tx_bitcnt == 4'd0)  ? 1'b0 :        // start bit
                           (tx_bitcnt == 4'd9)  ? 1'b1 :        // stop bit
                           (tx_bitcnt == 4'd10) ? 1'b1 :        // idle after stop
                           tx_shift[0]) : 1'b1;

    // ========================================================================
    // RX path
    // ========================================================================
    reg [7:0] rx_data;
    reg       rx_valid_flag;
    reg       rx_running;
    reg [3:0] rx_bitcnt;
    reg [15:0] rx_timer;

    // Synchronize rx (avoid metastability)
    reg rx_sync1, rx_sync2;
    always @(posedge aclk) begin
        rx_sync1 <= rx;
        rx_sync2 <= rx_sync1;
    end

    always @(posedge aclk or posedge areset) begin
        if (areset) begin
            rx_data       <= 8'h0;
            rx_valid_flag <= 1'b0;
            rx_running    <= 1'b0;
            rx_bitcnt     <= 4'd0;
            rx_timer      <= 16'd0;
        end else begin
            // Clear rx_valid when data is read
            if (rready && arvalid && rvalid_reg && !araddr[2])
                rx_valid_flag <= 1'b0;

            if (!rx_running) begin
                // Detect start bit (falling edge)
                if (!rx_sync2) begin
                    rx_running <= 1'b1;
                    rx_bitcnt  <= 4'd0;
                    rx_timer   <= 16'd0;
                end
            end else begin
                rx_timer <= rx_timer + 1;
                // Sample at mid-bit
                if (rx_timer == BIT_PERIOD / 2 - 1) begin
                    if (rx_bitcnt == 4'd0) begin
                        // Verify start bit
                        if (rx_sync2) rx_running <= 1'b0;  // false start
                    end else if (rx_bitcnt <= 4'd8) begin
                        // Data bit
                        rx_data <= {rx_sync2, rx_data[7:1]};
                    end else begin
                        // Stop bit
                        rx_running    <= 1'b0;
                        rx_valid_flag <= 1'b1;
                    end
                    rx_bitcnt <= rx_bitcnt + 1;
                end
                // Timeout: go back to idle
                if (rx_timer == BIT_PERIOD - 1) begin
                    if (rx_bitcnt >= 4'd9) rx_running <= 1'b0;
                end
            end
        end
    end

    // ========================================================================
    // Read response
    // ========================================================================
    wire tx_ready = !tx_busy;

    reg [31:0] rdata_reg;
    reg        rvalid_reg;
    always @(posedge aclk or posedge areset)
        if (areset) begin
            rvalid_reg <= 1'b0;
            rdata_reg  <= 32'h0;
        end else if (arvalid && !rvalid_reg) begin
            rvalid_reg <= 1'b1;
            // araddr[2] = 0 => STAT, araddr[2] = 1 => DATA (RX)
            if (araddr[2])
                rdata_reg <= {24'h0, rx_data};
            else
                rdata_reg <= {30'h0, tx_ready, rx_valid_flag};
        end else if (rready) begin
            rvalid_reg <= 1'b0;
        end
    assign rdata  = rdata_reg;
    assign rvalid = rvalid_reg;

endmodule
