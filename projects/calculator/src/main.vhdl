library ieee;
use ieee.std_logic_1164.all;

use work.types.all;

entity main is
    port (
        clk : in std_logic;
        rst : in std_logic; 
        switches : in switches_t;
        buttons : in buttons_t;
        leds : out leds_t;
        rgb_led_pins : out rgb_led_pins_t
    );
end entity;

architecture arch of main is
    type state_t is (
        S_ADD1,
        S_ADD2,
        S_ADD3,

        S_SUB1,
        S_SUB2,
        S_SUB3
    );

    signal state : state_t;

    signal rgb_led_color : rgb_led_color_t;

    signal buttons_prev : buttons_t;
    signal buttons_pressed : buttons_t;

    signal a : word_t;
    signal b : word_t;

    type results_t is record
        add : word_t;
        sub : word_t;
    end record;

    signal results : results_t;
begin
    adder : entity work.adder
        port map (
            a => a,
            b => b,
            cin => '0',
            s => results.add
        );

    subtractor : entity work.subtractor
        port map (
            a => a,
            b => b,
            bin => '0',
            d => results.sub
        );

    rgb_led : entity work.rgb_led
        port map (
            clk => clk,
            rst => rst,
            color => rgb_led_color,
            brightness => 5,
            pins => rgb_led_pins
        );

    process (clk, rst) is
    begin
        if (rst = '1') then
            state <= S_ADD1;
            rgb_led_color <= C_GREEN;
            a <= (others => '0');
            b <= (others => '0');
            buttons_prev <= (others => '0');
            buttons_pressed <= (others => '0');
            leds <= (others => '0');

        elsif (rising_edge(clk)) then
            buttons_prev <= (fwd => buttons.fwd, 
                             back => buttons.back, 
                             cycle_mode => buttons.cycle_mode);

            buttons_pressed <= (fwd => buttons.fwd and not buttons_prev.fwd,
                                back => buttons.back and not buttons_prev.back,
                                cycle_mode => buttons.cycle_mode and not buttons_prev.cycle_mode);

            case (state) is
                when S_ADD1 => 
                    a <= switches;
                    leds <= a;

                    if (buttons_pressed.fwd = '1') then
                        state <= S_ADD2;
                    elsif (buttons_pressed.back = '1') then
                        state <= S_ADD3;
                    end if;

                when S_ADD2 =>
                    b <= switches;
                    leds <= b;

                    if (buttons_pressed.fwd = '1') then
                        state <= S_ADD3;
                    elsif (buttons_pressed.back = '1') then
                        state <= S_ADD1;
                    end if;

                when S_ADD3 =>
                    leds <= results.add;

                    if (buttons_pressed.fwd = '1') then
                        state <= S_ADD1;
                    elsif (buttons_pressed.back = '1') then
                        state <= S_ADD2;
                    end if;

                when S_SUB1 =>
                    a <= switches;
                    leds <= a;

                    if (buttons_pressed.fwd = '1') then
                        state <= S_SUB2;
                    elsif (buttons_pressed.back = '1') then
                        state <= S_SUB3;
                    end if;

                when S_SUB2 => 
                    b <= switches;
                    leds <= b;

                    if (buttons_pressed.fwd = '1') then
                        state <= S_SUB3;
                    elsif (buttons_pressed.back = '1') then
                        state <= S_SUB1;
                    end if;

                when S_SUB3 =>
                    leds <= results.sub;

                    if (buttons_pressed.fwd = '1') then
                        state <= S_SUB1;
                    elsif (buttons_pressed.back = '1') then
                        state <= S_SUB2;
                    end if;
            end case;

            case (state) is
                when S_ADD1 | S_ADD2 | S_ADD3 =>
                    rgb_led_color <= C_GREEN;
                    if (buttons_pressed.cycle_mode = '1') then
                        state <= S_SUB1;
                    end if;

                when S_SUB1 | S_SUB2 | S_SUB3 =>
                    rgb_led_color <= C_RED;
                    if (buttons_pressed.cycle_mode = '1') then
                        state <= S_ADD1;
                    end if;
            end case;
        end if;
    end process;
end architecture;
