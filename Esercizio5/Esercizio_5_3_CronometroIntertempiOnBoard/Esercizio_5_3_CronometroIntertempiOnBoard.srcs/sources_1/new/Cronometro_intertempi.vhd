

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Cronometro_intertempi is
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
end Cronometro_intertempi;

architecture Structural of Cronometro_intertempi is
component Gestore_tempo 
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
end component;

component cronometro 
    Port ( 
           CLOCK : in std_logic;
           RST : in std_logic;
           set : in std_logic;
           seconds_in : in std_logic_vector(5 downto 0);
           minutes_in: in std_logic_vector(5 downto 0);
           hours_in: in std_logic_vector(4 downto 0);
           seconds_out : out std_logic_vector(5 downto 0);
           minutes_out: out std_logic_vector(5 downto 0);
           hours_out: out std_logic_vector(4 downto 0)
          );
end component;


signal tmp_s : std_logic_vector(5 downto 0) := (others => '0');
signal tmp_m : std_logic_vector(5 downto 0) := (others => '0');
signal tmp_h : std_logic_vector(4 downto 0) := (others => '0');
begin

    cron: cronometro
        port map(
        CLK,
        RST,
        SET,
        seconds_in,
        minutes_in,
        hours_in,
        tmp_s,
        tmp_m,
        tmp_h
    );
     gt: Gestore_tempo port map (
        CLK,
        RST,
        tmp_s,
        tmp_m,
        tmp_h,
        STOP ,
        VISUALIZZA,
        seconds_out,
        minutes_out,
        hours_out 
    
    );

end Structural;
