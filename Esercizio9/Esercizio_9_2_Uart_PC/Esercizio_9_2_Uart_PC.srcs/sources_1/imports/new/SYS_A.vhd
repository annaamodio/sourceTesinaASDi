

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SYS_A is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           start : in STD_LOGIC;
           switches : in STD_LOGIC_VECTOR (7 downto 0);
           data_serial_in : in std_logic;
           leds : out STD_LOGIC_VECTOR (7 downto 0);                     
           data_serial_out : out STD_LOGIC
           
           
           );
end SYS_A;

architecture Structural of SYS_A is
component Rs232RefComp 
    Port ( 
		TXD 	: out std_logic  	:= '1';
    	RXD 	: in  std_logic;					
    	CLK 	: in  std_logic;								--Master Clock
		DBIN 	: in  std_logic_vector (7 downto 0);	--Data Bus in
		DBOUT : out std_logic_vector (7 downto 0);	--Data Bus out
		RDA	: inout std_logic;						--Read Data Available(è alto quando il dato è disponibile nel registro rdReg)
		TBE	: inout std_logic 	:= '1';			--Transfer Bus Empty(se è 0 significa che il bus è occupato per una trasmissione)
		RD		: in  std_logic;					--Read Strobe(se è 0 significa "leggi")
		WR		: in  std_logic;					--Write Strobe(se è 1 significa "scrivi")
		PE		: out std_logic;					--Parity Error Flag
		FE		: out std_logic;					--Frame Error Flag
		OE		: out std_logic;					--Overwrite Error Flag
		RST		: in  std_logic	:= '0');	--Master Reset
end component;
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
component register_pp 
    
    generic (
        n: integer := 8
    );
    Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           write : in STD_LOGIC;
           x : in STD_LOGIC_VECTOR ( n-1 downto 0);
           y : out STD_LOGIC_VECTOR ( n-1 downto 0)
     );
end component;
component D_FF 
    Port ( 
        CLK : in STD_LOGIC;
        RST : in std_logic;
        D : in STD_LOGIC;
        Q : out STD_LOGIC);
end component;

signal tmp_wr : std_logic  := '0';
signal tmp_PE, tmp_FE, tmp_OE, tmp_RDA, tmp_TBE, tmp_RD: std_logic := '0';

signal tmp_DBOUT : std_logic_vector(7 downto 0) := (others => '0');
begin
    
    
    db_write: ButtonDebouncer port map(
        RST,
        CLK,
        start,
        tmp_wr 
    );
    
    uart: Rs232RefComp port map(
        data_serial_out,
        data_serial_in,
        CLK,
        switches,
        tmp_DBOUT,
        tmp_RDA,
        tmp_TBE,
        tmp_RD,
        tmp_wr,
        tmp_PE,
        tmp_FE,
        tmp_OE,
        RST        
    );
    
    reg: register_pp port map(
        CLk,
        RST,
        tmp_RDA,
        tmp_DBOUT,
        leds   
    );
    
    ff: D_FF port map(
        CLK,
        RST,
        tmp_RDA,
        tmp_RD 
    );
    


end Structural;
