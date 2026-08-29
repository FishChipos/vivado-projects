library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;

use work.graphics.all;
use work.vector2.all;
use work.types.all;
use work.ip.all;

entity triangle is
    port (
        clk : in std_logic;
        rst : in std_logic;
        hold : in std_logic;
        pixel : in vector2_t(
            x(11 downto 0),
            y(10 downto 0)
        );
        vertices : in vertices_t(0 to 2)(
            x(11 downto 0),
            y(10 downto 0)
        );
        valid : out std_logic;
        hit : out std_logic;
        color : out rgb_t
    );
end entity;

architecture arch of triangle is
    constant LATENCY : natural := 10;
    constant LATENCY_DG : natural := 32;
    signal valid_pipe : std_logic_vector(0 to LATENCY + LATENCY_DG - 1);

    type sfixed_pipe_t is array (natural range <>) of sfixed;

    -- 1 cycle.
    type s1_t is record
        b : vector2_t(
            x(12 downto 0),
            y(11 downto 0)
        );
        c : vector2_t(
            x(12 downto 0),
            y(11 downto 0)
        );
        p : vector2_t(
            x(12 downto 0),
            y(11 downto 0)
        );
    end record;

    -- 2 cycles.
    type s2_t is record
        d1 : sfixed_pipe_t(0 to 1)(24 downto 0);
        d2 : sfixed_pipe_t(0 to 1)(24 downto 0);
        wbn1 : sfixed_pipe_t(0 to 1)(24 downto 0);
        wbn2 : sfixed_pipe_t(0 to 1)(24 downto 0);
        wcn1 : sfixed_pipe_t(0 to 1)(24 downto 0);
        wcn2 : sfixed_pipe_t(0 to 1)(24 downto 0);
    end record;

    -- 1 cycle.
    type s3_t is record
        one : sfixed(1 downto 0);
        d : sfixed(25 downto 0);
        wbn : sfixed_pipe_t(0 to LATENCY_DG - 1)(25 downto 0);
        wcn : sfixed_pipe_t(0 to LATENCY_DG - 1)(25 downto 0);
    end record;

    -- LATENCY_DG cycles.
    signal invd_slv : std_logic_vector(31 downto 0);

    -- 1 cycle.
    type s4_t is record
        invd : sfixed(1 downto -26);
    end record;

    -- 2 cycles.
    type s5_t is record
        wb : sfixed_pipe_t(0 to 1)(27 downto -26);
        wc : sfixed_pipe_t(0 to 1)(27 downto -26);
    end record;

    -- 1 cycle.
    type s6_t is record
        wa : sfixed(28 downto -26);
        wb : sfixed(27 downto -26);
        wc : sfixed(27 downto -26);
    end record;

    -- 1 cycle.
    type s7_t is record
        ina : std_logic;
        inb : std_logic;
        inc : std_logic;
    end record;

    -- 1 cycle to pipe into output registers.

    signal s1 : s1_t;
    signal s2 : s2_t;
    signal s3 : s3_t;
    signal s4 : s4_t;
    signal s5 : s5_t;
    signal s6 : s6_t;
    signal s7 : s7_t;
begin
    div_gen_0_inst : div_gen_0
        port map (
            aclk => clk,
            aclken => not hold,
            s_axis_divisor_tvalid => '1',
            s_axis_divisor_tdata => (25 downto 0 => to_slv(s3.d), others => '1'),
            s_axis_dividend_tvalid => '1',
            s_axis_dividend_tdata => (1 downto 0 => to_slv(s3.one), others => '1'),
            m_axis_dout_tvalid => open,
            m_axis_dout_tdata => invd_slv
        );

    valid <= valid_pipe(valid_pipe'high);

    process (clk) is
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                valid_pipe <= (others => '0');
            elsif (hold /= '1') then
                s1 <= (
                    b => vertices(1) - vertices(0),
                    c => vertices(2) - vertices(0),
                    p => pixel - vertices(0)
                );

                s2 <= (
                    d1 => (s1.b.x * s1.c.y, s2.d1(0)),
                    d2 => (s1.c.x * s1.b.y, s2.d2(0)),
                    wbn1 => (s1.p.x * s1.c.y, s2.wbn1(0)),
                    wbn2 => (s1.p.y * s1.c.x, s2.wbn2(0)),
                    wcn1 => (s1.p.y * s1.b.x, s2.wcn1(0)),
                    wcn2 => (s1.p.x * s1.b.y, s2.wcn2(0))
                );

                s3 <= (
                    one => "01",
                    d => s2.d1(1) - s2.d2(1),
                    wbn => (s2.wbn1(1) - s2.wbn2(1), s3.wbn(0 to s3.wbn'high - 1)),
                    wcn => (s2.wcn1(1) - s2.wcn2(1), s3.wcn(0 to s3.wcn'high - 1))
                );

                s4 <= (
                    invd => to_sfixed(invd_slv(27 downto 0), s4.invd)
                );

                s5 <= (
                    wb => (s3.wbn(s3.wbn'high) * s4.invd, s5.wb(0)),
                    wc => (s3.wcn(s3.wcn'high) * s4.invd, s5.wc(0))
                );

                s6 <= (
                    wa => resize(to_sfixed(1, 1, 0) - s5.wb(1) - s5.wc(1), 28, -26),
                    wb => s5.wb(1),
                    wc => s5.wc(1)
                );

                s7.ina <= '1' when s6.wa >= 0 and s6.wa <= 1 else '0';
                s7.inb <= '1' when s6.wb >= 0 and s6.wb <= 1 else '0';
                s7.inc <= '1' when s6.wc >= 0 and s6.wc <= 1 else '0';

                hit <= s7.ina and s7.inb and s7.inc;
                color <= (others => '1');

                valid_pipe <= ('1', valid_pipe(0 to valid_pipe'high - 1));
            end if;
        end if;
    end process;
end architecture;
