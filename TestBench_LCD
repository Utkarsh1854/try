
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity lcd_interface_tb is
end lcd_interface_tb;

architecture Behavioral of lcd_interface_tb is

    -- Component signals
    signal clk    : STD_LOGIC := '0';
    signal rst    : STD_LOGIC := '0';
    signal lcd_e  : STD_LOGIC;
    signal lcd_rs : STD_LOGIC;
    signal lcd_rw : STD_LOGIC;
    signal lcd_db : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- DUT INSTANTIATION
    uut: entity work.lcd_interface
        generic map (
            POWERUP_CYCLES => 10,
            CYCLE_CYCLES   => 20,
            E_LOW_CYCLES   => 3,
            E_HIGH_END     => 10
        )
        port map (
            clk    => clk,
            rst    => rst,
            lcd_e  => lcd_e,
            lcd_rs => lcd_rs,
            lcd_rw => lcd_rw,
            lcd_db => lcd_db
        );

    -- CLOCK GENERATION
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- TEST PROCESS
    stim_process: process
    begin

        -- RESET
        rst <= '1';
        wait for 20 ns;

        rst <= '0';
        wait for 20 ns;

        -- WAIT FOR LCD INITIALIZATION
        wait for 1500 ns;

        -- WAIT FOR HELLO WORLD TRANSMISSION
        wait for 3000 ns;

        -- END SIMULATION
        wait;

    end process;

end Behavioral;
