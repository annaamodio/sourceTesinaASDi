----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.01.2023 20:05:33
-- Design Name: 
-- Module Name: TB_ff_d - Behavioral
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



entity TB_ff_d is
--  Port ( );
end TB_ff_d;

architecture Behavioral of TB_ff_d is
component D_FF 
    Port ( 
        CLK : in STD_LOGIC;
        RST : in std_logic;
        D : in STD_LOGIC;
        Y : out STD_LOGIC);
end component ;

signal clk, rst, d, y : std_logic := '0';
constant clk_period : time := 20 ns;
begin
    ff: D_FF port map(
        clk ,
        rst ,
        d,
        y  
    );
    
    clk_process : process
    begin
		clk  <= '0';
		wait for clk_period/2;
		clk  <= '1';
		wait for clk_period/2;
    end process;
    
    tb: process 
    begin 
        wait for 100ns;
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 20ns;
        d <= '1';
        wait for 20ns;
        d <= '0';
        wait for 20ns;
        d <= '1';
        wait;
    
    
    end process;

end Behavioral;
