module DES_Top(i_Clk, i_Rst, i_Rx, o_Tx, o_LED);
  
  //input
  input i_Clk, i_Rst;
  input i_Rx;
  //output
  output o_Tx;
  output reg [7:0] o_LED;
  
  reg [2:0] c_State, n_State;
  reg [63:0] c_Key, n_Key;
  reg [63:0] c_Text, n_Text;
  reg [1:0] c_Cmd, n_Cmd;
  reg [2:0] c_ByteCnt, n_ByteCnt;
  
  wire fLstByte;
  
  wire TX_i_fTx;
  wire [7:0] TX_i_Data;
  wire TX_o_fReady, TX_o_fDone;
  
  wire RX_o_fDone;
  wire [7:0] RX_o_Data;
  
  wire DES_i_fStart, DES_i_fDec, DES_o_fDone;
  wire [63:0] DES_o_Text, DES_i_Key, DES_i_Text;
  
  parameter IDLE = 3'b000,
            RX_TEXT = 3'b001,
            RX_KEY = 3'b010,
            START_DES = 3'b011,
            WAIT_DES = 3'b100,
            TX_RES = 3'b101,
            TX_TEXT = 3'b110;
  //module 
  UART_RX RX0(i_Clk, i_Rst, i_Rx, RX_o_fDone, RX_o_Data);
  UART_TX TX0(i_Clk, i_Rst, TX_i_fTx, TX_i_Data, TX_o_fDone,  TX_o_fReady, o_Tx);
  DES DES0(i_Clk, i_Rst, DES_i_fStart, DES_i_fDec, DES_i_Key, DES_i_Text, DES_o_fDone, DES_o_Text);     
  
  assign fLstByte = &c_ByteCnt,
         TX_i_fTx = TX_o_fReady && (c_State == TX_RES || c_State == TX_TEXT),
         TX_i_Data = c_State == TX_RES ? c_Cmd : c_Text[63:56],
         DES_i_fStart = c_State == START_DES,
         DES_i_fDec = c_Cmd[0],
         DES_i_Key = c_Key,
         DES_i_Text = c_Text;    
  
  always@(posedge i_Clk, negedge i_Rst) begin
    if(!i_Rst) begin
      c_State = IDLE;
      c_Key = 0;
      c_Text = 0;
      c_Cmd = 0;
      c_ByteCnt = 0;
    end 
    else begin
      c_State = n_State;
      c_Key = n_Key;
      c_Text = n_Text;
      c_Cmd = n_Cmd;
      c_ByteCnt = n_ByteCnt;
    end
  end
  

  always@*
  begin
    n_Cmd = c_Cmd;
    n_Text = c_Text;
    n_Key = c_Key;
    n_ByteCnt = 0;
    o_LED = 8'b11111111;
    
    n_State = c_State;
    case(c_State)
      IDLE: begin
        n_Cmd = RX_o_fDone ? RX_o_Data : c_Cmd;
        o_LED = 8'b00000000;
        
        if(RX_o_fDone) n_State= RX_o_Data[1]? RX_TEXT : RX_KEY;

      end
      RX_TEXT: begin
        n_Text = RX_o_fDone ? {c_Text[55:0], RX_o_Data} : c_Text;
        n_ByteCnt = RX_o_fDone ? c_ByteCnt + 1 : c_ByteCnt;
        o_LED = 8'b00000001;
        
        if(RX_o_fDone && fLstByte)
          n_State = START_DES;
      end
      RX_KEY: begin
        n_Key = RX_o_fDone ? {c_Key[55:0],RX_o_Data} : c_Key;
        n_ByteCnt = RX_o_fDone ? c_ByteCnt + 1 : c_ByteCnt;
        o_LED = 8'b00000010;
        
        if(RX_o_fDone && fLstByte)
          n_State = TX_RES;
      end
      START_DES: begin
        o_LED = 8'b00000100;
        n_State = WAIT_DES;
      end
      WAIT_DES: begin
        n_Text = DES_o_fDone ? DES_o_Text : c_Text;
        o_LED = 8'b00001000;
        
        if(DES_o_fDone)
          n_State = TX_RES;
      end
      TX_RES: begin
        o_LED = 8'b00010000;
        
        if(TX_o_fDone) n_State= c_Cmd[1]? TX_TEXT : IDLE;

      end
      TX_TEXT: begin
        n_Text = TX_o_fDone ? {c_Text[55:0], RX_o_Data} : c_Text;
        n_ByteCnt = TX_o_fDone ? c_ByteCnt + 1 : c_ByteCnt;
        o_LED = 8'b00100000;
        
        if(TX_o_fDone && fLstByte)
          n_State = IDLE;
      end
      
    endcase
  end
  
endmodule