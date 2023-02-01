

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Selezionatore_2_1 is
    generic (
        n : integer := 8
    );
    Port ( 
        data_in1 : in STD_LOGIC_VECTOR (n-1 downto 0);
        data_in2 : in STD_LOGIC_VECTOR (n-1 downto 0);
        sel      : in STD_LOGIC;
        data_out : out STD_LOGIC_VECTOR (n-1 downto 0)
    );
end Selezionatore_2_1;

architecture Structural of Selezionatore_2_1 is
component Mux_2_1 
	port( 	
        bit_in 	: in std_logic_vector(1 downto 0);
        sel 	: in STD_LOGIC;
        bit_out 	: out std_logic 
	);
end component;

begin
    mux_1_to_n: for i in n-1 downto 0 generate 
        mux_i: Mux_2_1 port map(
            data_in2(i)&data_in1(i),
            sel,
            data_out(i)
        );
    
    end generate;

end Structural;
