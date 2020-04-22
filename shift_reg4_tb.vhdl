---------------------------------------------------
-- Shift Register test bench 
--by Alex Bushinsky and Ryan Peterson
-- Lab 3 part 2- CPEG324
-- Behavioral Model test bench for the Shift Register
----------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity shift_reg4_tb is
end shift_reg4_tb;

architecture behav of shift_reg4_tb is
--  Declaration of the component that will be instantiated.
component shift_reg4
port (		I:		in std_logic_vector (3 downto 0);
		I_SHIFT_IN:	in std_logic;
		sel:		in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; 
		enable:		in std_logic;
		O:		out std_logic_vector(3 downto 0);
		SHIFT_OUT:	out std_logic
);
end component;
--  Specifies which entity is bound with the component.
-- for shift_reg_0: shift_reg use entity work.shift_reg(rtl);
signal i, o : std_logic_vector(3 downto 0);
signal i_shift_in, clk, enable, shift_out : std_logic;
signal sel : std_logic_vector(1 downto 0);
begin
--  Component instantiation.
shift_reg4_0: shift_reg4 port map (I => i, I_SHIFT_IN => i_shift_in, sel => sel, clock => clk, enable => enable, O => o, SHIFT_OUT => shift_out);

--  This process does the real job.
process
type pattern_type is record
--  The inputs of the shift_reg.
i: std_logic_vector (3 downto 0);
i_shift_in, clock, enable: std_logic;
sel: std_logic_vector(1 downto 0);
--  The expected outputs of the shift_reg.
o: std_logic_vector (3 downto 0);
shift_out: std_logic;
end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array := --WRONG test vectors. replace with your own.
----I---I_S_I--CLK--EN---SEL------O----
(("0000", '0', '0', '0', "00", "0000", '0'),
("0000", '0', '1', '1', "00", "0000", '0'),
("0000", '1', '0', '1', "00", "0000", '0'),
("0000", '1', '1', '1', "00", "0000", '0'),
-----------------------------------------
("0010", '0', '0', '1', "01", "0000", '0'),
("1010", '0', '1', '1', "01", "0000", '0'),
("0111", '1', '0', '1', "01", "0000", '0'),
("1001", '1', '1', '1', "01", "0001", '0'),
("1011", '1', '0', '1', "01", "0001", '0'),
("0010", '1', '1', '1', "01", "0011", '0'),
("0000", '1', '0', '1', "01", "0011", '0'),
("1111", '0', '1', '1', "01", "0110", '0'),
("1101", '1', '0', '1', "01", "0110", '0'),
("0001", '1', '1', '1', "01", "1101", '0'),
("0111", '1', '0', '1', "01", "1101", '0'),
("1000", '0', '1', '1', "01", "1010", '1'),
-----------------------------------------
("1101", '0', '0', '1', "10", "1010", '0'),
("0101", '0', '1', '1', "10", "0101", '0'),
("0001", '1', '0', '0', "10", "0101", '0'),
("0110", '1', '1', '1', "10", "1010", '1'),
("0001", '1', '0', '0', "10", "1010", '0'),
("0110", '1', '1', '1', "10", "1101", '0'),
("0001", '0', '0', '0', "10", "1101", '0'),
("0110", '1', '1', '1', "10", "1110", '1'),
---------------------------------------
("1101", '1', '0', '1', "11", "1110", '0'),
("0101", '1', '1', '1', "11", "0101", '0'),
("1101", '0', '0', '1', "11", "0101", '0'),
("1111", '1', '1', '1', "11", "1111", '0'),
("0000", '0', '0', '0', "11", "1111", '0')); -- Need two vectors to simulate an edge.
begin
--  Check each pattern.
for n in patterns'range loop
--  Set the inputs.
i <= patterns(n).i;
i_shift_in <= patterns(n).i_shift_in;
sel <= patterns(n).sel;
clk <= patterns(n).clock;
enable <= patterns(n).enable;
--  Wait for the results.
wait for 1 ns;
--  Check the outputs.
assert o = patterns(n).o
report "bad output value" severity error;
assert shift_out = patterns(n).shift_out
report "bad shift out value" severity error;
end loop;
assert false report "end of test" severity note;
--  Wait forever; this will finish the simulation.
wait;
end process;
end behav;
