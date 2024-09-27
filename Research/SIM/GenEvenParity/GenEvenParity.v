module GenEvenParity(i_Data, o_Data, o_Parity);
input [7:0] i_Data;
output [7:0] o_Data;
output o_Parity;
assign o_Data = i_Data;
assign o_Parity = ^i_Data;
endmodule
