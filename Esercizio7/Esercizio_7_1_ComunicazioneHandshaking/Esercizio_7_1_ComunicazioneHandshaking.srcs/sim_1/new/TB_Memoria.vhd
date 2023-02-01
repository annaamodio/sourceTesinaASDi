----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.01.2023 16:02:57
-- Design Name: 
-- Module Name: TB_Memoria - Behavioral
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



entity TB_Memoria is
--  Port ( );
end TB_Memoria;

architecture Behavioral of TB_Memoria is
    component Memoria 
    generic (
        n : integer := 8; --numero registri
        k : integer := 3; --numero bto selezione=log_2(n)
        m : integer := 8  --numero bit per registro
    );
    port(
        CLK : in std_logic;
        RST : in std_logic;
        data_in : in std_logic_vector(n-1 downto 0);
        Rin : in std_logic;
        addr: in std_logic_vector(k-1 downto 0);
        data_out : out std_logic_vector(n-1 downto 0)
        
    );
    end component;
    
    signal clock : std_logic := '0';
    signal reset : std_logic := '0';
    signal tmp_write : std_logic := '0';
    signal tmp_data_in : std_logic_vector(7 downto 0) := (others => '0');
    signal tmp_addr : std_logic_vector(2 downto 0) := (others => '0');
    signal tmp_data_out : std_logic_vector(7 downto 0) := (others => '0');
    constant CLK_period : time := 10ns;
    
begin
    test_mem: Memoria port map(
        clock,
        reset,
        tmp_data_in,
        tmp_write,
        tmp_addr,
        tmp_data_out 
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
        wait for 30ns;
        tmp_data_in <= "10101010";
        tmp_addr <= "101";
        tmp_write <= '1';
        wait for 10ns;
        tmp_write <= '0';
        wait for 50ns;
        tmp_addr <= "100";
        
        wait;
    end process;

end Behavioral;
