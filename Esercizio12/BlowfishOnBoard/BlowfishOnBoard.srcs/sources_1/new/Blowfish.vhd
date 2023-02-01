
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Blowfish is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           start: in STD_LOGIC;
           data_key: in std_logic_vector(31 downto 0);
           data_msg: in std_logic_vector(63 downto 0);
           encrypted_msg : out STD_LOGIC_VECTOR (63 downto 0);
           fine: out STD_LOGIC
           );
end Blowfish;

architecture Structural of Blowfish is
component ParteOperativa is
port (
    CLK: in std_logic;
    RST: in std_logic;
    en_cont: in std_logic;
    en_cont_5: in std_logic;
    write: in std_logic;
    en_key: in std_logic;
    en_msg: in std_logic;
    sel_msg: in std_logic;
    sel_last: in std_logic;
    en_first: in std_logic;
    en_last: in std_logic;
    data_key: in std_logic_vector(31 downto 0);
    data_msg: in std_logic_vector(63 downto 0);
    fc: out std_logic;
    fc_5: out std_logic;
    val_count: out std_logic_vector(4 downto 0);
    encrypted_msg : out STD_LOGIC_VECTOR (63 downto 0)
);
end component;

component ControlUnit is
    Port (
        CLK: in std_logic;
        RST: in std_logic;
        fc: in std_logic;
        fc_5: in std_logic;
        val_count:in std_logic_vector (4 downto 0);
        start: in std_logic;
        fine : out std_logic;
        write: out std_logic;
        en_key: out std_logic;
        en_cont5: out std_logic;
        en_msg: out std_logic;
        en_cont: out std_logic;
        sel_msg: out std_logic;
        sel_last:out std_logic;
        en_first: out std_logic;
        en_last: out std_logic
     );
end component;

signal sWrite: std_logic:='0';
signal sEnKey: std_logic:='0';
signal sEnCont: std_logic:='0';
signal sEnCont5: std_logic:='0';
signal sEnMsg: std_logic:='0';
signal sSelMsg: std_logic:='0';
signal sSelLast: std_logic:='0';
signal sEnFirst: std_logic:='0';
signal sEnLast: std_logic:='0';

signal sFineCont: std_logic:='0';
signal sFineCont5: std_logic:='0';
signal sValCount: std_logic_vector(4 downto 0):=(others=>'0');


begin

    po: ParteOperativa
    port map(
        CLK,
        RST,
        sEnCont,
        sEnCont5,
        sWrite,
        sEnKey,
        sEnMsg,
        sSelMsg,
        sSelLast,
        sEnFirst,
        sEnLast,
        data_key,
        data_msg,
        sFineCont,
        sFineCont5,
        sValCount,
        encrypted_msg
    );
    
    pc: ControlUnit
    port map(
        CLK,
        RST,
        sFineCont,
        sFineCont5,
        sValCount,
        start,
        fine,
        sWrite,
        sEnKey,
        sEnCont5,
        sEnMsg,
        sEnCont,
        sSelMsg,
        sSelLast,
        sEnFirst,
        sEnLast
    
    );

end Structural;
