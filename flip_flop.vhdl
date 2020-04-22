----------------------------------------
-- D Flip-Flop
--by Alex Bushinsky and Ryan Peterson
-- Lab 3 part 2- CPEG324
-- Rising edge flip-flop used in Shift register
----------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity flip_flop is
port(	D:	in std_logic;
	clk:	in std_logic;
	Q:	in std_logic;
);
end flip_flop;

architecture behav of flip_flop is
begin
	process(D, clk)
	begin
		if(clk='1' and clock'event) then
			Q <= D;
		end if;
	end process;
end behav;
