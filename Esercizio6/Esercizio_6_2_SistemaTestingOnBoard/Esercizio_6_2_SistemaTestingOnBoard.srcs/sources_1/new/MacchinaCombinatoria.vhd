library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MacchinaCombinatoria is
    Port ( 
        input : in STD_LOGIC_VECTOR (3 downto 0);
        output : out STD_LOGIC_VECTOR (2 downto 0)
        );
end MacchinaCombinatoria;

architecture Dataflow of MacchinaCombinatoria is

begin
        with input  select
        output <="000" when "1000",
                 "001" when "0001",
                 "010" when "0010",
                 "011" when "0011",
                 "100" when "0100",
                 "101" when "0101",
                 "110" when "0110",
                 "111" when "0111",
                 "000" when others; 

end Dataflow;






