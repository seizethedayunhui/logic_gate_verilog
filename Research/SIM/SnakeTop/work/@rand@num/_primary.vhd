library verilog;
use verilog.vl_types.all;
entity RandNum is
    port(
        i_Clk           : in     vl_logic;
        i_Rst           : in     vl_logic;
        o_Num           : out    vl_logic_vector(15 downto 0)
    );
end RandNum;
