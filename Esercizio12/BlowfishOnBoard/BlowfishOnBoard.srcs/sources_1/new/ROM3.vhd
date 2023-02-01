library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



entity ROM3 is
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
end ROM3;
-- creo una ROM di 8 elementi da 32 bit ciascuno
architecture behavioral of ROM3 is 
signal tmpAddr : std_logic_vector(7 downto 0):= (others=>'0'); 
type rom_type is array (0 to 255) of std_logic_vector(31 downto 0);
signal ROM : rom_type := (

        X"3A39CE37", X"D3FAF5CF", X"ABC27737", X"5AC52D1B",
        X"5CB0679E", X"4FA33742", X"D3822740", X"99BC9BBE",
        X"D5118E9D", X"BF0F7315", X"D62D1C7E", X"C700C47B",
        X"B78C1B6B", X"21A19045", X"B26EB1BE", X"6A366EB4",
        X"5748AB2F", X"BC946E79", X"C6A376D2", X"6549C2C8",
        X"530FF8EE", X"468DDE7D", X"D5730A1D", X"4CD04DC6",
        X"2939BBDB", X"A9BA4650", X"AC9526E8", X"BE5EE304",
        X"A1FAD5F0", X"6A2D519A", X"63EF8CE2", X"9A86EE22",
        X"C089C2B8", X"43242EF6", X"A51E03AA", X"9CF2D0A4",
        X"83C061BA", X"9BE96A4D", X"8FE51550", X"BA645BD6",
        X"2826A2F9", X"A73A3AE1", X"4BA99586", X"EF5562E9",
        X"C72FEFD3", X"F752F7DA", X"3F046F69", X"77FA0A59",
        X"80E4A915", X"87B08601", X"9B09E6AD", X"3B3EE593",
        X"E990FD5A", X"9E34D797", X"2CF0B7D9", X"022B8B51",
        X"96D5AC3A", X"017DA67D", X"D1CF3ED6", X"7C7D2D28",
        X"1F9F25CF", X"ADF2B89B", X"5AD6B472", X"5A88F54C",
        X"E029AC71", X"E019A5E6", X"47B0ACFD", X"ED93FA9B",
        X"E8D3C48D", X"283B57CC", X"F8D56629", X"79132E28",
        X"785F0191", X"ED756055", X"F7960E44", X"E3D35E8C",
        X"15056DD4", X"88F46DBA", X"03A16125", X"0564F0BD",
        X"C3EB9E15", X"3C9057A2", X"97271AEC", X"A93A072A",
        X"1B3F6D9B", X"1E6321F5", X"F59C66FB", X"26DCF319",
        X"7533D928", X"B155FDF5", X"03563482", X"8ABA3CBB",
        X"28517711", X"C20AD9F8", X"ABCC5167", X"CCAD925F",
        X"4DE81751", X"3830DC8E", X"379D5862", X"9320F991",
        X"EA7A90C2", X"FB3E7BCE", X"5121CE64", X"774FBE32",
        X"A8B6E37E", X"C3293D46", X"48DE5369", X"6413E680",
        X"A2AE0810", X"DD6DB224", X"69852DFD", X"09072166",
        X"B39A460A", X"6445C0DD", X"586CDECF", X"1C20C8AE",
        X"5BBEF7DD", X"1B588D40", X"CCD2017F", X"6BB4E3BB",
        X"DDA26A7E", X"3A59FF45", X"3E350A44", X"BCB4CDD5",
        X"72EACEA8", X"FA6484BB", X"8D6612AE", X"BF3C6F47",
        X"D29BE463", X"542F5D9E", X"AEC2771B", X"F64E6370",
        X"740E0D8D", X"E75B1357", X"F8721671", X"AF537D5D",
        X"4040CB08", X"4EB4E2CC", X"34D2466A", X"0115AF84",
        X"E1B00428", X"95983A1D", X"06B89FB4", X"CE6EA048",
        X"6F3F3B82", X"3520AB82", X"011A1D4B", X"277227F8",
        X"611560B1", X"E7933FDC", X"BB3A792B", X"344525BD",
        X"A08839E1", X"51CE794B", X"2F32C9B7", X"A01FBAC9",
        X"E01CC87E", X"BCC7D1F6", X"CF0111C3", X"A1E8AAC7",
        X"1A908749", X"D44FBD9A", X"D0DADECB", X"D50ADA38",
        X"0339C32A", X"C6913667", X"8DF9317C", X"E0B12B4F",
        X"F79E59B7", X"43F5BB3A", X"F2D519FF", X"27D9459C",
        X"BF97222C", X"15E6FC2A", X"0F91FC71", X"9B941525",
        X"FAE59361", X"CEB69CEB", X"C2A86459", X"12BAA8D1",
        X"B6C1075E", X"E3056A0C", X"10D25065", X"CB03A442",
        X"E0EC6E0E", X"1698DB3B", X"4C98A0BE", X"3278E964",
        X"9F1F9532", X"E0D392DF", X"D3A0342B", X"8971F21E",
        X"1B0A7441", X"4BA3348C", X"C5BE7120", X"C37632D8",
        X"DF359F8D", X"9B992F2E", X"E60B6F47", X"0FE3F11D",
        X"E54CDA54", X"1EDAD891", X"CE6279CF", X"CD3E7E6F",
        X"1618B166", X"FD2C1D05", X"848FD2C5", X"F6FB2299",
        X"F523F357", X"A6327623", X"93A83531", X"56CCCD02",
        X"ACF08162", X"5A75EBB5", X"6E163697", X"88D273CC",
        X"DE966292", X"81B949D0", X"4C50901B", X"71C65614",
        X"E6C6C7BD", X"327A140A", X"45E1D006", X"C3F27B9A",
        X"C9AA53FD", X"62A80F00", X"BB25BFE2", X"35BDD2F6",
        X"71126905", X"B2040222", X"B6CBCF7C", X"CD769C2B",
        X"53113EC0", X"1640E3D3", X"38ABBD60", X"2547ADF0",
        X"BA38209C", X"F746CE76", X"77AFA1C5", X"20756060",
        X"85CBFE4E", X"8AE88DD8", X"7AAAF9B0", X"4CF9AA7E",
        X"1948C25C", X"02FB8A8C", X"01C36AE4", X"D6EBE1F9",
        X"90D4F869", X"A65CDEA0", X"3F09252D", X"C208E69F",
        X"B74E6132", X"CE77E25B", X"578FDFE3", X"3AC372E6"

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