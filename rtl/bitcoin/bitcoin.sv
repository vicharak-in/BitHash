module bitcoin(
    input                clk,
    input [DATAIN-1:0]   datain,
    input                empty,
    output               wren,
    output reg           rden,
    output [DATAOUT-1:0] dataout
);

parameter DATAIN = 48;
parameter DATAOUT = 48;

logic [95:0] data;
logic [255:0] midstate;
logic [255:0] target;
logic en;
logic [255:0] hash;
logic [31:0] nonce_accepted;
logic end_nonce;

always @(posedge clk) begin
    if (empty == 0) rden <= 1;
    else if (empty==1) rden <= 0;
end

collector uc (
    .clk       (clk),
    .datain    (datain),
    .data_hash (data),
    .midstate  (midstate),
    .target    (target),
    .en        (en)
);          

top_1 um (
    .clk            (clk),
    .en             (en),
    .data           (data),
    .midstate       (midstate),
    .target         (target),
    .hash           (hash),
    .nonce_accepted (nonce_accepted),
    .end_nonce_1    (end_nonce)
);

dout ud (
    .clk       (clk),
    .hash      (hash),
    .nonce     (nonce_accepted),
    .end_nonce (end_nonce),
    .dataout   (dataout),
    .wren      (wren)
);
endmodule
