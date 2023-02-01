----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_n is
	generic(
		n : integer :=5
	);
    Port ( CLK : in  STD_LOGIC;
		   RST : in STD_LOGIC;
		   enable : in std_logic;
		   end_cont : out std_logic
        );
end counter_n;

architecture Behavioral of counter_n is

constant count_max_value : integer := n - 1;

begin

count_for_division: process(CLK)
variable counter : integer :=0;
begin
	if CLK'event and CLK = '0' then
	 if RST = '1' then
		counter := 0;
		end_cont <= '0';
	 else
		if enable = '1' then
			if counter = count_max_value then
				end_cont <=  '1';
				counter := 0;
			else
			    end_cont <=  '0';
				counter := counter + 1;
			end if;
		end if;
	 end if;
	end if;
end process;

end Behavioral;

