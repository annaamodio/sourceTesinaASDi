----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2023 16:06:24
-- Design Name: 
-- Module Name: Encrypter - Structural
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

entity Encrypter is
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
           encrypted_msg : out STD_LOGIC_VECTOR (63 downto 0));
end Encrypter;

architecture Structural of Encrypter is

component op_f is
    Port ( CLK : in STD_LOGIC;
           value_in : in STD_LOGIC_VECTOR (31 downto 0);
           value_out : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component register_pp is
    
    generic (
        n: integer := 8
    );

    Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           write : in STD_LOGIC;
           x : in STD_LOGIC_VECTOR ( n-1 downto 0);
           y : out STD_LOGIC_VECTOR ( n-1 downto 0));
end component;

component Selezionatore_2_1 is
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


component register_pp_splited is
    
    generic (
        n: integer := 8
        
    );

    Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           writeL : in STD_LOGIC;
           writeR : in STD_LOGIC;
           x : in STD_LOGIC_VECTOR ( (n/2) - 1 downto 0);
           y : out STD_LOGIC_VECTOR ( n-1 downto 0));
end component;

component counter_n is
	generic(
		n : integer :=4;
		m : integer := 2
	);
    Port ( CLK : in  STD_LOGIC;
		   RST : in STD_LOGIC;
		   enable : in std_logic;
		   y: out std_logic_vector( m-1 downto 0);
		   end_cont : out std_logic
        );
end component;


signal msg_out: std_logic_vector(63 downto 0) := (others => '0');
signal value_msg: std_logic_vector(63 downto 0) := (others => '0');
signal sel_in_2: std_logic_vector(63 downto 0) := (others => '0');

signal f_in: std_logic_vector(31 downto 0) := (others => '0');
signal f_out: std_logic_vector(31 downto 0) := (others => '0');

signal sel_last_out: std_logic_vector(31 downto 0) := (others => '0');

signal reg_res_in: std_logic_vector(31 downto 0) := (others => '0');
signal reg_res_out: std_logic_vector(63 downto 0) := (others => '0');

signal cont_out: std_logic_vector(2 downto 0) := (others => '0');


begin


reg_msg: register_pp
generic map(64)
port map(
    CLK,
    RST,
    en_msg,
    value_msg,
    msg_out
);

selec_msg: Selezionatore_2_1
generic map(64)
port map(
    data_msg,
    sel_in_2,
    sel_msg,
    value_msg
);

f_in <= data_in xor msg_out(63 downto 32);

f: op_f
port map(
    CLK,
    f_in,
    f_out
);

sel_in_2(31 downto 0) <= f_in;
sel_in_2(63 downto 32) <= f_out xor msg_out(31 downto 0);


selec_res: Selezionatore_2_1
generic map(32)
port map(
    msg_out(63 downto 32),
    msg_out(31 downto 0),
    sel_last,
    sel_last_out
);

reg_res_in <= sel_last_out xor data_in;

reg_res: register_pp_splited
generic map(64)
port map(
    CLK,
    RST,
    en_first,
    en_last,
    reg_res_in,
    encrypted_msg
);

cont_mem: counter_n
generic map(5, 3)
port map(
    CLK,
    RST,
    en_cont_5,
    cont_out,
    fine_cont_5
);



end Structural;
