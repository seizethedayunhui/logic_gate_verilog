library verilog;
use verilog.vl_types.all;
entity \ROL\ is
    port(
        i_Data          : in     vl_logic_vector(27 downto 0);
        i_fRight        : in     vl_logic;
        i_f1bit         : in     vl_logic;
        o_Data          : out    vl_logic_vector(27 downto 0)
    );
end \ROL\;
