`timescale 1 ns / 1ns
module tb_DotMatrixTop;
reg i_Clk;
reg i_Rst;
wire [7:0] o_DM_Col;
wire [7:0] o_DM_Row;

DotMatrixTop U0(i_Clk, i_Rst, o_DM_Col, o_DM_Row);

always
   #10 i_Clk = ~i_Clk;
initial
begin
   i_Clk = 1;
   i_Rst = 1;

   @(posedge i_Clk) i_Rst = 0;
   
end
endmodule