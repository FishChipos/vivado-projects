library ieee;
use ieee.std_logic_1164.all;

package types is
    constant DISPLAY_WIDTH : natural := 1280;
    constant DISPLAY_HEIGHT : natural := 720;

    type buttons_t is record
        cycle_pattern : std_logic;
    end record;

    subtype rgb_t is std_logic_vector(23 downto 0);

    type vid_t is record
        rgb : rgb_t;
        hsync : std_logic;
        vsync : std_logic;
        vde : std_logic;
    end record;

    type tmds_t is record
        clk_p : std_logic;
        clk_n : std_logic;
        data_p : std_logic_vector(2 downto 0);
        data_n : std_logic_vector(2 downto 0);
    end record;

    type pixel_t is record
        x : natural range 0 to DISPLAY_WIDTH - 1;
        y : natural range 0 to DISPLAY_HEIGHT - 1;
    end record;

    type pattern_t is (
        PATTERN_BLANK,
        PATTERN_SOLID,
        PATTERN_CHECKERS1,
        PATTERN_CHECKERS2,
        PATTERN_CHECKERS4
    );
end package;
