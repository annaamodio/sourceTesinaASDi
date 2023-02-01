----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.11.2022 13:46:35
-- Design Name: 
-- Module Name: ControlUnit - Behavioral
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

entity ControlUnit is
  port(
        clock : in std_logic;
        reset : in std_logic;
        load_selection: in std_logic;
        load_data : in std_logic;
        value_in: in std_logic_vector(0 to 15);
        value_data: out std_logic_vector(0 to 15);
        value_selection: out std_logic_vector(0 to 5)
  );
end ControlUnit;

architecture Behavioral of ControlUnit is
  
  signal data16 : std_logic_vector (0 to 15) := (others => '0');
  signal selection6 : std_logic_vector (0 to 5) := (others => '0');

  begin 
    
    value_data <= data16;
    value_selection <=selection6;   
    
    process_cu: process(clock) 
   
    begin 
    
    if(clock'event AND clock = '1') then  
        
        if (reset = '1') then 
            data16 <= (others => '0');
            selection6 <= (others =>'0');
        
        else 
            if(load_selection =  '1' ) then
                selection6 <= value_in(0 to 5);
            elsif(load_data = '1') then
                data16 <= value_in;
            end if;            
        end if;
    end if;
    
    end process;
    

end Behavioral;
