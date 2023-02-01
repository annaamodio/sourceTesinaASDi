

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Rete_2_2 is
    Port ( 
        data_in : in STD_LOGIC_VECTOR (1 downto 0);
        sel : in STD_LOGIC_VECTOR (1 downto 0);
        data_out : out STD_LOGIC_VECTOR (1 downto 0)
    );
end Rete_2_2;

architecture Structural of Rete_2_2 is
    component mux_2_1 
        port( 	
            a0 	: in STD_LOGIC;
            a1 	: in STD_LOGIC;
            s 	: in STD_LOGIC;
            y 	: out std_logic 
        );	
    end component;
    --
    component Demux_1_2 
        Port (
            a : in std_logic;
            s : in std_logic;
            y: out std_logic_vector(1 downto 0)
            
        );
    end component;
    --
    signal tmp_y : std_logic := '0';

begin
    mux: mux_2_1 port map(
        data_in(0),
        data_in(1),
        sel(0),
        tmp_y
          
    );
        
    demux: Demux_1_2 port map(
        tmp_y,
        sel(1),
        data_out    
    );
    

end Structural;
