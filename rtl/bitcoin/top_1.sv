`timescale 1ns / 1ps
module top_1(
    input          clk,
    input          en,
    input [95:0]   data,
    input [255:0]  midstate,
    input [255:0]  target,
    output [255:0] hash,
    output [31:0]  nonce_accepted,
    output         end_nonce_1
);
    
logic [511:0] padding_value_1 = 512'b0;
logic [255:0] hash_value_1 = 256'b0;
logic [511:0] padding_value_2 = 512'b0;
logic [255:0] hash_value_2 = 256'b0;
logic end_nonce = 1'b0;
logic done = 1'b0;

assign end_nonce_1 = end_nonce;

nonce_gen ung(
    .clk            (clk),          
    .en             (en),           
    .data           (data),         
    .done           (done),         
    .end_nonce      (end_nonce),    
    .nonce_accepted (nonce_accepted),
    .padding_value  (padding_value_1)
);

SHA_256_1 usha1(
    .clk           (clk),          
    .en            (en),           
    .PADDING_VALUE (padding_value_1),
    .midstate      (midstate),     
    .HASH_VALUE    (hash_value_1)  
);

pad_1 up(
    .hash      (hash_value_1),     
    .pad_value (padding_value_2)
);

SHA_256_2 usha2(
    .clk           (clk),          
    .en            (en),           
    .PADDING_VALUE (padding_value_2),
    .HASH_VALUE    (hash_value_2)    
);

comperator uc(
    .clk           (clk),
    .en            (en),           
    .target        (target),        
    .hash          (hash_value_2),          
    .hash_accepted (hash),
    .done          (done), 
    .end_nonce     (end_nonce)    
);
endmodule
