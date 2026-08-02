library ieee;
use ieee.std_logic_1164.all;

entity blinker is
    generic
    (
        BLINK_FREQ : natural
    );
    port 
    (
        clk : in std_logic;
        hold : in std_logic;
        led : out std_logic := '0'
    );
end entity;

architecture arch of blinker is
    signal scaled : std_logic;
begin
    prescaler : entity work.prescaler 
        generic map
        (
            SCALED_FREQ => BLINK_FREQ
        )
        port map
        (
            clk => clk,
            scaled => scaled
        );

    process (scaled) is
    begin
        if (rising_edge(scaled)) then
            if (hold /= '1') then
                led <= not led;
            end if;
        end if;
    end process;
end architecture;
