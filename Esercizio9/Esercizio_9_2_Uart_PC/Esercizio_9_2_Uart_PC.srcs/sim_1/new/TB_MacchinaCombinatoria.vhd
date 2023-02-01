----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.01.2023 12:28:16
-- Design Name: 
-- Module Name: TB_MacchinaCombinatoria - Behavioral
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

entity TB_MacchinaCombinatoria is
--  Port ( );
end TB_MacchinaCombinatoria;

architecture Behavioral of TB_MacchinaCombinatoria is
component  MacchinaCombinatoria is
    Port ( 
        input : in STD_LOGIC_VECTOR (3 downto 0);
        output : out STD_LOGIC_VECTOR (2 downto 0));
end component ;

signal tmpIn : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal tmpOut : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
begin
    MC_test: MacchinaCombinatoria port map(
        tmpIn,
        tmpOut 
    );
    
    test_proc: process 
    begin 
        wait for 10ns;
        --test 1
        tmpIn <= "0000";
        wait for 10ns;
        assert tmpOut = "000"
        report "Errore1"
        severity FAILURE;
        
        --test 2
        wait for 20ns;
        tmpIn <= "0100";
        wait for 10ns;
        assert tmpOut = "100"
        report "Errore1"
        severity FAILURE;

        wait;
        
    
    end process;


end Behavioral;
