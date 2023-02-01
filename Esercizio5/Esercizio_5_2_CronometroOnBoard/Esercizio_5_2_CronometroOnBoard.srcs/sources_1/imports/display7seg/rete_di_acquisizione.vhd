----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2023 12:18:30
-- Design Name: 
-- Module Name: rete_di_acquisizione - Structural
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

entity rete_di_acquisizione is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           switches : in STD_LOGIC_VECTOR (5 downto 0);
           load : in STD_LOGIC;
           seconds_out : out STD_LOGIC_VECTOR (5 downto 0);
           minutes_out : out STD_LOGIC_VECTOR (5 downto 0);
           hours_out : out STD_LOGIC_VECTOR (4 downto 0));
end rete_di_acquisizione;

architecture Structural of rete_di_acquisizione is

component input_control_unit
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           load : in STD_LOGIC;
           load_s : out STD_LOGIC;
           load_m : out STD_LOGIC;
           load_h : out STD_LOGIC);
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


component register_pp
    
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


--segnali 
signal tmp_load   : std_logic :='0';
signal tmp_load_s : std_logic :='0';
signal tmp_load_m : std_logic :='0';
signal tmp_load_h : std_logic :='0';


begin

        db: ButtonDebouncer
        port map(
            RST,
            CLK,
            load, 
            tmp_load
        );
        
        icu: input_control_unit
        port map(
           CLK,
           RST,
           tmp_load,
           tmp_load_s,
           tmp_load_m,
           tmp_load_h
        );
        
        
        reg_sec: register_pp
        generic map( 6 )
        port map(
            CLK,
            RST,
            tmp_load_s,
            switches,
            seconds_out
        );
        
        
        reg_min: register_pp
        generic map( 6 )
        port map(
            CLK,
            RST,
            tmp_load_m,
            switches,
            minutes_out
        );
        
        
        reg_h: register_pp
        generic map( 5 )
        port map(
            CLK,
            RST,
            tmp_load_h,
            switches(4 downto 0),
            hours_out
        );
        




end Structural;
