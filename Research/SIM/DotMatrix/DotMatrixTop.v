module DotMatrixTop
(i_Clk, i_Rst, o_DM_Col, o_DM_Row);
input i_Clk; // 50MHz
input i_Rst;
output wire [7:0] o_DM_Col, o_DM_Row;
reg [7:0] c_Cnt, n_Cnt;
reg [63:0] c_Data, n_Data;
wire DM_o_fDone; // 4s

parameter HEART = {
8'b11101111,
8'b11101111,
8'b11101111,
8'b11111111,
8'b11111111,
8'b11111111,
8'b11111111,
8'b11111111};
parameter SMILE = {
8'b11111111,
8'b11101111,
8'b11101111,
8'b11101111,
8'b11111111,
8'b11111111,
8'b11111111,
8'b11111111};
parameter ARROW = {
8'b11111111,
8'b11111111,
8'b11101111,
8'b11101111,
8'b11101111,
8'b11111111,
8'b11111111,
8'b11111111};
parameter  HOME= {
8'b11111111,
8'b11111111,
8'b11111111,
8'b11101111,
8'b11101111,
8'b11101111,
8'b11111111,
8'b11111111};


DotMatrix DM0(i_Clk, i_Rst, c_Data, o_DM_Col, o_DM_Row, DM_o_fDone);
always@(posedge i_Clk, posedge i_Rst)
if(i_Rst) begin
c_Cnt = 0;
c_Data = 0;
end else begin
c_Cnt = n_Cnt;
c_Data = n_Data;
end

always@*
begin
n_Cnt = DM_o_fDone ? c_Cnt + 1 : c_Cnt;
case(c_Cnt[7:6])
2'h0 : n_Data = HEART;
2'h1 : n_Data = SMILE;
2'h2 : n_Data = ARROW;
default : n_Data = HOME;
endcase
end
endmodule


