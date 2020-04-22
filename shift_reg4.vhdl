----------------------------------------
-- Shift Register 
--by Alex Bushinsky and Ryan Peterson
-- Lab 3 part 2- CPEG324
-- Behavioral Model for the Shift Register
----------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity shift_reg4 is
port(		I:		in std_logic_vector(3 downto 0); -- for loading
		I_SHIFT_IN:	in std_logic; -- shifted in bit for both left and right
		sel:		in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; -- positive level triggering in problem 3
		enable:		in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
		O:		out std_logic_vector(3 downto 0); -- output the current register content. HINT: should be combinational.
		SHIFT_OUT : out std_logic --shifted out bit for both left and right
);
end shift_reg4;

architecture behav of shift_reg4 is
	signal temp:	std_logic_vector(3 downto 0):="0000";
begin
	process(clock)
	begin
		if( enable = '1') then
			if( clock'event and clock = '1') then
				case sel is
					when "00"=>
						--HOLD
						SHIFT_OUT <= '0'; --SHIFT_OUT not used, value doesn't matter
					when "01" =>
						--SHIFT LEFT
						SHIFT_OUT <= temp(3);
						temp(3 downto 1) <= temp(2 downto 0);
						temp(0) <= I_SHIFT_IN;
					when "10" =>
						--SHIFT RIGHT
						SHIFT_OUT <= temp(0);
						temp(2 downto 0) <= temp(3 downto 1);
						temp(3) <= I_SHIFT_IN;
					when "11" =>
						--LOAD
						temp <= I;
						SHIFT_OUT <= '0'; --SHIFT_OUT not used, value doesn't matter
					when others =>
						temp <= "ZZZZ";
				end case;
			else
				SHIFT_OUT <= '0'; --SHIFT_OUT not used, value doesn't matter
			end if;
		else
			SHIFT_OUT <= '0'; --SHIFT_OUT not used, value doesn't matter
		end if;
	end process;
	O <= temp;
end behav;

