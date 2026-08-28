library ieee;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;

use work.vector2.all;
use work.fixed.all;

package graphics is
    constant DISPLAY_WIDTH : fixed_t := to_fixed(1280);
    constant DISPLAY_HEIGHT : fixed_t := to_fixed(720);

    type param_triangle_t is record
        a : vector2_t;
        b : vector2_t;
        c : vector2_t;
    end record;

    function next_pixel (pixel : vector2_t) return vector2_t;
end package;

package body graphics is
    function next_pixel (pixel : vector2_t) return vector2_t is 
    begin
        if (pixel.x >= DISPLAY_WIDTH) then
            if (pixel.y >= DISPLAY_HEIGHT) then
                return to_vector2(0, 0);
            else
                return (to_fixed(0), resize_fixed(pixel.y + 1));
            end if;
        else
            return (resize_fixed(pixel.x + 1), pixel.y);
        end if;
    end function;
end package body;
