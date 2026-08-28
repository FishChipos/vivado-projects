library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;

use work.graphics.all;
use work.vector2.all;
use work.fixed.all;
use work.types.all;
use work.ip.all;

entity triangle is
    port (
        clk : in std_logic;
        rst : in std_logic;
        hold : in std_logic;
        pixel : in vector2_t;
        param : in param_triangle_t;
        valid : out std_logic;
        hit : out std_logic;
        color : out rgb_t
    );
end entity;

architecture arch of triangle is
    constant LATENCY : natural := 15;    
    constant LATENCY_DG : natural := 52;
    signal valid_pipe : std_logic_vector(LATENCY + LATENCY_DG downto 1);

    signal b : vector2_t;
    signal c : vector2_t;

    signal d1 : fixed_mul_t;
    signal d2 : fixed_mul_t;
    signal d : fixed_t;
    signal invd : fixed_t;

    signal p : vector2_t;

    signal wbn1 : fixed_mul_t;
    signal wbn2 : fixed_mul_t;
    signal wcn1 : fixed_mul_t;
    signal wcn2 : fixed_mul_t;

    type pipe_waitdg_t is array (LATENCY_DG + 2 downto 1) of fixed_t;
    signal wbn : pipe_waitdg_t;
    signal wcn : pipe_waitdg_t;

    signal wbi : fixed_mul_t;
    signal wci : fixed_mul_t;

    signal wa : fixed_t;
    signal wb : fixed_t;
    signal wc : fixed_t;

    signal ina : std_logic;
    signal inb : std_logic;
    signal inc : std_logic;

    signal dgdivisor : std_logic_vector(23 downto 0);
    signal dgdividend : std_logic_vector(23 downto 0);
    signal dgout : std_logic_vector(47 downto 0);
begin
    div_gen_0_inst : div_gen_0
        port map (
            aclk => clk,
            aclken => not hold,
            s_axis_divisor_tvalid => '1',
            s_axis_divisor_tdata => dgdivisor,
            s_axis_dividend_tvalid => '1',
            s_axis_dividend_tdata => dgdividend,
            m_axis_dout_tvalid => open,
            m_axis_dout_tdata => dgout
        );

    valid <= valid_pipe(valid_pipe'left);

    process (clk) is
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                valid_pipe <= (others => '0');
            elsif (hold /= '1') then
                b <= param.b - param.a;
                c <= param.c - param.a;
                p <= pixel - param.a;

                d1.a <= b.x;
                d1.b <= c.y;
                d2.a <= c.x;
                d2.b <= b.y;
                wbn1.a <= p.x;
                wbn1.b <= c.y;
                wbn2.a <= p.y;
                wbn2.b <= c.x;
                wcn1.a <= p.y;
                wcn1.b <= b.x;
                wcn2.a <= p.x;
                wcn2.b <= b.y;

                mul_fixed(d1);
                mul_fixed(d2);
                mul_fixed(wbn1);
                mul_fixed(wbn2);
                mul_fixed(wcn1);
                mul_fixed(wcn2);

                d <= resize_fixed(d1.r - d2.r);
                wbn(wbn'right) <= resize_fixed(wbn1.r - wbn2.r);
                wcn(wcn'right) <= resize_fixed(wcn1.r - wcn2.r);

                dgdividend <= to_slv(to_fixed(1));
                dgdivisor <= to_slv(d);
                wbn(wbn'left downto wbn'right + 1) <= wbn(wbn'left - 1 downto wbn'right);
                wcn(wbn'left downto wcn'right + 1) <= wcn(wbn'left - 1 downto wbn'right);

                invd <= resize_fixed(to_sfixed(dgout, 24, -23));

                wbi.a <= wbn(wbn'left);
                wbi.b <= invd;
                wci.a <= wcn(wcn'left);
                wci.b <= invd;

                mul_fixed(wbi);
                mul_fixed(wci);

                wa <= resize_fixed(1 - wbi.r - wci.r);
                wb <= wbi.r;
                wc <= wci.r;

                ina <= '1' when wa >= 0 and wa <= 1 else '0';
                inb <= '1' when wb >= 0 and wb <= 1 else '0';
                inc <= '1' when wc >= 0 and wc <= 1 else '0';

                hit <= ina and inb and inc;
                color <= (others => '1');

                valid_pipe(valid_pipe'left downto valid_pipe'right + 1) <= valid_pipe(valid_pipe'left - 1 downto valid_pipe'right);

                valid_pipe(valid_pipe'right) <= '1';
            end if;
        end if;
    end process;
end architecture;
