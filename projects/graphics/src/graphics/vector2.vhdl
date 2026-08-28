library ieee;
use ieee.fixed_pkg.all;

use work.fixed.all;

package vector2 is
    type vector2_t is record
        x : fixed_t;
        y : fixed_t;
    end record;

    function "-" (arg : vector2_t) return vector2_t;
    function "+" (left, right : vector2_t) return vector2_t;
    function "-" (left, right : vector2_t) return vector2_t;
    function "*" (left, right : vector2_t) return vector2_t;

    function to_vector2 (x, y : integer) return vector2_t;
end package;

package body vector2 is
    function "-" (arg : vector2_t) return vector2_t is
        variable res : vector2_t;
    begin
        res := (x => -arg.x, y => -arg.y);
        return res;
    end function;

    function "+" (left, right : vector2_t) return vector2_t is
        variable res : vector2_t;
    begin
        res := (x => resize_fixed(left.x + right.x),
                y => resize_fixed(left.y + right.y));
        return res;
    end function;

    function "-" (left, right : vector2_t) return vector2_t is
        variable res : vector2_t;
    begin
        res := (x => resize_fixed(left.x - right.x),
                y => resize_fixed(left.y - right.y));
        return res;
    end function;

    function "*" (left, right : vector2_t) return vector2_t is
        variable res : vector2_t;
    begin
        res := (x => resize_fixed(left.x * right.x),
                y => resize_fixed(left.y * right.y));
        return res;
    end function;

    function to_vector2 (x, y : integer) return vector2_t is
        variable res : vector2_t;
    begin
        res := (x => to_fixed(x),
                y => to_fixed(y));
        return res;
    end function;
end package body;
