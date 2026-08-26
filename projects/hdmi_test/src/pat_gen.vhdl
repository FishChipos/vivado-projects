library ieee;
use ieee.std_logic_1164.all;

use work.types.all;

entity pat_gen is
    port (
        clk : in std_logic;
        rst : in std_logic;
        pattern : in pattern_t;
        hsync : in std_logic;
        vsync : in std_logic;
        pixel : in pixel_t;
        data : out rgb_t
    );
end entity;

architecture arch of pat_gen is
begin
    process (clk) is
        procedure set_color_white is
        begin
            data <= (others => '1');
        end procedure;

        procedure set_color_black is
        begin
            data <= (others => '0');
        end procedure;
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                set_color_black;
            else
                case (pattern) is
                    when PATTERN_CHECKERS1 =>
                        if (pixel.x mod 2 = 0 and pixel.y mod 2 = 0) then
                            set_color_white;
                        else
                            set_color_black;
                        end if;

                    when PATTERN_CHECKERS2 =>
                        if (pixel.x mod 4 = 0 and pixel.y mod 4 = 0) then
                            set_color_white;
                        else
                            set_color_black;
                        end if;

                    when PATTERN_CHECKERS4 =>
                        if (pixel.x mod 8 = 0 and pixel.y mod 8 = 0) then
                            set_color_white;
                        else
                            set_color_black;
                        end if;
                end case;
            end if;
        end if;
    end process;
end architecture;
