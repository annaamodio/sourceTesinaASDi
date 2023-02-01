library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ROM is
port(
    CLK : in std_logic; 
    RST : in std_logic; 
    ADDR : in std_logic_vector(2 downto 0); --3 bit di indirizzo per accedere agli elementi della ROM,                      
    DATA : out std_logic_vector(3 downto 0) -- dato su 4 bit letto dalla ROM
    );
end ROM;
-- creo una ROM di 8 elementi da 4 bit ciascuno
architecture behavioral of ROM is 
type rom_type is array (0 to 7) of std_logic_vector(3 downto 0);
signal ROM : rom_type := (
"0001",
"0010",
"0011",
"0100",
"0101",
"0110",
"0111",
"1000");

begin
process(CLK)
  begin
    if rising_edge(CLK) then
        if(RST = '1') then
            DATA <= (others => '0');
        else
            DATA <= ROM(conv_integer(ADDR));
        end if;
    end if;
end process;
end behavioral;