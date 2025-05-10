`timescale 1ns / 1ps
module comperator(
    input              clk,
    input              en,
    input [255:0]      target,
    input [255:0]      hash,
    output reg [255:0] hash_accepted = 256'b0,
    output reg         done = 1'b0,
    output reg         end_nonce = 1'b0
);
reg [2:0] count = 2'b0;
always @ (posedge clk) begin
    if (en) begin   
        if (count < 7) begin
            count = count + 1;
            done = 1'b0;
        end
        if (count == 7) begin
            done = 1'b1;
            if(hash < target) begin
                end_nonce <= 1'b1;
                hash_accepted <= hash;
            end else begin
                end_nonce <= 1'b0;
                hash_accepted <= 256'b0;
            end
            count <= 0;
        end
    end else begin
        end_nonce <= 1'b0;
        count <= 3'b0;
        done <= 1'b0;
    end
end
endmodule