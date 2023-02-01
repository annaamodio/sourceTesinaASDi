----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.01.2023 16:18:11
-- Design Name: 
-- Module Name: TB_icu - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_icu is
--  Port ( );
end TB_icu;

architecture Behavioral of TB_icu is
component input_control_unit 
    Port (
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           A : in STD_LOGIC;
           b1: in STD_LOGIC;
           b2: in STD_LOGIC;
           s1: in STD_LOGIC;
           s2: in STD_LOGIC;
           en : out STD_LOGIC;
           i : out STD_LOGIC;
           m : out STD_LOGIC;
           stato: out std_logic_vector(2 downto 0)  --segnale per il debug
           );
end component ;
    
    signal clock : std_logic := '0';
    signal reset : std_logic := '0';
    signal tempA : std_logic := '0';
    signal tempB1 : std_logic := '0';
    signal tempB2 : std_logic := '0';
    signal tempS1 : std_logic := '0';
    signal tempS2 : std_logic := '0';
    signal tempEn : std_logic := '0';
    signal tempI : std_logic := '0';
    signal tempM : std_logic := '0';
    signal tempStato : std_logic_vector (2 downto 0);
    
    constant CLK_period : time := 10 ns;
begin
    test_icu : input_control_unit 
        port map(
            clock ,
            reset ,
            tempA ,
            tempB1 ,
            tempB2 ,
            tempS1 ,
            tempS2 ,
            tempEn ,
            tempI ,
            tempM ,
            tempStato          
        );
        
        
    clk_proc: process
    begin
        clock <= '0';
        wait for CLK_period / 2;
        clock <= '1';
        wait for CLK_period /2;

    end process;
    
    a_proc: process
    begin
        tempA  <= '0';
        wait for CLK_period*9+CLK_period/2;
        tempA  <= '1';
        wait for CLK_period;

    end process;
    
    
    proc_test: process 
    begin 
        wait for 100ns;
        reset <= '1';
        wait for 10ns;
        reset <= '0';
        wait for 20ns;
        tempB2 <= '1';
        wait for 10ns;
        tempB2 <= '0';
        wait for 250ns;
        
        tempS1 <= '1';
        tempB1 <= '1';
        wait for 10ns;
        tempB1 <= '0';
        wait for 250ns;
        
        tempS1 <= '0';
        tempB1 <= '1';
        wait for 10ns;
        tempB1 <= '0';
        wait for 250ns;
        
        tempS1 <= '0';
        tempB1 <= '1';
        wait for 10ns;
        tempB1 <= '0';
        wait for 250ns;
        
        tempS1 <= '1';
        tempB1 <= '1';
        wait for 10ns;
        tempB1 <= '0';
        wait for 250ns;
        
        
        
        
        wait;
    
    end process ;



end Behavioral;
