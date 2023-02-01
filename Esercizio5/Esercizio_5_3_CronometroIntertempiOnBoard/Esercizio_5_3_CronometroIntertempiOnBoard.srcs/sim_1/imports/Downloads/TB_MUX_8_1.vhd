----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.01.2023 16:44:35
-- Design Name: 
-- Module Name: TB_MUX_8_1 - Behavioral
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

entity TB_MUX_8_1 is
--  Port ( );
end TB_MUX_8_1;

architecture Behavioral of TB_MUX_8_1 is

    component MUX_8_1 is
        Port ( 
               data : in STD_LOGIC_VECTOR (7 downto 0);
               sel : in STD_LOGIC_VECTOR (2 downto 0);
               output : out STD_LOGIC
               );
    end component;
    
    signal sData : std_logic_vector(7 downto 0):=(others=>'0');
    signal sSel : std_logic_vector(2 downto 0):=(others=>'0');
    signal sOutput : std_logic :='0';
    
begin

    uut: MUX_8_1
    port map(
    sData,
    sSel,
    sOutput
    );


    test_proc: process
        begin
        
        wait for 100ns;
        sData <= "00010110";
        wait for 10ns;
        sSel <= "010";
        wait for 10ns;
        
        sData <= "01010101";
        wait for 10ns;
        sSel <= "001";
        wait for 10ns;
        
        wait;
        end process;
        
end Behavioral;
