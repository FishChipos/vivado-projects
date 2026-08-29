library ieee;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;

use work.types.all;
use work.ip.all;
use work.graphics.all;
use work.vector2.all;

entity main is
    port (
        sys_clk : in std_logic;
        buttons : in buttons_t;
        tmds : out tmds_t
    );
end entity;

architecture arch of main is
    constant TRIANGLE_VERTICES : vertices_t(0 to 2)(
        x(11 downto 0),
        y(10 downto 0)
    ) := (
        (to_sfixed(0, 11, 0), to_sfixed(0, 10, 0)),
        (to_sfixed(0, 11, 0), to_sfixed(720, 10, 0)),
        (to_sfixed(1280, 11, 0), to_sfixed(0, 10, 0))
    );

    type vid_timing_pipe_t is array (0 to 66) of vid_timing_t;
    signal vid_timing_pipe : vid_timing_pipe_t;

    signal pixel : vector2_t(
        x(11 downto 0),
        y(10 downto 0)
    );

    signal triangle_hold : std_logic;
    signal triangle_valid : std_logic;
    signal triangle_hit : std_logic;
    signal triangle_color : rgb_t;

    signal buttons_prev : buttons_t;
    signal buttons_pressed : buttons_t;

    signal pixel_clk : std_logic;
    signal serial_clk : std_logic;

    signal vid : vid_t;
    signal vid_timing : vid_timing_t;
begin
    clk_wiz_0_inst : clk_wiz_0
        port map (
            pixel_clk => pixel_clk,
            serial_clk => serial_clk,
            reset => buttons.reset,
            sys_clk => sys_clk
        );

    v_tc_0_inst : v_tc_0
        port map (
            clk => pixel_clk,
            clken => '1',
            gen_clken => '1',
            sof_state => '0',
            hsync_out => vid_timing.hsync,
            vsync_out => vid_timing.vsync,
            active_video_out => vid_timing.vde,
            resetn => not buttons.reset,
            fsync_out => open
        );

    rgb2dvi_0_inst : rgb2dvi_0
        port map (
            tmds_clk_p => tmds.clk_p,
            tmds_clk_n => tmds.clk_n,
            tmds_data_p => tmds.data_p,
            tmds_data_n => tmds.data_n,
            arst => buttons.reset,
            vid_pdata => vid.data,
            vid_pvde => vid.timing.vde,
            vid_phsync => vid.timing.hsync,
            vid_pvsync => vid.timing.vsync,
            pixelclk => pixel_clk,
            serialclk => serial_clk
        );

    triangle_inst : entity work.triangle
        port map (
            clk => pixel_clk,
            rst => buttons.reset,
            hold => triangle_hold,
            pixel => pixel,
            vertices => TRIANGLE_VERTICES,
            valid => triangle_valid,
            hit => triangle_hit,
            color => triangle_color
        );


    process (pixel_clk) is
    begin
        if (rising_edge(pixel_clk)) then
            if (buttons.reset = '1') then
                pixel <= (to_sfixed(0, pixel.x), to_sfixed(0, pixel.y));
                vid.timing <= (others => '0');
                triangle_hold <= '0';
            else
                if (triangle_hit = '1') then
                    vid.data <= triangle_color;
                else
                    vid.data <= (others => '0');
                end if;

                vid.timing <= vid_timing_pipe(vid_timing_pipe'high);

                if (vid_timing.vsync = '1') then
                    pixel <= (to_sfixed(0, pixel.x), to_sfixed(0, pixel.y));
                elsif (vid_timing.vde = '1') then
                    if (pixel.x >= 1280 - 1) then
                        pixel.x <= to_sfixed(0, pixel.x);
                        pixel.y <= resize(pixel.y + 1, pixel.y);
                    else
                        pixel.x <= resize(pixel.x + 1, pixel.x);
                    end if;
                end if;
            end if;
        end if;
    end process;

    process (pixel_clk) is
    begin
        if (rising_edge(pixel_clk)) then
            vid_timing_pipe <= (vid_timing, vid_timing_pipe(0 to vid_timing_pipe'high - 1));
        end if;
    end process;
end architecture;
