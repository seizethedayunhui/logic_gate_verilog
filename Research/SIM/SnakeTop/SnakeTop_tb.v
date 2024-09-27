module SnakeTop_tb;

  reg i_Clk, i_Rst, i_Start;
  reg [3:0] i_Push;
  wire [7:0] o_Row, o_Col;
  wire [6:0] o_Score, o_Score1, o_Score2;
  
  // Instantiate the module under test
  SnakeTop dut (
    .i_Clk(i_Clk),
    .i_Rst(i_Rst),
    .i_Start(i_Start),
    .i_Push(i_Push),
    .o_Row(o_Row),
    .o_Col(o_Col),
    .o_Score(o_Score),
    .o_Score1(o_Score1),
    .o_Score2(o_Score2)
  );

  // Clock generation
  initial begin
    i_Clk = 0;
    forever #5 i_Clk = ~i_Clk;
  end

  // Test scenario
  initial begin
    i_Rst = 1;
    i_Start = 0;
    i_Push = 4'b1111;
    #10 i_Rst = 0;

    // Run the simulation for a number of clock cycles
    #100;
    i_Start = 1; // Trigger the start condition
    i_Push = 4'b1110;
    i_Push = 4'b1011;
    // Additional test conditions can be added here
    #500 $finish; // Terminate the simulation after a certain number of clock cycles
  end

endmodule
