library ieee;
use ieee.std_logic_1164.all;

entity main is
    port (
        clk : in std_logic;
        toggle : in std_logic;
        led : out std_logic;

        ddr_cas_n : inout std_logic;
        ddr_cke : inout std_logic;
        ddr_ck_n : inout std_logic;
        ddr_ck_p : inout std_logic;
        ddr_cs_n : inout std_logic;
        ddr_reset_n : inout std_logic;
        ddr_odt : inout std_logic;
        ddr_ras_n : inout std_logic;
        ddr_we_n : inout std_logic;
        ddr_ba : inout std_logic_vector(2 downto 0);
        ddr_addr : inout std_logic_vector(14 downto 0);
        ddr_dm : inout std_logic_vector(3 downto 0);
        ddr_dq : inout std_logic_vector(31 downto 0);
        ddr_dqs_n : inout std_logic_vector(3 downto 0);
        ddr_dqs_p : inout std_logic_vector(3 downto 0);
        fixed_io_mio : inout std_logic_vector(53 downto 0);
        fixed_io_ddr_vrn : inout std_logic;
        fixed_io_ddr_vrp : inout std_logic;
        fixed_io_ps_srstb : inout std_logic;
        fixed_io_ps_clk : inout std_logic;
        fixed_io_ps_porb : inout std_logic
    );
end entity;

architecture arch of main is
    signal toggle_prev : std_logic;
    signal toggle_pressed : std_logic;

    component ps7
        port (
            ddr_cas_n : inout std_logic;
            ddr_cke : inout std_logic;
            ddr_ck_n : inout std_logic;
            ddr_ck_p : inout std_logic;
            ddr_cs_n : inout std_logic;
            ddr_reset_n : inout std_logic;
            ddr_odt : inout std_logic;
            ddr_ras_n : inout std_logic;
            ddr_we_n : inout std_logic;
            ddr_ba : inout std_logic_vector(2 downto 0);
            ddr_addr : inout std_logic_vector(14 downto 0);
            ddr_dm : inout std_logic_vector(3 downto 0);
            ddr_dq : inout std_logic_vector(31 downto 0);
            ddr_dqs_n : inout std_logic_vector(3 downto 0);
            ddr_dqs_p : inout std_logic_vector(3 downto 0);
            fixed_io_mio : inout std_logic_vector(53 downto 0);
            fixed_io_ddr_vrn : inout std_logic;
            fixed_io_ddr_vrp : inout std_logic;
            fixed_io_ps_srstb : inout std_logic;
            fixed_io_ps_clk : inout std_logic;
            fixed_io_ps_porb : inout std_logic
        );
    end component;
begin
    ps7_inst : ps7
        port map (
            ddr_cas_n,
            ddr_cke,
            ddr_ck_n,
            ddr_ck_p,
            ddr_cs_n,
            ddr_reset_n,
            ddr_odt,
            ddr_ras_n,
            ddr_we_n,
            ddr_ba,
            ddr_addr,
            ddr_dm,
            ddr_dq,
            ddr_dqs_n,
            ddr_dqs_p,
            fixed_io_mio,
            fixed_io_ddr_vrn,
            fixed_io_ddr_vrp,
            fixed_io_ps_srstb,
            fixed_io_ps_clk,
            fixed_io_ps_porb
        );

    process (clk) is
    begin
        if (rising_edge(clk)) then
            toggle_prev <= toggle;
            toggle_pressed <= toggle and not toggle_prev;

            if (toggle_pressed) then
                led <= not led;
            end if;
        end if;
    end process;
end architecture;
