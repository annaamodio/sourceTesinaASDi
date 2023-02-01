----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2023 11:20:36
-- Design Name: 
-- Module Name: OutputManager - Behavioral
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
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Encoder is
  Port (
        seconds_in: in std_logic_vector(5 downto 0);
        minutes_in: in std_logic_vector(5 downto 0);
        hours_in: in std_logic_vector(4 downto 0);
        value_out: out std_logic_vector(31 downto 0)
   );
end Encoder;

architecture Dataflow of Encoder is

    signal temp_second : std_logic_vector (7 downto 0) := (others => '0');
    signal temp_minutes :  std_logic_vector (7 downto 0) := (others => '0');
    signal temp_hours :  std_logic_vector (7 downto 0) := (others => '0');
    
begin
    -- i primi 8 bit non vengono utilizzati pertanto li poniamo pari a 0
    
    --concatenazione di valori
    value_out <= "00000000" & temp_hours & temp_minutes & temp_second;
    
    
    -- In caso di valore anomalo viene visualizzato F, corrispondente alla stringa "1111".
    
    -- Prima cifra dei secondi
    with to_integer(unsigned(seconds_in)) select
        temp_second (3 downto 0) <= "0000" when 0|10|20|30|40|50,
                                    "0001" when 1|11|21|31|41|51,
                                    "0010" when 2|12|22|32|42|52,
                                    "0011" when 3|13|23|33|43|53,
                                    "0100" when 4|14|24|34|44|54,
                                    "0101" when 5|15|25|35|45|55,
                                    "0110" when 6|16|26|36|46|56,
                                    "0111" when 7|17|27|37|47|57,
                                    "1000" when 8|18|28|38|48|58,
                                    "1001" when 9|19|29|39|49|59,
                                    "1111" when others;
                                    
    -- Seconda cifra dei secondi 
     with to_integer(unsigned(seconds_in)) select
        temp_second (7 downto 4) <= "0000" when 0 to 9,
                                    "0001" when 10 to 19,
                                    "0010" when 20 to 29,
                                    "0011" when 30 to 39,
                                    "0100" when 40 to 49,
                                    "0101" when 50 to 59,
                                     "1111" when others;
                                    
    -- Prima cifra dei minuti
     with to_integer(unsigned(minutes_in)) select
        temp_minutes (3 downto 0) <= "0000" when 0|10|20|30|40|50,
                                    "0001" when 1|11|21|31|41|51,
                                    "0010" when 2|12|22|32|42|52,
                                    "0011" when 3|13|23|33|43|53,
                                    "0100" when 4|14|24|34|44|54,
                                    "0101" when 5|15|25|35|45|55,
                                    "0110" when 6|16|26|36|46|56,
                                    "0111" when 7|17|27|37|47|57,
                                    "1000" when 8|18|28|38|48|58,
                                    "1001" when 9|19|29|39|49|59,
                                    "1111" when others;
                                    
    -- Seconda cifra dei minuti                               
     with to_integer(unsigned(minutes_in)) select
        temp_minutes (7 downto 4) <= "0000" when 0 to 9,
                                    "0001" when 10 to 19,
                                    "0010" when 20 to 29,
                                    "0011" when 30 to 39,
                                    "0100" when 40 to 49,
                                    "0101" when 50 to 59,
                                    "1111" when others;
                          
     -- Prima cifra delle ore                               
     with to_integer(unsigned(hours_in)) select
        temp_hours (3 downto 0) <= "0000" when 0|10|20,
                                    "0001" when 1|11|21,
                                    "0010" when 2|12|22,
                                    "0011" when 3|13|23,
                                    "0100" when 4|14,
                                    "0101" when 5|15,
                                    "0110" when 6|16,
                                    "0111" when 7|17,
                                    "1000" when 8|18,
                                    "1001" when 9|19,
                                    "1111" when others;
                                    
    -- Seconda cifra delle ore
    with to_integer(unsigned(hours_in)) select
        temp_hours (7 downto 4) <= "0000" when 0 to 9,
                                    "0001" when 10 to 19,
                                    "0010" when 20 to 23,
                                    "1111" when others;
                                                           
end Dataflow;
