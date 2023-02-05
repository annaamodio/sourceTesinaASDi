
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;



entity ROM is
    port(
        addr : in std_logic_vector(2 downto 0);
        data_out : out std_logic_vector(7 downto 0)
    );
    
end ROM;

architecture Behavioral of ROM is
    type rom_type is array (0 to 7) of std_logic_vector(7 downto 0);
    signal ROM : rom_type := (
        X"01", 
        X"03", 
        X"07", 
        X"0a", 
        X"02",
        X"08",
        X"0b", 
        X"11"
    );
begin
    data_out <= ROM(conv_integer(addr));

end Behavioral;
