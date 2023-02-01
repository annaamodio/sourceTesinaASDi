

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Output_manager is
    Port ( 
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        Q : in STD_LOGIC_VECTOR (3 downto 0);
        R : in STD_LOGIC_VECTOR (3 downto 0);
        fine_div : in STD_LOGIC;
        anodes : out STD_LOGIC_VECTOR (7 downto 0);
        cathodes : out STD_LOGIC_VECTOR (7 downto 0)
    );
end Output_manager;

architecture Structural of Output_manager is
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
    component Encoder 
        Port ( 
            data1_in : in STD_LOGIC_VECTOR (3 downto 0);
            data2_in : in STD_LOGIC_VECTOR (3 downto 0);
            data_out : out STD_LOGIC_VECTOR (31 downto 0)
        );  
    end component;
    --
    component display_seven_segments 
        Generic( 
                    clock_frequency_in : integer := 100000000; 
                    clock_frequency_out : integer := 500
                    );
        Port ( clock : in  STD_LOGIC;
               reset : in  STD_LOGIC;
               value32_in : in  STD_LOGIC_VECTOR (31 downto 0);
               enable : in  STD_LOGIC_VECTOR (7 downto 0);
               dots : in  STD_LOGIC_VECTOR (7 downto 0);
               anodes : out  STD_LOGIC_VECTOR (7 downto 0);
               cathodes : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;
    --signal
    signal tmp_d1 : std_logic_vector(3 downto 0) := (others => '0');
    signal tmp_d2 : std_logic_vector(3 downto 0) := (others => '0');
    signal tmp_data_out : std_logic_vector(31 downto 0) := (others => '0');
begin
    --Quoziente
    sel1: Selezionatore_2_1 generic map(4) port map(
        "0000", Q, fine_div, tmp_d1
    );
    --Resto
    sel2: Selezionatore_2_1 generic map(4) port map(
        "0000", R, fine_div, tmp_d2
    );
    enc: Encoder port map(
        tmp_d1, tmp_d2, tmp_data_out
    );
    
    diplay: display_seven_segments port map(
        CLK, RST, 
        tmp_data_out, "00001111", "00000100",
        anodes, cathodes
        
    );


end Structural;
