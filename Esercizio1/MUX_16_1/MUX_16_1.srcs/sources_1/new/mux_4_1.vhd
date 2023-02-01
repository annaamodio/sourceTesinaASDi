library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux_4_1 is
port (
        a1: in std_logic_vector(0 to 3);
        s1 : in std_logic_vector(0 to 1);
        y1 : out std_logic
);
end mux_4_1;


architecture structural of mux_4_1 is
	signal u1 : std_logic_vector(0 to 1) := "00";
	
    component mux_2_1
		port(	
		          b0 	: in STD_LOGIC;
				  b1 	: in STD_LOGIC;
				  s0 	: in STD_LOGIC;
			      y0 	: out STD_LOGIC
		);	
	end component;
    
    begin
        mux_01: for i in 0 to 1 generate mux: mux_2_1
            port map(
                b0 => a1(i*2),
                b1 => a1(i*2+1),
                s0 => s1(0),
                y0 => u1(i)
            );
        end generate ;
       
        mux_2: mux_2_1
            port map(
                b0 => u1(0),
                b1 => u1(1),
                s0 => s1(1),
                y0 => y1
            );   

end structural;