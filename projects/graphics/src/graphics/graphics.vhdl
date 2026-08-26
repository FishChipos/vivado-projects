use work.fixed_point.all;
use work.vector2.all;
use work.color.all;

package graphics is
    type triangle_t is array (0 to 2) of vector2_t;

    function is_in_triangle (point : vector2_t; triangle : triangle_t) return boolean;

    type triangle_weights_t is array (0 to 3) of fixed_point_t;
    function get_triangle_weights (point : vector2_t; triangle : triangle_t) return triangle_weights_t;
    function get_triangle_pixel (point : vector2_t; triangle : triangle_t) return color_t;

    type rectangle_t is array (0 to 1) of triangle_t;
end package;

package body graphics is
    function is_in_triangle (point : vector2_t; triangle : triangle_t) return boolean is
        variable weights : triangle_weights_t := get_triangle_weights(point, triangle);
    begin
        return weights(0) >= to_fixed_point(0) and
               weights(0) <= to_fixed_point(1) and
               weights(1) >= to_fixed_point(0) and
               weights(1) <= to_fixed_point(1) and
               weights(2) >= to_fixed_point(0) and
               weights(2) <= to_fixed_point(1);
    end function;

    function get_triangle_weights (point : vector2_t; triangle : triangle_t) return triangle_weights_t is
        variable a : vector2_t := triangle(0);
        variable b : vector2_t := triangle(1) - a;
        variable c : vector2_t := triangle(2) - a;
        variable p : vector2_t := point - a;

        variable d : fixed_point_t := b.x * c.y - c.x * b.y;
    begin
        return (
            (p.x * (b.y - c.y) + p.y * (c.x - b.x) + d) / d,
            (p.x * c.y - p.y * c.x) / d,
            (p.y * b.x - p.x * b.y) / d
        );
    end function;

    function get_triangle_pixel (point : vector2_t; triangle : triangle_t) return color_t is
    begin
        if (is_in_triangle(point, triangle)) then
            return COLOR_WHITE;
        else
            return COLOR_BLACK;
        end if;
    end function;
end package body;
