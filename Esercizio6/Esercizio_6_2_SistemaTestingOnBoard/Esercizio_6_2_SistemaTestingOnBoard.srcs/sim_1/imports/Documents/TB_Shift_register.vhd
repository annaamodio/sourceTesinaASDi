

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TB_Shift_register is
--  Port ( );
end TB_Shift_register;

architecture Behavioral of TB_Shift_register is
    component shift_register 
        generic (
            n   : integer := 8
        );
        port(
            CLK, RST : in std_logic;
            enable : in std_logic;
            input : in std_logic;
            Y : out std_logic
            );
    end component;
    
    signal clock : std_logic := '0';
    signal reset : std_logic := '0';
    signal en: std_logic := '0';
    signal data_input : std_logic := '0';
    signal data_output : std_logic := '0';
    constant CLK_period : time := 10ns; 

begin
    shift_reg_test: shift_register port map(
        clock,
        reset,
        en,
        data_input,
        data_output  
    );
    
    clk_proc: process
    begin
        clock <= '0';
        wait for CLK_period / 2;
        clock <= '1';
        wait for CLK_period /2;
    end process;
    
    
    test_proc: process 
    begin 
        wait for 100ns;
        reset <= '1';
        wait for 10ns;
        reset <= '0';
        
        en<= '1';
        data_input <= '1';
        wait for 10ns;
        en <= '0';
        wait for 100ns;
        
        data_input <= '1';
        en<= '1';
        wait for 10ns;
        en <= '0';
        
        wait ;
    
    end process ;

end Behavioral;
