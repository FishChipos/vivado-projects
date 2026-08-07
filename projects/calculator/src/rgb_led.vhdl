library ieee;
use ieee.std_logic_1164.all;

use work.types.all;

entity rgb_led is
    port (
        clk : in std_logic;
        rst : in std_logic;
        brightness : in rgb_led_brightness_t;
        color : in rgb_led_color_t;
        pins : out rgb_led_pins_t
    );
end entity;

architecture arch of rgb_led is
    signal clk_count : rgb_led_brightness_t;
begin
    process (clk, rst) is
    begin
        if (rst = '1') then
            pins <= (others => '0');
            clk_count <= rgb_led_brightness_t'low;
        elsif (rising_edge(clk)) then
            if (clk_count < brightness) then
                case (color) is
                    when C_WHITE =>
                        pins <= (r => '1',
                                 g => '1',
                                 b => '1');
                    when C_RED =>
                        pins <= (r => '1', others => '0');
                    when C_GREEN =>
                        pins <= (g => '1', others => '0');
                    when C_BLUE =>
                        pins <= (b => '1', others => '0');
                end case;
            else
                pins <= (others => '0');
            end if;

            if (clk_count >= rgb_led_brightness_t'high) then
                clk_count <= rgb_led_brightness_t'low;
            else
                clk_count <= clk_count + 1;
            end if;
        end if;
    end process;
end architecture;
