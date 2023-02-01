library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Rete_16_4 is
end TB_Rete_16_4;
    
architecture Behavioral of TB_Rete_16_4 is
    component rete16_4
        Port(
                a3: in std_logic_vector (0 to 15);
                s3_1 : in std_logic_vector (0 to 3);
                s3_2: in std_logic_vector (0 to 1);
                y3 : out std_logic_vector (0 to 3)
        );
    end component;

    --segnali
    signal inputs : std_logic_vector (0 to 15) := (others => '0');
    signal sel1: std_logic_vector (0 to 3) := (others => '0');
    signal sel2: std_logic_vector (0 to 1) := (others => '0');
    signal outputs:  std_logic_vector (0 to 3) := (others => '0');

begin
    test_rete: rete16_4
        port map(
            a3(0 to 15) => inputs(0 to 15),
            s3_1(0 to 3) => sel1(0 to 3),
            s3_2(0 to 1) => sel2(0 to 1),
            y3(0 to 3) => outputs(0 to 3)
        );

    test_proc: process

    begin
        
        --test 0: selezione linea 1, direzione verso la destinazione 2
        wait for 10ns;
        inputs <= "0100001000000010"; 
        sel1 <= "1000"; --il valore che voglio selezionare è '1'
        sel2 <= "01"; --voglio direzionarlo verso la destinazione 2
        wait for 10ns;
        assert outputs <= "0010"
        report "errore 0"
        severity failure;

        --test 1: selezione linea 1, direzione verso la destinazione 0
        wait for 10ns;
        inputs <= "0000001000000010"; 
        sel1 <= "1000"; --il valore che voglio selezionare è '0'
        sel2 <= "00"; --voglio direzionarlo verso la destinazione 0
        wait for 10ns;
        assert outputs <= "0000"
        report "errore 1"
        severity failure;

        --test 2: selezione linea 10, direzione verso la destinazione 3
        wait for 10ns;
        inputs <= "0100001000100010"; 
        sel1 <= "0101"; --il valore che voglio selezionare è '1'
        sel2 <= "11"; --voglio direzionarlo verso la destinazione 3
        wait for 10ns;
        assert outputs <= "0001"
        report "errore 2"
        severity failure;

        wait;
    end process;
end Behavioral;