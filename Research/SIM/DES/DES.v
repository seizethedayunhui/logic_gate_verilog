module DES(i_Clk, i_Rst, i_fStart, i_fDec, i_Key, i_Text, o_fDone, o_Text);
  input i_Clk;
  input i_Rst;
  //control
  input i_fStart;
  input i_fDec;
  //data
  input [63:0]i_Key;
  input [63:0]i_Text;
  //state
  output reg o_fDone;
  //data
  output reg [63:0] o_Text;
  
  reg [1:0] n_State, c_State;
  reg [3:0] n_Rnd, c_Rnd;
  reg [31:0] n_L, c_L;
  reg [31:0] n_R, c_R;
  reg [27:0] n_C, c_C;
  reg [27:0] n_D, c_D;
  
  reg f1bit;
  
  wire [63:0] o_IP; //IP ouput
  wire [55:0] o_PC1; //PC1 output
  wire [47:0] o_Etable; //Etable output
  wire [47:0] o_PC2; //PC2 ouput
  wire [31:0]o_Sboxes;
  wire [31:0]o_Ptable;
  wire [63:0] o_InvIP;
  wire [27:0] o_ROL_C;
  wire [27:0] o_ROL_D;
  
  
 parameter IDLE = 2'b00, 
            ENC = 2'b01, 
            DEC = 2'b10,
            DONE = 2'b11;
            
  //Instance define
  IP IP0(i_Text,o_IP);
  PC1 PC10(i_Key,o_PC1);
  E_Table ETable0 (c_R, o_Etable); 
  PC2 PC20 ({c_C,c_D},o_PC2);
  SBOX SBOX0(o_Etable^o_PC2,o_Sboxes);
  P_Table Ptable0(o_Sboxes,o_Ptable);
  InvIP InvIP0({c_R,c_L},o_InvIP);
  ROL ROL_C(c_C, n_State[1], f1bit, o_ROL_C);
  ROL ROL_D(c_D, n_State[1], f1bit, o_ROL_D);
  
  
  always@(posedge i_Clk, negedge i_Rst) begin
    if(!i_Rst) begin
      c_State = IDLE;
      c_Rnd=0;
      c_L=0;
      c_R=0;
      c_C=0;
      c_D=0;
      f1bit=0;

      end 
    else begin
      c_State = n_State;
      c_Rnd=n_Rnd;
      c_L=n_L;
      c_R=n_R;
      c_C=n_C;
      c_D=n_D;
    end
  end
  
  always@*
  begin
    n_State = c_State;
    o_fDone= c_State==DONE;
    f1bit = c_Rnd == 0 || c_Rnd == 7 || c_Rnd == 14 || c_Rnd==15;    
    n_Rnd=0;
    o_fDone=0;
    o_Text=0;
    n_L=0;
    n_R=0;
    n_C=0;
    n_D=0;
    case(c_State)
      
      IDLE: begin
        if(i_fStart) begin
          if(i_fDec) n_State=DEC;
          else  n_State=ENC;
          n_L=o_IP[63:32];
          n_R=o_IP[31:0];
          n_C= i_fDec? o_PC1[55:28]:{o_PC1[54:28],o_PC1[55]};
          n_D= i_fDec? o_PC1[27:0]:{o_PC1[26:0],o_PC1[27]};
        end
      end
      
      ENC, DEC: begin
         n_Rnd=c_Rnd+1;
         n_L=c_R;
         n_R=c_L^o_Ptable; 
         n_C=o_ROL_C;
         n_D=o_ROL_D;   

        if (c_Rnd==15) n_State=DONE;     
      end      
      DONE:begin
        o_Text= o_InvIP;
        n_State=IDLE;
        
      end
   
    endcase
  end
   
endmodule



