

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


library ieee;
use ieee.std_logic_1164.all;

entity shift_register is
    generic (
        n   : integer := 8
    );
    port(
        CLK, RST : in std_logic;
        input : in std_logic;
        dir : in std_logic ;
        inc : in std_logic;             -- se inc = 0 -> incremento di una poszione altrimenti di due
        Y : out std_logic
        );
end shift_register;


architecture Structural2 of shift_register is
component SR_Component 
    port(
        CLK, RST : in std_logic;
        a1, a2, b1, b2 : in std_logic;
        dir : in std_logic ;
        inc : in std_logic; -- se inc = 0 -> incremento di una poszione altrimenti di due
        Y : out std_logic
        );
end component  ;

signal tempY : std_logic_vector (n+1 downto 0) := (others => '0');
begin 
    tempY(n+1) <= input ;
    tempY (0) <= input ;
    cp_last: SR_Component port map(
        CLK , RST,
        input, tempY(n-1),
        '0', tempY(n-2),
        dir, 
        inc,
        tempY(n)
    );

    cp_last_1_to_2: for i in n-1 downto 2 generate 
        comp:SR_Component  port map(
            CLK, RST,
            tempY(i+1),tempY(i-1),
            tempY(i+2), tempY(i-2),
            dir,
            inc,
            tempY(i)
        
        );
     end generate;
    cp_1: SR_Component port map(
        CLK , RST,
        tempY(2) , input ,
        tempY(3) , '0',
        dir, 
        inc,
        tempY(1)
    );
      Y <=  tempY (n) when dir='1' else
            tempY (1);
     
end Structural2;

architecture Structural of shift_register is
component SR_Component 
    port(
        CLK, RST : in std_logic;
        a1, a2, b1, b2 : in std_logic;
        dir : in std_logic ;
        inc : in std_logic; -- se inc = 0 -> incremento di una poszione altrimenti di due
        Y : out std_logic
        );
end component  ;

signal tempY : std_logic_vector (n-1 downto 0) := (others => '0');
begin 
    cp_last: SR_Component port map(
        CLK , RST,
        input, tempY(n-2),
        '0', tempY(n-3),
        dir, 
        inc,
        tempY(n-1)
    );
    cp_last_1: SR_Component port map(
        CLK , RST,
        tempY(n-1), tempY(n-3),
        input , tempY(n-4),
        dir, 
        inc,
        tempY(n-2)
    );
    
    cp_last_3_to_2: for i in n-3 downto 2 generate 
        comp:SR_Component  port map(
            CLK, RST,
            tempY(i+1),tempY(i-1),
            tempY(i+2), tempY(i-2),
            dir,
            inc,
            tempY(i)
        
        );
     end generate;
     cp_1: SR_Component port map(
        CLK , RST,
        tempY(2), tempY(0),
        tempY(3), input ,
        dir, 
        inc,
        tempY(1)
    );
    cp_0: SR_Component port map(
        CLK , RST,
        tempY(1) , input ,
        tempY(2) , '0',
        dir, 
        inc,
        tempY(0)
    );
      Y <=  tempY (n-1) when dir='1' else
            tempY (0);
     
end Structural;

architecture Behavioral of shift_register is
    signal tmp: std_logic_vector(n-1 downto 0);
begin

    sh_reg : process (CLK)
    begin
        if (CLK'event and CLK='1') then
            if (RST='1') then
                tmp <= (others=>'0');
            elsif(inc = '0') then-- shift di una poszione
                if(dir = '0') then
                    tmp(n-1) <= input ;
                    tmp(n-2 downto 0) <= tmp(n-1 downto 1);
                else
                    tmp(0) <= input;
                    tmp(n-1 downto 1) <= tmp(n-2 downto 0);
                end if;
             else                   --shift di due posizioni
                if(dir = '0') then
                    tmp(n-1) <= '0';
                    tmp(n-2) <= input;
                    for i in n-3 downto 0 loop
                        tmp(i) <= tmp(i+2);
                    end loop;
                else
                    tmp(0) <= '0';
                    tmp(1) <= input;
                    for i in n-3 downto 0 loop
                        tmp(i+2) <= tmp(i);
                    end loop;
                end if;
            end if;
        end if;

      end process;
      Y <= tmp(n-1) when dir='1' else
            tmp(0);
         

end Behavioral;



				
				
