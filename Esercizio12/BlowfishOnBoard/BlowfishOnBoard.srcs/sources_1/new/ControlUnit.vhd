library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
    Port (
        CLK: in std_logic;
        RST: in std_logic;
        fc: in std_logic;
        fc_5: in std_logic;
        val_count:in std_logic_vector (4 downto 0);
        start: in std_logic;
        fine : out std_logic;
        write: out std_logic;
        en_key: out std_logic;
        en_cont5: out std_logic;
        en_msg: out std_logic;
        en_cont: out std_logic;
        sel_msg: out std_logic;
        sel_last:out std_logic;
        en_first: out std_logic;
        en_last: out std_logic
     );
end ControlUnit;

architecture Behavioral of ControlUnit is

    type state is (idle,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10);
    signal current_state: state := idle;
    
begin
    automa: process(CLK)
        begin
            if(rising_edge(CLK)) then
                if (RST='1') then
                    
                    current_state <= idle; 
                else
                    case current_state is
                        when idle =>
			                write<= '0';
                    	    en_key<= '0';
                    	    en_cont5<= '0';
                    	    en_msg<= '0';
                    	    en_cont<= '0';
                    	    sel_msg<= '0';
                    	    sel_last<= '0';
                    	    en_first<= '0';
                    	    en_last<= '0';
                            fine <= '1';
                            if(start='1') then
                                current_state<=s1;
                            else
                                current_state<=idle;
                            end if;
                        when s1 =>
                            en_key <= '1';
                            en_msg <= '1';
                            sel_msg <= '0';
                            fine <= '0';
                            current_state<=s2;
                        when s2 =>
                            en_key<='0';
                            en_msg<='0';
                            en_cont<='0';
                            current_state<=s3;
                        when s3 =>
                            write <= '1';
                            current_state<=s4;
                        when s4 =>
                            write <='0';
                            en_cont<='1';
                            if(val_count = "10001")  then
                                current_state <= s5;
                            else
                                current_state<= s2;
                            end if; 
                        when s5 =>
                            en_cont<='0';
                            en_cont5<='1';
                            sel_msg<='1';
                            en_msg<='0';
                            if(fc_5='0') then
                                current_state <= s5;
                            else 
                                current_state <= s6;
                            end if;
                        when s6 =>
                            en_cont5<='0';
                            en_cont<='1';
                            en_msg<='1';
                            if(val_count="01111") then
                                current_state<=s7;
                            else
                                current_state<=s5;
                            end if;
                        when s7 =>
                            en_msg <= '0';
                            en_cont<='0';
                            sel_last<='0';
                            current_state<=s8;
                        when s8 => 
                            en_last <='1';
                            en_cont<='1';
                            current_state<=s9;
                        when s9 => 
                            en_last <= '0';
                            sel_last <='1';
                            en_cont<='0';
                            current_state<=s10;
                        when s10=>
                            en_first<='1';
                            current_state<= idle;
                    end case;      
                end if;               
             end if;
        end process; 
end Behavioral;

