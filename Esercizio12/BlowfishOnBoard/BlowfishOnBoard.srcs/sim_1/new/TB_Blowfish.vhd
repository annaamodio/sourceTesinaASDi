----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2023 21:11:16
-- Design Name: 
-- Module Name: TB_Blowfish - Behavioral
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



entity TB_Blowfish is
--  Port ( );
end TB_Blowfish;

architecture Behavioral of TB_Blowfish is
    component Blowfish 
        Port ( CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               start: in STD_LOGIC;
               data_key: in std_logic_vector(31 downto 0);
               data_msg: in std_logic_vector(63 downto 0);
               encrypted_msg : out STD_LOGIC_VECTOR (63 downto 0);
               fine: out STD_LOGIC
               );
    end component;
    signal clock, reset, tmp_start : std_logic := '0';
    signal tmp_key : std_logic_vector(31 downto 0) := (others => '0'); 
    signal tmp_msg : std_logic_vector(63 downto 0) := (others => '0');
    signal tmp_enc_msg : std_logic_vector(63 downto 0) := (others => '0');
    constant CLK_period : time := 10ns; 
begin
    test_blowfish: Blowfish port map(
        clock, reset, tmp_start,
        tmp_key , tmp_msg, tmp_enc_msg 
    );
    
    clk_proc: process
    begin
        clock <= '0';
        wait for CLK_period / 2;
        clock <= '1';
        wait for CLK_period /2;
    end process;
    
    test_proc: process 
    begin 
        wait for 100ns;
        reset <= '1';
        wait for 10ns;
        reset <= '0';
        tmp_key <= x"61616262";
        tmp_msg <= x"6161616161616161";
        tmp_start <= '1';
        wait for 10ns;
        tmp_start <= '0';
        wait;
    
    end process;   

    


end Behavioral;
