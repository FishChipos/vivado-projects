library ieee;
use ieee.std_logic_1164.all;

package components is
    component clk_wiz
        port (
            pixel_clk : out std_logic;
            serial_clk : out std_logic;
            rst : in std_logic;
            sys_clk : in std_logic
        );
    end component;

    component vtc
        port (
            clk : in std_logic;
            clken : in std_logic;
            rst : in std_logic;
            hsync : out std_logic;
            vde : out std_logic;
            vsync : out std_logic
        );
    end component;

    component rgb_to_hdmi
        port (
            pixel_clk : in std_logic;
            serial_clk : in std_logic;
            rst : in std_logic;
            rgb : in std_logic_vector(23 downto 0);
            vsync : in std_logic;
            hsync : in std_logic;
            vde : in std_logic;
            clk_n : out std_logic;
            data_p : out std_logic_vector(2 downto 0);
            clk_p : out std_logic;
            data_n : out std_logic_vector(2 downto 0)
        );
    end component;
end package;
