`timescale 1ns / 1ps

module digled_wrap (
    input  wire         aclk,
    input  wire         areset,         // high active

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

    output wire [ 7:0]  dig_en,
    output wire [ 7:0]  dig_seg
);

    assign awready = 1'b1;
    assign wready  = 1'b1;
    assign arready = 1'b1;

    reg aw_hs, w_hs;

    reg [15:0] seg_reg;
    always @(posedge aclk or posedge areset) begin
        if (areset) begin
            seg_reg <= 16'h0;
            aw_hs   <= 1'b0;
            w_hs    <= 1'b0;
        end else begin
            if (awvalid && awready) aw_hs <= 1'b1;
            else if (bvalid && bready) aw_hs <= 1'b0;
            if (wvalid && wready) w_hs <= 1'b1;
            else if (bvalid && bready) w_hs <= 1'b0;
            if (awvalid && wvalid) seg_reg <= wdata[15:0];
            else if (aw_hs && w_hs)  seg_reg <= wdata[15:0];  // accept on completed handshake
        end
    end
    assign dig_en  = seg_reg[15:8];
    assign dig_seg = seg_reg[7:0];

    reg bvalid_reg;
    always @(posedge aclk or posedge areset)
        if (areset) bvalid_reg <= 1'b0;
        else if (bvalid && bready) bvalid_reg <= 1'b0;
        else if (aw_hs && w_hs) bvalid_reg <= 1'b1;
    assign bvalid = bvalid_reg;

    reg [31:0] rdata_reg;
    reg        rvalid_reg;
    always @(posedge aclk or posedge areset)
        if (areset) begin
            rvalid_reg <= 1'b0;
            rdata_reg  <= 32'h0;
        end else if (arvalid && !rvalid_reg) begin
            rvalid_reg <= 1'b1;
            rdata_reg  <= {16'h0, seg_reg};
        end else if (rready) begin
            rvalid_reg <= 1'b0;
        end
    assign rdata  = rdata_reg;
    assign rvalid = rvalid_reg;

endmodule
