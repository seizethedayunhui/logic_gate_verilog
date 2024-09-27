module	P_Table(i_Data, o_Data);
input			[31:0]	i_Data;
output	wire	[31:0]	o_Data;

assign o_Data = {	i_Data[16], i_Data[25], i_Data[12], i_Data[11], 
					i_Data[ 3], i_Data[20], i_Data[ 4], i_Data[15], 
					i_Data[31], i_Data[17], i_Data[ 9], i_Data[ 6],
					i_Data[27], i_Data[14], i_Data[ 1], i_Data[22], 
					i_Data[30], i_Data[24], i_Data[ 8], i_Data[18], 
					i_Data[ 0], i_Data[ 5], i_Data[29], i_Data[23], 
					i_Data[13], i_Data[19], i_Data[ 2], i_Data[26], 
					i_Data[10], i_Data[21], i_Data[28], i_Data[ 7]};
endmodule


