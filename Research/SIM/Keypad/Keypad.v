module Keypad(i_Clk, i_Rst, i_Col, o_Row, o_Num);
	
  input i_Clk;
  input i_Rst;
  input [3:0] i_Col;
  output wire [3:0] o_Row;
  output wire [3:0] o_Num;
  
  reg [3:0] c_Num, n_Num;
  reg [2:0] c_State, n_State;
  reg [3:0] c_Cnt, n_Cnt;
  
  parameter IDLE = 3'b000, 
            PUSH = 3'001, 
            ROW32 = 3'b010,
            ROW31 = 3'b011,
            ROW_A = 3'b100,
            UNPUSH = 3'b101;
            
  wire fPushed, fPushed32, fPushed31, fLstCnt, fIncCnt, fNext;
  wire [2:0] fCheck;
  
  always@(posedge i_Clk, negedge i_Rst) begin
    if(!i_Rst) begin
      c_State = IDLE;
      c_Num = 0;
      c_Cnt = 0;
    end 
    else begin
      c_State = n_State;
      c_Num = n_Num;
      c_Cnt = n_Cnt;
    end
  end
  
  // assign
  assign  fPushed = ~&i_Col,
          fPushed32 = i_Col[3] == 0 || i_Col[2] == 0,
          fPushed31 = i_Col[3] == 0 || i_Col[1] == 0,
          fLstCnt = &c_Cnt,
          fIncCnt = c_State == PUSH || c_State == ROW32 || c_State == ROW31 || c_State == ROW_A,
          fCheck = c_Cnt[1:0],
          fNext = &c_Cnt[1:0];
  assign o_Num = c_Num;
  assign  o_Row[3] = 0,
          o_Row[2] = c_State == ROW31,
          o_Row[1] = c_State == ROW32,
          o_Row[0] = c_State == ROW32 || c_State == ROW31;
  
  always@*
  begin
    n_State = c_State;
    n_Cnt = fIncCnt ? c_Cnt + 1 : 0;
    n_Num[3] = fCheck && c_State == ROW32 ? fPushed : c_Num[3];
    n_Num[2] = fCheck && c_State == ROW31 ? fPushed : c_Num[2];
    n_Num[1] = fCheck && c_State == ROW_A ? fPushed32 : c_Num[1];
    n_Num[0] = fCheck && c_State == ROW_A ? fPushed31 : c_Num[0];
    
    case(c_State)
      IDLE: begin
        n_Cnt = 0;
        if(fPushed) n_State = PUSH;
        end
      PUSH: begin
        if(fLstCnt) n_State = ROW32;
        else if (!fPushed) n_State = IDLE;
      end
      ROW32:begin
        if(fNext) n_State = ROW31;
      end
      ROW31:begin
        if(fNext) n_State = ROW_A;
      end
      ROW_A:begin
        if(fNext) n_State = UNPUSH;
      end
      UNPUSH:begin
        n_State = IDLE;
      end
      default: n_State=IDLE;
    endcase
  end
	
endmodule
