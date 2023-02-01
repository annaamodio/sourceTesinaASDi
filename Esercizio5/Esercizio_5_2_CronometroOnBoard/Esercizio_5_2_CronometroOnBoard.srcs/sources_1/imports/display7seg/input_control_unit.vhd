----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2023 11:57:21
-- Design Name: 
-- Module Name: input_control_unit - Behavioral
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

entity input_control_unit is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           load : in STD_LOGIC;
           load_s : out STD_LOGIC;
           load_m : out STD_LOGIC;
           load_h : out STD_LOGIC);
end input_control_unit;

architecture Behavioral of input_control_unit is

type state is (
    idle,
    loadS,
    loadM,
    loadH,
    seconds_ok,
    minutes_ok,
    hours_ok
);

signal current_state: state := idle;

begin

    proc: process(CLK)
    begin
        if(rising_edge(CLK)) then
            if(RST = '1') then
                current_state <= idle;
                load_s <= '0';
                load_m <= '0';
                load_h <= '0';
            else             
                case current_state is
                    when idle =>
                        load_s <= '0';
                        load_m <= '0';
                        load_h <= '0';
                        if(load ='1') then
                            current_state <= loadS;
                        else
                            current_state <= idle;
                        end if;
                    when loadS =>
                        load_s <= '1';
                        current_state <= seconds_ok;
                    when seconds_ok =>
                        load_s <= '0';
                        if(load ='1') then
                            current_state <= loadM;
                        else
                            current_state <= seconds_ok;
                        end if;
                    when loadM =>
                        load_m <= '1';
                        current_state <= minutes_ok;
                    when minutes_ok =>
                        load_m <= '0';
                        if(load ='1') then
                            current_state <= loadH;
                        else
                            current_state <= minutes_ok;
                        end if;
                    when loadH =>
                        load_h <= '1';
                        current_state <= hours_ok;
                    when hours_ok =>
                        load_h <= '0';
                        if(load ='1') then
                            current_state <= loadS;
                        else
                            current_state <= hours_ok;
                        end if;                      
                end case;
            end if;
        end if;
    end process;

end Behavioral;
