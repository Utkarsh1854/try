
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fifo_memory_tb is
end fifo_memory_tb;

architecture Behavioral of fifo_memory_tb is

    constant DATA_WIDTH : integer := 8;
    constant FIFO_DEPTH : integer := 16;

    signal clk   : STD_LOGIC := '0';
    signal rst   : STD_LOGIC := '0';
    signal wr_en : STD_LOGIC := '0';
    signal rd_en : STD_LOGIC := '0';

    signal din   : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0) := (others => '0');
    signal dout  : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);

    signal full  : STD_LOGIC;
    signal empty : STD_LOGIC;

begin

    -- DUT INSTANTIATION
    uut: entity work.fifo_memory
        generic map (
            DATA_WIDTH => DATA_WIDTH,
            FIFO_DEPTH => FIFO_DEPTH
        )
        port map (
            clk   => clk,
            rst   => rst,
            wr_en => wr_en,
            rd_en => rd_en,
            din   => din,
            dout  => dout,
            full  => full,
            empty => empty
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

        -- WRITE OPERATION
        wr_en <= '1';

        din <= "00000001";
        wait for 10 ns;

        din <= "00000010";
        wait for 10 ns;

        din <= "00000011";
        wait for 10 ns;

        din <= "00000100";
        wait for 10 ns;

        wr_en <= '0';
        wait for 10 ns;

        -- READ OPERATION
        rd_en <= '1';

        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;

        rd_en <= '0';
        wait for 10 ns;

        -- WRITE UNTIL FIFO IS FULL
        wr_en <= '1';

        for i in 1 to FIFO_DEPTH loop
            din <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, DATA_WIDTH));
            wait for 10 ns;
        end loop;

        wr_en <= '0';
        wait for 10 ns;

        -- READ UNTIL FIFO IS EMPTY
        rd_en <= '1';

        for i in 1 to FIFO_DEPTH loop
            wait for 10 ns;
        end loop;

        rd_en <= '0';
        wait for 10 ns;

        -- SIMULTANEOUS READ AND WRITE
        wr_en <= '1';
        rd_en <= '0';
        din <= "10101010";
        wait for 10 ns;

        din <= "11001100";
        wait for 10 ns;

        rd_en <= '1';
        din <= "11110000";
        wait for 10 ns;

        din <= "01010101";
        wait for 10 ns;

        wr_en <= '0';
        wait for 10 ns;

        rd_en <= '1';
        wait for 30 ns;

        rd_en <= '0';

        wait;

    end process;

end Behavioral;
