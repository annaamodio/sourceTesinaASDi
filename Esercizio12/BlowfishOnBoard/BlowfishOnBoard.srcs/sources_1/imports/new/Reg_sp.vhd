library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


library ieee;
use ieee.std_logic_1164.all;

entity Reg_sp is
    port(
        CLK, RST : in std_logic;
        enable : in std_logic;
        input : in std_logic_vector(7 downto 0);
        Y : out std_logic_vector(63 downto 0)
        );
end Reg_sp;

architecture Behavioral of Reg_sp is
    signal tmp: std_logic_vector(63 downto 0);
begin

    sh_reg : process (CLK)
    begin
        if (CLK'event and CLK='0') then
            if (RST='1') then
                tmp <= (others=>'0');
            elsif( enable = '1') then
                    tmp(7 downto 0) <= input;
                    tmp(63 downto 8) <= tmp(55 downto 0);               
            end if;
        end if;

      end process;
      Y <= tmp;
         

end Behavioral;
