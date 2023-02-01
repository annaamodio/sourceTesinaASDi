library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           read : in STD_LOGIC;
           enInput : out STD_LOGIC;
           saveOutput : out STD_LOGIC
           );
end ControlUnit;

architecture Behavioral of ControlUnit is

type state is (
    idle,
    start_reading,
    start_mem,
    read_ok,
    mem_ok
);

signal current_state: state := idle;

begin
    
 

    proc: process(CLK)
    begin
        if(rising_edge(CLK)) then
            if(RST = '1') then
                current_state <= idle;
                enInput <= '0';
                saveOutput <= '0';
            else
                case current_state is
                    when idle =>
                       enInput <= '0';
                       saveOutput <= '0';
                        if(read ='1') then
                            current_state <= start_reading;
                        else
                            current_state <= idle;
                        end if;
                    when start_reading =>
                        enInput <= '1';
                        current_state <= read_ok;
                    when read_ok =>
                        enInput <= '0';
                        current_state <= start_mem;
                    when start_mem =>
                        saveOutput <= '1';
                        current_state <= mem_ok;
                    when mem_ok =>
                        saveOutput <= '0';
                        current_state <= idle;
                end case;
            end if;
        end if;
    end process;

end Behavioral;