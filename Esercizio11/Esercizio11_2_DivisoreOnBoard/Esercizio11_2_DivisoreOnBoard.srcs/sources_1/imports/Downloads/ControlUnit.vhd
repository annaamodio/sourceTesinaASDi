----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.01.2023 11:29:46
-- Design Name: 
-- Module Name: ControlUnit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ControlUnit is
    Port (
        CLK: in std_logic;
        RST: in std_logic;
        start: in std_logic;
        fine_conteggio: in  std_logic;
        s: in std_logic;
        store:out std_logic;
        shift: out std_logic;
        load_a: out std_logic;
        load_q: out std_logic;
        load_m: out std_logic;
        load_zero: out std_logic;
        en_count:out std_logic;
        sel: out std_logic;
        fine_operazione : out std_logic
    );
end ControlUnit;

architecture Behavioral of ControlUnit is
    type state is (idle, q1, q2, q3, q4, q5,q6);
    signal current_state: state := idle;
begin
    automa:process (CLK)
    begin
        if(rising_edge(CLK)) then
            if(RST='1') then 
                current_state <= idle;
            else
                case current_state is
                    when idle => 
                        store <='0';
                        shift <= '0';
                        load_a <= '0';
                        load_q <= '0';
                        load_m <= '0';
                        load_zero <= '0';
                        en_count <= '0';
                        sel <= '0';
                        fine_operazione<='1';    
                        if (start='1') then 
                            current_state <= q1;
                        else 
                            current_state <= idle;
                        end if;
                    
                    when q1 =>
                        fine_operazione<='0';
                        load_a <= '1';
                        load_q <= '1';
                        load_m <= '1';
                        sel <= '0';
                        store <= '1';
                        current_state <= q2;
                    
                    when q2 =>
                        load_a <= '0';
                        load_q <= '0';
                        load_m <= '0';
                        shift <= '1';
                        store <= '0';
                        sel <= '1';
                        load_zero <= '0';
                        en_count <= '0';
                        current_state <= q3;
                    
                    when q3 =>
                        shift <= '0';
                        current_state <= q4;
                        
                    when q4 => 
                        load_a <= '1';
                        store <= '1';
                        en_count <= '1';                    
                        current_state <= q5;
                    
                    when q5 =>
                        store <= '0';
                        load_zero <= '1';
                        en_count <='0';
                        load_a <= '0';
                        if(fine_conteggio = '1') then
                            if(s='1') then
                            current_state <= q6;
                            else
                            current_state <= idle;
                            end if;
                        else 
                            current_state <= q2 ;
                        end if;
                        
                    when q6 =>  
                        load_a <= '1'; --passo correttivo
                        current_state<=idle;  
                end case;
            end if;
        end if;   
    end process;

end Behavioral;
