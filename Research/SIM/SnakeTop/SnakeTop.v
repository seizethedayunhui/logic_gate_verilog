module SnakeTop(i_Clk, i_Rst, i_Push, i_Start, o_Row, o_Col, o_Score, o_Score1, o_Score2, o_Led);
  input i_Clk, i_Rst, i_Start;
  input [3:0] i_Push;
  output wire [7:0] o_Row, o_Col;
  output wire [6:0] o_Score, o_Score1,o_Score2;
  output [5:0] o_Led;
  
  reg [2:0] n_State, c_State;
  reg [3:0] n_Direc, c_Direc;
  reg [3:0] n_head_row, c_head_row;
  reg [3:0] n_head_col, c_head_col;
  reg [2:0] n_center_row, c_center_row;
  reg [2:0] n_center_col, c_center_col;
  reg [2:0] n_tail_row, c_tail_row;
  reg [2:0] n_tail_col, c_tail_col;
  reg [2:0] n_Score, c_Score;
  reg [63:0] n_Matrix, c_Matrix;
  reg [7:0] n_Cnt, c_Cnt;
  reg [2:0] n_apple_row, c_apple_row; // c_State == GEN_APPLE -> assign
  reg [2:0] n_apple_col, c_apple_col;
  reg [21:0] n_WaitCnt, c_WaitCnt;
  
  wire fUp, fDown, fLeft, fRight;
  wire fStart, fIng;
  wire DM_o_fDone;
  wire [15:0] RN_o_Num;
  wire fEat, fValid, fDead;
  wire fDMCnt;

  
  integer i;
  
  parameter IDLE = 3'b000,
            DIS_START = 3'b001,
            GEN_APPLE = 3'b010,
            CHECK_APPLE = 3'b011,
            DIS_MOVE = 3'b100,
            WAIT = 3'b101,
            DIS_END = 3'b110;
            
            
  parameter CLEAR =  {
                      8'b11111111,
                      8'b11111111,
                      8'b11111111,
                      8'b11111111,
                      8'b11111111,
                      8'b11111111,
                      8'b11111111,
                      8'b11111111
                      };
                      
    parameter GO =  {
                      8'b11111111,
                      8'b10001000,
                      8'b01111010,
                      8'b01001010,
                      8'b01101010,
                      8'b10001000,
                      8'b11111111,
                      8'b11111111
                      };

  parameter OVER = {
                      8'b11111111,
                      8'b10011001,
                      8'b10011001,
                      8'b11111111,
                      8'b11100111,
                      8'b11011011,
                      8'b10111101,
                      8'b11111111
                      };
                      
                 
  parameter  Up = 4'b0001,
              Down = 4'b0010,
              Left = 4'b0100,
              Right = 4'b1000;
  
  
  DotMatrix DM0(i_Clk, i_Rst, c_Matrix, o_Col, o_Row, DM_o_fDone);
  RandNum RN0(i_Clk, i_Rst, RN_o_Num);
  FND FND0({1'b0,c_State}, o_Score);
  FND FND1({1'b0,c_head_col}, o_Score1); 
  FND FND2(c_Direc, o_Score2);
      
  assign fStart = i_Start;
  assign fUp = !i_Push[3];
  assign fDown = !i_Push[2];
  assign fLeft = !i_Push[1];
  assign fRight = !i_Push[0];
  
  assign fEat = (c_apple_col == c_head_col[2:0]) && (c_apple_row == c_head_row[2:0]);
  assign fValid = (c_apple_col != c_head_col[2:0])&& (c_apple_row != c_head_row[2:0]);
                    /*&& (c_apple_col != c_center_col) && (c_apple_row != c_center_row)
                    && (c_apple_col != c_tail_col) && (c_apple_row != c_tail_row); */
                    
  assign fDead = c_head_col == 15 || c_head_col == 8 || c_head_row == 15 || c_head_row == 8;
  //assign fDead = c_head_col[3] || c_head_row[3];
  //assign fDead = c_head_col == 15 || c_head_col == 8 || c_head_row == 15 || c_head_row == 8;
  assign fDMCnt = c_WaitCnt == (25-c_Score);
  //assign fDMCnt = c_WaitCnt == 25;
  
  assign o_Led[0] = c_Score == 3'b000;
  assign o_Led[1] = c_Score == 3'b001;
  assign o_Led[2] = c_Score == 3'b010;
  assign o_Led[3] = c_Score == 3'b011;
  assign o_Led[4] = c_Score == 3'b100;
  assign o_Led[5] = c_Score == 3'b101;
  
  always@(posedge i_Clk, negedge i_Rst)
  if(!i_Rst)begin
    c_State = IDLE;
    c_Direc = Up;
    c_Cnt = 0;
    c_WaitCnt = 0;
    c_Score = 0;
    //c_Matrix = CLEAR;
    c_head_row = 0;
    c_head_col = 0;
    c_center_row = 0;
    c_center_col = 0;
    c_tail_row = 0;
    c_tail_col = 0;
    c_apple_row = 0;
    c_apple_col = 0; 
  end
else begin
    c_State = n_State;
    c_Direc = n_Direc;
    c_Cnt = n_Cnt;
    c_WaitCnt = n_WaitCnt;
    c_Score = n_Score;
    c_Matrix = n_Matrix;
    c_head_row = n_head_row;
    c_head_col = n_head_col;
    c_center_row = n_center_row;
    c_center_col = n_center_col;
    c_tail_row = n_tail_row;
    c_tail_col = n_tail_col;
    c_apple_row = n_apple_row;
    c_apple_col = n_apple_col; 
end

always@*
begin
  
  n_Cnt = DM_o_fDone ? c_Cnt + 1 : c_Cnt;
  n_State = c_State;
  n_Direc = c_Direc;

  n_head_row = c_head_row;
  n_head_col = c_head_col;
  n_center_row = c_center_row;
  n_center_col = c_center_col;
  n_tail_row = c_tail_row;
  n_tail_col = c_tail_col;
  n_apple_row = c_apple_row;
  n_apple_col = c_apple_col; 
  n_WaitCnt = c_WaitCnt;
  n_Score = c_Score;
  
  
  //n_Matrix = c_State == IDLE ? CLEAR :
  //c_State == DIS_START ? GO : c_Matrix;
  
  case(c_State)
    IDLE : begin
       if(fStart) n_State = DIS_START;
    end
    DIS_START : begin
      n_head_row = 5;
      n_head_col = 1;
      n_center_row = 6;
      n_center_col = 1;
      n_tail_row = 7;
      n_tail_col = 1;
      
      //n_Matrix = GO;
      //n_Direc = Right;
      n_State = GEN_APPLE;
    
    end
    GEN_APPLE : begin
      n_apple_row = RN_o_Num[15:13];
      n_apple_col = RN_o_Num[2:0];
      n_Matrix = CLEAR;
      //if(n_Cnt[7:6]==2'h1) 
      n_State = CHECK_APPLE;
        
    end
    CHECK_APPLE : begin
      n_Matrix = CLEAR;
      if(fValid) n_State = DIS_MOVE;
      else n_State = GEN_APPLE;
        
    end
    DIS_MOVE : begin
      //n_Matrix = CLEAR;
      if(c_Direc == Up && fDown)               n_Direc = Up;
      else if(c_Direc == Down && fUp)          n_Direc = Down;
      else if(c_Direc == Left && fRight)       n_Direc = Left;
      else if(c_Direc == Right && fLeft)       n_Direc = Right;
      else   n_Direc = fUp ? Up : fDown ? Down : fLeft ? Left : fRight ? Right : c_Direc;
        
      if(c_Direc==Up)           n_head_row = c_head_row - 1;
      else if(c_Direc==Down)    n_head_row = c_head_row +1;
      else              n_head_row = c_head_row;
        
      if(c_Direc==Left)         n_head_col = c_head_col -1;
      else if(c_Direc==Right)   n_head_col = c_head_col + 1;
      else              n_head_col = c_head_col;
      
      n_center_row = c_head_row[2:0];
      n_center_col = c_head_col[2:0];
      n_tail_row = c_center_row;
      n_tail_col = c_center_col;
      
      
      if(fDead) begin
        n_State = DIS_END;

    end
      else if(fEat) begin
          n_Score = c_Score + 1;
          n_State = GEN_APPLE;
      end
      else n_State = WAIT;
        
    end
    WAIT : begin
      //n_Matrix = CLEAR;
      if(fDMCnt) begin
        n_State = DIS_MOVE;
        n_WaitCnt = 0;
        for (i = 0; i < 64; i = i + 1)
              n_Matrix[i] = !(i == {c_head_row[2:0], c_head_col[2:0]} || i == {c_center_row[2:0], c_center_col[2:0]} || i == {c_tail_row[2:0], c_tail_col[2:0]} || i == {c_apple_row, c_apple_col});
      end
    else n_WaitCnt = DM_o_fDone ? c_WaitCnt +1  : c_WaitCnt;
      
    end
    DIS_END : begin
      n_Matrix = OVER;
      if(c_Cnt[6:5] == 2'h1) n_State = IDLE;
      
    end
  endcase
end


endmodule

