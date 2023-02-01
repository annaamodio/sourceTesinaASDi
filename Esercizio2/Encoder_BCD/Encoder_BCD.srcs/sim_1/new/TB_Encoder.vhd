

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TB_Encoder is
--  Port ( );
end TB_Encoder;

architecture Behavioral of TB_Encoder is
    component Encoder is  
        Port(
            X : in STD_LOGIC_VECTOR(9 downto 0);
            Y : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    
    --signal 
    signal x : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
    signal y : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

begin
    test_encoder: Encoder 
    Port map(
        X(9 downto 0)=> x(9 downto 0),
        Y (3 downto 0) => y(3 downto 0)    
    );
    
    test_proc: process
    begin 
        wait for 100ns;
        
        wait for 10ns;
        x <= "0000000001";
        wait for 10ns;
        assert y = "0000"
        report "errore1"
        severity failure;
        
        wait for 10ns;
        x <= "0000100000";
        wait for 10ns;
        assert y = "0101"
        report "errore2"
        severity failure;
        
        
        wait for 10ns;
        x <= "1000000000";
        wait for 10ns;
        assert y = "1001"
        report "errore3"
        severity failure;
        wait;
        
    end process;

end Behavioral;
