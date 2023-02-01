----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.10.2022 11:13:58
-- Design Name: 
-- Module Name: rete16_4 - Structural
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

entity rete16_4 is
  Port (     
        a3   : in std_logic_vector(0 to 15);
        s3_1 : in std_logic_vector(0 to 3);      --ingressi di selezione per la sorgente
        s3_2 : in std_logic_vector(0 to 1) ;     --ingressi di selezione per la destinazione 
        y3   : out std_logic_vector(0 to 3)
  );
end rete16_4;

architecture Structural of rete16_4 is
    signal u3 : std_logic := '0' ;
    
    component demux1_4 is
        port( 
          a2 : in std_logic;
          s2 : in std_logic_vector(0 to 1); 
          y2 : out std_logic_vector(0 to 3) 
         );
    end component;
    
    component mux_16_1 is
        port (
           a : in std_logic_vector (0 to 15);
           s : in std_logic_vector (0 to 3);
           y : out std_logic
        );
    end component;
    
begin
    mux : mux_16_1
        port map(
             a (0 to 15) => a3(0 to 15),
             s (0 to 3) => s3_1(0 to 3),
             y => u3 
        );
     
    demux: demux1_4
        port map(
             a2 => u3,
             s2 (0 to 1) => s3_2 (0 to 1),
             y2 (0 to 3) => y3(0 to 3)
        );
        

end Structural;









