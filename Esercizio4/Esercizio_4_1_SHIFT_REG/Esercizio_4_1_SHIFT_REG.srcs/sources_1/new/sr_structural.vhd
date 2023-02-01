----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.01.2023 19:47:21
-- Design Name: 
-- Module Name: sr_structural - Behavioral
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



entity sr_structural is
    generic (
        n   : integer := 8
    );
    port(
        CLK, RST : in std_logic;
        input : in std_logic;
        Y : out std_logic_vector(n-1 downto 0)
        );
end sr_structural;

architecture arch_2 of sr_structural  is
component D_FF 
    Port ( 
        CLK : in STD_LOGIC;
        RST : in std_logic ;
        D : in STD_LOGIC;
        Q : out STD_LOGIC
        );
end component ;
signal tempY : std_logic_vector (n-1 downto  0);
begin
    

    ff_last: D_FF port map(
        CLK,
        RST,
        input,
        tempY(n-1) 
    );
    ff1_to_end: for i in n-2 downto 0 generate 
        ff: D_FF port map(
            CLK,
            RST,
            tempY(i+1),
            tempY(i)
        
        );
    end generate;
    
    Y <= tempY ;

end arch_2;
