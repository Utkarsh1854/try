
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Universal_Shift_Register is
    Port (
        Clk        : in  STD_LOGIC;
        Reset      : in  STD_LOGIC;
        Sel        : in  STD_LOGIC_VECTOR(1 downto 0);
        Serial_In  : in  STD_LOGIC;
        Parallel_In  : in  STD_LOGIC_VECTOR(3 downto 0);
        Parallel_Out : out STD_LOGIC_VECTOR(3 downto 0);
        Serial_Out : out STD_LOGIC
    );
end Universal_Shift_Register;

architecture Behavioral of Universal_Shift_Register is
    signal Reg_Data : STD_LOGIC_VECTOR(3 downto 0) := "0000";
                    
begin

    process(Clk, Reset)
    begin

        if Reset = '1' then
            Reg_Data <= (others => '0');

        elsif rising_edge(Clk) then
            case Sel is
                -- SISO / SIPO Operation
                when "00" => Reg_Data <= Serial_In & Reg_Data(3 downto 1);

                -- PISO Operation
                when "01" => Reg_Data <= '0' & Reg_Data(3 downto 1);

                -- PIPO Operation
                when "10" => Reg_Data <= Parallel_In;

                -- Hold State
                when others => Reg_Data <= Reg_Data;

            end case;
        end if;
    end process;

    Parallel_Out <= Reg_Data;
    Serial_Out   <= Reg_Data(0);

end Behavioral;
