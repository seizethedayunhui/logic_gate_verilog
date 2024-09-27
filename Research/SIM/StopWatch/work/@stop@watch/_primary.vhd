library verilog;
use verilog.vl_types.all;
entity StopWatch is
    generic(
        LST_CLK         : integer := 4999999;
        IDLE            : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        WORK            : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        PAUSE           : vl_logic_vector(0 to 1) := (Hi1, Hi0)
    );
    port(
        i_Clk           : in     vl_logic;
        i_Rst           : in     vl_logic;
        i_fStart        : in     vl_logic;
        i_fStop         : in     vl_logic;
        o_Sec0          : out    vl_logic_vector(6 downto 0);
        o_Sec1          : out    vl_logic_vector(6 downto 0);
        o_Sec2          : out    vl_logic_vector(6 downto 0);
        o_Rec0          : out    vl_logic_vector(6 downto 0);
        o_Rec1          : out    vl_logic_vector(6 downto 0);
        o_Rec2          : out    vl_logic_vector(6 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of LST_CLK : constant is 1;
    attribute mti_svvh_generic_type of IDLE : constant is 1;
    attribute mti_svvh_generic_type of WORK : constant is 1;
    attribute mti_svvh_generic_type of PAUSE : constant is 1;
end StopWatch;
