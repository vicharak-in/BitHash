`timescale 1ns / 1ps
module hash_value_1(
    input              clk,
    input              en,
    input [31:0]       W[0:63],
    input [255:0]      midstate,
    output reg [255:0] HASH_VALUE = 256'b0
);

    reg [31:0] H[7:0];
    reg [31:0] K[63:0];
    reg [31:0] a = 32'b0;
    reg [31:0] b = 32'b0;
    reg [31:0] c = 32'b0;
    reg [31:0] d = 32'b0;
    reg [31:0] e = 32'b0;
    reg [31:0] f = 32'b0;
    reg [31:0] g = 32'b0;
    reg [31:0] h = 32'b0;
    reg [31:0] T1[63:0];
    reg [31:0] T2[63:0];
    reg [31:0] X[7:0];
    
    initial begin
        K[0] = 32'h428a2f98;
        K[1] = 32'h71374491;
        K[2] = 32'hb5c0fbcf;
        K[3] = 32'he9b5dba5;
        K[4] = 32'h3956c25b;
        K[5] = 32'h59f111f1;
        K[6] = 32'h923f82a4;
        K[7] = 32'hab1c5ed5;
        K[8] = 32'hd807aa98;
        K[9] = 32'h12835b01;
        K[10] = 32'h243185be;
        K[11] = 32'h550c7dc3;
        K[12] = 32'h72be5d74;
        K[13] = 32'h80deb1fe;
        K[14] = 32'h9bdc06a7;
        K[15] = 32'hc19bf174;
        K[16] = 32'he49b69c1;
        K[17] = 32'hefbe4786;
        K[18] = 32'h0fc19dc6;
        K[19] = 32'h240ca1cc;
        K[20] = 32'h2de92c6f;
        K[21] = 32'h4a7484aa;
        K[22] = 32'h5cb0a9dc;
        K[23] = 32'h76f988da;
        K[24] = 32'h983e5152;
        K[25] = 32'ha831c66d;
        K[26] = 32'hb00327c8;
        K[27] = 32'hbf597fc7;
        K[28] = 32'hc6e00bf3;
        K[29] = 32'hd5a79147;
        K[30] = 32'h06ca6351;
        K[31] = 32'h14292967;
        K[32] = 32'h27b70a85;
        K[33] = 32'h2e1b2138;
        K[34] = 32'h4d2c6dfc;
        K[35] = 32'h53380d13;
        K[36] = 32'h650a7354;
        K[37] = 32'h766a0abb;
        K[38] = 32'h81c2c92e;
        K[39] = 32'h92722c85;
        K[40] = 32'ha2bfe8a1;
        K[41] = 32'ha81a664b;
        K[42] = 32'hc24b8b70;
        K[43] = 32'hc76c51a3;
        K[44] = 32'hd192e819;
        K[45] = 32'hd6990624;
        K[46] = 32'hf40e3585;
        K[47] = 32'h106aa070;
        K[48] = 32'h19a4c116;
        K[49] = 32'h1e376c08;
        K[50] = 32'h2748774c;
        K[51] = 32'h34b0bcb5;
        K[52] = 32'h391c0cb3;
        K[53] = 32'h4ed8aa4a;
        K[54] = 32'h5b9cca4f;
        K[55] = 32'h682e6ff3;
        K[56] = 32'h748f82ee;
        K[57] = 32'h78a5636f;
        K[58] = 32'h84c87814;
        K[59] = 32'h8cc70208;
        K[60] = 32'h90befffa;
        K[61] = 32'ha4506ceb;
        K[62] = 32'hbef9a3f7;
        K[63] = 32'hc67178f2;
    end
    
    always @(posedge clk)
        if (en) begin
            a = midstate[255:224];
            b = midstate[223:192];
            c = midstate[191:160];
            d = midstate[159:128];
            e = midstate[127:96];
            f = midstate[95:64];
            g = midstate[63:32];
            h = midstate[31:0]; 
            for (int round = 0; round < 64; round = round + 1) begin
                T1[round] = h + S1(e) + ch(e,f,g) + K[round] + W[round];
                T2[round] = S0(a) + maj(a,b,c);
                h = g;
                g = f;
                f = e;
                e = T1[round] + d;
                d = c;
                c = b;
                b = a;
                a = T1[round] + T2[round];
            end
            X[0] = midstate[255:224] + a;
            X[1] = midstate[223:192] + b;
            X[2] = midstate[191:160] + c;
            X[3] = midstate[159:128] + d;
            X[4] = midstate[127:96] + e;
            X[5] = midstate[95:64] + f;
            X[6] = midstate[63:32] + g;
            X[7] = midstate[31:0] + h;
                
            HASH_VALUE = {X[0], X[1], X[2], X[3], X[4], X[5], X[6], X[7]};
        end 
        
    function [31:0] S0 (input [31:0] x1);
        reg [31:0] temp4, temp5, temp6; 
        begin
            temp4 = (x1 >> 2) | (x1 << (32 - 2));
            temp5 = (x1 >> 13) | (x1 << (32 - 13));
            temp6 = (x1 >> 22) | (x1 << (32 - 22));
            S0 = temp4 ^ temp5 ^ temp6;
        end
    endfunction
    function [31:0] S1 (input [31:0] x2);
        reg [31:0] temp1, temp2, temp3; 
        begin
            temp1 = (x2 >> 6) | (x2 << (32 - 6));
            temp2 = (x2 >> 11) | (x2 << (32 - 11));
            temp3 = (x2 >> 25) | (x2 << (32 - 25));
            S1 = temp1 ^ temp2 ^ temp3;
        end
    endfunction
    function [31:0] maj (input [31:0] x3, input [31:0] y3, input [31:0] z3);
        maj = (x3 & y3) ^ (x3 & z3) ^ (y3 & z3);
    endfunction
    function [31:0] ch (input [31:0] x4, input [31:0] y4, input [31:0] z4);
        ch = (x4 & y4) ^ (~x4 & z4);
    endfunction
endmodule
