module dout (
    input                    clk,
    input [HASH-1:0]         hash,
    input [NONCE-1:0]        nonce,
    input                    end_nonce,
    output reg [DATAOUT-1:0] dataout,
    output reg               wren
);

parameter HASH = 256;
parameter NONCE = 32;
parameter DATAOUT = 48;

reg [4:0] count = 0;

always @(posedge clk) begin
    if (end_nonce) begin
        if (count == 0) begin
            wren <= 1;
            dataout <= {1'b0, 3'b001, 4'b0001, hash[255:216]};
            count <= count + 1;
        end else if (count == 1) begin
            wren <= 1;
            dataout <= {1'b0, 3'b001, 4'b0010, hash[215:176]};
            count <= count + 1;
        end else if (count == 2) begin
            wren <= 1;
            dataout <= {1'b0, 3'b001, 4'b0011, hash[175:136]};
            count <= count + 1;
        end else if (count == 3) begin
            wren <= 1;
            dataout <= {1'b0, 3'b001, 4'b0100, hash[135:96]};
            count <= count + 1;
        end else if (count == 4) begin
            wren <= 1;
            dataout <= {1'b0, 3'b001, 4'b0101, hash[95:56]};
            count <= count + 1;
        end else if (count == 5) begin
            wren <= 1;
            dataout <= {1'b0, 3'b001, 4'b0110, hash[55:16]};
            count <= count + 1;
        end else if (count == 6) begin
            wren <= 1;
            dataout <= {1'b0, 3'b001, 4'b0111, hash[15:0], 24'b0};
            count <= count + 1;
        end else if (count == 7) begin
            wren <= 1;
            dataout <= {1'b0, 3'b010, 4'b0001, nonce[31:0], 8'b0};
            count <= count + 1;
        end else if (count > 7) begin
            wren <= 0;
        end
    end else begin
        wren <= 0;
        count <= 0;
    end
end
endmodule