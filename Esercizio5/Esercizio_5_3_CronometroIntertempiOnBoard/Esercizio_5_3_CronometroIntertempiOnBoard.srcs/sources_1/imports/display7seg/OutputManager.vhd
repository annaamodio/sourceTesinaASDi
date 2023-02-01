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



entity OutputManager is

  Port (    
        CLK : in std_logic;
        RST : in std_logic;
        seconds_in: in std_logic_vector(5 downto 0);
        minutes_in: in std_logic_vector(5 downto 0);
        hours_in: in std_logic_vector(4 downto 0);
        anodes_out : out std_logic_vector(7 downto 0);
        cathodes_out : out std_logic_vector (7 downto 0)
   );
   
end OutputManager;

architecture Structural of OutputManager is

    component Encoder is
        Port (
            seconds_in: in std_logic_vector(5 downto 0);
            minutes_in: in std_logic_vector(5 downto 0);
            hours_in: in std_logic_vector(4 downto 0);
            value_out: out std_logic_vector(31 downto 0)
        );
   end component;
   
   component display_seven_segments is 
        Generic( 
			clock_frequency_in : integer := 50000000; 
			clock_frequency_out : integer := 5000000
				);
        Port ( 
           clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           value32_in : in  STD_LOGIC_VECTOR (31 downto 0);
           enable : in  STD_LOGIC_VECTOR (7 downto 0);
           dots : in  STD_LOGIC_VECTOR (7 downto 0);
           anodes : out  STD_LOGIC_VECTOR (7 downto 0);
           cathodes : out  STD_LOGIC_VECTOR (7 downto 0)
           );
   end component;
   
   signal tempY: std_logic_vector (31 downto 0)  := (others =>'0');
   
begin
    
    enc : Encoder
        port map(
            seconds_in => seconds_in,
            minutes_in => minutes_in,
            hours_in => hours_in,
            value_out => tempY
        );
    
    display: display_seven_segments
        generic map(
            clock_frequency_in => 100000000,
            clock_frequency_out => 500
        )
        port map(
            clock => CLK,
            reset => RST,
            value32_in => tempY,
            enable => "00111111",
            dots => "00010100",
            anodes => anodes_out,
            cathodes => cathodes_out
        );

end Structural;
