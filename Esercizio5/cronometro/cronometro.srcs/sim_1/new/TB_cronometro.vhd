----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2022 21:02:48
-- Design Name: 
-- Module Name: TB_cronometro - Behavioral
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

entity TB_cronometro is
--  Port ( );
end TB_cronometro;

architecture Behavioral of TB_cronometro is

component cronometro
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
     end component;

     signal sCLK: std_logic:= '0';                          
     signal sRESET: std_logic:= '0';                          
     signal sSet: std_logic:= '0';
     signal in_seconds: std_logic_vector(5 downto 0):= (others=>'0');                                                                    
     signal in_minutes: std_logic_vector(5 downto 0):= (others=>'0');             
     signal in_hours: std_logic_vector(4 downto 0):= (others=>'0');           
     signal out_seconds: std_logic_vector(5 downto 0):= (others=>'0');                                                                    
     signal out_minutes: std_logic_vector(5 downto 0):= (others=>'0');             
     signal out_hours: std_logic_vector(4 downto 0):= (others=>'0');        
     
      constant CLK_period : time := 10ns; --modifichiamo il clock della scheda
       --divido e sarà 1s in questo caso
       
begin

   
    uut: cronometro
      port map(
        sCLK,
        sReset,
        sSet,
        in_seconds,
        in_minutes,
        in_hours,
        out_seconds,
        out_minutes,
        out_hours
      );
       
      
       clk_proc: process
        begin
        sCLK <= '0';
        wait for CLK_period / 2;
        sCLK <= '1';
        wait for CLK_period /2;
        end process;
     
      test: process
        begin
        wait for 100ns;
        sRESET<='1';
        wait for 10ns;
        sRESET<='0';
        wait for 10ns;
        in_seconds<="000001";
        in_minutes<="111011";
        in_hours<="10110";
        sSet<='1';
        wait for 10ns;
        sSet<='0';
        wait;
        end process;
        

end Behavioral;
