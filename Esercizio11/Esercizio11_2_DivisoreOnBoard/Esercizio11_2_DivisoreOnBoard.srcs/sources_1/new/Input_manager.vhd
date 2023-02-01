

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Input_manager is
    Port ( 
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        start : in STD_LOGIC;
        data_divisore : in STD_LOGIC_VECTOR (3 downto 0);
        cl_start : out STD_LOGIC;
        exception : out STD_LOGIC
    );
end Input_manager;

architecture Structural of Input_manager is
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
    --
    component Comparatore 
    generic(
        n : integer := 8
    );
    port(
        data_in_1 : in std_logic_vector(n-1 downto 0);
        data_in_2 : in std_logic_vector(n-1 downto 0);
        output:     out std_logic
    );
    end component ;
    --
    component Mux_2_1 
	port( 	
        bit_in 	: in std_logic_vector(1 downto 0);
        sel 	: in STD_LOGIC;
        bit_out 	: out std_logic 
	);	
    end component;
    --
    signal tmp_start : std_logic := '0';
    signal tmp_cmp_out : std_logic := '0';
begin
    db: ButtonDebouncer port map(
        RST, CLK, start, tmp_start 
    );
    
    mux: Mux_2_1 port map(
        '0' & tmp_start ,tmp_cmp_out, cl_start 
    );
    
    cmp: Comparatore generic map(4) port map(
        "0000", data_divisore , tmp_cmp_out 
    );
    
    exception_proc: process ( CLK )
    begin
        if( rising_edge(CLK) ) then
            if( RST = '1') then
                exception <= '0';
            elsif(tmp_start = '1') then
                 exception <= tmp_cmp_out;
            end if;
        end if;
    
    
    end process;
   


end Structural;
