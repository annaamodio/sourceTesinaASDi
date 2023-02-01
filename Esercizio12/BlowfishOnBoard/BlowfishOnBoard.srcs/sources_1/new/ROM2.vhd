library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



entity ROM2 is
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
end ROM2;
-- creo una ROM di 8 elementi da 32 bit ciascuno
architecture behavioral of ROM2 is 
signal tmpAddr : std_logic_vector(7 downto 0):= (others=>'0'); 
type rom_type is array (0 to 255) of std_logic_vector(31 downto 0);
signal ROM : rom_type := (
        X"E93D5A68", X"948140F7", X"F64C261C", X"94692934",
        X"411520F7", X"7602D4F7", X"BCF46B2E", X"D4A20068",
        X"D4082471", X"3320F46A", X"43B7D4B7", X"500061AF",
        X"1E39F62E", X"97244546", X"14214F74", X"BF8B8840",
        X"4D95FC1D", X"96B591AF", X"70F4DDD3", X"66A02F45",
        X"BFBC09EC", X"03BD9785", X"7FAC6DD0", X"31CB8504",
        X"96EB27B3", X"55FD3941", X"DA2547E6", X"ABCA0A9A",
        X"28507825", X"530429F4", X"0A2C86DA", X"E9B66DFB",
        X"68DC1462", X"D7486900", X"680EC0A4", X"27A18DEE",
        X"4F3FFEA2", X"E887AD8C", X"B58CE006", X"7AF4D6B6",
        X"AACE1E7C", X"D3375FEC", X"CE78A399", X"406B2A42",
        X"20FE9E35", X"D9F385B9", X"EE39D7AB", X"3B124E8B",
        X"1DC9FAF7", X"4B6D1856", X"26A36631", X"EAE397B2",
        X"3A6EFA74", X"DD5B4332", X"6841E7F7", X"CA7820FB",
        X"FB0AF54E", X"D8FEB397", X"454056AC", X"BA489527",
        X"55533A3A", X"20838D87", X"FE6BA9B7", X"D096954B",
        X"55A867BC", X"A1159A58", X"CCA92963", X"99E1DB33",
        X"A62A4A56", X"3F3125F9", X"5EF47E1C", X"9029317C",
        X"FDF8E802", X"04272F70", X"80BB155C", X"05282CE3",
        X"95C11548", X"E4C66D22", X"48C1133F", X"C70F86DC",
        X"07F9C9EE", X"41041F0F", X"404779A4", X"5D886E17",
        X"325F51EB", X"D59BC0D1", X"F2BCC18F", X"41113564",
        X"257B7834", X"602A9C60", X"DFF8E8A3", X"1F636C1B",
        X"0E12B4C2", X"02E1329E", X"AF664FD1", X"CAD18115",
        X"6B2395E0", X"333E92E1", X"3B240B62", X"EEBEB922",
        X"85B2A20E", X"E6BA0D99", X"DE720C8C", X"2DA2F728",
        X"D0127845", X"95B794FD", X"647D0862", X"E7CCF5F0",
        X"5449A36F", X"877D48FA", X"C39DFD27", X"F33E8D1E",
        X"0A476341", X"992EFF74", X"3A6F6EAB", X"F4F8FD37",
        X"A812DC60", X"A1EBDDF8", X"991BE14C", X"DB6E6B0D",
        X"C67B5510", X"6D672C37", X"2765D43B", X"DCD0E804",
        X"F1290DC7", X"CC00FFA3", X"B5390F92", X"690FED0B",
        X"667B9FFB", X"CEDB7D9C", X"A091CF0B", X"D9155EA3",
        X"BB132F88", X"515BAD24", X"7B9479BF", X"763BD6EB",
        X"37392EB3", X"CC115979", X"8026E297", X"F42E312D",
        X"6842ADA7", X"C66A2B3B", X"12754CCC", X"782EF11C",
        X"6A124237", X"B79251E7", X"06A1BBE6", X"4BFB6350",
        X"1A6B1018", X"11CAEDFA", X"3D25BDD8", X"E2E1C3C9",
        X"44421659", X"0A121386", X"D90CEC6E", X"D5ABEA2A",
        X"64AF674E", X"DA86A85F", X"BEBFE988", X"64E4C3FE",
        X"9DBC8057", X"F0F7C086", X"60787BF8", X"6003604D",
        X"D1FD8346", X"F6381FB0", X"7745AE04", X"D736FCCC",
        X"83426B33", X"F01EAB71", X"B0804187", X"3C005E5F",
        X"77A057BE", X"BDE8AE24", X"55464299", X"BF582E61",
        X"4E58F48F", X"F2DDFDA2", X"F474EF38", X"8789BDC2",
        X"5366F9C3", X"C8B38E74", X"B475F255", X"46FCD9B9",
        X"7AEB2661", X"8B1DDF84", X"846A0E79", X"915F95E2",
        X"466E598E", X"20B45770", X"8CD55591", X"C902DE4C",
        X"B90BACE1", X"BB8205D0", X"11A86248", X"7574A99E",
        X"B77F19B6", X"E0A9DC09", X"662D09A1", X"C4324633",
        X"E85A1F02", X"09F0BE8C", X"4A99A025", X"1D6EFE10",
        X"1AB93D1D", X"0BA5A4DF", X"A186F20F", X"2868F169",
        X"DCB7DA83", X"573906FE", X"A1E2CE9B", X"4FCD7F52",
        X"50115E01", X"A70683FA", X"A002B5C4", X"0DE6D027",
        X"9AF88C27", X"773F8641", X"C3604C06", X"61A806B5",
        X"F0177A28", X"C0F586E0", X"006058AA", X"30DC7D62",
        X"11E69ED7", X"2338EA63", X"53C2DD94", X"C2C21634",
        X"BBCBEE56", X"90BCB6DE", X"EBFC7DA1", X"CE591D76",
        X"6F05E409", X"4B7C0188", X"39720A3D", X"7C927C24",
        X"86E3725F", X"724D9DB9", X"1AC15BB4", X"D39EB8FC",
        X"ED545578", X"08FCA5B5", X"D83D7CD3", X"4DAD0FC4",
        X"1E50EF5E", X"B161E6F8", X"A28514D9", X"6C51133C",
        X"6FD5C7E7", X"56E14EC4", X"362ABFCE", X"DDC6C837",
        X"D79A3234", X"92638212", X"670EFA8E", X"406000E0"
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