`timescale 1ns / 1ps
module nonce_gen(
    input              clk,
    input              en,
    input [95:0]       data,
    input              done,
    input              end_nonce,
    output reg [31:0]  nonce_accepted = 32'b0,
    output reg [511:0] padding_value = 511'b0
    );

parameter IDLE = 2'b00;
parameter GEN = 2'b01;
parameter END_N = 2'b10;
reg [31:0] nonce = 32'b0;
reg [31:0] count = 32'b0;
reg [1:0] state = 2'b00;

always @ (posedge clk) begin
    case (state)
        IDLE:begin
            count = 0;
            nonce = 0;
            padding_value = 512'b0;
            nonce_accepted = 32'b0;
            if(en && !end_nonce) begin
                state = GEN;
            end
            else if (en && end_nonce) begin
                state = END_N;
            end
            else if(!en) begin
                state = IDLE;
            end
        end
        
        GEN:begin
            nonce = count;
            padding_value = {data,nonce,384'h800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000280};
            if(en && !end_nonce) begin
                if(done) begin
                    count = count+1;
                end
                else begin
                    count = count; 
                end
                state = GEN;
            end
            else if (en && end_nonce) begin
                state = END_N;
            end
            else if(!en) begin
                state = IDLE;
            end
        end
        
        END_N:begin
            nonce_accepted <= nonce ;
            if(en && !end_nonce) begin
                state = GEN;
            end
            else if (en && end_nonce) begin
                state = END_N;
            end
            else if(!en) begin
                state = IDLE;
            end
        end
        default:begin
            state <= IDLE;
        end
    endcase
end
endmodule
