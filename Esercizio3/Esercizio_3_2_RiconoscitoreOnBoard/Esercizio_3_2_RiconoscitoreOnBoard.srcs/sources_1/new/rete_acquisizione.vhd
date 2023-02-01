

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity rete_acquisizione is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           A : in STD_LOGIC;
           S1 : in STD_LOGIC;
           S2 : in STD_LOGIC;
           B1 : in STD_LOGIC;
           B2 : in STD_LOGIC;
           en : out STD_LOGIC;
           i : out STD_LOGIC;
           m : out STD_LOGIC
           --stato: out std_logic_vector(2 downto 0) --Debug
           );
end rete_acquisizione;

architecture Structural of rete_acquisizione is

    signal button1: std_logic := '0';
    signal button2: std_logic := '0';
    
component input_control_unit
    Port (
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           A : in STD_LOGIC;
           b1: in STD_LOGIC;
           b2: in STD_LOGIC;
           s1: in STD_LOGIC;
           s2: in STD_LOGIC;
           en : out STD_LOGIC;
           i : out STD_LOGIC;
           m : out STD_LOGIC
           --stato: out std_logic_vector(2 downto 0) --Debug
           );
end component;

component ButtonDebouncer 
    generic (                       
        CLK_period: integer := 10;  -- periodo del clock in nanosec
        btn_noise_time: integer := 10000000 --durata dell'oscillazione in nanosec
        );
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BTN : in STD_LOGIC; 
           CLEARED_BTN : out STD_LOGIC);
end component;

begin

    db1: ButtonDebouncer
        port map(
            RST => RST,
            CLK => CLK,
            BTN => B1,
            CLEARED_BTN => button1
        );
        
     db2: ButtonDebouncer
        port map(
            RST => RST,
            CLK => CLK,
            BTN => B2,
            CLEARED_BTN => button2
        );
        
     icu: input_control_unit
        port map(
            CLK=>CLK,
            RST=>RST,
            A=>A,
            b1 => button1,
            b2 => button2,
            s1 => S1,
            s2 => S2,
            en => en,
            i => i, 
            m => m
            --stato => stato    --Debug
        );
        
end Structural;