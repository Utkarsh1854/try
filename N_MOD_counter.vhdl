
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mod_n_counter is

    generic (
        N     : integer := 10;
        WIDTH : integer := 4
    );

    port (
        clk      : in  STD_LOGIC;
        rst      : in  STD_LOGIC;
        en       : in  STD_LOGIC;
        count    : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
        max_tick : out STD_LOGIC
    );

end mod_n_counter;


architecture Behavioral of mod_n_counter is

    signal r_reg  : unsigned(WIDTH-1 downto 0);
    signal r_next : unsigned(WIDTH-1 downto 0);

begin

    -- Register Logic
    process(clk, rst)
    begin

        if rst = '1' then
            r_reg <= (others => '0');

        elsif rising_edge(clk) then

            if en = '1' then
                r_reg <= r_next;
            end if;

        end if;

    end process;


    -- Next State Logic
    r_next <= (others => '0')
              when r_reg = to_unsigned(N-1, WIDTH)
              else r_reg + 1;


    -- Output Logic
    count <= std_logic_vector(r_reg);

    max_tick <= '1'
                when r_reg = to_unsigned(N-1, WIDTH)
                else '0';

end Behavioral;
