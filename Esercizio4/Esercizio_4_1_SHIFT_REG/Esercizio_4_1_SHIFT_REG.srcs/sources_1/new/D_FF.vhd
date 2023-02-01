----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.01.2023 11:09:34
-- Design Name: 
-- Module Name: D_FF - Behavioral
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

entity D_FF is
    Port ( 
        CLK : in STD_LOGIC;
        RST : in std_logic;
        D : in STD_LOGIC;
        Q : out STD_LOGIC);
end D_FF;

architecture Behavioral of D_FF is
   signal Ytemp : std_logic := '0';

begin
    Q <= Ytemp;
    ff: process( CLK )
    begin
        if( CLK'event and CLK = '1' ) then
            if(RST = '1') then
                Ytemp  <= '0';
            else
                Ytemp   <= D;
            end if;
        end if;
end process;


end Behavioral;
