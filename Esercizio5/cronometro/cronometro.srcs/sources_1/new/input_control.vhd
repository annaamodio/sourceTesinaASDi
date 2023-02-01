----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2022 11:54:11
-- Design Name: 
-- Module Name: input_control - Behavioral
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

--HO PENSATO DI PRELEVARE SEMPRE L'INFORMAZIONE DAI 6 BIT MENO SIGNIFICATIVI

entity input_control is
port(
        clock : in std_logic;
        reset : in std_logic;
        load_s : in std_logic;
        load_m : in std_logic;
        load_h : in std_logic;
        value_in: in std_logic_vector(5 downto 0);
        s_out: out std_logic_vector(5 downto 0);
        m_out: out std_logic_vector(5 downto 0);
        h_out: out std_logic_vector(4 downto 0);
        --mettiamo o no?
        ok_s: out std_logic;
        ok_m: out std_logic;
        ok_h: out std_logic
);
end input_control;

architecture Behavioral of input_control is
    
    signal sOut : std_logic_vector(5 downto 0) :=(others=>'0');
    signal mOut : std_logic_vector(5 downto 0) :=(others=>'0');
    signal hOut : std_logic_vector(4 downto 0) :=(others=>'0');
    signal sOk: std_logic :='0';
    signal mOk: std_logic :='0';
    signal hOk: std_logic :='0';
begin
    
    --abbiamo deciso di mettere segnali intermedi ma non ricordo perchè!!
    s_out <= sOut;
    m_out <= mOut;
    h_out <= hOut;
    --tre segnali che indicano se ho caricato h,m,s: vorrei mapparli con i led
    --è utile?è brutto?
    ok_s <= sOk;
    ok_m <= mOk;
    ok_h <= hOk;
    
    process_input: process(clock)
     begin   
        if(clock'event AND clock = '1') then 
           if(reset = '1') then
               sOut <= (others=>'0');
               mOut <= (others=>'0');
               hOut <= (others=>'0');
               sOk<='0';
               mOk<='0';
               hOk<='0';
           else
            --acquisisco
            if(load_s = '1') then
                sOut <= value_in;
                sOK<='1';
            elsif(load_m = '1') then
                mOut <= value_in;
                mOk <= '1';
            elsif(load_h='1') then
                hOut<=value_in(4 downto 0);
                hOk<='1';
            end if;
                
          end if;
       end if;
    end process;
end Behavioral;
