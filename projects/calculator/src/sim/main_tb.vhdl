library ieee;
use ieee.std_logic_1164.all;

use work.types.all;

entity main_tb is
end entity;

architecture test of main_tb is
    constant CLK_PERIOD : time := 100 ns;

    signal clk : std_logic := '0';
    signal rst : std_logic := '0'; 
    signal switches : switches_t := (others => '0');
    signal buttons : buttons_t := (others => '0');
    signal leds : leds_t;
    signal rgb_led_pins : rgb_led_pins_t;
begin
    main : entity work.main
        port map (
            clk => clk,
            rst => rst,
            switches => switches,
            buttons => buttons,
            leds => leds,
            rgb_led_pins => rgb_led_pins
        );

    process is
    begin
        clk <= not clk;
        wait for CLK_PERIOD / 2;
    end process;

    process is
    begin
        rst <= '1';

        wait for CLK_PERIOD;

        rst <= '0';

        wait;
    end process;
end architecture;
