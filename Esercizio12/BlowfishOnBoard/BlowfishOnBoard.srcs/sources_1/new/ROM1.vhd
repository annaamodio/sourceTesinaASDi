library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



entity ROM1 is
port(
    CLK : in std_logic; 
    --RST : in std_logic; -- il reset normalmente si applica alle uscite della ROM (il valore letto dalla memoria risulta 
                        -- costituito da tutti '0'), mentre in questo caso non viene usato
    --READ : in std_logic; -- segnale che abilita la lettura, in questo caso non lo considero perchè 
                           -- è come se leggessi il contenuto della ROM ad ogni colpo di clock
                           -- andando a modificare tramite un bottone l'indirizzo
    ADDR : in std_logic_vector(7 downto 0); --3 bit di indirizzo per accedere agli elementi della ROM,
                                           
    DATA : out std_logic_vector(31 downto 0) -- dato su 32 bit letto dalla ROM
    );
end ROM1;
-- creo una ROM di 8 elementi da 32 bit ciascuno
architecture behavioral of ROM1 is 
signal tmpAddr : std_logic_vector(7 downto 0):= (others=>'0'); 
type rom_type is array (0 to 255) of std_logic_vector(31 downto 0);
signal ROM : rom_type := (
        X"4B7A70E9", X"B5B32944", X"DB75092E", X"C4192623",
        X"AD6EA6B0", X"49A7DF7D", X"9CEE60B8", X"8FEDB266",
        X"ECAA8C71", X"699A17FF", X"5664526C", X"C2B19EE1",
        X"193602A5", X"75094C29", X"A0591340", X"E4183A3E",
        X"3F54989A", X"5B429D65", X"6B8FE4D6", X"99F73FD6",
        X"A1D29C07", X"EFE830F5", X"4D2D38E6", X"F0255DC1",
        X"4CDD2086", X"8470EB26", X"6382E9C6", X"021ECC5E",
        X"09686B3F", X"3EBAEFC9", X"3C971814", X"6B6A70A1",
        X"687F3584", X"52A0E286", X"B79C5305", X"AA500737",
        X"3E07841C", X"7FDEAE5C", X"8E7D44EC", X"5716F2B8",
        X"B03ADA37", X"F0500C0D", X"F01C1F04", X"0200B3FF",
        X"AE0CF51A", X"3CB574B2", X"25837A58", X"DC0921BD",
        X"D19113F9", X"7CA92FF6", X"94324773", X"22F54701",
        X"3AE5E581", X"37C2DADC", X"C8B57634", X"9AF3DDA7",
        X"A9446146", X"0FD0030E", X"ECC8C73E", X"A4751E41",
        X"E238CD99", X"3BEA0E2F", X"3280BBA1", X"183EB331",
        X"4E548B38", X"4F6DB908", X"6F420D03", X"F60A04BF",
        X"2CB81290", X"24977C79", X"5679B072", X"BCAF89AF",
        X"DE9A771F", X"D9930810", X"B38BAE12", X"DCCF3F2E",
        X"5512721F", X"2E6B7124", X"501ADDE6", X"9F84CD87",
        X"7A584718", X"7408DA17", X"BC9F9ABC", X"E94B7D8C",
        X"EC7AEC3A", X"DB851DFA", X"63094366", X"C464C3D2",
        X"EF1C1847", X"3215D908", X"DD433B37", X"24C2BA16",
        X"12A14D43", X"2A65C451", X"50940002", X"133AE4DD",
        X"71DFF89E", X"10314E55", X"81AC77D6", X"5F11199B",
        X"043556F1", X"D7A3C76B", X"3C11183B", X"5924A509",
        X"F28FE6ED", X"97F1FBFA", X"9EBABF2C", X"1E153C6E",
        X"86E34570", X"EAE96FB1", X"860E5E0A", X"5A3E2AB3",
        X"771FE71C", X"4E3D06FA", X"2965DCB9", X"99E71D0F",
        X"803E89D6", X"5266C825", X"2E4CC978", X"9C10B36A",
        X"C6150EBA", X"94E2EA78", X"A5FC3C53", X"1E0A2DF4",
        X"F2F74EA7", X"361D2B3D", X"1939260F", X"19C27960",
        X"5223A708", X"F71312B6", X"EBADFE6E", X"EAC31F66",
        X"E3BC4595", X"A67BC883", X"B17F37D1", X"018CFF28",
        X"C332DDEF", X"BE6C5AA5", X"65582185", X"68AB9802",
        X"EECEA50F", X"DB2F953B", X"2AEF7DAD", X"5B6E2F84",
        X"1521B628", X"29076170", X"ECDD4775", X"619F1510",
        X"13CCA830", X"EB61BD96", X"0334FE1E", X"AA0363CF",
        X"B5735C90", X"4C70A239", X"D59E9E0B", X"CBAADE14",
        X"EECC86BC", X"60622CA7", X"9CAB5CAB", X"B2F3846E",
        X"648B1EAF", X"19BDF0CA", X"A02369B9", X"655ABB50",
        X"40685A32", X"3C2AB4B3", X"319EE9D5", X"C021B8F7",
        X"9B540B19", X"875FA099", X"95F7997E", X"623D7DA8",
        X"F837889A", X"97E32D77", X"11ED935F", X"16681281",
        X"0E358829", X"C7E61FD6", X"96DEDFA1", X"7858BA99",
        X"57F584A5", X"1B227263", X"9B83C3FF", X"1AC24696",
        X"CDB30AEB", X"532E3054", X"8FD948E4", X"6DBC3128",
        X"58EBF2EF", X"34C6FFEA", X"FE28ED61", X"EE7C3C73",
        X"5D4A14D9", X"E864B7E3", X"42105D14", X"203E13E0",
        X"45EEE2B6", X"A3AAABEA", X"DB6C4F15", X"FACB4FD0",
        X"C742F442", X"EF6ABBB5", X"654F3B1D", X"41CD2105",
        X"D81E799E", X"86854DC7", X"E44B476A", X"3D816250",
        X"CF62A1F2", X"5B8D2646", X"FC8883A0", X"C1C7B6A3",
        X"7F1524C3", X"69CB7492", X"47848A0B", X"5692B285",
        X"095BBF00", X"AD19489D", X"1462B174", X"23820E00",
        X"58428D2A", X"0C55F5EA", X"1DADF43E", X"233F7061",
        X"3372F092", X"8D937E41", X"D65FECF1", X"6C223BDB",
        X"7CDE3759", X"CBEE7460", X"4085F2A7", X"CE77326E",
        X"A6078084", X"19F8509E", X"E8EFD855", X"61D99735",
        X"A969A7AA", X"C50C06C2", X"5A04ABFC", X"800BCADC",
        X"9E447A2E", X"C3453484", X"FDD56705", X"0E1E9EC9",
        X"DB73DBD3", X"105588CD", X"675FDA79", X"E3674340",
        X"C5C43465", X"713E38D8", X"3D28F89E", X"F16DFF20",
        X"153E21E7", X"8FB03D4A", X"E6E39F2B", X"DB83ADF7" 
);

--attribute rom_style : string;
--attribute rom_style of ROM : signal is "block";-- block dice al tool di sintesi di inferire blocchi di RAMB, 
                                               -- distributed di usare le LUT
begin
process(CLK)
  begin
    if falling_edge(CLK) then
       tmpAddr <= ADDR;
    end if;
end process;

DATA <= ROM(conv_integer(tmpAddr));

end behavioral;
