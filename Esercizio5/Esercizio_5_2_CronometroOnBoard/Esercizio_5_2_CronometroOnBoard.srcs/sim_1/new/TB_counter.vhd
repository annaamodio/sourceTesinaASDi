library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_counter is
end TB_counter;

architecture Behavioral of TB_counter is

component counter                                    
   generic(                                             
        m : integer := 8;                               
        n : integer := 3                                
    );                                                  
   port(
          CLK:   in  std_logic;                          
         RESET: in  std_logic;                          
         enable: in std_logic;                          
         load:  in  std_logic;                          
         data:  in  std_logic_vector(n - 1 downto 0);   
         y:     out std_logic_vector(n - 1 downto 0);   
         count: out std_logic                           
   );                                                   
   end component;
   
component clock_divider is
	 generic(
				clock_frequency_in : integer := 100000000;--100MHz
				clock_frequency_out : integer := 500 --500 Hz
				);
    Port (
            clock_in : in  STD_LOGIC;
		   reset : in STD_LOGIC;
           clock_out : out  STD_LOGIC
           );
    end component;
    
     signal sCLK: std_logic:= '0';
     signal sEn: std_logic:='0';                          
     signal sRESET: std_logic:= '0';                                              
     signal sload:  std_logic:= '0';                                               
     signal sdata:  std_logic_vector(2 downto 0):=(others=>'0');   
     signal sy:     std_logic_vector(2 downto 0) := (others=>'0');   
     signal scount: std_logic := '0';
    
     constant CLK_period : time := 10 ns;
         
begin
    
    test_counter: counter
        generic map(
            6,
            3            
        )
        port map(
            sCLK,
            sRESET,
            sEn,
            sload,
            sdata,
            sy,
            scount
        );
        
        test_divider: clock_divider
            generic map(
                2,
                1
            )
            port map(
                sCLK,
                sRESET,
                sEn
            );
        
        
    clk_proc: process
        begin
        sCLK <= '0';
        wait for CLK_period / 2;
        sCLK <= '1';
        wait for CLK_period /2;
    end process;
 
    test: process
        begin
        wait for 100ns;
        sRESET<='1';
        wait for 10ns;
        sRESET<='0';
        sdata<="001";
        wait for 100ns;
        sload <= '1';
        wait for 30ns;
        sload <='0';
        wait;
   end process;

 

end Behavioral;