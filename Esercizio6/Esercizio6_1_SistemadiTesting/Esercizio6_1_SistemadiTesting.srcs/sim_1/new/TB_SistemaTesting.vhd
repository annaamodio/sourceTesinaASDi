library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TB_SistemaTesting is
--  Port ( );
end TB_SistemaTesting;

architecture Behavioral of TB_SistemaTesting is

component SistemaTesting is
    Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           read : in STD_LOGIC
      );
  end component;
    
    signal sCLK: std_logic :='0';
    signal sRST: std_logic :='0';
    signal sRead: std_logic :='0';
    constant CLK_period : time := 10ns; 

begin

    uut: SistemaTesting
        port map(
            sCLK,
            sRST,
            sRead
        );
        
    clk_proc: process
    begin
        sCLK <= '0';
        wait for CLK_period / 2;
        sCLK <= '1';
        wait for CLK_period /2;
    end process;
        
    test_proc: process
    begin
    
    wait for 100ns;
    sRST <= '1';
    wait for 10ns;
    sRST <='0';
    
    sRead <='1';
    wait for 10ns;
    sRead <='0';
    wait for 100ns;
    sRead <='1';
    wait for 10ns;
    sRead <='0';
    wait for 100ns;
    sRead <='1';
    wait for 10ns;
    sRead <='0';
    
    wait;
    
    end process;   
     
end Behavioral;
