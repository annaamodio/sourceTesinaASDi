
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ROM_selector is
    Port ( 
        CLK         : in std_logic;
        RST         : in std_logic;
        enable      : in std_logic;
        data_output : out std_logic_vector (3 downto 0)
        );
end ROM_selector;

architecture Structural of ROM_selector is
    
    component CONTATOREmodN is
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
    end component;
    
    component ROM is
        port(
            CLK : in std_logic; 
            RST : in std_logic; 
            ADDR : in std_logic_vector(2 downto 0);                       
            DATA : out std_logic_vector(3 downto 0) 
        );
    end component;
    
    signal tempAddr: std_logic_vector (2 downto 0) := (others => '0');
    
begin
    
    counter: CONTATOREmodN
    port map(
        CLK => CLK,
        RESET => RST,
        enable => enable,
        y => tempAddr
    );
    
    mem_rom: ROM
    port map(
        CLK => CLK,
        RST => RST,
        ADDR=>tempAddr,
        DATA => data_output
    );


end Structural;