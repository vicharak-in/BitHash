`timescale 1ns / 1ps
module SHA_256_2(
    input          clk,
    input          en,
    input [511:0]  PADDING_VALUE, 
    output [255:0] HASH_VALUE
);
wire [31:0] W[0:63];

w_rom_2 w1(
    .clk         (clk),
    .en            (en),
    .PADDING_VALUE (PADDING_VALUE),
    .W(W)
);

hash_value_2 h1(
    .clk(clk),
    .en(en),
    .W(W),
    .HASH_VALUE(HASH_VALUE)
);

endmodule
