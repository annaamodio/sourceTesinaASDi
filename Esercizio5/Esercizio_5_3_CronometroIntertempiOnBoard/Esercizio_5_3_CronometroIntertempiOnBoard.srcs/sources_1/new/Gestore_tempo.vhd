----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.01.2023 17:12:03
-- Design Name: 
-- Module Name: Gestore_tempo - Behavioral
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

entity Gestore_tempo is
    Port ( 
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        s_in: in std_logic_vector(5 downto 0);
        m_in: in std_logic_vector(5 downto 0);
        h_in: in std_logic_vector(4 downto 0);
        stop : in std_logic;
        visualizza : in std_logic;
        s_out: out std_logic_vector(5 downto 0);
        m_out: out std_logic_vector(5 downto 0);
        h_out: out std_logic_vector(4 downto 0)
        
    );
end Gestore_tempo;

architecture Structural of Gestore_tempo is
component Banco_registri
    generic(
        n: integer := 8 --numero di registri
        
    );
    Port ( 
        CLK : in std_logic ;
        RST : in std_logic;
        enable: in std_logic;
        sel  : in std_logic_vector(2 downto 0);
        data_in : in std_logic_vector (n-1 downto 0);
        
        data_out : out std_logic_vector (n-1 downto 0)
    );        
           
end component;

component counter_mod8 
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC; --questo è l'enable del clock, insieme danno l'impulso di conteggio
           counter : out  STD_LOGIC_VECTOR (2 downto 0));
end component;

component ButtonDebouncer 
    generic (                       
        CLK_period: integer := 10;  -- periodo del clock in nanosec
        btn_noise_time: integer := 10000000 --durata dell'oscillazione in nanosec
        );
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BTN : in STD_LOGIC; 
           CLEARED_BTN : out STD_LOGIC);
end component;

signal tmp_visualizza : std_logic := '0';
signal tmp_stop : std_logic := '0';
signal tmp_sel : std_logic_vector (2 downto 0) := (others => '0');
begin
    db_visualizza: ButtonDebouncer port map(
        RST ,
        CLK,
        visualizza,
        tmp_visualizza
    
    );
    
    db_stop: ButtonDebouncer port map(
        RST ,
        CLK,
        stop,
        tmp_stop  
    );
    
    count: counter_mod8
    Port map(
        CLK,
        RST,
        tmp_visualizza,
        tmp_sel 
    );
    
    br_s: Banco_registri 
    generic map(6)
    port map(
        CLK ,
        RST,
        tmp_stop,
        tmp_sel,
        s_in,
        s_out       
    );
    br_m: Banco_registri 
    generic map(6)
    port map(
        CLK ,
        RST,
        tmp_stop,
        tmp_sel,
        m_in,
        m_out       
    );
    br_h: Banco_registri 
    generic map(5)
    port map(
        CLK ,
        RST,
        tmp_stop,
        tmp_sel,
        h_in,
        h_out       
    );


end Structural;
