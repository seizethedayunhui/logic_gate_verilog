module	PC1(i_Data, o_Data);
input			[63:0]	i_Data;
output	wire	[55:0]	o_Data;


assign o_Data = {	i_Data[ 7], i_Data[15], i_Data[23], i_Data[31], i_Data[39], i_Data[47], i_Data[55], 
					i_Data[63], i_Data[ 6], i_Data[14], i_Data[22], i_Data[30], i_Data[38], i_Data[46], 
					i_Data[54], i_Data[62], i_Data[ 5], i_Data[13], i_Data[21], i_Data[29], i_Data[37], 
					i_Data[45], i_Data[53], i_Data[61], i_Data[ 4], i_Data[12], i_Data[20], i_Data[28],
					i_Data[ 1], i_Data[ 9], i_Data[17], i_Data[25], i_Data[33], i_Data[41], i_Data[49], 
					i_Data[57], i_Data[ 2], i_Data[10], i_Data[18], i_Data[26], i_Data[34], i_Data[42], 
					i_Data[50], i_Data[58], i_Data[ 3], i_Data[11], i_Data[19], i_Data[27], i_Data[35], 
					i_Data[43], i_Data[51], i_Data[59], i_Data[36], i_Data[44], i_Data[52], i_Data[60]};
endmodule


