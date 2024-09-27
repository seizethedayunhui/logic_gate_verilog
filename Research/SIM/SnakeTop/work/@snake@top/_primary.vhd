library verilog;
use verilog.vl_types.all;
entity SnakeTop is
    generic(
        IDLE            : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi0);
        DIS_START       : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi1);
        GEN_APPLE       : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi0);
        CHECK_APPLE     : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi1);
        DIS_MOVE        : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi0);
        \WAIT\          : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi1);
        DIS_END         : vl_logic_vector(0 to 2) := (Hi1, Hi1, Hi0);
        CLEAR           : vl_logic_vector(63 downto 0) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1);
        GO              : vl_logic_vector(63 downto 0) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1);
        OVER            : vl_logic_vector(63 downto 0) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1);
        Up              : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi1);
        Down            : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi0);
        Left            : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi0);
        Right           : vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi0, Hi0)
    );
    port(
        i_Clk           : in     vl_logic;
        i_Rst           : in     vl_logic;
        i_Push          : in     vl_logic_vector(3 downto 0);
        i_Start         : in     vl_logic;
        o_Row           : out    vl_logic_vector(7 downto 0);
        o_Col           : out    vl_logic_vector(7 downto 0);
        o_Score         : out    vl_logic_vector(6 downto 0);
        o_Score1        : out    vl_logic_vector(6 downto 0);
        o_Score2        : out    vl_logic_vector(6 downto 0);
        o_Led           : out    vl_logic_vector(5 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDLE : constant is 1;
    attribute mti_svvh_generic_type of DIS_START : constant is 1;
    attribute mti_svvh_generic_type of GEN_APPLE : constant is 1;
    attribute mti_svvh_generic_type of CHECK_APPLE : constant is 1;
    attribute mti_svvh_generic_type of DIS_MOVE : constant is 1;
    attribute mti_svvh_generic_type of \WAIT\ : constant is 1;
    attribute mti_svvh_generic_type of DIS_END : constant is 1;
    attribute mti_svvh_generic_type of CLEAR : constant is 1;
    attribute mti_svvh_generic_type of GO : constant is 1;
    attribute mti_svvh_generic_type of OVER : constant is 1;
    attribute mti_svvh_generic_type of Up : constant is 1;
    attribute mti_svvh_generic_type of Down : constant is 1;
    attribute mti_svvh_generic_type of Left : constant is 1;
    attribute mti_svvh_generic_type of Right : constant is 1;
end SnakeTop;
