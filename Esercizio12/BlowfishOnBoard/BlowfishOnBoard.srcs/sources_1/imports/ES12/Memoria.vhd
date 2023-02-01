

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity Memoria is
    generic (
        n : integer := 32  --numero bit per registro
    );
    port(
        CLK : in std_logic;
        RST : in std_logic;
        data_in : in std_logic_vector(n-1 downto 0);
        write : in std_logic;
        addr: in std_logic_vector(4 downto 0);
        data_out : out std_logic_vector(n-1 downto 0)
        
    );
end Memoria;

architecture Behavioral of Memoria is
type mem_type is array (0 to 17) of std_logic_vector(n-1 downto 0);
signal mem: mem_type;
signal rst_mem : mem_type := (
        X"243F6A88", X"85A308D3", X"13198A2E", X"03707344",
        X"A4093822", X"299F31D0", X"082EFA98", X"EC4E6C89",
        X"452821E6", X"38D01377", X"BE5466CF", X"34E90C6C",
        X"C0AC29B7", X"C97C50DD", X"3F84D5B5", X"B5470917",
        X"9216D5D9", X"8979FB1B",
        others => (others => '0')
);
signal t_addr : integer := 0;

begin
    
    t_addr <= to_integer(unsigned(addr));
    
    mem_proc : process( CLK ) 
    begin 
        if (falling_edge( CLK )) then
            if( RST = '1' ) then
                mem <= rst_mem;             
            elsif( write = '1') then
                mem(t_addr) <= data_in;
            end if;
        end if;
    
    end process;
    
    data_out <= mem(t_addr);


end Behavioral;
