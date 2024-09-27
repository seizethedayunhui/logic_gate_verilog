
module tb_Keypad;
  reg Clk;
  reg Rst;
  reg [3:0] KP_i_Col, Num;
  wire [3:0] KP_o_Row, KP_o_Num;
  
  //module Top (Top_i_Clk, Top_i_Rst, Top_i_Col, Top_o_FND, Top_o_Row);
  //Top T0(Clk, Rst, KP_i_Col,KP_o_Num, KP_o_Row);
  Keypad KP0(Clk, Rst, KP_i_Col, KP_o_Row, KP_o_Num);
  
  /* 50 MHz clock */
  always
    #10 Clk = ~Clk;
  
  always@*
    begin
      KP_i_Col = 4'b1111;
      KP_i_Col[Num[1:0]] = KP_o_Row[Num[3:2]];
    end

  initial
  begin
    Clk = 1;
    Rst = 0;
    KP_i_Col = 4'b1111;
   @(negedge Clk) Rst = 1;
    PushNum(0);
    PushNum(1);
    PushNum(2);
    PushNum(3);
    PushNum(4);
    PushNum(5);
    PushNum(6);
    PushNum(7);
    PushNum(8);
    PushNum(9);
    PushNum(10);
    PushNum(11);
    PushNum(12);
    PushNum(13);
    PushNum(14);
    PushNum(15);
    
    $stop;
  end

  task PushNum;
  input [3:0] i_Num;
  begin
    Num = i_Num; #1000000;
    KP_i_Col = 4'b1111; #100;
  end
  endtask
  
endmodule
