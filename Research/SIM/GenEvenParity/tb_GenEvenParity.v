module tb_GenEvenParity;
reg [7:0] LT_i_Data;
wire [7:0] LT_o_Data;
wire LT_o_Parity;
GenEvenParity U0(LT_i_Data, LT_o_Data, LT_o_Parity);

initial
begin
LT_i_Data = 8'b01010101; 
#10 LT_i_Data = 8'b10001100;
#10 LT_i_Data = 8'b00011001; 
#10 LT_i_Data = 8'b11011010; 
#10 LT_i_Data = 8'b01010010;
#10 LT_i_Data = 8'b01000010;  
end
endmodule

