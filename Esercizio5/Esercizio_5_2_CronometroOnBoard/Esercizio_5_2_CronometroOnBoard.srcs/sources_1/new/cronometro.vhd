----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2022 20:15:29
-- Design Name: 
-- Module Name: cronometro - Structural
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

entity cronometro is
    Port ( 
           CLOCK : in std_logic;
           RST : in std_logic;
           set : in std_logic;
           seconds_in : in std_logic_vector(5 downto 0);
           minutes_in: in std_logic_vector(5 downto 0);
           hours_in: in std_logic_vector(4 downto 0);
           seconds_out : out std_logic_vector(5 downto 0);
           minutes_out: out std_logic_vector(5 downto 0);
           hours_out: out std_logic_vector(4 downto 0)
          );
end cronometro;

architecture Structural of cronometro is
    
    signal en_seconds : std_logic :='0';
    signal en_minutes: std_logic :='0';
    signal en_hours: std_logic :='0';
    signal count_seconds : std_logic:='0';
    signal count_minutes: std_logic:='0';
    signal count_hours: std_logic:='0'; --devo  metterlo? in realtà non servirà mai
    
    component clock_divider
       generic(
               clock_frequency_in : integer := 100000000;--100MHz
               clock_frequency_out : integer := 500 --500 Hz
			);
        port (
               clock_in : in  STD_LOGIC;
               reset : in STD_LOGIC;
               clock_out : out  STD_LOGIC
            );
    end component;

    component counter
         generic(
                m : integer := 8;
                n : integer := 3
            );
         port( 
                CLK:   in  std_logic;
                RESET: in  std_logic;
                enable: in std_logic;
                load:  in  std_logic;
                data:  in  std_logic_vector(n - 1 downto 0);
                y:     out std_logic_vector(n - 1 downto 0);
                count: out std_logic
            );
   end component;
   
   
begin
    
    --aggiungere generic map per verificare il clock della scheda??
    time_base: clock_divider
        generic map(

            100000000,
            1
        )
        port map(
            clock_in =>CLOCK,
            reset => RST,
            clock_out =>en_seconds   
        );
        
      seconds_counter: counter
        generic map(
            60,
            6
        )
        port map(
            CLK => CLOCK,
            RESET => RST,
            enable => en_seconds,
            load => set,
            data => seconds_in,
            y => seconds_out,
            count => count_seconds
        );
        
        en_minutes <= en_seconds and count_seconds;
        
        minutes_counter: counter
        generic map(
            60,
            6
        )
        port map(
            CLK => CLOCK,
            RESET => RST,
            enable => en_minutes,
            load => set,
            data => minutes_in,
            y => minutes_out,
            count => count_minutes
        );
        
        en_hours <= en_seconds and en_minutes and count_minutes;
        
        hours_counter: counter
        generic map(
            24,
            5
        )
        port map(
            CLK => CLOCK,
            RESET => RST,
            enable => en_hours,
            load => set,
            data => hours_in,
            y => hours_out,
            count => count_hours
        );
    
    

end Structural;
