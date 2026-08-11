library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.ip.all;
use work.types.all;

entity main is
    port (
        rst : in std_logic;
        sys_clk : in std_logic;
        tmds : out tmds_t
    );
end entity;

architecture arch of main is
    signal pixel_clk : std_logic;
    signal vid : vid_t;

    signal pixel : pixel_t;
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

    process (pixel_clk, rst) is
    begin
        if (rising_edge(pixel_clk)) then
            if (rst = '1') then
                pixel <= (others => 0);
                vid.data <= (others => '0');
            else
                if (pixel.x >= pixel.y) then
                    vid.data <= (others => '1');
                else 
                    vid.data <= (others => '0');
                end if;

                if (pixel.y >= pixel.y'high) then
                    pixel.y <= 0;
                    pixel.x <= 0;
                elsif (pixel.x >= pixel.x'high) then
                    pixel.x <= 0;
                    pixel.y <= pixel.y + 1;
                else
                    pixel.x <= pixel.x + 1;
                end if;
            end if;
        end if;
    end process;
end architecture;
