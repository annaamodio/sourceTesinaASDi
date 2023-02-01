----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.01.2023 11:45:51
-- Design Name: 
-- Module Name: Reg_1 - Behavioral
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

entity Reg_1 is
    Port ( 
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        load : in STD_LOGIC;
        load_0 : in STD_LOGIC;
        shift : in STD_LOGIC;        
        data_in : in STD_LOGIC_VECTOR (4 downto 0);
        bit_in : in STD_LOGIC;
        bit_out : out STD_LOGIC;
        data_out : out STD_LOGIC_VECTOR (4 downto 0)
    );
end Reg_1;

architecture Behavioral of Reg_1 is
signal tmp_out : std_logic_vector(4 downto 0) := (others => '0');
begin
    reg: process (CLK)
    begin 
        if( CLK'event and CLK = '0') then
            if(RST = '1') then
                tmp_out <= (others => '0');
            elsif(load = '1') then
                tmp_out <= data_in;
            elsif(load_0 = '1') then
                tmp_out(0) <= bit_in;
            elsif( shift = '1') then
                tmp_out(0) <= '0';
                tmp_out(4 downto 1) <= tmp_out(3 downto 0);      
            end if;
        end if;
           
    end process;
    data_out <= tmp_out;
    bit_out <= tmp_out(4);
end Behavioral;
