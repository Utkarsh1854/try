
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_4_TB is
end ALU_4_TB;

architecture Behavioral of ALU_4_TB is

    SIGNAL A   : STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL B   : STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL F   : STD_LOGIC_VECTOR(2 downto 0);
    SIGNAL Y   : STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL C_B : STD_LOGIC;

begin

    UUT: entity work.ALU_4
        PORT MAP (
            A   => A,
            B   => B,
            F   => F,
            Y   => Y,
            C_B => C_B
        );

    PROCESS
    begin

        A <= "1010";
        B <= "1100";

        F <= "000";  -- AND
        WAIT FOR 10 ns;

        F <= "001";  -- NAND
        WAIT FOR 10 ns;

        F <= "010";  -- OR
        WAIT FOR 10 ns;

        F <= "011";  -- NOR
        WAIT FOR 10 ns;

        F <= "100";  -- XOR
        WAIT FOR 10 ns;

        F <= "101";  -- XNOR
        WAIT FOR 10 ns;

        F <= "110";  -- Default
        WAIT FOR 10 ns;

        F <= "111";  -- Default
        WAIT FOR 10 ns;

        A <= "1111";
        B <= "0000";

        F <= "000";
        WAIT FOR 10 ns;

        F <= "001";
        WAIT FOR 10 ns;

        F <= "010";
        WAIT FOR 10 ns;

        F <= "011";
        WAIT FOR 10 ns;

        F <= "100";
        WAIT FOR 10 ns;

        F <= "101";
        WAIT FOR 10 ns;

        WAIT;

    end PROCESS;

end Behavioral;
