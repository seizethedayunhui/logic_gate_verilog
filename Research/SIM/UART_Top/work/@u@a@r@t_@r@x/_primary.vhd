library verilog;
use verilog.vl_types.all;
entity UART_RX is
    generic(
        CYCLES_PER_BIT  : integer := 434;
        IDLE            : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        RX_START        : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        RX_DATA         : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        RX_STOP         : vl_logic_vector(0 to 1) := (Hi1, Hi1)
    );
    port(
        i_Clk           : in     vl_logic;
        i_Rst           : in     vl_logic;
        i_Rx            : in     vl_logic;
        o_fDone         : out    vl_logic;
        o_Data          : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CYCLES_PER_BIT : constant is 1;
    attribute mti_svvh_generic_type of IDLE : constant is 1;
    attribute mti_svvh_generic_type of RX_START : constant is 1;
    attribute mti_svvh_generic_type of RX_DATA : constant is 1;
    attribute mti_svvh_generic_type of RX_STOP : constant is 1;
end UART_RX;
