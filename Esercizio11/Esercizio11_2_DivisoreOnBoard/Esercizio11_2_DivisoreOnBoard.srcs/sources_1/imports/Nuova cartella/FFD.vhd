library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FFD is
	port( clock, clock_div, reset, d: in std_logic;
          y: out std_logic :='0');
end FFD;

architecture behavioural of FFD is

	begin
	
	FF_D: process(clock)
		  begin
			if(clock'event and clock='0') then 
		       if(reset='1') then	
				  y<='0';
			   elsif(clock_div='1') then			
			      y<=d;
			   end if;
			end if;
		  end process;
		  
	
	end behavioural;