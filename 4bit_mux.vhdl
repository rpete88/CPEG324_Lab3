----------------------------------------
-- 4x1 MUX- 4 bit 
--by Alex Bushinsky and Ryan Peterson
-- Lab 3 part 2- CPEG324
-- MUX used in Shift register
----------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity 4bit_mux is 
port(	sel:			in std_logic_vector (1 downto 0);
	In0, In1, In2, In3:	in std_logic_vector (3 downto 0);
	Z:			in std_logic_vector (3 downto 0)
);

architecture behav of 4bit_mux is
begin
	Z <=	In0 when sel="00" else
	     	In1 when sel="01" else
		In2 when sel="10" else
		In3 when sel="11" else
		"ZZZZ";
end behav;
