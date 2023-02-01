----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.10.2022 16:26:44
-- Design Name: 
-- Module Name: Encoder - Behavioral
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

entity Encoder is
    Port(
        X : in STD_LOGIC_VECTOR(9 downto 0);
        Y : out STD_LOGIC_VECTOR(3 downto 0)
       );
end Encoder;

architecture Dataflow of Encoder is
begin
    with X select
        Y <= "0000" when "0000000001",
             "0001" when "0000000010",
             "0010" when "0000000100",
             "0011" when "0000001000",
             "0100" when "0000010000",
             "0101" when "0000100000",
             "0110" when "0001000000",
             "0111" when "0010000000",
             "1000" when "0100000000",
             "1001" when "1000000000",
             "----" when others; 
end Dataflow;

