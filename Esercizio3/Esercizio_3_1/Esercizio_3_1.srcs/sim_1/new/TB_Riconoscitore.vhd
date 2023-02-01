library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Riconoscitore_1001 is
end TB_Riconoscitore_1001;
    
architecture Behavioral of TB_Riconoscitore_1001 is
    component Riconoscitore_1001
        Port(
                CLK : in std_logic;
                RST  : in std_logic;
                modo : in std_logic;
                i   : in std_logic;
                y : out std_logic
        );
    end component;

    --segnali
    signal dato : std_logic :='0';
    signal reset : std_logic :='0';
    signal clock : std_logic :='0';
    signal m : std_logic :='0';
    
    signal uscita : std_logic;


    constant CLK_period : time := 10 ns;

begin
    test_riconoscitore: Riconoscitore_1001
        port map(
            i => dato,
            RST => reset,
            CLK => clock,
            modo => m,
            y => uscita
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
        
        wait for 100 ns;
        -- test 0 Modo = 0 sequenza valdia
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        m <= '0';
        wait for 10 ns;
        dato <= '1';
        wait for 10 ns;
        dato <= '0';
        wait for 10 ns;
        dato <= '0'; 
        wait for 10 ns;
        dato <= '1';
-- verificare che l'uscita sia 1


        -- test 1 Modo = 0 sequenza non valdia
        wait for 10 ns;
        dato <= '1';
        wait for 10 ns;
        dato <= '1';
        wait for 10 ns;
        dato <= '0'; 
        wait for 10 ns;
        dato <= '1';
-- verificare che l'uscita sia 0



        -- test 2 dare reset

        wait for 10 ns;
        dato <= '1';
        wait for 10 ns;
        reset <= '1';

        -- test 3 modo = 1 input che contiene sequenza valida
        wait for 10 ns;
        reset <= '0';
        m <= '1';
        
        wait for 10 ns;
        dato <= '1';
        wait for 10 ns;
        dato <= '1';
        wait for 10 ns;
        dato <= '0'; 
        wait for 10 ns;
        dato <= '0';
        wait for 10 ns;
        dato <= '1';
        wait for 10 ns;
        dato <= '0';
        wait for 10 ns;
        dato <= '0'; 
        wait for 10 ns;
        dato <= '1';
--verificare che l'uscita sia pari a 1

    -- test 4 cambio di modo senza dare reset
        wait for 10 ns;
        m <= '0';
        --verificare che lo stato non sia cambiato
        wait ;
    end process;
end Behavioral;