----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2023 14:25:00
-- Design Name: 
-- Module Name: ParteOperativa - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ParteOperativa is
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
end ParteOperativa;

architecture Structural of ParteOperativa is


component Key_whitening is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           write : in STD_LOGIC;
           en_count : in STD_LOGIC;
           en_key : in STD_LOGIC;
           data_key: in std_logic_vector(31 downto 0);
           p : out STD_LOGIC_VECTOR (31 downto 0);
           val_count: out STD_LOGIC_VECTOR(4 downto 0);
           fc: out STD_LOGIC
           );
end component;

component Encrypter is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           en_msg : in STD_LOGIC;
           sel_msg : in STD_LOGIC;
           sel_last : in STD_LOGIC;
           en_first : in STD_LOGIC;
           en_last : in STD_LOGIC;
           en_cont_5 : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (31 downto 0);
           data_msg : in STD_LOGIC_VECTOR (63 downto 0);
           fine_cont_5: out STD_LOGIC;
           encrypted_msg : out STD_LOGIC_VECTOR (63 downto 0)
           );
end component;

signal p_val: STD_LOGIC_VECTOR (31 downto 0) := (others => '0');

begin

kw: Key_whitening
port map(
    CLK,
    RST,
    write,
    en_cont,
    en_key,
    data_key,
    p_val,
    val_count,
    fc
);

enc: Encrypter
port map(
    CLK,
    RST,
    en_msg,
    sel_msg,
    sel_last,
    en_first,
    en_last,
    en_cont_5,
    p_val,
    data_msg,
    fc_5,
    encrypted_msg
);





end Structural;
