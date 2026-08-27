library ieee;
use ieee.std_logic_1164.all;

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
    constant TRIANGLE_VERTICES : param_triangle_t := (
        to_vector2(0, 0),
        to_vector2(1280, 0),
        to_vector2(0, 720)
    );

    type state_t is (
        S_WAITING,
        S_DRAWING
    );

    signal state : state_t;

    signal drawing : std_logic;

    signal pixel : vector2_t;

    signal triangle_hold : std_logic;
    signal triangle_valid : std_logic;
    signal triangle_hit : std_logic;
    signal triangle_color : rgb_t;

    signal buttons_prev : buttons_t;
    signal buttons_pressed : buttons_t;

    signal pixel_clk : std_logic;
    signal serial_clk : std_logic;

    signal vid : vid_t;

    signal resetn : std_logic;
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
            clken => drawing,
            gen_clken => '1',
            sof_state => '0',
            hsync_out => vid.hsync,
            vsync_out => vid.vsync,
            active_video_out => vid.vde,
            resetn => resetn,
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
            vid_pvde => vid.vde,
            vid_phsync => vid.hsync,
            vid_pvsync => vid.vsync,
            pixelclk => pixel_clk,
            serialclk => serial_clk
        );

    triangle_inst : entity work.triangle
        port map (
            clk => pixel_clk,
            rst => buttons.reset,
            hold => triangle_hold,
            pixel => pixel,
            param => TRIANGLE_VERTICES,
            valid => triangle_valid,
            hit => triangle_hit,
            color => triangle_color
        );

    resetn <= not buttons.reset;

    process (pixel_clk) is
    begin
        if (rising_edge(pixel_clk)) then
            if (buttons.reset = '1') then
                pixel <= to_vector2(0, 0);
                triangle_hold <= '0';
                drawing <= '0';
                state <= S_WAITING;
            else
                case (state) is
                    when S_WAITING =>
                        if (triangle_valid = '1') then
                            drawing <= '1';
                            state <= S_DRAWING;
                        end if;
                    when S_DRAWING =>
                        if (triangle_hit = '1') then
                            vid.data <= triangle_color;
                        else
                            vid.data <= (others => '0');
                        end if;

                        if (vid.vde = '1') then
                            triangle_hold <= '0';
                            pixel <= next_pixel(pixel);
                        else
                            triangle_hold <= '1';
                        end if;
                end case;
            end if;
        end if;
    end process;
end architecture;
