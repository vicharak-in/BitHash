`timescale 1ns / 1ps
module pad_1(
    input [255:0]      hash,
    output reg [511:0] pad_value = 512'b0
);
always @ (*) begin
    pad_value <= {hash, 1'b1, 246'b0, 9'b100000000};
end
endmodule