library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity counter is
   generic(
        m : integer := 8;
        n : integer := 3
    );
   port( CLK:   in  std_logic;
         RESET: in  std_logic;
         enable: in std_logic;
         load:  in  std_logic;
         data:  in  std_logic_vector(n - 1 downto 0);
         y:     out std_logic_vector(n - 1 downto 0);
         count: out std_logic
   );
   end counter;

   architecture Behavioral of counter is
       signal Ty: std_logic_vector( n - 1 downto 0) := (others => '0');
       signal Tcount: std_logic := '0';
begin
       y <= Ty;

       -- Counts
       proc_counter: process( CLK )
       begin
           if( CLK'event and CLK = '0' ) then
               if(RESET='1') then
                    Ty <= (others => '0');
               elsif(load = '1') then
                    Ty<=data;
               elsif(enable = '1') then
                     if(Ty = std_logic_vector(to_unsigned(m-1,n))) then
                        Ty <= (others => '0');
                    else
                        Ty <= std_logic_vector(unsigned(Ty) + 1);
                    end if;
               end if;
            end if;
       end process;


        proc_count_out: process( CLK )
           begin
               if( CLK'event and CLK = '1' ) then
                    if( RESET = '1' ) then
                        Tcount <= '0';
                    elsif(Ty = std_logic_vector(to_unsigned(m-1,n))) then
                            Tcount <= '1';
                        else
                            Tcount <= '0';
                    end if;
                end if;
           end process;

       count <= Tcount;

end Behavioral;