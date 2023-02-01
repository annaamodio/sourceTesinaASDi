

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity DivisoreOnBoard is
--  Port ( );
port(
    CLK: in std_logic;
    RST: in std_logic;
    start: in std_logic;
    switches: in std_logic_vector(7 downto 0);
    anodes: out std_logic_vector(7 downto 0);
    cathodes: out std_logic_vector(7 downto 0);
    data_out : out std_logic_vector (7 downto 0);
    exception : out std_logic
);
end DivisoreOnBoard;

architecture Structural of DivisoreOnBoard is

component Input_manager 
    Port ( 
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        start : in STD_LOGIC;
        data_divisore : in STD_LOGIC_VECTOR (3 downto 0);
        cl_start : out STD_LOGIC;
        exception : out STD_LOGIC
    );
end component;


component DivisoreNonRestoring is
    Port (
        CLK: in std_logic;
        RST: in std_logic;
        start: in std_logic;
        A: in std_logic_vector (3 downto 0);
        B: in std_logic_vector (3 downto 0);
        Q: out std_logic_vector (3 downto 0);
        R: out std_logic_vector ( 3 downto 0);
        fine_op: out std_logic
    );
end component;

component Output_manager is
    Port ( 
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        Q : in STD_LOGIC_VECTOR (3 downto 0);
        R : in STD_LOGIC_VECTOR (3 downto 0);
        fine_div : in STD_LOGIC;
        anodes : out STD_LOGIC_VECTOR (7 downto 0);
        cathodes : out STD_LOGIC_VECTOR (7 downto 0)
    );
end component;

signal cl_start : std_logic := '0';
signal tempQ : std_logic_vector(3 downto 0):= (others => '0');
signal tempR : std_logic_vector(3 downto 0):= (others => '0');
signal tempFine : std_logic := '0';

begin

    inpMan: Input_manager port map(
        CLk, RST, start, switches(3 downto 0), cl_start, exception 
    );
    
    div: DivisoreNonRestoring
    port map(
        CLK,
        RST,
        cl_start,
        switches(7 downto 4),
        switches(3 downto 0),
        tempQ,
        tempR,
        tempFine
    );
    
    outMan: Output_manager
    port map(
        CLK,
        RST,
        tempQ,
        tempR,
        tempFine,
        anodes,
        cathodes
    );
    data_out <= tempQ & tempR;
    


end Structural;
