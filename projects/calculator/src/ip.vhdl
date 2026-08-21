library ieee;
use ieee.std_logic_1164.all;

package ip is
    component processing_system7_0
        port (
            ps_clk : inout std_logic;
            ps_srstb : inout std_logic;
            mio : inout std_logic_vector(53 downto 0);
            ps_porb : inout std_logic
        );
    end component;
end package;
