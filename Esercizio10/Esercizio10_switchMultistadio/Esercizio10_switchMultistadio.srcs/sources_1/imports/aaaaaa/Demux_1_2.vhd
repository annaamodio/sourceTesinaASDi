
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Demux_1_2 is
    Port (
        a : in std_logic;
        s : in std_logic;
        y: out std_logic_vector(1 downto 0)
        
    );
end Demux_1_2;

architecture Dataflow of Demux_1_2 is
begin
    with s select 
    y <= (0 => a, others => '0') when '0',
            (1 => a, others => '0') when '1',
            "--" when others;

end Dataflow;
