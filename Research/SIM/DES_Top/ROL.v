module	ROL(i_Data, i_fRight, i_f1bit, o_Data);
input		[27:0]	i_Data;
input		i_fRight;
input		i_f1bit;
output	reg	[27:0]	o_Data;

always@*
	case({i_fRight, i_f1bit})
		2'b00	:	o_Data	 = {i_Data[25:0], i_Data[27:26]};	 // ROL2
		2'b01	:	o_Data	 = {i_Data[26:0], i_Data[27   ]};	 // ROL1
		2'b10	:	o_Data	 = {i_Data[ 1:0], i_Data[27: 2]};	 // ROR2
		default	:	o_Data	 = {i_Data[   0], i_Data[27: 1]};	 // ROR1
	endcase

endmodule


