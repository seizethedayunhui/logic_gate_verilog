module	E_Table(i_Data, o_Data);
input			[31:0]	i_Data;
output	wire	[47:0]	o_Data;

assign o_Data = {	i_Data[0],		i_Data[31:27],
					i_Data[28:23],	i_Data[24:19],
					i_Data[20:15],	i_Data[16:11],
					i_Data[12: 7],	i_Data[ 8: 3],
					i_Data[ 4: 0],	i_Data[31]};
endmodule


