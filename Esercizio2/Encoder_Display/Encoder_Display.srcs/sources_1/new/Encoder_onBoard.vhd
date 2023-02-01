----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.10.2022 17:22:25
-- Design Name: 
-- Module Name: Encoder_onBoard - Behavioral
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


-- questo esercizio consente di mostrare la cifra decimale corrispondente
-- alla rappresentazione decodificata in ingresso sia sui led sia sui display
-- in particolare la stessa cifra viene visualizzata su tutti gli 8 display

entity Encoder_onBoard is
  Port ( 
       switch : in STD_LOGIC_VECTOR(9 downto 0);
       catodi : out STD_LOGIC_VECTOR(7 downto 0);
       anodi : out STD_LOGIC_VECTOR(7 downto 0)   
  );
end Encoder_onBoard;

architecture Behavioral of Encoder_onBoard is

component Encoder
	Port(
		X : in STD_LOGIC_VECTOR(9 downto 0);
		Y : out STD_LOGIC_VECTOR(3 downto 0)
		);
end component;


component cathodes_manager
	port(
		value : in std_logic_vector(3 downto 0);
		dot : in std_logic;          
		cathodes_dot : out std_logic_vector(7 downto 0)
		);
end component;

signal ytemp : std_logic_vector (3 downto 0);
signal dot : std_logic;
begin


dot <= '0';  --decido di non illuminare il punto accanto alla cifra
anodi <=(0=>'0', others=>'1'); --decido di illuminare solo la cifra pi� a destra


enc: Encoder port map(
     X => switch,
     Y => ytemp
);

cat: cathodes_manager port map(
    value => ytemp,
    dot => dot,
    cathodes_dot => catodi
    );





end Behavioral;
