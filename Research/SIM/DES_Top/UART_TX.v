module UART_TX(i_Clk, i_Rst, i_fTx, i_Data, o_fDone, o_fReady, o_Tx);
  //input
  input i_Clk;
  input i_Rst;
  input i_fTx; 
  input [7:0] i_Data;
  
  //output
  output reg o_fDone;
  output reg o_fReady;
  output reg o_Tx;
  
  //register
  reg [1:0]n_State, c_State;
  reg [19:0]n_ClkCnt, c_ClkCnt;
  reg [2:0]n_BitCnt, c_BitCnt;
  reg [8:0]n_Data, c_Data;
  
  wire fLstClk, fLstBit, fIncClkCnt;

//CYCLES_PER_BIT
  parameter CYCLES_PER_BIT = 434;
  
 //parameter = State
 parameter IDLE = 2'b00, 
           TX_START = 2'b01, 
           TX_DATA = 2'b10, //DATA receiving, 8 count
           TX_DONE = 2'b11;
            
        
  always@(posedge i_Clk, negedge i_Rst) begin
    if(!i_Rst) begin
      c_State = IDLE;
      c_ClkCnt=0; 
      c_BitCnt=0;
      c_Data=0;
      end  
    else begin
      c_State = n_State;
      c_ClkCnt=n_ClkCnt;
      c_BitCnt=n_BitCnt;
      c_Data=n_Data;
    end
  end
  
  
 assign fLstClk = c_ClkCnt == CYCLES_PER_BIT,
        fLstBit = fLstClk && &c_BitCnt,
        fIncClkCnt = c_State != IDLE && !fLstClk;
        
        
  always@*
  begin
    o_fDone = (c_State == TX_DONE) && fLstClk;
    o_fReady = c_State == IDLE;
    o_Tx = c_Data[0];
    
    n_ClkCnt = fIncClkCnt ? c_ClkCnt + 1 : 0;
    n_BitCnt = (c_State==TX_DATA) ? fLstClk ? c_BitCnt + 1 : c_BitCnt : 0;
    n_Data = (c_State==IDLE) && i_fTx ? {i_Data, 1'b0} : fLstClk ? {1'b1, c_Data[8:1]} : c_Data;
    n_State = c_State;
    
    case(c_State)
      IDLE: begin
        if(i_fTx) n_State=TX_START;
      end
      
      TX_START: begin
        if (fLstClk) n_State=TX_DATA;
      end 
      
      TX_DATA: begin
        if(fLstBit) n_State=TX_DONE;
      end  
          
      TX_DONE:begin //directly IDLE
        if(fLstClk) n_State=IDLE;
      end
    endcase
  end
endmodule
  
  
  
  



