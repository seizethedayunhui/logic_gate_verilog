library verilog;
use verilog.vl_types.all;
entity DES is
    generic(
        IDLE            : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        ENC             : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        DEC             : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        DONE            : vl_logic_vector(0 to 1) := (Hi1, Hi1)
    );
    port(
        i_Clk           : in     vl_logic;
        i_Rst           : in     vl_logic;
        i_fStart        : in     vl_logic;
        i_fDec          : in     vl_logic;
        i_Key           : in     vl_logic_vector(63 downto 0);
        i_Text          : in     vl_logic_vector(63 downto 0);
        o_fDone         : out    vl_logic;
        o_Text          : out    vl_logic_vector(63 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDLE : constant is 1;
    attribute mti_svvh_generic_type of ENC : constant is 1;
    attribute mti_svvh_generic_type of DEC : constant is 1;
    attribute mti_svvh_generic_type of DONE : constant is 1;
end DES;
