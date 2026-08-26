library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.ip.all;
use work.types.all;

entity main is
    port (
        rst : in std_logic;
        sys_clk : in std_logic;
        buttons : in buttons_t;
        tmds : out tmds_t
    );
end entity;

architecture arch of main is
    signal pixel_clk : std_logic;
    signal serial_clk : std_logic;
    signal vid : vid_t;

    signal pattern : pattern_t;

    signal buttons_prev : buttons_t;
    signal buttons_pressed : buttons_t;

    signal pixel : pixel_t;

    signal rstn : std_logic;
begin
    clk_wiz_0_inst : clk_wiz_0
        port map (
            pixel_clk => pixel_clk,
            serial_clk => serial_clk,
            reset => rst,
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
            resetn => rstn,
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
            pixelclk => pixel_clk,
            serialclk => serial_clk
        );

    pat_gen_inst : entity work.pat_gen
        port map (
            clk => pixel_clk,
            rst => rst,
            hsync => vid.hsync,
            vsync => vid.vsync,
            data => vid.data,
            pixel => pixel,
            pattern => pattern
        );                

    rstn <= not rst;

    process (pixel_clk) is
    begin
        if (rising_edge(pixel_clk)) then
            if (rst = '1') then
                pattern <= PATTERN_SOLID;
                buttons_prev <= (others => '0');
                buttons_pressed <= (others => '0');
            else
                buttons_prev <= (cycle_pattern => buttons.cycle_pattern);
                buttons_pressed <= (cycle_pattern => buttons.cycle_pattern and not buttons_prev.cycle_pattern);

                if (vid.hsync = '1') then
                    pixel.x <= 0;
                end if;

                if (vid.vsync = '1') then
                    pixel.y <= 0;
                end if;

                if (vid.vde = '1') then
                    pixel.x <= pixel.x + 1;

                    if (pixel.x = DISPLAY_WIDTH - 1) then
                        pixel.y <= pixel.y + 1;
                    end if;
                end if;

                if (buttons_pressed.cycle_pattern = '1') then
                    if (pattern = pattern_t'right) then
                        pattern <= pattern_t'left;
                    else
                        pattern <= pattern_t'rightof(pattern);
                    end if;
                end if;
            end if;
        end if;
    end process;
end architecture;
