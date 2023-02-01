

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DivisoreNonRestoring is
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
end DivisoreNonRestoring;

architecture Structural of DivisoreNonRestoring is
    component ControlUnit
         Port (
            CLK: in std_logic;
            RST: in std_logic;
            start: in std_logic;
            fine_conteggio: in  std_logic;
            s: in std_logic;
            store:out std_logic;
            shift: out std_logic;
            load_a: out std_logic;
            load_q: out std_logic;
            load_m: out std_logic;
            load_zero: out std_logic;
            en_count:out std_logic;
            sel: out std_logic;
            fine_operazione : out std_logic
    );
    end component;
    
component Parte_operativa is
    Port ( 
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        shift : in std_logic;
        load_m : in std_logic;
        load_q : in std_logic;
        load_a : in std_logic;
        load_0 : in std_logic;
        en_count : in std_logic;
        store : in std_logic;
        sel : in std_logic;
        A : in std_logic_vector(3 downto 0);
        B : in std_logic_vector(3 downto 0);
        fc: out std_logic;
        R : out std_logic_vector(3 downto 0);
        Q : out std_logic_vector(3 downto 0)

       );
end component;
    
signal temp_store : std_logic := '0';
signal temp_fine_cont : std_logic := '0';
signal temp_shift : std_logic := '0'; 
signal temp_load_A: std_logic := '0';
signal temp_load_Q: std_logic := '0'; 
signal temp_load_M: std_logic := '0';
signal temp_load_zero: std_logic := '0';
signal temp_enCount: std_logic := '0';
signal temp_sel: std_logic := '0';
signal tempR : std_logic_vector(3 downto 0) := (others =>'0');        
    
begin
    PC : ControlUnit
        port map(
            CLK,
            RST,
            start,
            temp_fine_cont,
            tempR(3),
            temp_store,
            temp_shift,
            temp_load_A,
            temp_load_Q,
            temp_load_M,
            temp_load_zero,
            temp_enCount,
            temp_sel,
            fine_op
        );
    
    PO : Parte_operativa
        port map(
            CLK,
            RST,
            temp_shift,
            temp_load_M,
            temp_load_Q,
            temp_load_A,
            temp_load_zero,
            temp_enCount,
            temp_store,
            temp_sel,
            A,
            B,
            temp_fine_cont,
            tempR,
            Q
        ); 
    
        R <= tempR;

end Structural;
