

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity TB_MUX_16_1 is
--  Port ( );
end TB_MUX_16_1;

architecture Behavioral of TB_MUX_16_1 is
    component mux_16_1
        Port(
                a: in std_logic_vector (0 to 15);
                s : in std_logic_vector (0 to 3);
                y : out std_logic
        );
    end component;
    
    --segnali
    signal x: std_logic_vector(0 to 15);
    signal sel: std_logic_vector (0 to 3);
    signal h: std_logic;
    
    
    --
begin
    test_mux: mux_16_1 
        Port map(
                a => x,
                s => sel,
                y => h
        );

    test_proc: process
        
    begin 
        --test0: selziona linea 1 con output 1
        wait for 10 ns;
        x <= "0100001000000010";
        sel <= "1000";
        wait for 10 ns;
        assert h <= '1'
        report "errore 0"
        severity failure;
        
        --test1: selziona linea 1 con output 0
        wait for 10 ns;
        x <= "0000001000000010";
        sel <= "1000";
        wait for 10 ns;
        assert h <= '0'
        report "errore 1"
        severity failure;
        
        --test2: selziona linea 2 con output 1
        wait for 10 ns;
        x <= "1010101010101010";
        sel <= "0100";
        wait for 10 ns;
        assert h <= '1'
        report "errore 2"
        severity failure;
        
        wait;
    end process;
end Behavioral;
