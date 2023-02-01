

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SistemaTesting is
    Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           read : in STD_LOGIC;
           data_out : out std_logic_vector(2 downto 0)
      );
end SistemaTesting;

architecture Structural of SistemaTesting is
    component ButtonDebouncer 
        generic (                       
            CLK_period: integer := 10;  -- periodo del clock in nanosec
            btn_noise_time: integer := 10000000 --durata dell'oscillazione in nanosec
            );
        Port ( RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               BTN : in STD_LOGIC; 
               CLEARED_BTN : out STD_LOGIC);
    end component;
    component ControlUnit is
    Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           read : in STD_LOGIC;
           enInput : out STD_LOGIC;
           saveOutput : out STD_LOGIC
           
           );
    end component;
    
    component ParteOperativa is
    Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           enInput : in STD_LOGIC;
           saveOutput : in STD_LOGIC;
           data_out : out std_logic_vector(2 downto 0)
        );
    end component;
    
    signal enR: std_logic :='0';
    signal enM: std_logic :='0';
    signal clRead : std_logic := '0';
begin
    db_read: ButtonDebouncer 
    port map(
        RST,
        CLK,
        read,
        clRead  
    );
    cu: ControlUnit
    port map(
        CLK,
        RST,
        clRead,
        enR,
        enM
    );
    
    PO: ParteOperativa
    port map(
        CLK,
        RST,
        enR,
        enM,
        data_out 
    );

end Structural;
