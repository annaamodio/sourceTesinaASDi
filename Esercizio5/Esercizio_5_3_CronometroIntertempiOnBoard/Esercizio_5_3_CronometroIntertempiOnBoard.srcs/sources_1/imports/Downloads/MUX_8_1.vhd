----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.01.2023 16:40:50
-- Design Name: 
-- Module Name: MUX_8_1 - Dataflow
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

entity MUX_8_1 is
    Port ( data : in STD_LOGIC_VECTOR (7 downto 0);
           sel : in STD_LOGIC_VECTOR (2 downto 0);
           output : out STD_LOGIC
           );
end MUX_8_1;

architecture Dataflow of MUX_8_1 is

begin
    
    with sel select
        output <= data(0) when  "000",
                  data(7) when  "001",
                  data(6) when  "010",
                  data(5) when  "011",
                  data(4) when  "100",
                  data(3) when  "101",
                  data(2) when  "110",
                  data(1) when  "111",
                  '-'     when  others;
                  
end Dataflow;
