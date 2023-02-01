

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity TB_F is
--  Port ( );
end TB_F;

architecture Behavioral of TB_F is
    component op_f 
        Port ( CLK : in STD_LOGIC;
               value_in : in STD_LOGIC_VECTOR (31 downto 0);
               value_out : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    signal clock : std_logic := '0';
    signal tmp_in : std_logic_vector(31 downto 0) := (others => '0');
    signal tmp_out : std_logic_vector(31 downto 0) := (others => '0');
    constant CLK_period : time := 10ns;
begin
    test_f: op_f port map(
        clock, tmp_in, tmp_out 
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
       
        wait;
    end process;


end Behavioral;
