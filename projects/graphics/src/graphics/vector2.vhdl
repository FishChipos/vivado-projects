library ieee;
use ieee.fixed_pkg.all;

package vector2 is
    type vector2_t is record
        x : sfixed;
        y : sfixed;
    end record;

    function "+" (left, right : vector2_t) return vector2_t;
    function "-" (left, right : vector2_t) return vector2_t;
    function "*" (left, right : vector2_t) return vector2_t;
end package;

package body vector2 is
    function "+" (left, right : vector2_t) return vector2_t is
    begin
        return (left.x + right.x, left.y + right.y);
    end function;

    function "-" (left, right : vector2_t) return vector2_t is
    begin
        return (left.x - right.x, left.y - right.y);
    end function;

    function "*" (left, right : vector2_t) return vector2_t is
    begin
        return (left.x * right.x, left.y * right.y);
    end function;
end package body;
