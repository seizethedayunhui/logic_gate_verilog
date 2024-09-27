module FNDx3(i_Numx3, o_FND0,o_FND1,o_FND2);
  input wire [9:0]i_Numx3;
  output wire [6:0]o_FND0;
  output wire [6:0]o_FND1;
  output wire [6:0]o_FND2;
  wire [3:0]input_Num3;
  
assign input_Num3 ={2'b0,i_Numx3[9:8]};
  
  
FND FND0(i_Numx3[3:0],o_FND0);
FND FND1(i_Numx3[7:4],o_FND1);
FND FND2(input_Num3,o_FND2);

endmodule
  


