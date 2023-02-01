library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ParteOperativa is
    Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           enInput : in STD_LOGIC;
           saveOutput : in STD_LOGIC
        );
end ParteOperativa;

architecture Structural of ParteOperativa is
    
    component ROM_selector is
    Port ( 
        CLK         : in std_logic;
        RST         : in std_logic;
        enable      : in std_logic;
        data_output : out std_logic_vector (3 downto 0)
        );
     end component;
     
     component MacchinaCombinatoria
        Port(                                 
            input : in STD_LOGIC_VECTOR (3 downto 0);   
            output : out STD_LOGIC_VECTOR (2 downto 0)  
         );                                          
       end component;

       
    component Memoria is
    Generic(
        k : integer :=8;
        m : integer := 3
    );
    Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           enable : in STD_LOGIC;
           value : in STD_LOGIC_VECTOR(m-1 downto 0)
        );
    end component;
    
    signal tempInput : std_logic_vector(3 downto 0) :=(others => '0');
    signal tempOutput: std_logic_vector(2 downto 0) :=(others => '0');
    
begin
    
  
    rom_sel: ROM_selector
    port map(
        CLK,
        RST,
        enInput,
        tempInput
    );
    
    M: MacchinaCombinatoria
    port map(
        tempInput,
        tempOutput
    );
    
    mem: Memoria
    generic map(
        8,
        3
    )
    port map(
        CLK,
        RST,
        saveOutput,
        tempOutput
    );


end Structural;
