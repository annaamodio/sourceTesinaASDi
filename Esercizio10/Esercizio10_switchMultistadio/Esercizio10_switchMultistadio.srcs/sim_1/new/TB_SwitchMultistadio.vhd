library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TB_SwitchMultistadio is
end TB_SwitchMultistadio;

architecture Behavioral of TB_SwitchMultistadio is
component switchMultistadio is
    Port ( 
           data_in0 : in STD_LOGIC_VECTOR (1 downto 0);
           data_in1 : in STD_LOGIC_VECTOR (1 downto 0);
           data_in2 : in STD_LOGIC_VECTOR (1 downto 0);
           data_in3 : in STD_LOGIC_VECTOR (1 downto 0);
           data_out0 : out STD_LOGIC_VECTOR (1 downto 0);
           data_out1 : out STD_LOGIC_VECTOR (1 downto 0);
           data_out2 : out STD_LOGIC_VECTOR (1 downto 0);
           data_out3 : out STD_LOGIC_VECTOR (1 downto 0);
           enable: in STD_LOGIC_VECTOR(3 downto 0);
           dest0: in STD_LOGIC_VECTOR(1 downto 0);
           dest1: in STD_LOGIC_VECTOR(1 downto 0);
           dest2: in STD_LOGIC_VECTOR(1 downto 0);
           dest3: in STD_LOGIC_VECTOR(1 downto 0)
           );
end component;

signal tmp_in0 : STD_LOGIC_VECTOR (1 downto 0) :=(others =>'0');
signal tmp_in1 : STD_LOGIC_VECTOR (1 downto 0) :=(others =>'0');
signal tmp_in2 : STD_LOGIC_VECTOR (1 downto 0) :=(others =>'0');
signal tmp_in3 : STD_LOGIC_VECTOR (1 downto 0) :=(others =>'0');
signal tmp_out0 : STD_LOGIC_VECTOR (1 downto 0):=(others =>'0');
signal tmp_out1 : STD_LOGIC_VECTOR (1 downto 0):=(others =>'0');
signal tmp_out2 : STD_LOGIC_VECTOR (1 downto 0):=(others =>'0');
signal tmp_out3 : STD_LOGIC_VECTOR (1 downto 0):=(others =>'0');
signal tmpEn : STD_LOGIC_VECTOR(3 downto 0):=(others =>'0');
signal tmpDest0: STD_LOGIC_VECTOR(1 downto 0):=(others =>'0');
signal tmpDest1: STD_LOGIC_VECTOR(1 downto 0):=(others =>'0');
signal tmpDest2: STD_LOGIC_VECTOR(1 downto 0):=(others =>'0');
signal tmpDest3: STD_LOGIC_VECTOR(1 downto 0):=(others =>'0');


begin
    uut: switchMultistadio
    port map(
    tmp_in0,
    tmp_in1,
    tmp_in2,
    tmp_in3,
    tmp_out0,
    tmp_out1,
    tmp_out2,
    tmp_out3,
    tmpEn,
    tmpDest0,
    tmpDest1,
    tmpDest2,
    tmpDest3
    );
    
    test_proc: process
    begin
        tmp_in0 <= "10";
        tmpDest0 <= "11";
        tmpEn <= "0001";
        wait for 10ns;
        
        assert tmp_out3 = "10";
        report "Errore1"
        severity FAILURE;
        
        tmp_in3 <= "11";
        tmpDest3 <= "11";
        tmpEn <= "1001";
        wait for 10ns;
        
        assert tmp_out2 = "00" and tmp_out3 = "10";
        report "Errore2"
        severity FAILURE;
        
        tmpEn <= "1000";
        wait for 10ns;
        
        assert tmp_out2 = "10";
        report "Errore3"
        severity FAILURE;
        
        tmpEn <= "1001";
        tmpDest0 <= "01";
        tmpDest3 <= "10";
        wait for 10ns;
        
        assert tmp_out1 = "10" and tmp_out2 = "00";
        report "Errore4"
        severity FAILURE;
        
    end process;
end Behavioral;
