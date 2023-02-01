
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using

entity Parte_operativa is
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
end Parte_operativa;

architecture Structural of Parte_operativa is
    component counter_n 
        generic(
            n : integer :=4
        );
        Port ( CLK : in  STD_LOGIC;
               RST : in STD_LOGIC;
               enable : in std_logic;
               end_cont : out std_logic
            );
    end component;
    --
    component adder_sub 
        port( X, Y: in std_logic_vector(3 downto 0);
              cin: in std_logic;
              Z: out std_logic_vector(3 downto 0);
              cout: out std_logic);		  
    end component;
    --
    component Selezionatore_2_1 
        generic (
            n : integer := 8
        );
        Port ( 
            data_in1 : in STD_LOGIC_VECTOR (n-1 downto 0);
            data_in2 : in STD_LOGIC_VECTOR (n-1 downto 0);
            sel      : in STD_LOGIC;
            data_out : out STD_LOGIC_VECTOR (n-1 downto 0)
        );
    end component;
    --
    component Mux_2_1 
	port( 	
        bit_in 	: in std_logic_vector(1 downto 0);
        sel 	: in STD_LOGIC;
        bit_out 	: out std_logic 
	);	
    end component;
    --
    component FFD 
	port( clock, clock_div, reset, d: in std_logic;
          y: out std_logic :='0');
    end component;
    --
    component Reg_1 is
    Port ( 
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        load : in STD_LOGIC;
        load_0 : in STD_LOGIC;
        shift : in STD_LOGIC;        
        data_in : in STD_LOGIC_VECTOR (3 downto 0);
        bit_in : in STD_LOGIC;
        bit_out : out STD_LOGIC;
        data_out : out STD_LOGIC_VECTOR (3 downto 0)
    );
    end component;
    --
    component Reg_2 is
    Port ( 
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        load : in STD_LOGIC;
        shift : in STD_LOGIC;        
        data_in : in STD_LOGIC_VECTOR (3 downto 0);
        bit_in : in STD_LOGIC;
        bit_out : out STD_LOGIC;
        data_out : out STD_LOGIC_VECTOR (3 downto 0)
    );
    end component;
    --
    component register_pp is
    generic (
        n: integer := 8
    );
    Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           write : in STD_LOGIC;
           x : in STD_LOGIC_VECTOR ( n-1 downto 0);
           y : out STD_LOGIC_VECTOR ( n-1 downto 0));
    end component;
    
    
    signal tmp_m : std_logic_vector( 3 downto 0) := (others => '0');
    signal tmp_q_out : std_logic := '0';
    signal tmp_ff_out: std_logic := '0'; 
    signal tmp_ff_in: std_logic := '0';
    signal tmp_sum : std_logic_vector( 3 downto 0) := (others => '0');
    signal tmp_selector : std_logic_vector( 3 downto 0) := (others => '0');
    signal tmp_a_out : std_logic_vector( 3 downto 0) := (others => '0');
    signal tmp_cout :  std_logic := '0';
    signal tmp_mux_in : std_logic := '0';
    
begin
    reg_m : register_pp generic map(4) port map(
        CLK,
        RST,
        load_m,
        B,
        tmp_m      
    );
    
    reg_q : Reg_1 port map(
        CLk,
        RST,
        load_q,
        load_0,
        shift,
        A,
        not tmp_ff_out,
        tmp_q_out,
        Q
    );
    
    reg_a: Reg_2 port map(
        CLk,
        RST,
        load_a,
        shift,
        tmp_selector,
        tmp_q_out,
        tmp_mux_in,
        tmp_a_out 
            
    );
    
    R <= tmp_a_out;
    
    selector: Selezionatore_2_1 generic map(4)
        port map(
        "0000",
        tmp_sum,
        sel,
        tmp_selector   
    );
    add: adder_sub port map(
        tmp_a_out,
        tmp_m,
        not tmp_ff_out,
        tmp_sum,
        tmp_cout 
    );
    mux: Mux_2_1 port map(
        tmp_sum(3)&'0', sel, tmp_ff_in 
    );
    
    ff_s: FFD port map(
        CLK, store, RST, tmp_ff_in, tmp_ff_out       
    );
    
    
    --
    cont: counter_n port map(
        CLK, RST , en_count, fc
    );
    

end Structural;
