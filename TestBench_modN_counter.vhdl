
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mod_n_counter_tb is
end mod_n_counter_tb;

architecture Behavioral of mod_n_counter_tb is

    constant N     : integer := 10;
    constant WIDTH : integer := 4;

    signal clk      : STD_LOGIC := '0';
    signal rst      : STD_LOGIC := '0';
    signal en       : STD_LOGIC := '0';
    signal count    : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
    signal max_tick : STD_LOGIC;

begin

    -- DUT INSTANTIATION
    uut: entity work.mod_n_counter
        generic map (
            N     => N,
            WIDTH => WIDTH
        )
        port map (
            clk      => clk,
            rst      => rst,
            en       => en,
            count    => count,
            max_tick => max_tick
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

    -- TEST STIMULUS
    stim_process: process
    begin

        -- RESET
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 10 ns;

        -- ENABLE COUNTER
        en <= '1';

        -- COUNT FROM 0 TO 9
        for i in 1 to N loop
            wait for 10 ns;
        end loop;

        -- DISABLE COUNTER
        en <= '0';
        wait for 30 ns;

        -- ENABLE COUNTER AGAIN
        en <= '1';

        -- COUNT AGAIN
        for i in 1 to 15 loop
            wait for 10 ns;
        end loop;

        -- RESET AGAIN
        rst <= '1';
        wait for 10 ns;
        rst <= '0';

        -- CHECK COUNTER AFTER RESET
        en <= '1';
        wait for 50 ns;

        -- END SIMULATION
        wait;

    end process;

end Behavioral;
