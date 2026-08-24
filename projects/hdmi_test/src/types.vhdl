library ieee;
use ieee.std_logic_1164.all;

package types is
    constant WIDTH : natural := 1280;
    constant HEIGHT : natural := 720;

    type vid_t is record
        data : std_logic_vector(23 downto 0);
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
        x : natural range 0 to WIDTH - 1;
        y : natural range 0 to HEIGHT - 1;
    end record;

    type parity_t is record
        x : std_logic;
        y : std_logic;
    end record;

    type parity_counter_t is record
        x : natural range 0 to 3;
        y : natural range 0 to 3;
    end record;
end package;
