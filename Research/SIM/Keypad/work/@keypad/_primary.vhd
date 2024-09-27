library verilog;
use verilog.vl_types.all;
entity Keypad is
    generic(
        IDLE            : integer := 0;
        PUSH            : integer := 1;
        ROW32           : integer := 2;
        ROW31           : integer := 3;
        ROW_A           : integer := 4;
        UNPUSH          : integer := 5
    );
    port(
        i_Clk           : in     vl_logic;
        i_Rst           : in     vl_logic;
        i_Col           : in     vl_logic_vector(3 downto 0);
        o_Row           : out    vl_logic_vector(3 downto 0);
        o_Num           : out    vl_logic_vector(3 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDLE : constant is 1;
    attribute mti_svvh_generic_type of PUSH : constant is 1;
    attribute mti_svvh_generic_type of ROW32 : constant is 1;
    attribute mti_svvh_generic_type of ROW31 : constant is 1;
    attribute mti_svvh_generic_type of ROW_A : constant is 1;
    attribute mti_svvh_generic_type of UNPUSH : constant is 1;
end Keypad;
