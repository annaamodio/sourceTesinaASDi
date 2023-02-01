----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.10.2022 11:37:20
-- Design Name: 
-- Module Name: TB_Demux_1_4 - Behavioral
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

entity TB_Demux1_4 is
--  Port ( );
end TB_Demux1_4;

architecture Behavioral of TB_Demux1_4 is
    component demux1_4 is
        Port( 
              a2 : in std_logic;
              s2 : in std_logic_vector(0 to 1); 
              y2 : out std_logic_vector(0 to 3) 
            );
    end component;
    
    signal x: std_logic := '0';
    signal sel: std_logic_vector (0 to 1) := (others => '0');
    signal h: std_logic_vector (0 to 3) := (others => '0');
    
begin
     test_demux: demux1_4 
        Port map(
                a2 => x,
                s2 (0 to 1) => sel (0 to 1),
                y2 (0 to 3) => h (0 to 3)
        );
      
      test_proc: process
      
      begin 
      
           wait for 100 ns;
           
          -- test seleziona linea 1 con output 1 
           wait for 10 ns;
           x <= '1';
           sel <= "00";
           wait for 10 ns;
           assert h(0 to 3) <= ('1','0','0','0')
           report "errore 1"
           severity failure;
           
           -- test seleziona linea 1 con output 0
           wait for 10 ns;
           x <= '0';
           sel <= "00";
           wait for 10 ns;
           assert h(0 to 3) <= ('0','0','0','0')
           report "errore 1"
           severity failure;
           
           --test seleziona linea 4 con output 1
           wait for 10 ns;
           x <= '1';
           sel <= "11";
           wait for 10 ns;
           assert h(0 to 3) <= ('0','0','0','1')
           report "errore 1"
           severity failure;     
      
      
      end process;

end Behavioral;










