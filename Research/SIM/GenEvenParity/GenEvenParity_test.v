module GenEvenParity;
reg LT_i_Data;
wire LT_o_Data;
wire LT_o_Parity;
logic_test U0(LT_i_Data, LT_o_Data, LT_o_Parity);

initial
begin
LT_i_Data = 00110000; 
#10 LT_i_Data = 00110100;
#10 LT_i_Data = 10100001; 
#10 LT_i_Data = 00111100; 
end
endmodule
