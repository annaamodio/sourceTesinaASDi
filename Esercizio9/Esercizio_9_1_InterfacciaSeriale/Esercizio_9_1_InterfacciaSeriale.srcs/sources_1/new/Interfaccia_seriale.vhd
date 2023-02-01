

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Interfaccia_seriale is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           start : in STD_LOGIC;
           switches : in STD_LOGIC_VECTOR (7 downto 0);
           leds : out STD_LOGIC_VECTOR (7 downto 0));
end Interfaccia_seriale;

architecture Structural of Interfaccia_seriale is
component SYS_A 
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           start : in STD_LOGIC;
           switches : in STD_LOGIC_VECTOR (7 downto 0);
           data_serial_out : out STD_LOGIC);
end component;
component SYS_B 
  Port ( 
        CLK:            in std_logic;
        RST:            in std_logic;
        data_serial:    in std_logic;
        leds:           out std_logic_vector(7 downto 0)
  );
end component;
 signal tmp_data_serial_out : std_logic := '0';

begin
    a_sys : SYS_A port map(
        CLK,
        RST,
        start,
        switches,
        tmp_data_serial_out 
    );
    b_sys: SYS_B port map (
        CLK,
        RST,
        tmp_data_serial_out,
        leds
    );


end Structural;
