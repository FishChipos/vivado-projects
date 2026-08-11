library ieee;
use ieee.std_logic_1164.all;

package types is
    type vid_t is record
        data : std_logic_vector(23 downto 0);
        hsync : std_logic;
        vsync : std_logic;
        vde : std_logic;
    end record;

    type tmds_t is record
        clk_p : std_logic;
        clk_n : std_logic;
        data_p : std_logic;
        data_n : std_logic;
    end record;
end package;
