library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux_2_1 is
port (
        b0 : in STD_LOGIC;
        b1 : in STD_LOGIC;
        s0 : in STD_LOGIC;
        y0 : out STD_LOGIC
);
end mux_2_1;


architecture dataflow of mux_2_1 is
    begin 
        y0 <= b0 when s0='0' else
             b1 when s0 ='1' else 
             '-';
end dataflow;
			