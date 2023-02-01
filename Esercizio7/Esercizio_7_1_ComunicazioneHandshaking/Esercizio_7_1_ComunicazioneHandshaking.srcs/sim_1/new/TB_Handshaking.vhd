----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2023 11:27:31
-- Design Name: 
-- Module Name: TB_Handshaking - Behavioral
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

entity TB_Handshaking is
--  Port ( );
end TB_Handshaking;

architecture Behavioral of TB_Handshaking is
    component SYS_A
        Port ( CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               RST_MEM: in std_logic;
               start : in STD_LOGIC;
               ok : in STD_LOGIC;
               send : out STD_LOGIC;
               data : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    component SYS_B 
        Port ( 
            CLK : in STD_LOGIC;
            RST : in STD_LOGIC;
            RST_MEM : in std_logic;
            send : in STD_LOGIC;
            data_in : in STD_LOGIC_VECTOR (7 downto 0);
            ok : out STD_LOGIC
        );
    end component;
    
    signal clk_a : std_logic := '0'; 
    signal clk_b : std_logic := '0'; 
    signal reset : std_logic := '0';
    signal reset_mem : std_logic := '0';
    signal tmp_start : std_logic := '0';
    signal tmp_ok : std_logic := '0'; 
    signal tmp_send : std_logic := '0'; 
    signal tmp_data : std_logic_vector(7 downto 0) := (others => '0'); 
    constant CLK_period : time := 10ns; 
    signal phase : std_logic := '0';
begin
    clk_a_proc: process
    begin
        clk_a  <= '0';
        wait for CLK_period / 2;
        clk_a  <= '1';
        wait for CLK_period /2;
    end process;
    
    clk_b_proc: process
    begin
        if( phase = '0') then
            wait for CLK_period/4;
            clk_b <= '0';
            phase <= '1';
        end if;
        clk_b  <= '0';
        wait for CLK_period / 2;
        clk_b  <= '1';
        wait for CLK_period /2;
    end process;
    
    
    s_a: SYS_A port map(
        clk_a,
        reset,
        reset_mem,
        tmp_start,
        tmp_ok,
        tmp_send,
        tmp_data
       
    );
    
    s_b: SYS_B port map(
        clk_b,
        reset,
        reset_mem,
        tmp_send,
        tmp_data,
        tmp_ok   
    );
    
    
    
    test_proc : process 
    begin 
        wait for 100ns;
        
        reset <= '1';
        wait for 10ns;
        reset <= '0';
        tmp_start <= '1';
        wait for 10ns;
        tmp_start <= '0';
        
        wait;
    
    
    end process;
    
    
    

end Behavioral;
