
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Reg_2 is
    Port ( 
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        load : in STD_LOGIC;
        shift : in STD_LOGIC;        
        data_in : in STD_LOGIC_VECTOR (4 downto 0);
        bit_in : in STD_LOGIC;
        bit_out : out STD_LOGIC;
        data_out : out STD_LOGIC_VECTOR (4 downto 0)
    );
end Reg_2;

architecture Behavioral of Reg_2 is
signal tmp_out : std_logic_vector(4 downto 0) := (others => '0');
begin
    reg: process (CLK)
    begin 
        if( CLK'event and CLK = '0') then
            if(RST = '1') then
                tmp_out <= (others => '0');
            elsif(load = '1') then
                tmp_out <= data_in;
            elsif( shift = '1') then
                tmp_out(0) <= bit_in ;
                tmp_out(4 downto 1) <= tmp_out(3 downto 0);      
            end if;
        end if;
           
    end process;
    data_out <= tmp_out;
    bit_out <= tmp_out(4);

end Behavioral;
