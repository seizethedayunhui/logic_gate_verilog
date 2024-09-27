library verilog;
use verilog.vl_types.all;
entity DotMatrixTop is
    generic(
        HEART           : vl_logic_vector(63 downto 0) := (Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi1, Hi1);
        SMILE           : vl_logic_vector(63 downto 0) := (Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1);
        ARROW           : vl_logic_vector(63 downto 0) := (Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1);
        HOME            : vl_logic_vector(63 downto 0) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1)
    );
    port(
        i_Clk           : in     vl_logic;
        i_Rst           : in     vl_logic;
        o_DM_Col        : out    vl_logic_vector(7 downto 0);
        o_DM_Row        : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of HEART : constant is 1;
    attribute mti_svvh_generic_type of SMILE : constant is 1;
    attribute mti_svvh_generic_type of ARROW : constant is 1;
    attribute mti_svvh_generic_type of HOME : constant is 1;
end DotMatrixTop;
