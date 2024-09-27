library verilog;
use verilog.vl_types.all;
entity Rx_Top is
    port(
        i_Clk           : in     vl_logic;
        i_Rst           : in     vl_logic;
        i_Rx            : in     vl_logic;
        o_Rx_Top0       : out    vl_logic_vector(6 downto 0);
        o_Rx_Top1       : out    vl_logic_vector(6 downto 0)
    );
end Rx_Top;
