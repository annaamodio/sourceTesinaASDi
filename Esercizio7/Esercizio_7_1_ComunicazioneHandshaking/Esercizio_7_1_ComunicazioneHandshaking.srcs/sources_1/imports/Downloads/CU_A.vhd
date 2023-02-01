
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity CU_A is
    Port ( 
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        start : in STD_LOGIC;
        ok : in STD_LOGIC;
        fineConteggio : in STD_LOGIC;
        enCont : out STD_LOGIC;
        Rin : out STD_LOGIC;
        send : out STD_LOGIC
    );
end CU_A;

architecture Behavioral of CU_A is

type state is (
    idle,
    S0,
    S1,
    S2,
    S3
);

signal current_state: state := idle;

begin

    proc: process(CLK)
    begin
        if(rising_edge(CLK)) then
            if(RST = '1') then
                current_state <= idle;
                enCont <= '0';
                Rin <= '0';
                send <= '0';
            else
                case current_state is
                    when idle =>
                        if(start ='1') then
                            current_state <= S0;
                        else
                            current_state <= idle;
                        end if;
                    when S0 =>
                        send <= '1';
                        current_state <= S1;
                    when S1 =>
                        Rin <= '0';                       
                        if(ok ='1') then
                            current_state <= S2;
                        else
                            current_state <= S1;
                        end if;
                    when S2 =>
                        send <= '0';
                        enCont <= '1';
                        current_state <= S3;
                    when S3 =>
                        enCont <= '0';
                        if(fineConteggio ='1') then
                            current_state <= idle;
                        else
                            current_state <= S0;
                        end if;
                end case;
            end if;
        end if;
    end process;

end Behavioral;