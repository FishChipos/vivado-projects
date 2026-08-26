library ieee;
use ieee.std_logic_1164.all;

use work.fixed_point.all;

package vector2 is
    type vector2_t is record
        x : fixed_point_t;
        y : fixed_point_t;
    end record;

    function "+" (left, right : vector2_t) return vector2_t;
    function "-" (left, right : vector2_t) return vector2_t;
    function "*" (left, right : vector2_t) return vector2_t;
    function "-" (vec : vector2_t) return vector2_t;
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

    function "-" (vec : vector2_t) return vector2_t is
    begin
        return (-vec.x, -vec.y);
    end function;

end package body;
