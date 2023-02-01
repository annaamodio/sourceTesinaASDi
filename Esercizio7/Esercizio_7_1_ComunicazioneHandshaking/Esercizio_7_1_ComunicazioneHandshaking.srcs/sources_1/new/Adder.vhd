
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder is
    generic (
        m: integer := 8
    );
    Port ( 
        X   :   in std_logic_vector(m-1 downto 0);
        Y   :   in std_logic_vector(m-1 downto 0);
        sum :   out std_logic_vector (m-1 downto 0)                 
           );
end Adder ;

architecture Behavioral of Adder is
    
begin 
    --adder_proc : process(X,Y)
    --begin 
        sum <= std_logic_vector(unsigned(X)+unsigned(Y));
    --end process;

end Behavioral;
