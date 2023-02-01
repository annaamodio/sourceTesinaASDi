----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2023 15:10:37
-- Design Name: 
-- Module Name: BlowfishOnBoard - Behavioral
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

entity BlowfishOnBoard is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           bit_in : in STD_LOGIC;
           swap: in std_logic;
           fine : out STD_LOGIC;
           anodes : out std_logic_vector (7 downto 0);
           cathodes : out std_logic_vector (7 downto 0)
           
           );
end BlowfishOnBoard;

architecture Behavioral of BlowfishOnBoard is
    component register_pp 
        generic (
            n: integer := 8
        );
        Port ( 
               CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               write : in STD_LOGIC;
               x : in STD_LOGIC_VECTOR ( n-1 downto 0);
               y : out STD_LOGIC_VECTOR ( n-1 downto 0));
    end component;
    component counter_n 
	generic(
		n : integer :=4;
		m : integer := 2
	);
    Port ( CLK : in  STD_LOGIC;
		   RST : in STD_LOGIC;
		   enable : in std_logic;
		   y: out std_logic_vector( m-1 downto 0);
		   end_cont : out std_logic
        );
    end component;
    component Rs232RefComp 
        Port ( 
            TXD 	: out std_logic  	:= '1';
            RXD 	: in  std_logic;					
            CLK 	: in  std_logic;								--Master Clock
            DBIN 	: in  std_logic_vector (7 downto 0);	--Data Bus in
            DBOUT : out std_logic_vector (7 downto 0);	--Data Bus out
            RDA	: inout std_logic;						--Read Data Available(� alto quando il dato � disponibile nel registro rdReg)
            TBE	: inout std_logic 	:= '1';			--Transfer Bus Empty(se � 0 significa che il bus � occupato per una trasmissione)
            RD		: in  std_logic;					--Read Strobe(se � 0 significa "leggi")
            WR		: in  std_logic;					--Write Strobe(se � 1 significa "scrivi")
            PE		: out std_logic;					--Parity Error Flag
            FE		: out std_logic;					--Frame Error Flag
            OE		: out std_logic;					--Overwrite Error Flag
            RST		: in  std_logic	:= '0');	--Master Reset
    end component;
    
    component FFD 
	   port( clock, clock_div, reset, d: in std_logic;
          y: out std_logic :='0');
    end component;
    
    component Reg_sp 
    port(
        CLK, RST : in std_logic;
        enable : in std_logic;
        input : in std_logic_vector(7 downto 0);
        Y : out std_logic_vector(63 downto 0)
        );
    end component;
    
    component Blowfish 
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           start: in STD_LOGIC;
           data_key: in std_logic_vector(31 downto 0);
           data_msg: in std_logic_vector(63 downto 0);
           encrypted_msg : out STD_LOGIC_VECTOR (63 downto 0);
           fine: out STD_LOGIC
           );
    end component;
    
    component Selezionatore_2_1 is
    generic (
        n : integer := 8
    );
    Port ( 
        data_in1 : in STD_LOGIC_VECTOR (n-1 downto 0);
        data_in2 : in STD_LOGIC_VECTOR (n-1 downto 0);
        sel      : in STD_LOGIC;
        data_out : out STD_LOGIC_VECTOR (n-1 downto 0)
    );
    end component;
    
    component display_seven_segments is
	Generic( 
				clock_frequency_in : integer := 10000000; 
				clock_frequency_out : integer := 500
				);
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           value32_in : in  STD_LOGIC_VECTOR (31 downto 0);
           enable : in  STD_LOGIC_VECTOR (7 downto 0);
           dots : in  STD_LOGIC_VECTOR (7 downto 0);
           anodes : out  STD_LOGIC_VECTOR (7 downto 0);
           cathodes : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;
    


signal temp_key : std_logic_vector(31 downto 0):=(others =>'0');
signal temp_RDA : std_logic;
signal temp_start : std_logic;
signal temp_fittizio : std_logic_vector(2 downto 0):=(others =>'0');
signal temp_txd : std_logic;
signal temp_val: std_logic_vector(7 downto 0):=(others =>'0');
signal temp_tbe : std_logic;
signal temp_FFout: std_logic;
signal temp_PE: std_logic;
signal temp_FE: std_logic;
signal temp_OE: std_logic;
signal temp_EnterBlow: std_logic_vector (63 downto 0) := (others=>'0');
signal temp_EncryptMSG: std_logic_vector (63 downto 0) := (others=>'0');
signal temp_fine: std_logic;
signal temp_sel: std_logic;
signal temp_selOut: std_logic_vector (31 downto 0):= (others =>'0');
signal tmp_enCont : std_logic := '0';

begin
    key: register_pp
        generic map(
            32
        )
        port map(
            CLK,
            RST,
            '1',
            X"61616262",
            temp_key
        );
          
     tmp_enCont <= temp_RDA when temp_start = '0' else '1';
                
     contatore: counter_n
        generic map(
            8,
            3
        )
        port map(
            CLK,
            RST,
            tmp_enCont ,
            temp_fittizio,
            temp_start
        );  
     
     interfaccia: Rs232RefComp
        port map(
            temp_txd,
            bit_in,
            CLK,
            (others =>'0'),
            temp_val,
            temp_RDA,
            temp_tbe,
            temp_FFout,
            '0',
            temp_PE,
            temp_FE,
            temp_OE,
            RST
        );
        
      flipflop: FFD
        port map(
            CLK,
            '1',
            RST,
            temp_RDA,
            temp_FFout
        );
      
      regSP: Reg_sp
        port map(
            CLK,
            RST,
            temp_RDA,
            temp_val,
            temp_EnterBlow
        );
     
     
     blow: Blowfish
        port map(
            CLK,
            RST,
            temp_start,
            temp_key,
            temp_EnterBlow,
            temp_EncryptMSG,
            temp_fine
        );
    fine <= temp_fine;
    
    sel: Selezionatore_2_1
        generic map(
            32
        )
        port map(
            temp_EncryptMSG(31 downto 0),
            temp_EncryptMSG(63 downto 32),
            swap,
            temp_selOut
        );
    
    display: display_seven_segments
        generic map(
            5000000,
            500
        )
        port map(
            CLK,
            RST,
            temp_selOut,
            "11111111",
            "00000000",
            anodes,
            cathodes
        );
        

    
end Behavioral;
