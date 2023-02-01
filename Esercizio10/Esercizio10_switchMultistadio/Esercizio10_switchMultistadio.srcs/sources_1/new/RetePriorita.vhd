library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity RetePriorita is
    Port (
        en: in std_logic_vector(3 downto 0);
        dest0: in std_logic_vector(1 downto 0);
        dest1: in std_logic_vector(1 downto 0);
        dest2: in std_logic_vector(1 downto 0);
        dest3: in std_logic_vector(1 downto 0);
        source_sel: out std_logic_vector(1 downto 0);
        dest_sel: out std_logic_vector(1 downto 0)
     );
end RetePriorita;

architecture Behavioral of RetePriorita is

begin
    
    proc: process(en)
    begin
        if(en(0) = '1') then
         source_sel <= "00";
         dest_sel <= dest0;
        elsif(en(1) = '1') then
         source_sel <= "01";
         dest_sel <= dest1;
        elsif(en(2) = '1') then
         source_sel <= "10";
         dest_sel<= dest2; 
        elsif(en(3) = '1') then
         source_sel <= "11";
         dest_sel <= dest3;
        else
         source_sel <= "00";
         dest_sel <= "00";
        end if;
   end process;  
   
end Behavioral;
