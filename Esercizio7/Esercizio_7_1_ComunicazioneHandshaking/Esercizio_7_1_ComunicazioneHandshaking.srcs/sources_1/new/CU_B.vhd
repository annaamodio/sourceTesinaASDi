

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity CU_B is
    Port ( 
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        send : in std_logic;
        enCount: out std_logic;         
        Rin  : out std_logic;
        ok   : out std_logic                  
    );
end CU_B;

architecture Behavioral of CU_B is

type state is (idle, S0, S1, S2, S3);
signal current_state: state := idle;

begin
    automa_b: process( CLK ) 
    begin 
        if(rising_edge( CLK )) then
            if(RST = '1') then
                current_state <= idle;
            else
                case current_state is
                    when idle =>
                        ok <= '0';
                        Rin <= '0';
                        enCount <= '0';
                        if(send = '1') then 
                            current_state <= S0;
                         else
                            current_state <= idle;  
                        end if;
                    when S0 =>
                        Rin <= '0';
                        current_state <= S1;
                    when S1 => 
                        Rin <= '1';
                        current_state <= S2;
                    when S2 =>
                        Rin <= '0';
                        ok <= '1';
                        current_state <= S3;
                    when S3 =>
                        ok <= '0';
                        enCount <= '1';
                        current_state <= idle;
                end case;
            end if;
        end if;
    
    end process;


end Behavioral;
