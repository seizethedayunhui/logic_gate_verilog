library verilog;
use verilog.vl_types.all;
entity Top is
    port(
        Top_i_Clk       : in     vl_logic;
        Top_i_Rst       : in     vl_logic;
        Top_i_Col       : in     vl_logic_vector(3 downto 0);
        Top_o_FND       : out    vl_logic_vector(6 downto 0);
        Top_o_Row       : out    vl_logic_vector(3 downto 0)
    );
end Top;
