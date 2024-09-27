module UART_Top(i_Clk,i_Rst,i_Rx,o_Tx,i_Push,o_FND0,o_FND1);

input i_Clk,i_Rst,i_Rx;
input [3:0] i_Push;

output o_Tx;
output [6:0] o_FND0,o_FND1;

wire [7:0] o_Data;
wire [3:0] fPush;
wire i_fTx,Tx_fReady;
wire [7:0] Tx_i_Data;

reg [3:0]c_Push,n_Push;

assign fPush = ~i_Push&c_Push,
       i_fTx = Tx_fReady & |(fPush),
       Tx_i_Data = fPush[3]? 3: fPush[2] ? 2 : fPush[1] ? 1 : 0;

Rx_Top RxTop0(i_Clk, i_Rst, i_Rx, o_FND0, o_FND1);
UART_TX TX0(i_Clk, i_Rst, i_fTx, Tx_i_Data, , Tx_fReady, o_Tx);

always@(posedge i_Clk,negedge i_Rst)
if(!i_Rst) c_Push = 4'b1111;
else c_Push = n_Push;
  
always@*
  n_Push = i_Push;

endmodule
