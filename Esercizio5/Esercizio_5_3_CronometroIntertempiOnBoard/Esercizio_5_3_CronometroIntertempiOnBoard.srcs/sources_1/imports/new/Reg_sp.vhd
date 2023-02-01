library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


library ieee;
use ieee.std_logic_1164.all;

entity Reg_sp is
    generic (
        n   : integer := 8
    );
    port(
        CLK, RST : in std_logic;
        enable : in std_logic;
        input : in std_logic;
        Y : out std_logic_vector(n-1 downto 0)
        );
end Reg_sp;

architecture Behavioral of Reg_sp is
    signal tmp: std_logic_vector(n-1 downto 0);
begin

    sh_reg : process (CLK)
    begin
        if (CLK'event and CLK='1') then
            if (RST='1') then
                tmp <= (others=>'0');
            elsif( enable = '1') then-- shift di una poszione
                    tmp(n-1) <= input ;
                    tmp(n-2 downto 0) <= tmp(n-1 downto 1);
            end if;
        end if;

      end process;
      Y <= tmp;
         

end Behavioral;
