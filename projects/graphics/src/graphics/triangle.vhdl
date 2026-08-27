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
        pixel : in vector2_t;
        param : in param_triangle_t;
        valid : out std_logic;
        hit : out std_logic;
        color : out rgb_t
    );
end entity;

architecture arch of triangle is
    type state_t is (
        S_SETUP1,
        S_SETUP2,
        S_SETUP3,
        S_SETUP4,
        S_PIPING
    );

    signal state : state_t;

    signal piping_counter : natural range 0 to 5;

    signal b : vector2_t;
    signal c : vector2_t;

    signal d : fixed_t;
    signal invd : fixed_t;

    signal p : vector2_t;
    signal wbn : fixed_t;
    signal wcn : fixed_t;

    signal wb : fixed_t;
    signal wc : fixed_t;

    signal ina : std_logic;
    signal inb : std_logic;
    signal inc : std_logic;

    signal dgrstn : std_logic;
    signal dgen : std_logic;
    signal dgdivisor : std_logic_vector(23 downto 0);
    signal dgdividend : std_logic_vector(23 downto 0);
    signal dgvalid : std_logic;
    signal dgout : std_logic_vector(39 downto 0);
begin
    div_gen_0_inst : div_gen_0
        port map (
            aclk => clk,
            aresetn => dgrstn,
            s_axis_divisor_tvalid => dgen,
            s_axis_divisor_tready => open,
            s_axis_divisor_tdata => dgdivisor,
            s_axis_dividend_tvalid => dgen,
            s_axis_dividend_tready => open,
            s_axis_dividend_tdata => dgdividend,
            m_axis_dout_tvalid => dgvalid,
            m_axis_dout_tdata => dgout
        );

    process (clk) is
        variable wa_v : fixed_t;
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                state <= S_SETUP1;
                piping_counter <= 0;

                b <= to_vector2(0, 0);
                c <= to_vector2(0, 0);
                p <= to_vector2(0, 0);
                d <= to_fixed(0);
                wbn <= to_fixed(0);
                wcn <= to_fixed(0);
                wb <= to_fixed(0);
                wc <= to_fixed(0);
                hit <= '0';

                dgrstn <= '0';
                dgen <= '0';
                dgdivisor <= (others => '0');
                dgdividend <= (others => '0');
            else
                dgrstn <= '1';

                case (state) is
                    when S_SETUP1 =>
                        b <= param.b - param.a;
                        c <= param.c - param.a;
                        state <= S_SETUP2;

                    when S_SETUP2 =>
                        d <= resize_fixed(b.x * c.y - c.x * b.y);
                        state <= S_SETUP3;

                    when S_SETUP3 =>
                        dgdividend <= std_logic_vector(to_signed(1, dgdividend'length));
                        dgdivisor <= to_stdlogicvector(d);
                        dgen <= '1';
                        state <= S_SETUP4;

                    when S_SETUP4 =>
                        if (dgvalid = '1') then
                            invd <= to_sfixed(to_integer(signed(dgout(23 downto 0))), invd'left, invd'right);
                            dgen <= '0';
                            state <= S_PIPING;
                        end if;

                    when S_PIPING =>
                        if (hold /= '1') then
                            p <= pixel - param.a;

                            wbn <= resize_fixed(p.x * c.y - p.y * c.x);
                            wcn <= resize_fixed(p.y * b.x - p.x * b.y);

                            wb <= resize_fixed(wbn * invd);
                            wc <= resize_fixed(wcn * invd);

                            wa_v := resize_fixed(1 - wb - wc);
                            ina <= '1' when (wa_v >= 0 and wa_v <= 1) else '0';
                            inb <= '1' when (wb >= 0 and wb <= 1) else '0';
                            inc <= '1' when (wc >= 0 and wc <= 1) else '0';

                            hit <= ina and inb and inc;
                            color <= (others => '1');

                            if (piping_counter < 5) then
                                piping_counter <= piping_counter + 1;
                            else
                                valid <= '1';
                            end if;
                        end if;
                end case;
            end if;
        end if;
    end process;
end architecture;
