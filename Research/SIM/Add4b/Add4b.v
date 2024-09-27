module Add4b(i_A,i_B,o_S,o_C);
input [3:0]i_A,i_B;
output wire [3:0]o_S;
output wire o_C;
wire [2:0] cout;

assign{o_C,o_S}= i_fSub?a-b:a+b;

endmodule