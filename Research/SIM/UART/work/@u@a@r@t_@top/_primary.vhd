library verilog;
use verilog.vl_types.all;
entity UART_Top is
    port(
        i_Clk           : in     vl_logic;
        i_Rst           : in     vl_logic;
        i_Rx            : in     vl_logic;
        o_Tx            : out    vl_logic;
        i_Push          : in     vl_logic_vector(3 downto 0);
        o_FND0          : out    vl_logic_vector(6 downto 0);
        o_FND1          : out    vl_logic_vector(6 downto 0)
    );
end UART_Top;
