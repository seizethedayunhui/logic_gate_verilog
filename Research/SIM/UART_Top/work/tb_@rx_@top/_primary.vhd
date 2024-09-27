library verilog;
use verilog.vl_types.all;
entity tb_Rx_Top is
    generic(
        BAUD            : integer := 115200;
        TIME_PER_BIT    : vl_notype
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BAUD : constant is 1;
    attribute mti_svvh_generic_type of TIME_PER_BIT : constant is 3;
end tb_Rx_Top;
