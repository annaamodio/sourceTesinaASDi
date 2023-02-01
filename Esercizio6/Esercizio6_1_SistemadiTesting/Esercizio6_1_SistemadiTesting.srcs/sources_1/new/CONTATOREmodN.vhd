library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity CONTATOREmodN is
   generic(
        m : integer := 8;
        n : integer := 3
    );
   port( 
        CLK     :   in  std_logic;
        RESET   :   in  std_logic;
        enable :   in std_logic;
        y       :   out std_logic_vector(n - 1 downto 0)
   );
   end CONTATOREmodN;

architecture Behavioral of CONTATOREmodN is
       signal Ty: std_logic_vector( n - 1 downto 0) := (others => '0');
begin
       y <= Ty;

       -- Counts
       proc_counter: process( CLK )
       begin
           if( CLK'event and CLK = '0' ) then
               if(RESET='1') then
                    Ty <= (others => '0');
               elsif(enable = '1') then
                     if(Ty = std_logic_vector(to_unsigned(m-1,n))) then
                        Ty <= (others => '0');
                    else
                        Ty <= std_logic_vector(unsigned(Ty) + 1);
                    end if;
               end if;
            end if;
       end process;



end Behavioral;