
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity TB_Counter is
--  Port ( );
end TB_Counter;

architecture Behavioral of TB_Counter is
component Counter
    generic(
        m : integer := 8;
        n : integer := 3
    );
    port( 
        CLK:   in  std_logic;
        RESET: in  std_logic;
        enable: in std_logic;
        y:     out std_logic_vector(n - 1 downto 0);
        fineConteggio: out std_logic
    );
    end component ;
   
    signal clock : std_logic := '0';
    signal reset : std_logic := '0';
    signal output : std_logic_vector (2 downto 0) := (others =>'0');
    signal count: std_logic := '0';
    constant CLK_period : time := 10ns; 
begin
    --testiamo un contatore moudulo 8
    test_counter: Counter    port map(
        clock,
        reset,
        '1',
        output,
        count   
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
        wait;
    
    
    end process ;


end Behavioral;
