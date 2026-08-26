library ieee;
use ieee.std_logic_1164.all;

package color is
    type color_t is record
        r : std_logic_vector(7 downto 0);
        g : std_logic_vector(7 downto 0);
        b : std_logic_vector(7 downto 0);
    end record;

    constant COLOR_WHITE : color_t := (others => (others => '1'));
    constant COLOR_BLACK : color_t := (others => (others => '0'));
end package;
