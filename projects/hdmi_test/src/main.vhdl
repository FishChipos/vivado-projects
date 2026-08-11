library ieee;
use ieee.std_logic_1164.all;

use work.types.all;

entity main is
    port (
        rst : in std_logic;
        sys_clk : in std_logic;
        tmds : out tmds_t
    );
end entity;

architecture arch of main is
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

    signal pixel_clk : std_logic;

    signal vid : vid_t;
begin
    clk_wiz_0_inst : clk_wiz_0
        port map (
            pixel_clk => pixel_clk,
            reset => rst,
            locked => open,
            sys_clk => sys_clk
        );

    v_tc_0_inst : v_tc_0
        port map (
            clk => pixel_clk,
            clken => '1',
            gen_clken => '1',
            sof_state => '0',
            hsync_out => vid.hsync,
            vsync_out => vid.vsync,
            active_video_out => vid.vde,
            resetn => rst,
            fsync_out => open
        );

    rgb2dvi_0_inst : rgb2dvi_0
        port map (
            tmds_clk_p => tmds.clk_p,
            tmds_clk_n => tmds.clk_n,
            tmds_data_p => tmds.data_p,
            tmds_data_n => tmds.data_n,
            arst => rst,
            vid_pdata => vid.data,
            vid_pvde => vid.vde,
            vid_phsync => vid.hsync,
            vid_pvsync => vid.vsync,
            pixelclk => pixel_clk
        );
end architecture;
