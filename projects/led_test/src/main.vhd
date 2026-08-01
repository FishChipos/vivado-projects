library ieee;
use ieee.std_logic_1164.all;

entity led_test is
    port (
        a : out std_logic
    );
end led_test;

architecture arch of led_test is
begin
    a <= '1';
end arch;
