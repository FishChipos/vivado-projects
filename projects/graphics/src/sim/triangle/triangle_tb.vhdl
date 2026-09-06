library ieee;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;

use work.types.all;
use work.vector2.all;
use work.graphics.all;

entity triangle_tb is
end entity;

architecture arch of triangle_tb is
    constant CYCLES : natural := 1280 * 720;

    signal rst : std_logic := '0';
    signal clk : std_logic := '0';
    signal triangle_hold : std_logic := '0';

    constant TRIANGLE_VERTICES : vertices_t(0 to 2)(
        x(11 downto 0),
        y(10 downto 0)
    ) := (
        (to_sfixed(0, 11, 0), to_sfixed(0, 10, 0)),
        (to_sfixed(0, 11, 0), to_sfixed(720, 10, 0)),
        (to_sfixed(1280, 11, 0), to_sfixed(0, 10, 0))
    );

    signal pixel : vector2_t(
        x(11 downto 0),
        y(10 downto 0)
    ) := (
        to_sfixed(0, 11, 0),
        to_sfixed(0, 10, 0)
    );

    signal triangle_valid, triangle_hit : std_logic;
    signal triangle_color : rgb_t;
begin
    triangle_inst : entity work.triangle
        port map (
            clk => clk,
            rst => rst,
            hold => triangle_hold,
            pixel => pixel,
            vertices => TRIANGLE_VERTICES,
            valid => triangle_valid,
            hit => triangle_hit,
            color => triangle_color
        );

    gen_clk : process is
        variable cycle_count : natural := 0;
    begin
        wait for 50 ns;
        clk <= '0';
        wait for 50 ns;
        clk <= '1';

        cycle_count := cycle_count + 1;

        if (cycle_count >= CYCLES) then
            wait;
        end if;
    end process;
end architecture;
