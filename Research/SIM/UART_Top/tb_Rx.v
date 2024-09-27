`timescale 1 ns / 1 ns
module	tb_Rx();

parameter	BAUD	= 115200;
parameter	TIME_PER_BIT	= 1000_000_000 / BAUD;

reg	Clk;
reg	Rst;

reg				Rx_i;			// uart rxd signal
wire			Rx_o_fDone;		// when there is received data
wire	[7:0]	Rx_o_Data;		// received byte 
reg		[7:0]	RxData;

UART_RX RX0(Clk, Rst, Rx_i, Rx_o_fDone, Rx_o_Data);

always
	#10 Clk = ~Clk;

always@*
	if(Rx_o_fDone)	begin
		$display("Rx Data: %x", Rx_o_Data);
		RxData = Rx_o_Data;
	end

initial
begin
	Clk			= 1;
	Rst			= 0;
	Rx_i		= 1;
	RxData		= 0;

	@(negedge Clk)	Rst = 1;
	TxByte(8'h3c);
	TxByte(8'he5);

	#5000 $stop;
end

task TxByte;
input	[7:0]	i_Data;
begin
	Rx_i = 0;			#TIME_PER_BIT;	
	Rx_i = i_Data[0];   #TIME_PER_BIT;	
	Rx_i = i_Data[1];   #TIME_PER_BIT;	
	Rx_i = i_Data[2];   #TIME_PER_BIT;	
	Rx_i = i_Data[3];   #TIME_PER_BIT;	
	Rx_i = i_Data[4];   #TIME_PER_BIT;	
	Rx_i = i_Data[5];   #TIME_PER_BIT;	
	Rx_i = i_Data[6];   #TIME_PER_BIT;	
	Rx_i = i_Data[7];   #TIME_PER_BIT;	
	Rx_i = 1;           #TIME_PER_BIT;	
end
endtask

endmodule

