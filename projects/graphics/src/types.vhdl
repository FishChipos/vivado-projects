library ieee;
use ieee.std_logic_1164.all;

package types is
    type buttons_t is record
        reset : std_logic;
    end record;

    subtype rgb_t is std_logic_vector(23 downto 0);

    type vid_timing_t is record
        hsync : std_logic;
        vsync : std_logic;
        vde : std_logic;
    end record;

    type vid_t is record
        data : rgb_t;
        timing : vid_timing_t;
    end record;

    type tmds_t is record
        clk_p : std_logic;
        clk_n : std_logic;
        data_p : std_logic_vector(2 downto 0);
        data_n : std_logic_vector(2 downto 0);
    end record;
end package;
