module tb_logic_test;
reg [3:0]LT_i_0;
reg [3:0]LT_i_1;
wire [3:0] LT_o_AND;
wire [3:0] LT_o_OR;
wire [3:0] LT_o_NOT;
wire [3:0] LT_o_XOR;
logic_test U0(LT_i_0, LT_i_1, LT_o_AND, LT_o_OR, 
LT_o_NOT, LT_o_XOR);
initial
begin
LT_i_0 = 4'b0000; LT_i_1 = 4'b0001;
#10 LT_i_0 = 4'b1111; LT_i_1 = 4'b1000;
#10 LT_i_0 = 4'b0101; LT_i_1 = 4'b0010;
#10 LT_i_0 = 4'b1110; LT_i_1 = 4'b1100;
#10 LT_i_0 = 4'b0010; LT_i_1 = 4'b1001;
#10 LT_i_0 = 4'b0011; LT_i_1 = 4'b1100;
#10 LT_i_0 = 4'b1110; LT_i_1 = 4'b0001;
#10 LT_i_0 = 4'b0000; LT_i_1 = 4'b1011;
#10 LT_i_0 = 4'b1100; LT_i_1 = 4'b0010;
#10 LT_i_0 = 4'b1011; LT_i_1 = 4'b0010;
end
endmodule