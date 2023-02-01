

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;



entity Encoder is
    Port ( 
        data1_in : in STD_LOGIC_VECTOR (3 downto 0);
        data2_in : in STD_LOGIC_VECTOR (3 downto 0);
        data_out : out STD_LOGIC_VECTOR (31 downto 0)
    );  
end Encoder;

architecture Dataflow of Encoder is
signal tmp_d1 : std_logic_vector(7 downto 0) := (others => '0');
signal tmp_d2 : std_logic_vector(7 downto 0) := (others => '0');
signal tmp_out : std_logic_vector(15 downto 0) := (others => '0');
begin
    data_out <= tmp_out & tmp_d1 & tmp_d2;
    
    --prima cifra
    with to_integer(unsigned(data1_in)) select
    tmp_d1 (3 downto 0) <= "0000" when 0|10|20|30|40|50,
                                "0001" when 1|11|21|31|41|51,
                                "0010" when 2|12|22|32|42|52,
                                "0011" when 3|13|23|33|43|53,
                                "0100" when 4|14|24|34|44|54,
                                "0101" when 5|15|25|35|45|55,
                                "0110" when 6|16|26|36|46|56,
                                "0111" when 7|17|27|37|47|57,
                                "1000" when 8|18|28|38|48|58,
                                "1001" when 9|19|29|39|49|59,
                                "1111" when others;
    --seconda cifra                       
    with to_integer(unsigned(data1_in)) select
    tmp_d1(7 downto 4) <= "0000" when 0 to 9,
                            "0001" when 10 to 19,
                            "0010" when 20 to 29,
                            "0011" when 30 to 39,
                            "0100" when 40 to 49,
                            "0101" when 50 to 59,
                             "1111" when others;                               
     --prima cifra
    with to_integer(unsigned(data2_in)) select
    tmp_d2 (3 downto 0) <= "0000" when 0|10|20|30|40|50,
                                "0001" when 1|11|21|31|41|51,
                                "0010" when 2|12|22|32|42|52,
                                "0011" when 3|13|23|33|43|53,
                                "0100" when 4|14|24|34|44|54,
                                "0101" when 5|15|25|35|45|55,
                                "0110" when 6|16|26|36|46|56,
                                "0111" when 7|17|27|37|47|57,
                                "1000" when 8|18|28|38|48|58,
                                "1001" when 9|19|29|39|49|59,
                                "1111" when others;
    --seconda cifra                       
    with to_integer(unsigned(data2_in)) select
    tmp_d2(7 downto 4) <= "0000" when 0 to 9,
                            "0001" when 10 to 19,
                            "0010" when 20 to 29,
                            "0011" when 30 to 39,
                            "0100" when 40 to 49,
                            "0101" when 50 to 59,
                             "1111" when others;   

end Dataflow;
