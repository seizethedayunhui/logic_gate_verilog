module Top (Ti_Clk, Ti_Rst, Ti_Col, To_FND, To_Row);
  input Ti_Clk;
  input Ti_Rst;
  input [3:0] Ti_Col;
  output [6:0] To_FND;
  output [3:0] To_Row;
  
  // connection
  wire [3:0] Ko_Num;
  
  Keypad K0(Ti_Clk, Ti_Rst, Ti_Col, To_Row, Ko_Num);
  FND F0(Ko_Num, To_FND);
  
endmodule
