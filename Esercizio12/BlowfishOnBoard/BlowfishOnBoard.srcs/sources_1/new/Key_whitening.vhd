----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2023 16:06:24
-- Design Name: 
-- Module Name: Key_whitening - Structural
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

entity Key_whitening is
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
end Key_whitening;

architecture Structural of Key_whitening is

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


component Memoria is
    generic (
        n : integer := 32  --numero bit per registro
    );
    port(
        CLK : in std_logic;
        RST : in std_logic;
        data_in : in std_logic_vector(n-1 downto 0);
        write : in std_logic;
        addr: in std_logic_vector(4 downto 0);
        data_out : out std_logic_vector(n-1 downto 0)
        
    );
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

signal key_out: std_logic_vector(31 downto 0) := (others => '0');

signal data_in_mem: std_logic_vector(31 downto 0) := (others => '0');
signal data_out_mem: std_logic_vector(31 downto 0) := (others => '0');
signal temp_addr: std_logic_vector(4 downto 0) := (others => '0');

begin

reg_key: register_pp
generic map(32)
port map(
    CLK,
    RST,
    en_key,
    data_key,
    key_out
);

mem: Memoria
port map(
    CLK,
    RST,
    data_in_mem,
    write,
    temp_addr,
    data_out_mem
);

data_in_mem <= data_out_mem xor key_out;


cont_mem: counter_n
generic map(18,5)
port map(
    CLK,
    RST,
    en_count,
    temp_addr,
    fc
);

val_count <= temp_addr;
p <= data_out_mem;

end Structural;
