library ieee;
use ieee.std_logic_1164.all;

entity main is
    port
    (
        clk : in std_logic;
        hold : in std_logic;
        led : out std_logic
    );
end entity;

architecture arch of main is
begin
    blinker : entity work.blinker
        generic map
        (
            BLINK_FREQ => 1
        )
        port map
        (
            clk => clk,
            hold => hold,
            led => led
        );
end architecture;
