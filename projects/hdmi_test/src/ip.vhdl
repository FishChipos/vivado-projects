library ieee;
use ieee.std_logic_1164.all;

package ip is
    component clk_wiz_0
        port (
            pixel_clk : out std_logic;
            reset : in std_logic;
            locked : out std_logic;
            sys_clk : in std_logic
        );
    end component;

    component v_tc_0
        port (
            clk : in std_logic;
            clken : in std_logic;
            gen_clken : in std_logic;
            sof_state : in std_logic;
            hsync_out : out std_logic;
            vsync_out : out std_logic;
            active_video_out : out std_logic;
            resetn : in std_logic;
            fsync_out : out std_logic_vector(0 downto 0) 
        );
    end component;

    component rgb2dvi_0
        port (
            tmds_clk_p : out std_logic;
            tmds_clk_n : out std_logic;
            tmds_data_p : out std_logic_vector(2 downto 0);
            tmds_data_n : out std_logic_vector(2 downto 0);
            arst : in std_logic;
            vid_pdata : in std_logic_vector(23 downto 0);
            vid_pvde : in std_logic;
            vid_phsync : in std_logic;
            vid_pvsync : in std_logic;
            pixelclk : in std_logic 
        );
    end component;
end package;
