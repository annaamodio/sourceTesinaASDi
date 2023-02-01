library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ******************************************************************************* --
-- Definizione di un componente MUX 2:1 attraverso 
-- l'utilizzo di vari costrutti al livello di astrazione dataflow/behavioral
-- ******************************************************************************* --


-- Definizione dell'interfaccia del modulo mux_2_1.
entity Mux_2_1 is
	port( 	
        bit_in 	: in std_logic_vector(1 downto 0);
        sel 	: in STD_LOGIC;
        bit_out 	: out std_logic 
	);	
end mux_2_1;

-- Utilizzo di statement di assegnazione concorrente.
architecture dataflow of Mux_2_1 is

	begin
		bit_out <= ((bit_in(0) and (NOT sel)) OR (bit_in(1) and sel));

end dataflow;