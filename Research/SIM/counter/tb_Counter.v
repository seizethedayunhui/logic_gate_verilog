`timescale 1 ns / 1ns
module tb_Cnt();
  reg Clk;
  reg Rst;
  reg [1:0] Push;
  wire[3:0] Cnt_o_LED;
Counter U0(Clk, Rst, Push, Cnt_o_LED,);
always
  #10 Clk = ~Clk;
initial
  begin
  Clk = 1;
  Rst = 0; //0? ? ???
  Push = 2'b11;

  @(negedge Clk) Rst = 1; //1? ? ??
  #200 Push = 2'b01; #200 Push = 2'b11;
  #200 Push = 2'b01; #200 Push = 2'b11;
  #200 Push = 2'b01; #200 Push = 2'b11;
  #200 Push = 2'b01; #200 Push = 2'b11;
  #200 Push = 2'b01; #200 Push = 2'b11;
  #200 Push = 2'b01; #200 Push = 2'b11;
  #200 Push = 2'b01; #200 Push = 2'b11;
  #200 Push = 2'b01; #200 Push = 2'b11;
  #200 Push = 2'b01; #200 Push = 2'b11;
  #200 Push = 2'b01; #200 Push = 2'b11;
  #200 Push = 2'b01; #200 Push = 2'b11;
  #200 Push = 2'b01; #200 Push = 2'b11;
  #200 Push = 2'b01; #200 Push = 2'b11;
  #200 Push = 2'b10; #200 Push = 2'b11;
  #200 Push = 2'b10; #200 Push = 2'b11;
  #200 Push = 2'b10; #200 Push = 2'b11;
  #200 Push = 2'b10; #200 Push = 2'b11;
  #200 Push = 2'b10; #200 Push = 2'b11;
  #200 Push = 2'b10; #200 Push = 2'b11;
  #200 Push = 2'b10; #200 Push = 2'b11;
  #200 Push = 2'b10; #200 Push = 2'b11;
  #200 Push = 2'b10; #200 Push = 2'b11;
  #200 Push = 2'b10; #200 Push = 2'b11;
  #200 Push = 2'b10; #200 Push = 2'b11;
end
endmodule
