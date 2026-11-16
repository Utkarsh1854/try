
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Universal_Shift_Register_tb is
end Universal_Shift_Register_tb;

architecture Behavioral of Universal_Shift_Register_tb is

    signal Clk          : STD_LOGIC := '0';
    signal Reset        : STD_LOGIC := '0';
    signal Sel          : STD_LOGIC_VECTOR(1 downto 0);
    signal Serial_In    : STD_LOGIC;
    signal Parallel_In  : STD_LOGIC_VECTOR(3 downto 0);
    signal Parallel_Out : STD_LOGIC_VECTOR(3 downto 0);
    signal Serial_Out   : STD_LOGIC;

begin

    -- DUT INSTANTIATION
    uut: entity work.Universal_Shift_Register
        port map (
            Clk          => Clk,
            Reset        => Reset,
            Sel          => Sel,
            Serial_In    => Serial_In,
            Parallel_In  => Parallel_In,
            Parallel_Out => Parallel_Out,
            Serial_Out   => Serial_Out
        );

    -- CLOCK GENERATION
    clk_process: process
    begin
        while true loop
            Clk <= '0';
            wait for 5 ns;
            Clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- TEST STIMULUS
    stim_process: process
    begin

        -- RESET
        Reset <= '1';
        wait for 20 ns;
        Reset <= '0';
        wait for 10 ns;

        -- PIPO OPERATION
        Sel <= "10";
        Parallel_In <= "1010";
        wait for 10 ns;

        -- SISO / SIPO OPERATION
        Sel <= "00";
        Serial_In <= '1';
        wait for 10 ns;

        Serial_In <= '0';
        wait for 10 ns;

        Serial_In <= '1';
        wait for 10 ns;

        Serial_In <= '1';
        wait for 10 ns;

        -- PISO OPERATION
        Sel <= "01";
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;

        -- HOLD OPERATION
        Sel <= "10";
        Parallel_In <= "1100";
        wait for 10 ns;

        Sel <= "11";
        wait for 30 ns;

        -- RESET AGAIN
        Reset <= '1';
        wait for 10 ns;
        Reset <= '0';

        wait for 20 ns;

        -- END SIMULATION
        wait;

    end process;

end Behavioral;
