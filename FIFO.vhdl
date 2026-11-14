library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fifo_memory is
    generic (
        DATA_WIDTH : integer := 8;
        FIFO_DEPTH : integer := 16
    );
    port (
        clk   : in  STD_LOGIC;
        rst   : in  STD_LOGIC;
        wr_en : in  STD_LOGIC;
        rd_en : in  STD_LOGIC;
        din   : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
        dout  : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
        full  : out STD_LOGIC;
        empty : out STD_LOGIC
    );

end fifo_memory;


architecture rtl of fifo_memory is

    -- Memory declaration
    type ram_type is array (0 to FIFO_DEPTH-1) of STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);

    signal memory : ram_type := (others => (others => '0'));

    -- Read and write pointers
    signal wr_ptr : integer range 0 to FIFO_DEPTH-1 := 0;
    signal rd_ptr : integer range 0 to FIFO_DEPTH-1 := 0;

    -- Number of stored elements
    signal count : integer range 0 to FIFO_DEPTH := 0;

    -- Internal status flags
    signal full_i  : STD_LOGIC;
    signal empty_i : STD_LOGIC;

begin

    -- Full and Empty detection
    full_i <= '1' when count = FIFO_DEPTH else '0';

    empty_i <= '1' when count = 0 else '0';

    full  <= full_i;
    empty <= empty_i;


    -- FIFO Read and Write Operations
    process(clk, rst)

        variable write_accept : boolean;
        variable read_accept  : boolean;

    begin
        if rst = '1' then
            wr_ptr <= 0;
            rd_ptr <= 0;
            count  <= 0;
            dout   <= (others => '0');

        elsif rising_edge(clk) then
            write_accept := false;
            read_accept  := false;


            -- WRITE OPERATION
            if wr_en = '1' and full_i = '0' then
                memory(wr_ptr) <= din;
                if wr_ptr = FIFO_DEPTH-1 then
                    wr_ptr <= 0;
                else
                    wr_ptr <= wr_ptr + 1;
                end if;
                write_accept := true;
            end if;


            -- READ OPERATION
            if rd_en = '1' and empty_i = '0' then
                dout <= memory(rd_ptr);
                if rd_ptr = FIFO_DEPTH-1 then
                    rd_ptr <= 0;
                else
                    rd_ptr <= rd_ptr + 1;
                end if;
                read_accept := true;
            end if;


            -- OCCUPANCY COUNTER
            if write_accept and not read_accept then
                count <= count + 1;

            elsif read_accept and not write_accept then
                count <= count - 1;

            end if;
        end if;
    end process;

end rtl;
