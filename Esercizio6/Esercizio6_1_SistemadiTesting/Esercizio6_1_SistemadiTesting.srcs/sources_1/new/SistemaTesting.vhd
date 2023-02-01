

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SistemaTesting is
    Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           read : in STD_LOGIC
      );
end SistemaTesting;

architecture Structural of SistemaTesting is

    component ControlUnit is
    Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           read : in STD_LOGIC;
           enInput : out STD_LOGIC;
           saveOutput : out STD_LOGIC
           );
    end component;
    
    component ParteOperativa is
    Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           enInput : in STD_LOGIC;
           saveOutput : in STD_LOGIC
        );
    end component;
    
    signal enR: std_logic :='0';
    signal enM: std_logic :='0';
    
begin

    cu: ControlUnit
    port map(
        CLK,
        RST,
        read,
        enR,
        enM
    );
    
    PO: ParteOperativa
    port map(
        CLK,
        RST,
        enR,
        enM
    );

end Structural;
