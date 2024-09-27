module logic_test(i_0, i_1, o_AND, o_OR, o_NOT, o_XOR);
input [3:0] i_0;
input [3:0] i_1;
output [3:0] o_AND;
output [3:0] o_OR;
output [3:0] o_NOT;
output [3:0] o_XOR;
assign o_AND = i_0 && i_1;
assign o_OR = i_0 || i_1;
assign o_NOT = !i_0;
assign o_XOR = i_0 ^ i_1;
endmodule
