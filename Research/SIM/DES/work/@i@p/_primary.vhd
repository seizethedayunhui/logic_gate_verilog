library verilog;
use verilog.vl_types.all;
entity IP is
    port(
        i_Data          : in     vl_logic_vector(63 downto 0);
        o_Data          : out    vl_logic_vector(63 downto 0)
    );
end IP;
