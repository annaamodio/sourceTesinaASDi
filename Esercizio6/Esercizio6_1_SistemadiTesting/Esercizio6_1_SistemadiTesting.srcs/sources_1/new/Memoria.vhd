library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Memoria is
    Generic(
        k : integer :=8; --numero di bit per registro
        m : integer := 3 --numero di registri
    );
    Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           enable : in STD_LOGIC;
           value : in STD_LOGIC_VECTOR(m-1 downto 0)
        );
end Memoria;

architecture Structural of Memoria is

component shift_register is
    generic (
        n   : integer := 8
    );
    port(
        CLK, RST : in std_logic;
        enable : in std_logic;
        input : in std_logic;
        Y : out std_logic
        );
end component;

begin
    
    sr_all: for i in m-1 downto 0 generate
        s: Shift_register
        generic map(
            n => k
        )
         port map(
            CLK => CLK,
            RST => RST,
            enable => enable,
            input => value(i)
         );   
    
    end generate;
    


end Structural;
