`timescale 1 ns / 1 ns
module	tb_Rx_Top();

parameter	BAUD	= 115200;
parameter	TIME_PER_BIT	= 1000_000_000 / BAUD;

reg	Clk;
reg	Rst;

reg				Top_i_Rx;		// uart rxd signal

Rx_Top RX0(Clk, Rst, Top_i_Rx,	,);

always
	#10 Clk = ~Clk;

initial
begin
	Clk			= 1;
	Rst			= 0;
	Top_i_Rx	= 1;

	@(negedge Clk)	Rst = 1;
	TxByte(8'h3c);
	TxByte(8'he5);

	#5000 $stop;
end

task TxByte;
input	[7:0]	i_Data;
begin
	Top_i_Rx = 0;			#TIME_PER_BIT;	
	Top_i_Rx = i_Data[0];   #TIME_PER_BIT;	
	Top_i_Rx = i_Data[1];   #TIME_PER_BIT;	
	Top_i_Rx = i_Data[2];   #TIME_PER_BIT;	
	Top_i_Rx = i_Data[3];   #TIME_PER_BIT;	
	Top_i_Rx = i_Data[4];   #TIME_PER_BIT;	
	Top_i_Rx = i_Data[5];   #TIME_PER_BIT;	
	Top_i_Rx = i_Data[6];   #TIME_PER_BIT;	
	Top_i_Rx = i_Data[7];   #TIME_PER_BIT;	
	Top_i_Rx = 1;           #TIME_PER_BIT;	
end
endtask

endmodule


