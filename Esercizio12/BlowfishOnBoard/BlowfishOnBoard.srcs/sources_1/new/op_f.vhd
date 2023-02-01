----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2023 16:24:02
-- Design Name: 
-- Module Name: op_f - Structural
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

entity op_f is
    Port ( CLK : in STD_LOGIC;
           value_in : in STD_LOGIC_VECTOR (31 downto 0);
           value_out : out STD_LOGIC_VECTOR (31 downto 0));
end op_f;

architecture Structural of op_f is

component ROM is
port(
    CLK : in std_logic; 
    ADDR : in std_logic_vector(7 downto 0); --3 bit di indirizzo per accedere agli elementi della                   
    DATA : out std_logic_vector(31 downto 0) -- dato su 32 bit letto dalla ROM
    );
end  component;

component ROM1 is
port(
    CLK : in std_logic; 
    ADDR : in std_logic_vector(7 downto 0); --3 bit di indirizzo per accedere agli elementi della                   
    DATA : out std_logic_vector(31 downto 0) -- dato su 32 bit letto dalla ROM
    );
end  component;

component ROM2 is
port(
    CLK : in std_logic; 
    ADDR : in std_logic_vector(7 downto 0); --3 bit di indirizzo per accedere agli elementi della                   
    DATA : out std_logic_vector(31 downto 0) -- dato su 32 bit letto dalla ROM
    );
end  component;


component ROM3 is
port(
    CLK : in std_logic; 
    ADDR : in std_logic_vector(7 downto 0); --3 bit di indirizzo per accedere agli elementi della                   
    DATA : out std_logic_vector(31 downto 0) -- dato su 32 bit letto dalla ROM
    );
end  component;


component F is
port(
    data_0: in std_logic_vector(31 downto 0);
    data_1: in std_logic_vector(31 downto 0);
    data_2: in std_logic_vector(31 downto 0);
    data_3: in std_logic_vector(31 downto 0);
    y: out std_logic_vector(31 downto 0) 

);
end component;


signal data_out_s0: std_logic_vector(31 downto 0) := (others => '0');
signal data_out_s1: std_logic_vector(31 downto 0) := (others => '0');
signal data_out_s2: std_logic_vector(31 downto 0) := (others => '0');
signal data_out_s3: std_logic_vector(31 downto 0) := (others => '0');

signal reg1: std_logic_vector(31 downto 0) := (others => '0');
signal reg2: std_logic_vector(31 downto 0) := (others => '0');
signal reg3: std_logic_vector(31 downto 0) := (others => '0');
signal reg4: std_logic_vector(31 downto 0) := (others => '0');


begin

--proc_regs: process (CLK ) 
--begin 
--    if(falling_edge (CLK)) then
--            reg1 <= data_out_s0;
--            reg2 <= data_out_s1;
--            reg3 <= data_out_s2 ;
--            reg4 <= data_out_s3 ;
--        end if;

--end process;


s0: ROM
port map(
    CLK,
    value_in(31 downto 24),
    data_out_s0
    
); 

s1: ROM1
port map(
    CLK,
    value_in(23 downto 16),
    data_out_s1
    
); 

s2: ROM2
port map(
    CLK,
    value_in(15 downto 8),
    data_out_s2
    
); 


s3: ROM3
port map(
    CLK,
    value_in(7 downto 0),
    data_out_s3
); 

op: F
port map(
    data_out_s0 ,
    data_out_s1 ,
    data_out_s2 ,
    data_out_s3 ,
    value_out
);

end Structural;
