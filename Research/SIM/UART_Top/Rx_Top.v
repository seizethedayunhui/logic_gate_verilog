module Rx_Top(i_Clk, i_Rst, i_Rx, o_Rx_Top0, o_Rx_Top1);
  input i_Rx; //UART & Top module input
  input i_Clk;
  input i_Rst;
  output [6:0]o_Rx_Top0; //Top module output
  output [6:0]o_Rx_Top1; //Top module output
  //wire o_Rx_UART_fDone;
  wire [7:0] RxData; // UART module output & FND input
  

UART_RX UART_RX0(i_Clk, i_Rst, i_Rx, o_fDone, RxData);
FND FND0(RxData[7:4],o_Rx_Top0);
FND FND1(RxData[3:0],o_Rx_Top1);

endmodule