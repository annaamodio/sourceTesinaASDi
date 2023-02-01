library ieee;
use ieee.std_logic_1164.all;

entity shift_register_tb is
end shift_register_tb;

architecture tb of shift_register_tb is

    component shift_register
    generic (
        n   : integer := 8
    );
    port(
        CLK, RST : in std_logic;
        input : in std_logic;
        dir : in std_logic ;
        inc : in std_logic; -- se inc = 0 -> incremento di una poszione altrimenti di due
        Y : out std_logic
        );
    end component;

    signal clk_tb : std_logic;
    signal input  : std_logic :='0';
    signal direction : std_logic  := '0';
    signal increment : std_logic  := '0';
    signal output  : std_logic := '0';
    signal rst : std_logic := '0';

    constant clk_period : time := 20 ns; 
    

begin
    -- Clock generation
   clk_process : process
   begin
		clk_tb <= '0';
		wait for clk_period/2;
		clk_tb <= '1';
		wait for clk_period/2;
   end process;
   
   
   
    uut : entity work.shift_register(Structural2)
    generic map(8)
    port map (
        CLK => clk_tb,
        RST => rst,
        input  => input,
        dir => direction,
        inc => increment,
        Y  => output
        );
              

    stimuli : process
    begin
  
        --test 0: inc: 0 e dir :0      
        rst <= '1';
        wait for 100ns;  --global reset
        
        direction  <= '0';
        increment  <='0';
        rst <='0';
        input <= '1';
        wait for 20ns;
        input <= '0';
        wait for 180ns;
        rst<='1';
        wait for 20ns;
        rst<='0';
        direction <= '1';
        input <= '1';
        wait for 20ns;
        input <= '0';
        wait for 180ns;
        rst<='1';
        wait for 20ns;
        rst<='0';
        direction <= '0';
        increment <= '1';
        input <= '1';
        wait for 20ns;
        input <= '0';
        wait for 180ns;
        rst<='1';
        wait for 20ns;
        rst<='0';
        direction <= '1';
        increment <= '1';
        input <= '1';
        wait for 20ns;
        input <= '0';
        wait for 180ns;   
        
        
    
        
        

        wait;
    end process;

end tb;
