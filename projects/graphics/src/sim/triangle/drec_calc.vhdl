library ieee;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;

entity drec_calc is
    port (
        d : in std_logic_vector(25 downto 0);
        clk : in std_logic;
        clken : in std_logic;
        drec : out std_logic_vector(27 downto 0)
    );
end entity;

architecture arch of drec_calc is
    type d_pipe_t is array (0 to 31) of drec'subtype;

    signal d_pipe : d_pipe_t;
begin
    drec <= d_pipe(d_pipe'high);

    process (clk) is
    begin
        if (rising_edge(clk)) then
            if (clken) then
                d_pipe(d_pipe'low) <= to_slv(resize(1 / resize(to_sfixed(d, 25, 0), 25, -26), 1, -26));
                d_pipe(d_pipe'low + 1 to d_pipe'high) <= d_pipe(d_pipe'low to d_pipe'high - 1);
            end if;
        end if;
    end process;
end architecture;
