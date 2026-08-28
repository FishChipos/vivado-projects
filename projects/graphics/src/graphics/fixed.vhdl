library ieee;
use ieee.fixed_pkg.all;

package fixed is
    subtype fixed_t is sfixed(11 downto -12);
    subtype fixed_product_t is sfixed(23 downto -24);

    type fixed_mul_t is record
        a : fixed_t;
        b : fixed_t;
        m : fixed_product_t;
        p : fixed_product_t;
        r : fixed_t;
    end record;

    function resize_fixed (fixed : sfixed) return fixed_t;
    function to_fixed (arg : integer) return fixed_t;

    procedure mul_fixed (signal arg : inout fixed_mul_t);
end package;

package body fixed is
    function resize_fixed (fixed : sfixed) return fixed_t is
    begin
        return resize(fixed, fixed_t'left, fixed_t'right);
    end function;

    function to_fixed (arg : integer) return fixed_t is
    begin
        return to_sfixed(arg, fixed_t'left, fixed_t'right);
    end function;

    procedure mul_fixed (signal arg : inout fixed_mul_t) is
    begin
        arg.m <= arg.a * arg.b;
        arg.p <= arg.m;
        arg.r <= resize_fixed(arg.p);
    end procedure;
end package body;
