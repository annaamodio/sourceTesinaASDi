----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2023 11:25:48
-- Design Name: 
-- Module Name: register_pp - Behavioral
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

entity register_pp is
    
    generic (
        n: integer := 8
    );
    Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           write : in STD_LOGIC;
           x : in STD_LOGIC_VECTOR ( n-1 downto 0);
           y : out STD_LOGIC_VECTOR ( n-1 downto 0)
     );
end register_pp;

architecture Behavioral of register_pp is

    signal temp : STD_LOGIC_VECTOR ( n-1 downto 0);

begin

    reg: process(CLK)
    begin
        if(rising_edge(CLK)) then
            if(RST = '1') then
                temp <= (others => '0');
            elsif(write = '1') then
                temp <= x;
            end if;
        end if;
    end process;

    y <= temp;

end Behavioral;
