module RandNum(i_Clk, i_Rst, o_Num);
input					i_Clk, i_Rst;
output	wire	[15:0]	o_Num;

reg		[15:0]	c_LFSR,	n_LFSR;		// Text - left  32 bits

always@(posedge i_Clk or negedge i_Rst)
	if(!i_Rst) begin
		c_LFSR	= 1;
	end else begin	
		c_LFSR	= n_LFSR;
	end	
	
assign	o_Num	= c_LFSR;

always@*
begin
	n_LFSR	= {c_LFSR, c_LFSR[15] ^ c_LFSR[0]};
end

endmodule

