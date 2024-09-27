library verilog;
use verilog.vl_types.all;
entity FNDx3 is
    port(
        i_Numx3         : in     vl_logic_vector(9 downto 0);
        o_FND0          : out    vl_logic_vector(6 downto 0);
        o_FND1          : out    vl_logic_vector(6 downto 0);
        o_FND2          : out    vl_logic_vector(6 downto 0)
    );
end FNDx3;
