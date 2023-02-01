library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


library ieee;
use ieee.std_logic_1164.all;

entity shift_register is
    generic (
        n   : integer := 8
    );
    port(
        CLK, RST : in std_logic;
        enable : in std_logic;
        input : in std_logic;
        Y : out std_logic
        );
end shift_register;

architecture Behavioral of shift_register is
    signal tmp: std_logic_vector(n-1 downto 0);
begin

    sh_reg : process (CLK)
    begin
        if (CLK'event and CLK='0') then
            if (RST='1') then
                tmp <= (others=>'0');
            else
                if(enable = '1') then
                    tmp(0) <= input;
                    tmp(n-1 downto 1) <= tmp(n-2 downto 0);
                 end if;
            end if;
         end if;
     
      end process;
      Y <= tmp(n-1);

end Behavioral;
