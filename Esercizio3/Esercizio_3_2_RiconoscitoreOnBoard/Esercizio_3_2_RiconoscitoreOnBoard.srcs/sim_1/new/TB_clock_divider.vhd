----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.01.2023 11:49:30
-- Design Name: 
-- Module Name: TB_clock_divider - Behavioral
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

entity TB_clock_divider is
--  Port ( );
end TB_clock_divider;

architecture Behavioral of TB_clock_divider is

    component clock_divider 
         generic(
                    clock_frequency_in : integer := 100000000;--100MHz
                    clock_frequency_out : integer := 500 --500 Hz
                    );
        Port ( clock_in : in  STD_LOGIC;
               reset : in STD_LOGIC;
               clock_out : out  STD_LOGIC);
    end component;

    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal output : std_logic := '0';
    constant CLK_period : time := 10 ns;


begin
    test_cd : clock_divider 
        generic map(100000000, 10000000)
        port map(
            clk, rst, output
        );
        
        clk_proc: process 
        begin
            clk <= '0';
            wait for CLK_period / 2;
            clk <= '1';
            wait for CLK_period /2;
        end process;
        


end Behavioral;
