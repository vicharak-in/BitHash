`timescale 1ns / 1ps
module w_rom_2(
    input            clk,
    input            en,
    input [511:0]    PADDING_VALUE,
    output reg[31:0] W[0:63]
);

    always @(posedge clk) begin
        if (en) begin
            W[15] = PADDING_VALUE[31:0];
            W[14] = PADDING_VALUE[63:32];
            W[13] = PADDING_VALUE[95:64];
            W[12] = PADDING_VALUE[127:96];
            W[11] = PADDING_VALUE[159:128];
            W[10] = PADDING_VALUE[191:160];
            W[9] = PADDING_VALUE[223:192];
            W[8] = PADDING_VALUE[255:224];
            W[7] = PADDING_VALUE[287:256];
            W[6] = PADDING_VALUE[319:288];
            W[5] = PADDING_VALUE[351:320];
            W[4] = PADDING_VALUE[383:352];
            W[3] = PADDING_VALUE[415:384];
            W[2] = PADDING_VALUE[447:416];
            W[1] = PADDING_VALUE[479:448];
            W[0] = PADDING_VALUE[511:480];
                
            for (int i = 16; i < 64; i = i + 1) begin
                W[i] = s1(W[i - 2]) + W[i - 7] + s0(W[i - 15]) + W[i - 16];
            end
        end
    end
    function [31:0] s0 (input [31:0] x1);
            reg [31:0] temp10, temp11, temp12; 
            begin
                temp10 = (x1 >> 7) | (x1 << (32 - 7));
                temp11 = (x1 >> 18) | (x1 << (32 - 18));
                temp12 = x1 >> 3;
                s0 = temp10 ^ temp11 ^ temp12;
            end
    endfunction
    function [31:0] s1 (input [31:0] x2);
            reg [31:0] temp7, temp8, temp9; 
            begin
                temp7 = (x2 >> 17) | (x2 << (32 - 17));
                temp8 = (x2 >> 19) | (x2 << (32 - 19));
                temp9 = x2 >> 10;
                s1 = temp7 ^ temp8 ^ temp9;
            end
    endfunction
endmodule
