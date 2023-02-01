
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Omega_network is
    Port (    
        data_in : in STD_LOGIC_VECTOR (3 downto 0);
        source_sel : in STD_LOGIC_VECTOR (1 downto 0);
        dest_sel : in STD_LOGIC_VECTOR (1 downto 0);       
        data_out : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Omega_network;

architecture Structural of Omega_network is
    component Rete_2_2 is
        Port ( 
            data_in : in STD_LOGIC_VECTOR (1 downto 0);
            sel : in STD_LOGIC_VECTOR (1 downto 0);
            data_out : out STD_LOGIC_VECTOR (1 downto 0)
        );
    end component;
    signal tmp_data_out : std_logic_vector(3 downto 0);
begin
    rete1_s1: Rete_2_2 port map(
        data_in(2) & data_in(0),
        dest_sel(1)&source_sel(1),
        tmp_data_out(1 downto 0)
    );
    rete2_s1: Rete_2_2 port map(
        data_in(3)&data_in(1),
        dest_sel(1)&source_sel(1),
        tmp_data_out(3 downto 2)
    );
    
    rete1_s2: Rete_2_2 port map(
        tmp_data_out(2)&tmp_data_out(0),
        dest_sel(0)&source_sel(0),
        data_out(1 downto 0)
    );
    rete2_s2: Rete_2_2 port map(
        tmp_data_out(3)&tmp_data_out(1),
        dest_sel(0)&source_sel(0),
        data_out(3 downto 2)
    );
    



end Structural;
