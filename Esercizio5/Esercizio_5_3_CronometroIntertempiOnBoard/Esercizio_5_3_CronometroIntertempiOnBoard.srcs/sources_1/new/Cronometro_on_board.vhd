----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2023 12:49:15
-- Design Name: 
-- Module Name: Cronometro_on_board - Structural
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



entity Cronometro_on_board is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           switches : in STD_LOGIC_VECTOR (5 downto 0);
           SET : in STD_LOGIC;          
           LOAD : in STD_LOGIC;
           VISUALIZZA : in STD_LOGIC;
           STOP : in STD_LOGIC ;
           cathodes : out STD_LOGIC_VECTOR (7 downto 0);
           anodes : out STD_LOGIC_VECTOR (7 downto 0));
end Cronometro_on_board;

architecture Structural of Cronometro_on_board is
component  rete_di_acquisizione
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           switches : in STD_LOGIC_VECTOR (5 downto 0);
           load : in STD_LOGIC;
           seconds_out : out STD_LOGIC_VECTOR (5 downto 0);
           minutes_out : out STD_LOGIC_VECTOR (5 downto 0);
           hours_out : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component Cronometro_intertempi 
    Port ( 
        CLK : in std_logic ;
        RST : in std_logic ;
        SET : in std_logic;
        STOP: in std_logic;
        VISUALIZZA: in std_logic;
        seconds_in: in std_logic_vector(5 downto 0);
        minutes_in: in std_logic_vector(5 downto 0);
        hours_in: in std_logic_vector(4 downto 0);
        seconds_out: out std_logic_vector(5 downto 0);
        minutes_out: out std_logic_vector(5 downto 0);
        hours_out: out std_logic_vector(4 downto 0)
              
    );    
end component;


component  OutputManager 

  Port (    
        CLK : in std_logic;
        RST : in std_logic;
        seconds_in: in std_logic_vector(5 downto 0);
        minutes_in: in std_logic_vector(5 downto 0);
        hours_in: in std_logic_vector(4 downto 0);
        anodes_out : out std_logic_vector(7 downto 0);
        cathodes_out : out std_logic_vector (7 downto 0)
   );  
end component;

signal s_in : std_logic_vector (5 downto 0) := (others =>'0');
signal m_in : std_logic_vector (5 downto 0) := (others =>'0');
signal h_in : std_logic_vector (4 downto 0) := (others =>'0');
signal s_out : std_logic_vector (5 downto 0) := (others =>'0');
signal m_out : std_logic_vector (5 downto 0) := (others =>'0');
signal h_out : std_logic_vector (4 downto 0) := (others =>'0');

begin
    racq: rete_di_acquisizione port map(
        CLK,
        RST,
        switches,
        LOAD,
        s_in,
        m_in,
        h_in    
    );
    
    cron_intertempi: Cronometro_intertempi port map(
        CLK,
        RST ,
        SET,
        STOP,
        VISUALIZZA,
        s_in,
        m_in,
        h_in,
        s_out,
        m_out,
        h_out 
    );

    
    OM: OutputManager port map(
        CLK,
        RST,
        s_out,
        m_out,
        h_out,
        anodes,
        cathodes   
    );
    


end Structural;
