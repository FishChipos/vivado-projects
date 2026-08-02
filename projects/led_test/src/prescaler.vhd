library ieee;
use ieee.std_logic_1164.all;

entity prescaler is
    generic 
    (
        SCALED_FREQ : natural
    );
    port 
    (
        clk : in std_logic;  
        scaled : out std_logic := '0'
    );
end entity;

architecture arch of prescaler is
    constant CLK_FREQ : natural := 125000000;
begin
    process (clk) is
        variable count : natural := 0;
    begin
        if (rising_edge(clk)) then
            count := count + 1;

            if (count >= CLK_FREQ / (2 * SCALED_FREQ)) then
                scaled <= not scaled;
                count := 0;
            end if;
        end if;
    end process;
end architecture;
