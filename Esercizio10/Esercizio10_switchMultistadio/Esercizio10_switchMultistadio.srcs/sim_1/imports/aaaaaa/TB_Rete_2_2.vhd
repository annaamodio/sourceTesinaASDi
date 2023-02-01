

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity TB_Rete_2_2 is
--  Port ( );
end TB_Rete_2_2;

architecture Behavioral of TB_Rete_2_2 is
    component Rete_2_2 
        Port ( 
            data_in : in STD_LOGIC_VECTOR (1 downto 0);
            sel : in STD_LOGIC_VECTOR (1 downto 0);
            data_out : out STD_LOGIC_VECTOR (1 downto 0)
        );
    end component;
    --
    signal tmp_data_in : std_logic_vector(1 downto 0) := (others => '0');
    signal tmp_sel : std_logic_vector(1 downto 0) := (others => '0');
    signal tmp_data_out : std_logic_vector(1 downto 0) := (others => '0');
begin
    test_rete: Rete_2_2 port map(
        tmp_data_in,
        tmp_sel,
        tmp_data_out 
    );
    
    
    test_proc: process 
    begin 
        --test 1
        wait for 10ns;
        tmp_data_in <= "01";
        tmp_sel <= "00";
        wait for 10ns;
        
        assert tmp_data_out = "01"
        report "Errore 1"
        severity FAILURE;
        
        --test 2
        wait for 10ns;
        tmp_data_in <= "10";
        tmp_sel <= "11";
        wait for 10ns;
        
        assert tmp_data_out = "10"
        report "Errore 1"
        severity FAILURE;
    
    end process;


end Behavioral;
