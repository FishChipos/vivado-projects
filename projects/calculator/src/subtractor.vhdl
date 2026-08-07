library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.types.all;

entity subtractor is
    port (
        a : in word_t;
        b : in word_t;
        bin : in std_logic;
        d : out word_t;
        bout : out std_logic
    );
end entity;

architecture arch of subtractor is
    signal difference : unsigned(word_t'length downto 0);
begin
    difference <= resize(unsigned(a), difference'length) -
                  resize(unsigned(b), difference'length) -
                  resize(unsigned'(0 => bin), difference'length);

    d <= word_t(difference(word_t'length - 1 downto 0));
    bout <= difference(word_t'length);
end architecture;
