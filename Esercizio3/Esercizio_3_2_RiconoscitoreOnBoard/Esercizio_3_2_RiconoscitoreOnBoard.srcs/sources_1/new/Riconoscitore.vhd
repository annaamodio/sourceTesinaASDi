----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.10.2022 12:22:11
-- Design Name: 
-- Module Name: Riconoscitore - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Riconoscitore_1001 is
    Port ( 
           CLK   : in std_logic;
           RST   : in std_logic;
           en     : in std_logic ;
           modo  : in std_logic;
           i     : in std_logic;
           Y     : out std_logic;
           statoAutoma : out std_logic_vector(3 downto 0)
     );
end Riconoscitore_1001;

architecture Behavioral of Riconoscitore_1001 is
    
    type stato is (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11);
    
    signal stato_corrente : stato := S0;
    signal stato_prossimo : stato ;
    signal Ytemp          : std_logic;

    begin
    
    stato_uscita: process (stato_corrente,i,modo)
        
    begin
    
    case stato_corrente is 
            when S0 => 
                if (modo = '0' ) then 
                    stato_prossimo <= S1 ;
                    Ytemp <= '0';
                else 
                    stato_prossimo <= S8 ;
                    Ytemp <= '0';
                end if;
                    
            when S1 => 
                if (i = '0' ) then 
                    stato_prossimo <= S5 ;
                    Ytemp <= '0';
                else 
                    stato_prossimo <= S2 ;
                    Ytemp <= '0';
                end if;
                
            when S2 => 
                if (i = '0' ) then 
                    stato_prossimo <= S3 ;
                    Ytemp <= '0';
                else 
                    stato_prossimo <= S6 ;
                    Ytemp <= '0';
                end if;
                
            when S3 => 
                if (i = '0' ) then 
                    stato_prossimo <= S4 ;
                    Ytemp <= '0';
                else 
                    stato_prossimo <= S7 ;
                    Ytemp <= '0';
                end if;
                
            when S4 => 
                if (i = '0' ) then 
                    stato_prossimo <= S1 ;
                    Ytemp <= '0';
                else 
                    stato_prossimo <= S1 ;
                    Ytemp <= '1';
                end if;
               
            when S5 => 
                    stato_prossimo <= S6 ;
                    Ytemp <= '0';
                
            when S6 => 
                    stato_prossimo <= S7 ;
                    Ytemp <= '0';
    
            when S7 => 
                    stato_prossimo <= S1 ;
                    Ytemp <= '0';      
            when S8 => 
                if (i = '0' ) then 
                    stato_prossimo <= S8 ;
                    Ytemp <= '0';
                else 
                    stato_prossimo <= S9 ;
                    Ytemp <= '0';
                end if;
             
            when S9 => 
                if (i = '0' ) then 
                    stato_prossimo <= S10 ;
                    Ytemp <= '0';
                else 
                    stato_prossimo <= S9 ;
                    Ytemp <= '0';
                end if;
          
             
            when S10 => 
                if (i = '0' ) then 
                    stato_prossimo <= S11 ;
                    Ytemp <= '0';
                else 
                    stato_prossimo <= S9 ;
                    Ytemp <= '0';
                end if;
          
             
            when S11 => 
                if (i = '0' ) then 
                    stato_prossimo <= S8 ;
                    Ytemp <= '0';
                else 
                    stato_prossimo <= S8 ;
                    Ytemp <= '1';
                end if;
            
      end case;
    end process;


    memory: process (CLK)
    begin 
        if (CLK 'Event and CLK = '0') then          -- sarebbe l'equivalante di scrivere CLK 'Event and CLK = '1', prendendo sul fronte di salita.
            if (RST = '1') then 
                stato_corrente <= S0;
                --RST <= '0';
                Y <= '0';
                --RST <= '0';
            elsif(en = '1') then
                stato_corrente <= stato_prossimo;
                Y <= Ytemp;
            end if;
        end if;
    end process;
    
    with stato_corrente  select
        statoAutoma <= 
                "1100" when S0,
                "0001" when S1,
                "0010" when S2,
                "0011" when S3,
                "0100" when S4,
                "0101" when S5,
                "0110" when S6,
                "0111" when S7,
                "1000" when S8,
                "1001" when S9,
                "1010" when S10,
                "1011" when S11,
                 "1111" when others;
    

end Behavioral;















