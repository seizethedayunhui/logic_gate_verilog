module UART_RX(i_Clk, i_Rst, i_Rx, o_fDone, o_Data);
  //input
  input i_Clk;
  input i_Rst;
  input i_Rx; //reg save -> c_Rx
  
  //output
  output reg o_fDone;
  output reg [7:0]o_Data;
  
  //register
  reg n_Rx, c_Rx;
  reg [1:0]n_State, c_State;
  reg [19:0]n_ClkCnt, c_ClkCnt;
  reg [2:0]n_BitCnt, c_BitCnt;
  reg [7:0]n_Data, c_Data;
  
  wire fLstClk, fCapture, fLstBit, fIncClkCnt, fCaptureData;

//CYCLES_PER_BIT
  parameter CYCLES_PER_BIT = 434;
  
 //parameter = State
 parameter IDLE = 2'b00, 
           RX_START = 2'b01, 
           RX_DATA = 2'b10, //DATA receiving, 8 count
           RX_STOP = 2'b11;
            
        
  always@(posedge i_Clk, negedge i_Rst) begin
    if(!i_Rst) begin
      c_State = IDLE;
      c_Rx=0;
      c_ClkCnt=0;
      c_BitCnt=0;
      c_Data=0;
      end  
    else begin
      c_State = n_State;
      c_Rx=n_Rx;
      c_ClkCnt=n_ClkCnt;
      c_BitCnt=n_BitCnt;
      c_Data=n_Data;
    end
  end
  
  
 assign fLstClk = c_ClkCnt == CYCLES_PER_BIT,
        fCapture = c_ClkCnt == CYCLES_PER_BIT/2, //middle
        fLstBit = fLstClk && &c_BitCnt, //111
        fIncClkCnt = !fLstClk && (c_State == RX_START || c_State == RX_DATA),
        fCaptureData = fCapture && c_State == RX_DATA;
        
        
  always@*
  begin
    n_Rx= i_Rx;
    o_fDone = c_State == RX_STOP;
    //o_Data = o_fDone ? c_Data : 0;
    o_Data = c_Data;
    n_ClkCnt = fIncClkCnt ? c_ClkCnt + 1 : 0;
    n_BitCnt = (c_State==RX_DATA) ? fLstClk ? c_BitCnt + 1 : c_BitCnt : 0;
    n_Data = fCaptureData ? {c_Rx, c_Data[7:1]} : c_Data;
    
    n_State = c_State;
    
    case(c_State)
      IDLE: begin
        if(!c_Rx) n_State=RX_START;
      end
      
      RX_START: begin
        if(fCapture && c_Rx) n_State=IDLE;//fault signal
      else if (fLstClk) n_State=RX_DATA;
      end 
      
      RX_DATA: begin
        if(fLstBit) n_State=RX_STOP;
      end  
          
      RX_STOP:begin //directly IDLE
        n_State= IDLE;
      end
    endcase
  end
endmodule
  
  
  
  

