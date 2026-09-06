library ieee;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;

use work.types.all;
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

    type vid_timing_pipe_t is array (0 to 45) of vid_timing_t;
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

    component clk_wiz
        port (
            sys_clk : in std_logic;
            pixel_clk : out std_logic;
            rst : in std_logic;
            serial_clk : out std_logic
        );
    end component;

    component vtc
      port (
        rst : in std_logic;
        clken : in std_logic;
        clk : in std_logic;
        hsync : out std_logic;
        vde : out std_logic;
        vsync : out std_logic
      );
    end component;

    component rgb_to_hdmi
      port (
        serial_clk : in std_logic;
        rst : in std_logic;
        pixel_clk : in std_logic;
        rgb : in std_logic_vector(23 downto 0);
        hsync : in std_logic;
        vsync : in std_logic;
        vde : in std_logic;
        clk_n : out std_logic;
        data_p : out std_logic_vector(2 downto 0);
        clk_p : out std_logic;
        data_n : out std_logic_vector(2 downto 0)
      );
    end component;
begin
    clk_wiz_inst : clk_wiz
        port map (
            pixel_clk => pixel_clk,
            serial_clk => serial_clk,
            rst => buttons.reset,
            sys_clk => sys_clk
        );

    vtc_inst : vtc
        port map (
            clk => pixel_clk,
            clken => '1',
            hsync => vid_timing.hsync,
            vsync => vid_timing.vsync,
            vde => vid_timing.vde,
            rst => buttons.reset
        );

    rgb_to_hdmi_inst : rgb_to_hdmi
        port map (
            clk_p => tmds.clk_p,
            clk_n => tmds.clk_n,
            data_p => tmds.data_p,
            data_n => tmds.data_n,
            rst => buttons.reset,
            rgb => vid.rgb,
            vde => vid.timing.vde,
            hsync => vid.timing.hsync,
            vsync => vid.timing.vsync,
            pixel_clk => pixel_clk,
            serial_clk => serial_clk
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
                    vid.rgb <= triangle_color;
                else
                    vid.rgb <= (others => '0');
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
