
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Comparatore is
    generic(
        n : integer := 8
    );
    port(
        data_in_1 : in std_logic_vector(n-1 downto 0);
        data_in_2 : in std_logic_vector(n-1 downto 0);
        output:     out std_logic
    );
end Comparatore;

architecture Behavioral of Comparatore is

begin
    comp: process(data_in_1 , data_in_2 )
    begin 
        if(data_in_1 = data_in_2 ) then
            output <= '1';
        else
            output <= '0';

        end if;
    
    end process;


end Behavioral;
