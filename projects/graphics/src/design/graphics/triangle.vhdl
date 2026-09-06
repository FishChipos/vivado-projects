library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;

use work.graphics.all;
use work.vector2.all;
use work.types.all;

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
    constant LATENCY : natural := 14;
    constant LATENCY_DG : natural := 32;
    signal valid_pipe : std_logic_vector(0 to LATENCY + LATENCY_DG - 1);

    type sfixed_pipe_t is array (natural range <>) of sfixed;

    function shift_in (pipe : sfixed_pipe_t; val : sfixed) return sfixed_pipe_t is
    begin
        return (val, pipe(pipe'low to pipe'high - 1));
    end function;

    function peek (pipe : sfixed_pipe_t) return sfixed is
    begin
        return pipe(pipe'high);
    end function;

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

    -- 3 cycles.
    type s2_t is record
        d1 : sfixed_pipe_t(0 to 2)(24 downto 0);
        d2 : sfixed_pipe_t(0 to 2)(24 downto 0);
        wbn1 : sfixed_pipe_t(0 to 2)(24 downto 0);
        wbn2 : sfixed_pipe_t(0 to 2)(24 downto 0);
        wcn1 : sfixed_pipe_t(0 to 2)(24 downto 0);
        wcn2 : sfixed_pipe_t(0 to 2)(24 downto 0);
    end record;

    -- 1 cycle.
    type s3_t is record
        d : sfixed(25 downto 0);
        wbn : sfixed_pipe_t(0 to LATENCY_DG - 1)(25 downto 0);
        wcn : sfixed_pipe_t(0 to LATENCY_DG - 1)(25 downto 0);
    end record;

    -- LATENCY_DG cycles.
    signal drec_slv : std_logic_vector(27 downto 0);

    -- 1 cycle.
    type s4_t is record
        drec : sfixed(1 downto -26);
    end record;

    -- 5 cycles.
    -- This will use chained DSPs so MREG and PREG need to be inferred twice.
    type s5_t is record
        wb : sfixed_pipe_t(0 to 4)(27 downto -26);
        wc : sfixed_pipe_t(0 to 4)(27 downto -26);
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

    component drec_calc
        port (
            d : in std_logic_vector(25 downto 0);
            clk : in std_logic;
            clken : in std_logic;
            drec : out std_logic_vector(27 downto 0)
        );
    end component;
begin
    drec_calc_inst : drec_calc
        port map (
            clk => clk,
            clken => not hold,
            d => to_slv(s3.d),
            drec => drec_slv
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
                    d1 => shift_in(s2.d1, s1.b.x * s1.c.y),
                    d2 => shift_in(s2.d2, s1.c.x * s1.b.y),
                    wbn1 => shift_in(s2.wbn1, s1.p.x * s1.c.y),
                    wbn2 => shift_in(s2.wbn2, s1.p.y * s1.c.x),
                    wcn1 => shift_in(s2.wcn1, s1.p.y * s1.b.x),
                    wcn2 => shift_in(s2.wcn2, s1.p.x * s1.b.y)
                );

                s3 <= (
                    d => s2.d1(1) - s2.d2(1),
                    wbn => shift_in(s3.wbn, peek(s2.wbn1) - peek(s2.wbn2)),
                    wcn => shift_in(s3.wcn, peek(s2.wcn1) - peek(s2.wcn2))
                );

                s4 <= (
                    drec => to_sfixed(drec_slv(27 downto 0), s4.drec)
                );

                s5 <= (
                    wb => shift_in(s5.wb, peek(s3.wbn) * s4.drec),
                    wc => shift_in(s5.wc, peek(s3.wcn) * s4.drec)
                );

                s6 <= (
                    wa => resize(to_sfixed(1, 1, 0) - peek(s5.wb) - peek(s5.wc), 28, -26),
                    wb => peek(s5.wb),
                    wc => peek(s5.wc)
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
