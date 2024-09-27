module AddSub4b(i_A, i_B, i_fSub, o_S, o_C);
input [3:0] i_A, i_B;
input i_fSub;
output wire [3:0] o_S;
output wire o_C;
wire [3:0] cout;

assign o_C= cout[3]^i_fSub;
assign {o_C,o_S}=i_fSub?i_A-i_B:i_A+i_B;
endmodule