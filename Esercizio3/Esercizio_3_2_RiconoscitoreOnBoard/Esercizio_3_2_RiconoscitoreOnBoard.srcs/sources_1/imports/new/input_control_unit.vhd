

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity input_control_unit is
    Port (
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           A : in STD_LOGIC;
           b1: in STD_LOGIC;
           b2: in STD_LOGIC;
           s1: in STD_LOGIC;
           s2: in STD_LOGIC;
           en : out STD_LOGIC;
           i : out STD_LOGIC;
           m : out STD_LOGIC
           --stato: out std_logic_vector(2 downto 0)  --segnale per il debug
           );
end input_control_unit;

architecture Behavioral of input_control_unit is
    type state is (idle, 
    beg_acq_m, beg_acq_i, acq, end_acq
    );
    
    signal current_state : state := idle;

    
begin

        
    mem: process(CLK)
       begin
         if(CLK'event and CLK = '1') then
            if(RST='1') then
                current_state <= idle;
                en <= '0';
                m <= '0';
                i <= '0';
             else
                case current_state is 
                    when idle =>
                        en <= '0';
                        if(b2='0') then
                            current_state  <= idle;
                        else
                            current_state  <= beg_acq_m;
                        end if;
                           
                    when beg_acq_m =>
                        m <= s2;
                        en  <= '0';
                        if(A = '1') then 
                            current_state  <= acq;
                        else
                            current_state <= beg_acq_m;
                        end if;
                              
                    when beg_acq_i  => 
                        i  <= s1;
                        en  <= '0';
                        if(A = '1') then
                            current_state  <= acq ;
                        else
                            current_state <= beg_acq_i;
                        end if;
                        
                    when acq =>
                        en    <= '1';
                        current_state  <= end_acq; 
                         
                    when end_acq=>
                        en  <= '0';
                        if(b1='0') then
                            current_state  <= end_acq ; 
                        else
                            current_state  <= beg_acq_i;
                        end if;
                    end case; 
 
            end if;
        end if;
    end process;
    

    
--debug   
--with current_state select
--        stato <= 
--                "000" when idle,
--                "001" when beg_acq_m ,
--                "010" when beg_acq_i  ,
--                "011" when acq ,
--                "100" when end_acq,
--                "111" when others;

     
end Behavioral;




