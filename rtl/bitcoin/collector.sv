module collector (
    input                          clk,
    input [DATAIN-1:0]             datain,
    output reg [DATA_WID-1:0]      data_hash,
    output reg [HASH_DATA_WID-1:0] midstate,
    output reg [HASH_DATA_WID-1:0] target,
    output reg                     en
);

parameter DATA_WID = 96;
parameter HASH_DATA_WID = 256;
parameter DATAIN = 48;

always @(posedge clk) begin
    
    if(datain[46:44] == 1)begin
        if(datain[43:40] == 1)begin
            data_hash[95:56] <= datain[39:0];
            en <= 0;
        end else if(datain[43:40] == 2) begin
            data_hash[55:16] <= datain[39:0];
            en <= 0;
        end else if(datain[43:40] == 3) begin
            data_hash[15:0] <= datain[39:24];
            en <= 0;
        end
    end
    else if(datain[46:44] == 2)begin
        if(datain[43:40] == 1)begin
            midstate[255:216] <= datain[39:0];
            en <= 0;
        end else if(datain[43:40] == 2) begin
            midstate[215:176] <= datain[39:0];
            en <= 0;
        end else if(datain[43:40] == 3) begin
            midstate[175:136] <= datain[39:0];
            en <= 0;
        end else if(datain[43:40] == 4) begin
            midstate[135:96] <= datain[39:0];
            en <= 0;
        end else if(datain[43:40] == 5) begin
            midstate[95:56] <= datain[39:0];
            en <= 0;
        end else if(datain[43:40] == 6) begin
            midstate[55:16] <= datain[39:0];
            en <= 0;
        end else if(datain[43:40] == 7) begin
            midstate[15:0] <= datain[39:24];
            en <= 0;
        end
    end
    else if(datain[46:44] == 3)begin
        if(datain[43:40] == 1)begin
            target[255:216] <= datain[39:0];
            en <= 0;
        end else if(datain[43:40] == 2) begin
            target[215:176] <= datain[39:0];
            en <= 0;
        end else if(datain[43:40] == 3) begin
            target[175:136] <= datain[39:0];
            en <= 0;
        end else if(datain[43:40] == 4) begin
            target[135:96] <= datain[39:0];
            en <= 0;
        end else if(datain[43:40] == 5) begin
            target[95:56] <= datain[39:0];
            en <= 0;
        end else if(datain[43:40] == 6) begin
            target[55:16] <= datain[39:0];
            en <= 0;
        end else if(datain[43:40] == 7) begin
            target[15:0] <= datain[39:24];
            if (datain[47] == 1) begin
                en <= 1;
            end
        end
    end 
end
endmodule