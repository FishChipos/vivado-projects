library ieee;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;

use work.vector2.all;

package graphics is
    constant DISPLAY_WIDTH : natural := 1280;
    constant DISPLAY_HEIGHT : natural := 720;

    type vertices_t is array (natural range <>) of vector2_t;
end package;
