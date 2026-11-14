library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity lcd_interface is
    generic (
        POWERUP_CYCLES : positive := 1000000;
        CYCLE_CYCLES   : positive := 100000;
        E_LOW_CYCLES   : positive := 2000;
        E_HIGH_END     : positive := 10000
    );

    port (
        clk    : in  STD_LOGIC;
        rst    : in  STD_LOGIC;
        lcd_e  : out STD_LOGIC;
        lcd_rs : out STD_LOGIC;
        lcd_rw : out STD_LOGIC;
        lcd_db : out STD_LOGIC_VECTOR(7 downto 0)
    );
end lcd_interface;


architecture Behavioral of lcd_interface is

    -- FSM states
    type state_type is (
        ST_RESET,
        ST_INIT,
        ST_COMMAND,
        ST_DATA,
        ST_DONE
    );

    signal state : state_type := ST_RESET;

    -- Timing counter
    signal count : unsigned(22 downto 0) := (others => '0');

    -- LCD commands
    type rom_commands is array(0 to 5) of
        STD_LOGIC_VECTOR(7 downto 0);

    constant commands : rom_commands := (
        X"38", -- 8-bit, 2-line, 5x8 font
        X"38", -- Repeat function set
        X"0C", -- Display ON, cursor OFF
        X"01", -- Clear display
        X"06", -- Entry mode
        X"80"  -- First row, first position
    );

    -- Character data
    type rom_data is array(0 to 10) of
        STD_LOGIC_VECTOR(7 downto 0);

    constant data_chars : rom_data := (
        X"48", -- H
        X"45", -- E
        X"4C", -- L
        X"4C", -- L
        X"4F", -- O
        X"20", -- Space
        X"57", -- W
        X"4F", -- O
        X"52", -- R
        X"4C", -- L
        X"44"  -- D
    );

    signal index   : integer range 0 to 10 := 0;
    signal e_state : STD_LOGIC := '0';

begin

    -- LCD Read/Write: Always Write
    lcd_rw <= '0';

    -- LCD Enable output
    lcd_e <= e_state;


    process(clk, rst)
    begin

        if rst = '1' then
            state   <= ST_RESET;
            count   <= (others => '0');
            index   <= 0;
            e_state <= '0';
            lcd_rs  <= '0';
            lcd_db  <= X"00";

        elsif rising_edge(clk) then
            case state is

                -- LCD Power-up delay
                when ST_RESET =>
                    lcd_rs <= '0';
                    e_state <= '0';

                    if count < to_unsigned(POWERUP_CYCLES, 23) then
                        count <= count + 1;
                    else
                        count <= (others => '0');
                        index <= 0;
                        state <= ST_INIT;
                    end if;


                -- Send initialization commands
                when ST_INIT =>
                    lcd_rs <= '0';
                    lcd_db <= commands(index);

                    if count < to_unsigned(CYCLE_CYCLES, 23) then
                        count <= count + 1;

                        if count < to_unsigned(E_LOW_CYCLES, 23) then
                            e_state <= '0';

                        elsif count < to_unsigned(E_HIGH_END, 23) then
                            e_state <= '1';

                        else
                            e_state <= '0';
                        end if;

                    else

                        count <= (others => '0');
                        e_state <= '0';

                        if index < 5 then
                            index <= index + 1;
                        else
                            index <= 0;
                            state <= ST_COMMAND;
                        end if;

                    end if;

                -- Command transmission state
                when ST_COMMAND =>
                    state <= ST_DATA;

                -- Send character data
                when ST_DATA =>
                    lcd_rs <= '1';
                    lcd_db <= data_chars(index);
                    if count < to_unsigned(CYCLE_CYCLES, 23) then
                        count <= count + 1;

                        if count < to_unsigned(E_LOW_CYCLES, 23) then
                            e_state <= '0';

                        elsif count < to_unsigned(E_HIGH_END, 23) then
                            e_state <= '1';

                        else
                            e_state <= '0';
                        end if;

                    else
                        count <= (others => '0');
                        e_state <= '0';
                        if index < 10 then
                            index <= index + 1;
                        else
                            state <= ST_DONE;
                        end if;
                    end if;


                -- Transmission complete
                when ST_DONE =>
                    e_state <= '0';
                    state <= ST_DONE;

                when others =>
                    state <= ST_RESET;

            end case;
        end if;
    end process;

end Behavioral;
