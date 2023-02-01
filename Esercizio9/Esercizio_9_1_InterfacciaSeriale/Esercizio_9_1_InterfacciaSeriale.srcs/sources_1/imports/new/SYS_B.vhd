

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity SYS_B is
  Port ( 
        CLK:            in std_logic;
        RST:            in std_logic;
        data_serial:    in std_logic;
        leds:           out std_logic_vector(7 downto 0)
  );
end SYS_B;

architecture Structural of SYS_B is
    
    component RS232RefComp 
          Port ( 
            TXD 	: out std_logic  	:= '1';
            RXD 	: in  std_logic;					
            CLK 	: in  std_logic;								--Master Clock
            DBIN 	: in  std_logic_vector (7 downto 0);	--Data Bus in
            DBOUT : out std_logic_vector (7 downto 0);	--Data Bus out
            RDA	: inout std_logic;						--Read Data Available(è alto quando il dato è disponibile nel registro rdReg)
            TBE	: inout std_logic 	:= '1';			     --Transfer Bus Empty(se è 0 significa che il bus è occupato per una trasmissione)
            RD		: in  std_logic;					--Read Strobe(se è 0 significa "leggi")
            WR		: in  std_logic;					--Write Strobe(se è 1 significa "scrivi")
            PE		: out std_logic;					--Parity Error Flag
            FE		: out std_logic;					--Frame Error Flag
            OE		: out std_logic;					--Overwrite Error Flag
            RST		: in  std_logic	:= '0');	        --Master Reset
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
    
signal out_parallel: std_logic_vector(7 downto 0) := (others =>'0');
signal temp_RDA: std_logic := '0';
signal tempFFout: std_logic := '0';
signal fittizio: std_logic := '0';
signal fittizio_pe: std_logic := '0';
signal fittizio_oe: std_logic := '0';
signal fittizio_fe: std_logic := '0';
signal fittizio_TBE: std_logic := '0';

begin
    uart: RS232RefComp
        port map(
            TXD=>fittizio,
            RXD =>data_serial,
            CLK=>CLK,
            DBIN=>(others=>'0'),
            DBOUT => out_parallel,
            RDA => temp_RDA,
            TBE => fittizio_TBE,
            RD => tempFFout,
            WR=>'0',
            PE=> fittizio_pe,
            FE => fittizio_fe,
            OE => fittizio_oe,
            RST=>RST          
        );
    
    mem: register_pp
        port map(
            CLK=>CLK,
            RST=>RST,
            write => temp_RDA,
            x=>out_parallel,
            y=>leds
        );
    
    ff: D_FF
        port map(
            CLK=>CLK,
            RST=>RST,
            D=>temp_RDA,
            Q=>tempFFout
        );


end Structural;
