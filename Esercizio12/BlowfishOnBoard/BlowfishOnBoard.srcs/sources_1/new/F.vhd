----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2023 14:46:20
-- Design Name: 
-- Module Name: F - Dataflow
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
--use IEEE.numeric_std.ALL;
use IEEE.std_logic_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity F is
port(
    data_0: in std_logic_vector(31 downto 0);
    data_1: in std_logic_vector(31 downto 0);
    data_2: in std_logic_vector(31 downto 0);
    data_3: in std_logic_vector(31 downto 0);
    y: out std_logic_vector(31 downto 0) 

);
end F;

architecture Dataflow of F is
signal temp_1 : std_logic_vector(31 downto 0) := (others => '0');
signal temp_2 : std_logic_vector(31 downto 0) := (others => '0');

begin




    temp_1 <= data_1 + data_0;
    temp_2 <= data_2 xor temp_1;
    y <= data_3 + temp_2 ;

end Dataflow;
