library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package fixed_point is
    constant FIXED_POINT_WIDTH : natural := 32;
    constant FIXED_POINT_PRECISION : natural := 16;
    
    subtype fixed_point_t is signed(FIXED_POINT_WIDTH - 1 downto 0);

    function "+" (left, right : fixed_point_t) return fixed_point_t;
    function "-" (left, right : fixed_point_t) return fixed_point_t;
    function "*" (left, right : fixed_point_t) return fixed_point_t;
    function "/" (left, right : fixed_point_t) return fixed_point_t;
    function "-" (fixed_point : fixed_point_t) return fixed_point_t;
    function "=" (left, right : fixed_point_t) return boolean;
    function "/=" (left, right : fixed_point_t) return boolean;
    function "<" (left, right : fixed_point_t) return boolean;
    function "<=" (left, right : fixed_point_t) return boolean;
    function ">" (left, right : fixed_point_t) return boolean;
    function ">=" (left, right : fixed_point_t) return boolean;

    function to_fixed_point (int : integer) return fixed_point_t;
    function from_fixed_point (fixed_point : fixed_point_t) return integer;
end package;

package body fixed_point is
    function "+" (left, right : fixed_point_t) return fixed_point_t is
    begin
        return left + right;
    end function;

    function "-" (left, right : fixed_point_t) return fixed_point_t is
    begin
        return left - right;
    end function;

    function "*" (left, right : fixed_point_t) return fixed_point_t is
    begin
        return left * right;
    end function;

    function "/" (left, right : fixed_point_t) return fixed_point_t is
    begin
        return left / right;
    end function;

    function "-" (fixed_point : fixed_point_t) return fixed_point_t is
    begin
        return -fixed_point;
    end function;

    function "=" (left, right : fixed_point_t) return boolean is
    begin
        return left = right;
    end function;

    function "/=" (left, right : fixed_point_t) return boolean is
    begin
        return left /= right;
    end function;

    function "<" (left, right : fixed_point_t) return boolean is
    begin
        return left < right;
    end function;

    function "<=" (left, right : fixed_point_t) return boolean is
    begin
        return left <= right;
    end function;

    function ">" (left, right : fixed_point_t) return boolean is
    begin
        return left > right;
    end function;

    function ">=" (left, right : fixed_point_t) return boolean is
    begin
        return left >= right;
    end function;
    
    function to_fixed_point (int : integer) return fixed_point_t is
    begin
        return to_signed(int, FIXED_POINT_WIDTH) * (2 ** FIXED_POINT_PRECISION);
    end function;

    function from_fixed_point (fixed_point : fixed_point_t) return integer is
    begin
        return to_integer(fixed_point / (2 ** FIXED_POINT_PRECISION));
    end function;
end package body;
