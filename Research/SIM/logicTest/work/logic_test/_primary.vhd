library verilog;
use verilog.vl_types.all;
entity logic_test is
    port(
        i_0             : in     vl_logic_vector(3 downto 0);
        i_1             : in     vl_logic_vector(3 downto 0);
        o_AND           : out    vl_logic_vector(3 downto 0);
        o_OR            : out    vl_logic_vector(3 downto 0);
        o_NOT           : out    vl_logic_vector(3 downto 0);
        o_XOR           : out    vl_logic_vector(3 downto 0)
    );
end logic_test;
