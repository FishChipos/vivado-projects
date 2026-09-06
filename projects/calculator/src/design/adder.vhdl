library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.types.all;

entity adder is
    port (
        a : in word_t;
        b : in word_t;
        cin : in std_logic;
        s : out word_t;
        cout : out std_logic
    );
end entity;

architecture arch of adder is
    signal sum : unsigned(word_t'length downto 0);
begin
    sum <= resize(unsigned(a), sum'length) +
           resize(unsigned(b), sum'length) +
           resize(unsigned'(0 => cin), sum'length);

    s <= word_t(sum(word_t'length - 1 downto 0));
    cout <= sum(word_t'length);
end architecture;
