----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2023 11:34:26
-- Design Name: 
-- Module Name: TB_reg_pp - Behavioral
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

entity TB_reg_pp is
--  Port ( );
end TB_reg_pp;

architecture Behavioral of TB_reg_pp is


component register_pp
    
    generic (
        n: integer := 8
    );

    Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           write : in STD_LOGIC;
           x : in STD_LOGIC_VECTOR ( n-1 downto 0);
           y : out STD_LOGIC_VECTOR ( n-1 downto 0));
end component;

signal clock : STD_LOGIC := '0';
signal reset :  STD_LOGIC := '0';
signal wr : STD_LOGIC := '0';
signal xTemp : STD_LOGIC_VECTOR ( 7 downto 0) :=(others => '0');
signal yTemp : STD_LOGIC_VECTOR ( 7 downto 0) :=(others => '0');

constant CLK_period : time := 10ns; --modifichiamo il clock della scheda


begin
    test_reg : register_pp
    
    port map (
        clock,
        reset,
        wr,
        xTemp,
        yTemp
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
        xTemp <= "01010011";
        wait for 69ns;
        wr <='1';
        wait for 10ns;
        wr <='0';
        wait;
    end process;
    
    
    


end Behavioral;
