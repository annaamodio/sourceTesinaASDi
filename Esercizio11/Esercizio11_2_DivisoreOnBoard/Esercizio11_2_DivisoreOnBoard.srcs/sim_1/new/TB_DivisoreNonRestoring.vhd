
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TB_DivisoreNonRestoring is
--  Port ( );
end TB_DivisoreNonRestoring;

architecture Behavioral of TB_DivisoreNonRestoring is
    component DivisoreNonRestoring is
        Port (
            CLK: in std_logic;
            RST: in std_logic;
            start: in std_logic;
            A: in std_logic_vector (3 downto 0);
            B: in std_logic_vector (3 downto 0);
            Q: out std_logic_vector (3 downto 0);
            R: out std_logic_vector ( 3 downto 0);
            fine_op: out std_logic
        );
    end component;
    signal clock, reset, tmp_start, tmp_fine_op : std_logic := '0';
    signal tmp_A, tmp_B, tmp_Q, tmp_R : std_logic_vector ( 3 downto 0) := (others => '0');
    
    constant CLK_period : time := 10 ns;
begin
    clk_proc: process
        begin
        clock <= '0';
        wait for CLK_period / 2;
        clock <= '1';
        wait for CLK_period /2;
    end process;
    
    
    test_div: DivisoreNonRestoring port map(
        clock,
        reset,
        tmp_start,
        tmp_A,tmp_B, tmp_Q , tmp_R, tmp_fine_op 
    );
    
    test_proc: process 
    begin 
        wait for 100ns;
        reset <= '1';
        wait for 10ns;
        reset <= '0';
        
        tmp_A <= "1000";
        tmp_B <= "0010";
        tmp_start <= '1';
        wait for 10ns;
        tmp_start <= '0';
        
        wait until tmp_fine_op = '1';
        wait for 40ns;
        tmp_A <= "1001";
        tmp_B <= "0010";
        tmp_start <= '1';
        wait for 10ns;
        tmp_start <= '0';
        
        wait until tmp_fine_op = '1';
        wait for 40ns;
        tmp_A <= "1010";
        tmp_B <= "1010";
        tmp_start <= '1';
        wait for 10ns;
        tmp_start <= '0';
        
        wait;
        
    end process;

end Behavioral;
