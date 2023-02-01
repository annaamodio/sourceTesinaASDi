----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.01.2023 19:49:34
-- Design Name: 
-- Module Name: TB_sr - Behavioral
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



entity TB_sr is
--  Port ( );
end TB_sr;

architecture Behavioral of TB_sr is
    component sr_structural 
        generic (
            n   : integer := 8
        );
        port(
            CLK, RST : in std_logic;
            input : in std_logic;
            Y : out std_logic_vector (n-1 downto 0)
            );
    end component ;
    signal clock, reset, tempIn : std_logic := '0';
    signal tempY : std_logic_vector (7 downto 0);
    constant clk_period : time := 20 ns;
begin
    test_sr: sr_structural port map(
        clock , 
        reset ,
        tempIn ,
        tempY 
    );
    clk_process : process
    begin
		clock  <= '0';
		wait for clk_period/2;
		clock  <= '1';
		wait for clk_period/2;
    end process;

    test: process
    begin

        wait for 100ns;  --global reset
        reset <= '1';
        wait for 20ns;
        reset  <='0';
        tempIn  <= '1';
        wait for 20ns;
        tempIn  <= '0';

        
        
        wait;
    
    
    end process ;

end Behavioral;
