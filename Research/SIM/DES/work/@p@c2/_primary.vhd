library verilog;
use verilog.vl_types.all;
entity PC2 is
    port(
        i_Data          : in     vl_logic_vector(55 downto 0);
        o_Data          : out    vl_logic_vector(47 downto 0)
    );
end PC2;
