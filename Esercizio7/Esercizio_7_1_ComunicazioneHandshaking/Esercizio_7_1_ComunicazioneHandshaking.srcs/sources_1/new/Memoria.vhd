

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity Memoria is
    
    generic (
        n : integer := 8; --numero registri
        k : integer := 3; --numero bto selezione=log_2(n)
        m : integer := 8  --numero bit per registro
    );
    port(
        CLK : in std_logic;
        RST : in std_logic;
        data_in : in std_logic_vector(m-1 downto 0);
        Rin : in std_logic;
        addr: in std_logic_vector(k-1 downto 0);
        data_out : out std_logic_vector(m-1 downto 0)
        
    );
end Memoria;

architecture Behavioral of Memoria is

type mem_type is array (n-1 downto 0) of std_logic_vector(m-1 downto 0);
signal mem: mem_type;
signal reset_mem: mem_type := (
    0=> "00001111",
    1=> "00001000",
    2=> "00001100",
    3=> "00000100",
    4=> "00010000",
    5=> "00110001",
    6=> "01011011",
    7=> "00101010",
    others => (others => '0')
);
signal t_addr : integer := 0;

begin  
    t_addr <= to_integer(unsigned(addr));
    
    mem_proc : process( CLK ) 
    begin 
        if (CLK'event and CLK = '0') then
            if( RST = '1' ) then
                mem <= reset_mem ;             
            elsif( Rin = '1') then
                mem(t_addr) <= data_in;
            end if;
        end if;
    
    end process;
    
    data_out <= mem(t_addr);
end Behavioral;
