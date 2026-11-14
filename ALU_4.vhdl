
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_4 is
    Port (
        A   : in  STD_LOGIC_VECTOR(3 downto 0);
        B   : in  STD_LOGIC_VECTOR(3 downto 0);
        F   : in  STD_LOGIC_VECTOR(2 downto 0);
        Y   : out STD_LOGIC_VECTOR(3 downto 0);
        C_B : out STD_LOGIC
    );
end ALU_4;

architecture Behavioral of ALU_4 is

    SIGNAL RESULT : STD_LOGIC_VECTOR(4 downto 0);

begin

    PROCESS(A, B, F)
    begin

        CASE F IS

            WHEN "000" => RESULT <= '0' & (A AND B);

            WHEN "001" => RESULT <= '0' & (A NAND B);

            WHEN "010" => RESULT <= '0' & (A OR B);

            WHEN "011" => RESULT <= '0' & (A NOR B);

            WHEN "100" => RESULT <= '0' & (A XOR B);

            WHEN "101" => RESULT <= '0' & (A XNOR B);

            WHEN OTHERS => RESULT <= "00000";

        END CASE;

    END PROCESS;

    Y   <= RESULT(3 downto 0);
    C_B <= RESULT(4);

end Behavioral;
