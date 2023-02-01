

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_16_1 is
port (
        a: in std_logic_vector (0 to 15);
        s : in std_logic_vector (0 to 3);
        y : out std_logic
);
end mux_16_1;


architecture structural of mux_16_1 is
    signal u: std_logic_vector (0 to 3) := ('0' , '0' , '0' , '0');
    
    component mux_4_1
        port(
            a1: in std_logic_vector(0 to 3);
            s1: in std_logic_vector (0 to 1);
            y1: out std_logic
        );
    end component;
    begin 
        mux_03: for i in 0 to 3 generate mux: mux_4_1 
            Port map(
                a1(0 to 3) => a(i*4 to i*4+3),
                s1(0 to 1) => s(0 to 1),
                y1 => u(i)
            );
        end generate;
       
        mux_4: mux_4_1
            port map(
                a1(0 to 3) => u(0 to 3),
                s1( 0 to 1) => s(2 to 3),
                y1 => y
            );
end structural;
