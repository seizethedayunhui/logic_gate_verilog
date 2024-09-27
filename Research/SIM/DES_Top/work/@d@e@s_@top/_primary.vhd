library verilog;
use verilog.vl_types.all;
entity DES_Top is
    generic(
        IDLE            : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi0);
        RX_TEXT         : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi1);
        RX_KEY          : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi0);
        START_DES       : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi1);
        WAIT_DES        : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi0);
        TX_RES          : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi1);
        TX_TEXT         : vl_logic_vector(0 to 2) := (Hi1, Hi1, Hi0)
    );
    port(
        i_Clk           : in     vl_logic;
        i_Rst           : in     vl_logic;
        i_Rx            : in     vl_logic;
        o_Tx            : out    vl_logic;
        o_LED           : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDLE : constant is 1;
    attribute mti_svvh_generic_type of RX_TEXT : constant is 1;
    attribute mti_svvh_generic_type of RX_KEY : constant is 1;
    attribute mti_svvh_generic_type of START_DES : constant is 1;
    attribute mti_svvh_generic_type of WAIT_DES : constant is 1;
    attribute mti_svvh_generic_type of TX_RES : constant is 1;
    attribute mti_svvh_generic_type of TX_TEXT : constant is 1;
end DES_Top;
