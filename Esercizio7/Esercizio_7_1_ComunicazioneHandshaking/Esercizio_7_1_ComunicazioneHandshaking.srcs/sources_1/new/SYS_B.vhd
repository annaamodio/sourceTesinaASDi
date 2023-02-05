
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity SYS_B is
    Port ( 
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        send : in STD_LOGIC;
        data_in : in STD_LOGIC_VECTOR (7 downto 0);
        ok : out STD_LOGIC
    );
end SYS_B;

architecture Structural of SYS_B is
    component CU_B 
        Port ( 
            CLK : in STD_LOGIC;
            RST : in STD_LOGIC;
            send : in std_logic;
            enCount: out std_logic;         
            Rin  : out std_logic;
            ok   : out std_logic                  
        );
    end component;
    
    component Counter 
    generic(
        m : integer := 8;
        n : integer := 3
    );
    port( 
        CLK:   in  std_logic;
        RESET: in  std_logic;
        enable: in std_logic;
        y:     out std_logic_vector(n - 1 downto 0);
        fineConteggio: out std_logic
    );
    end component;
    component Memoria 
    generic (
        n : integer := 8  --numero bit per registro
    );
    port(
        CLK : in std_logic;
        RST : in std_logic;
        data_in : in std_logic_vector(n-1 downto 0);
        Rin : in std_logic;
        addr: in std_logic_vector(2 downto 0);
        data_out : out std_logic_vector(n-1 downto 0)
        
    );
    end component;
    component Adder is
    generic (
        m: integer := 8
    );
    Port ( 
        X   :   in std_logic_vector(m-1 downto 0);
        Y   :   in std_logic_vector(m-1 downto 0);
        sum :   out std_logic_vector (m-1 downto 0)                 
           );
    end component ;
    
    signal tmp_enCount : std_logic := '0';
    signal tmp_Rin : std_logic := '0';
    signal tmp_addr : std_logic_vector(2 downto 0) := (others => '0');
    signal tmp_fineConteggio : std_logic := '0';
    signal tmp_data_out: std_logic_vector(7 downto 0) := (others => '0');
    signal tmp_data_in_add: std_logic_vector(7 downto 0) := (others => '0');
begin
    cub: CU_B port map (
        CLK,
        RST,
        send,
        tmp_enCount,
        tmp_Rin,
        ok 
    );
    
    cont: Counter port map(
        CLK,
        RST,
        tmp_enCount,
        tmp_addr,
        tmp_fineConteggio 
    );
    
    mem: Memoria port map(
        CLK,
        RST,
        tmp_data_in_add,
        tmp_Rin,
        tmp_addr,
        tmp_data_out       
    );
    
    add: Adder port map(
        data_in,
        tmp_data_out,
        tmp_data_in_add 
    );
    

   



end Structural;
