library ieee;
use ieee.std_logic_1164.all;

package types is
    constant BIT_COUNT : natural := 4;
    subtype word_t is std_logic_vector(BIT_COUNT - 1 downto 0);

    subtype switches_t is word_t;
    subtype leds_t is word_t;

    type buttons_t is record
        fwd : std_logic;
        back : std_logic;
        cycle_mode : std_logic;
    end record;

    type rgb_led_color_t is (
        C_WHITE,
        C_RED,
        C_GREEN,
        C_BLUE
    );

    subtype rgb_led_brightness_t is natural range 0 to 100;

    type rgb_led_pins_t is record
        r : std_logic;
        g : std_logic;
        b : std_logic;
    end record;
end package;
