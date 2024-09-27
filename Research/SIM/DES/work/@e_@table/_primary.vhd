library verilog;
use verilog.vl_types.all;
entity E_Table is
    port(
        i_Data          : in     vl_logic_vector(31 downto 0);
        o_Data          : out    vl_logic_vector(47 downto 0)
    );
end E_Table;
