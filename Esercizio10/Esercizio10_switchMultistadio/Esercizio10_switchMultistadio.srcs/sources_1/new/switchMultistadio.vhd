
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity switchMultistadio is
    Port ( 
           data_in0 : in STD_LOGIC_VECTOR (1 downto 0);
           data_in1 : in STD_LOGIC_VECTOR (1 downto 0);
           data_in2 : in STD_LOGIC_VECTOR (1 downto 0);
           data_in3 : in STD_LOGIC_VECTOR (1 downto 0);
           data_out0 : out STD_LOGIC_VECTOR (1 downto 0);
           data_out1 : out STD_LOGIC_VECTOR (1 downto 0);
           data_out2 : out STD_LOGIC_VECTOR (1 downto 0);
           data_out3 : out STD_LOGIC_VECTOR (1 downto 0);
           enable: in STD_LOGIC_VECTOR(3 downto 0);
           dest0: in STD_LOGIC_VECTOR(1 downto 0);
           dest1: in STD_LOGIC_VECTOR(1 downto 0);
           dest2: in STD_LOGIC_VECTOR(1 downto 0);
           dest3: in STD_LOGIC_VECTOR(1 downto 0)
           );
end switchMultistadio;

architecture Structural of switchMultistadio is

component RetePriorita is 
     Port (
        en: in std_logic_vector(3 downto 0);
        dest0: in std_logic_vector(1 downto 0);
        dest1: in std_logic_vector(1 downto 0);
        dest2: in std_logic_vector(1 downto 0);
        dest3: in std_logic_vector(1 downto 0);
        source_sel: out std_logic_vector(1 downto 0);
        dest_sel: out std_logic_vector(1 downto 0)
     );
end component;

component Parte_Operativa is
    Port (
        data0_in : in STD_LOGIC_VECTOR (1 downto 0);
        data1_in : in STD_LOGIC_VECTOR (1 downto 0);
        data2_in : in STD_LOGIC_VECTOR (1 downto 0);
        data3_in : in STD_LOGIC_VECTOR (1 downto 0);
        source_sel : in STD_LOGIC_VECTOR (1 downto 0);
        dest_sel : in STD_LOGIC_VECTOR (1 downto 0);
        data0_out : out STD_LOGIC_VECTOR (1 downto 0);
        data1_out : out STD_LOGIC_VECTOR (1 downto 0);
        data2_out : out STD_LOGIC_VECTOR (1 downto 0);
        data3_out : out STD_LOGIC_VECTOR (1 downto 0)
    );
 end component;   
    
signal tmpDest: std_logic_vector(1 downto 0):=(others=>'0');
signal tmpSource: std_logic_vector(1 downto 0):=(others=>'0');

begin
    
    parte_controllo: RetePriorita
    port map(
        enable,
        dest0,
        dest1,
        dest2,
        dest3,
        tmpSource,
        tmpDest
    );
    
    parte_op: Parte_Operativa
    port map(
        data_in0,
        data_in1,
        data_in2,
        data_in3,
        tmpSource,
        tmpDest,
        data_out0,
        data_out1,
        data_out2,
        data_out3
    );


end Structural;
