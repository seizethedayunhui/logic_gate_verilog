library verilog;
use verilog.vl_types.all;
entity tb_DES_Top is
    generic(
        DW              : integer := 64;
        SET_KEY         : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        ENC             : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0);
        DEC             : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1);
        KEY             : vl_logic_vector(0 to 63) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        PTEXT           : vl_logic_vector(0 to 63) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0);
        CTEXT           : vl_logic_vector(0 to 63) := (Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DW : constant is 1;
    attribute mti_svvh_generic_type of SET_KEY : constant is 1;
    attribute mti_svvh_generic_type of ENC : constant is 1;
    attribute mti_svvh_generic_type of DEC : constant is 1;
    attribute mti_svvh_generic_type of KEY : constant is 1;
    attribute mti_svvh_generic_type of PTEXT : constant is 1;
    attribute mti_svvh_generic_type of CTEXT : constant is 1;
end tb_DES_Top;
