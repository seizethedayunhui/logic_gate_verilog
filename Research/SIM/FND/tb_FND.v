module tb_FND;
reg [9:0] tb_i_Numx3;
wire [6:0] tb_o_FND0;
wire [6:0] tb_o_FND1;
wire [6:0] tb_o_FND2;

FNDx3 U0(tb_i_Numx3, tb_o_FND0,tb_o_FND1,tb_o_FND2);

initial
begin
  tb_i_Numx3 = 10'b1100111001;
  #10 tb_i_Numx3 = 10'b0101100001;
  #10 tb_i_Numx3 = 10'b1001010111;


end
endmodule
