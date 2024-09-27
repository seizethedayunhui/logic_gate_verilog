library verilog;
use verilog.vl_types.all;
entity UART_TX is
    generic(
        CYCLES_PER_BIT  : integer := 434;
        IDLE            : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        TX_START        : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        TX_DATA         : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        TX_DONE         : vl_logic_vector(0 to 1) := (Hi1, Hi1)
    );
    port(
        i_Clk           : in     vl_logic;
        i_Rst           : in     vl_logic;
        i_fTx           : in     vl_logic;
        i_Data          : in     vl_logic_vector(7 downto 0);
        o_fDone         : out    vl_logic;
        o_fReady        : out    vl_logic;
        o_Tx            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CYCLES_PER_BIT : constant is 1;
    attribute mti_svvh_generic_type of IDLE : constant is 1;
    attribute mti_svvh_generic_type of TX_START : constant is 1;
    attribute mti_svvh_generic_type of TX_DATA : constant is 1;
    attribute mti_svvh_generic_type of TX_DONE : constant is 1;
end UART_TX;
