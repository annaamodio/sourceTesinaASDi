----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.11.2022 13:53:52
-- Design Name: 
-- Module Name: rete16_4_onboard - Behavioral
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

entity rete16_4_onboard is
    Port (
        clock : in std_logic;
        reset: in std_logic;
        en_data : in std_logic;
        en_selection: in std_logic;
        switches : in std_logic_vector(0 to 15);
        leds: out std_logic_vector(0 to 3)
     );
end rete16_4_onboard;

architecture Structural of rete16_4_onboard is
    
    component rete16_4
        port (
            a3   : in std_logic_vector (0 to 15);
            s3_1 : in std_logic_vector (0 to 3);      --ingressi di selezione per la sorgente
            s3_2 : in std_logic_vector (0 to 1) ;     --ingressi di selezione per la destinazione 
            y3   : out std_logic_vector(0 to 3)
        );
     end component;
        
    component ControlUnit
        port(
            clock : in std_logic;
            reset : in std_logic;
            load_selection: in std_logic;
            load_data : in std_logic;
            value_in: in std_logic_vector(0 to 15);
            value_data: out std_logic_vector(0 to 15);
            value_selection: out std_logic_vector(0 to 5)
        );
     end component;
     
     signal data: std_logic_vector (0 to 15);
     signal selection: std_logic_vector (0 to 5);
     --signal ytemp: std_logic_vector (3 downto 0);
begin
    
    CU: ControlUnit
    Port map(
        clock => clock, 
        reset => reset,
        load_selection => en_selection,
        load_data => en_data,
        value_in => switches,
        value_data => data,
        value_selection => selection
    );
    
    rete: rete16_4
    Port map (
        a3 => data,
        s3_1(0 to 3 ) => selection(0 to 3),
        s3_2 (0 to 1 ) => selection(4 to 5),
        y3 (0 to 3) => leds(0 to 3)
    );
    
    
end Structural;
