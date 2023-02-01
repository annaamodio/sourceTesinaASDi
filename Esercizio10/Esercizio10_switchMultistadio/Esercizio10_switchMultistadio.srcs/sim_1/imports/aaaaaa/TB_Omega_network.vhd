

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TB_Omega_network is
--  Port ( );
end TB_Omega_network;

architecture Behavioral of TB_Omega_network is
    component Omega_network 
        Port (    
            data_in : in STD_LOGIC_VECTOR (3 downto 0);
            source_sel : in STD_LOGIC_VECTOR (1 downto 0);
            dest_sel : in STD_LOGIC_VECTOR (1 downto 0);       
            data_out : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;
    
    signal tmp_data_in : std_logic_vector(3 downto 0) := (others => '0');
    signal tmp_s : std_logic_vector(1 downto 0) := (others => '0');
    signal tmp_d : std_logic_vector(1 downto 0) := (others => '0');
    signal tmp_data_out : std_logic_vector(3 downto 0) := (others => '0');
begin

    test_on : Omega_network port map(
        tmp_data_in,
        tmp_s,
        tmp_d,
        tmp_data_out
    
    );
    
    
    test_proc: process
    begin 
        wait for 10ns;  
        tmp_data_in <= "0001";
        tmp_s <= "00";
        tmp_d <= "10";
        wait for 10ns;
        assert tmp_data_out = "0100"
        report "Errore1"
        severity FAILURE;
        
        wait for 10ns;  
        tmp_data_in <= "0010";
        tmp_s <= "01";
        tmp_d <= "00";
        wait for 10ns;
        assert tmp_data_out = "0001"
        report "Errore1"
        severity FAILURE;
        
    
    end process;


end Behavioral;
