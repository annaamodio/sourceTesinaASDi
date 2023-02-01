----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.01.2023 11:30:23
-- Design Name: 
-- Module Name: RiconoscitoreOnBoard - Structural
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

entity RiconoscitoreOnBoard is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           S1 : in STD_LOGIC;
           S2 : in STD_LOGIC;
           B1 : in STD_LOGIC;
           B2 : in STD_LOGIC;
           Y : out STD_LOGIC;
           --stato: out std_logic_vector(2 downto 0);
           statoAutoma : out std_logic_vector(3 downto 0)
           );
end RiconoscitoreOnBoard;

architecture Structural of RiconoscitoreOnBoard is
    
   signal tempA : std_logic :='0';
   signal enSignal : std_logic :='0';
   signal iSignal : std_logic :='0';
   signal mSignal : std_logic :='0';


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
    
  component rete_acquisizione
         port (
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           A : in STD_LOGIC;
           S1 : in STD_LOGIC;
           S2 : in STD_LOGIC;
           B1 : in STD_LOGIC;
           B2 : in STD_LOGIC;
           en : out STD_LOGIC;
           i : out STD_LOGIC;
           m : out STD_LOGIC
           --stato: out std_logic_vector(2 downto 0)    --Debug
           );
    end component;
    
    component Riconoscitore_1001 is
    Port ( 
           CLK   : in std_logic;
           RST   : in std_logic;
           en    : in std_logic;
           modo  : in std_logic;
           i     : in std_logic;
           Y     : out std_logic;
           statoAutoma : out std_logic_vector(3 downto 0)
     );
    end component;
  
begin
   
   time_base: clock_divider
    generic map(
        100000000,
        100
    )
    port map(
        clock_in => CLK,
        reset => RST,
        clock_out => tempA
    );
    
    acq: rete_acquisizione
    port map(
       CLK => CLK,
       RST => RST,
       A => tempA  , --tempA
       S1 => S1,
       S2 => S2,
       B1 => B1,
       B2 => B2,
       en => enSignal,
       i=> iSignal,
       m=> mSignal
       --stato => stato     --Debug
     );

    riconoscitore: Riconoscitore_1001
    port map(
          CLK => CLK,
          RST => RST,
          en => enSignal,
          modo => mSignal,
          i => iSignal,
          Y => Y,
          statoAutoma => statoAutoma
    );
    
end Structural;
