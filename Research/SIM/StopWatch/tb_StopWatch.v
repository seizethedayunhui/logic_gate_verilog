`timescale 1ns / 1ns
module tb_StopWatch;
    reg Clk;
    reg Rst;
    reg fStart;
    reg fRecord;
    wire [6:0] Sec0, Sec1, Sec2, Sec3, Sec4, Sec5;
StopWatch U0(Clk, Rst, fStart, fRecord, Sec0, Sec1, Sec2, Sec3, Sec4, Sec5);
always #10 Clk = ~Clk;
initial 
begin
  
        Clk = 1;
        Rst = 0;
        fStart = 1;
        fRecord = 1;
        
        @(negedge Clk) Rst = 1;
        #100 fStart = 1; #20 fStart = 1;
        #222_222_200 fStart = 0; #20 fStart = 1;
        #1000 fStart = 0; #20 fStart = 1;
        #333_333_300 fRecord = 0; #20 fRecord = 1;
        $stop;
end
endmodule


