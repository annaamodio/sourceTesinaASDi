
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Parte_Operativa is
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
end Parte_Operativa;

architecture Structural of Parte_Operativa is
    component Omega_network
        Port (    
            data_in : in STD_LOGIC_VECTOR (3 downto 0);
            source_sel : in STD_LOGIC_VECTOR (1 downto 0);
            dest_sel : in STD_LOGIC_VECTOR (1 downto 0);       
            data_out : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;
    
signal tmp_in1: std_logic_vector(3 downto 0) :=(others=>'0'); 
signal tmp_in2: std_logic_vector(3 downto 0) :=(others=>'0'); 
signal tmp_out1: std_logic_vector(3 downto 0) :=(others=>'0'); 
signal tmp_out2: std_logic_vector(3 downto 0) :=(others=>'0');    
 
begin

    tmp_in1 <=  data3_in(0)&data2_in(0)&data1_in(0)&data0_in(0);
    tmp_in2 <=  data3_in(1)&data2_in(1)&data1_in(1)&data0_in(1);

    
    on_l1: Omega_network port map(
        tmp_in1,
        source_sel,
        dest_sel,
        tmp_out1
    );
    
        data3_out(0) <= tmp_out1(3);
        data2_out(0) <= tmp_out1(2);
        data1_out(0) <= tmp_out1(1);
        data0_out(0) <= tmp_out1(0);
        
        on_l2: Omega_network port map(
        tmp_in2,
        source_sel,
        dest_sel,
        tmp_out2
    );
       
       data3_out(1) <= tmp_out2(3);
       data2_out(1) <= tmp_out2(2);
       data1_out(1) <= tmp_out2(1);
       data0_out(1) <= tmp_out2(0);    

end Structural;
