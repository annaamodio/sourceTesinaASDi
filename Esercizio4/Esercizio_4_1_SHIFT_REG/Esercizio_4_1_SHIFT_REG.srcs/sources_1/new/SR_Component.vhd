library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


library ieee;
use ieee.std_logic_1164.all;

entity SR_Component is
    port(
        CLK, RST : in std_logic;
        a1, a2, b1, b2 : in std_logic;
        dir : in std_logic ;
        inc : in std_logic; -- se inc = 0 -> incremento di una poszione altrimenti di due
        Y : out std_logic
        );
end SR_Component ;


architecture Structural of SR_Component is
component D_FF 
    Port ( 
        CLK : in STD_LOGIC;
        RST : in std_logic;
        D : in STD_LOGIC;
        Q : out STD_LOGIC);
end component ;


component mux_2_1 
port (
        b0 : in STD_LOGIC;
        b1 : in STD_LOGIC;
        s0 : in STD_LOGIC;
        y0 : out STD_LOGIC
);
end component ;

signal output1 : std_logic := '0';
signal output2 : std_logic := '0';
signal output3 : std_logic := '0';
begin

    mux1: mux_2_1 port map(
        a1, 
        a2,
        dir,
        output1 
    );
    mux2: mux_2_1 port map(
        b1, 
        b2,
        dir,
        output2 
    );
    mux3: mux_2_1 port map(
        output1 , 
        output2 ,
        inc ,
        output3  
    
    );

    ff: D_FF port map(
        CLK ,
        RST,
        output3 ,
        Y       
    );




end Structural;