
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Banco_registri is
    generic(
        n: integer := 8 --numero di registri
        
    );
    Port ( 
        CLK : in std_logic ;
        RST : in std_logic;
        enable: in std_logic;
        sel  : in std_logic_vector(2 downto 0);
        data_in : in std_logic_vector (n-1 downto 0);
        
        data_out : out std_logic_vector (n-1 downto 0)
    );        
           
end Banco_registri;

architecture Structural of Banco_registri is
component Reg_sp 
    generic (
        n   : integer := 8
    );
    port(
        CLK, RST : in std_logic;
        enable : in std_logic;
        input : in std_logic;
        Y : out std_logic_vector(n-1 downto 0)
        );
end component;

component MUX_8_1 
    Port ( data : in STD_LOGIC_VECTOR (7 downto 0);
           sel : in STD_LOGIC_VECTOR (2 downto 0);
           output : out STD_LOGIC
           );
end component;
type out_array is array (n-1 downto 0) of std_logic_vector(6 downto 0);
signal temp_output : out_array;



begin
    reg_n_1_to_0: for i in n-1 downto 0 generate
        reg_i:Reg_sp 
        generic map(7)
        port map(
            CLK,
            RST,
            enable,
            data_in(i),
            temp_output(i)
        );
        mux_i:MUX_8_1 port map(
            temp_output(i) & data_in(i),
            sel,
            data_out(i)
        );
    
    end generate;
    


end Structural;
