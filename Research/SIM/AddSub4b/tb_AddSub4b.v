module tb_AddSub4b;
reg [3:0]AddSub_i_A;
reg [3:0]AddSub_i_B;
reg      AddSub_i_fSub;
wire[3:0] AddSub_o_S;
wire AddSub_o_C;
wire[4:0]AddSub_o;
assign AddSub_o = {AddSub_o_C,AddSub_o_S};

AddSub4b U0(AddSub_i_A,AddSub_i_B,AddSub_i_fSub,AddSub_o_S,AddSub_o_C);

initial
begin
  
  AddSub_i_fSub=1;
  AddSub_i_A=4'b1010;AddSub_i_B=4'b1100;
  #10 AddSub_i_A=5; AddSub_i_B=7;
  #10 AddSub_i_A=9; AddSub_i_B=8;
  
end
endmodule

