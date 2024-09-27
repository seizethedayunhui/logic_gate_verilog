module FA(i_A,i_B,i_C,o_S,o_C);
  
input i_A, i_B;
input i_C;
output o_S;
output o_C;
wire HA0_o_s, HA0_o_c;
wire HA1_o_s, HA1_o_c;

HA HA0(i_A,i_B,HA0_o_s,HA0_o_c);
HA HA1(HA0_o_s,i_C,HA1_o_s,HA1_o_c);

assign o_S = HA1_o_s,
       o_C = HA0_o_c|HA1_o_c;

endmodule

