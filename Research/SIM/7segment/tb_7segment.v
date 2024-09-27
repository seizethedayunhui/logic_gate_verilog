module tb_7segment;
reg [3:0] tb_i_FND;
reg [3:0] tb_o_FND;

7segment U0(tb_i_FND, tb_o_FND);
initial
Begin
  tb_i_FND =0;
  #10 tb_i_FND = tb_i_FND+1;
  #10 tb_i_FND = tb_i_FND+1;

endmodule
