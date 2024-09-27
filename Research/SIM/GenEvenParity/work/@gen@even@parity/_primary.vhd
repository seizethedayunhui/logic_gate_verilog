library verilog;
use verilog.vl_types.all;
entity GenEvenParity is
    port(
        i_Data          : in     vl_logic_vector(7 downto 0);
        o_Data          : out    vl_logic_vector(7 downto 0);
        o_Parity        : out    vl_logic
    );
end GenEvenParity;
