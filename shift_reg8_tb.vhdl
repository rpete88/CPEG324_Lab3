library ieee;
use ieee.std_logic_1164.all;

entity shift_reg8_tb is
end shift_reg8_tb;

architecture behav of shift_reg8_tb is
component shift_reg8
port (		I:		in std_logic_vector (7 downto 0);
		I_SHIFT_IN:	in std_logic;
		SEL:		in std_logic_vector(1 downto 0);
		CLOCK:		in std_logic; 
		ENABLE:		in std_logic;
		O:		out std_logic_vector(7 downto 0)
);
end component;
signal i, o : std_logic_vector(7 downto 0);
signal i_shift_in, clk, enable : std_logic;
signal sel : std_logic_vector(1 downto 0);
begin
--  Component instantiation.
shift_reg8_0: shift_reg8 port map (I => i, I_SHIFT_IN => i_shift_in, SEL => sel, CLOCK => clk, ENABLE => enable, O => o);

process
type pattern_type is record
--  The inputs of the shift_reg.
i: std_logic_vector (7 downto 0);
i_shift_in, clock, enable: std_logic;
sel: std_logic_vector(1 downto 0);
--  The expected outputs of the shift_reg.
o: std_logic_vector (7 downto 0);
end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
-- 00:hold; 01: shift left; 10: shift right; 11: load
----I--------I_S_I--CLK--EN---SEL------O------
----------------Hold----------------------------
(("00000000", '0', '0', '0', "00", "00000000"),
("00000000", '0', '0', '0', "00", "00000000"),
("00000000", '0', '0', '0', "00", "00000000"),
("00000000", '1', '0', '0', "00", "00000000"),
("00000000", '0', '1', '0', "00", "00000000"),
("00000000", '0', '0', '1', "00", "00000000"),
("00000000", '1', '1', '0', "00", "00000000"),
("00000000", '0', '1', '1', "00", "00000000"),
("00000000", '1', '0', '1', "00", "00000000"),
("00000000", '1', '1', '1', "00", "00000000"),
("00010001", '1', '1', '1', "00", "00000000"),
----------------Load------------------------------
("00000001", '0', '0', '0', "11", "00000000"),
("00000001", '0', '0', '0', "11", "00000000"),
("00000001", '1', '0', '0', "11", "00000000"),
("00000001", '0', '1', '0', "11", "00000000"),
("00000001", '0', '0', '1', "11", "00000000"),
("10000011", '1', '1', '1', "11", "10000011"),
("10000011", '1', '0', '1', "11", "10000011"),
("10010001", '1', '1', '1', "11", "10010001"),
("00000001", '1', '0', '1', "11", "10010001"),
-------------------Shift left-----------------------
("00000000", '0', '0', '1', "01", "10010001"),
("00000000", '0', '1', '1', "01", "00100010"),
("00000000", '1', '0', '1', "01", "00100010"),
("00000000", '1', '1', '1', "01", "01000101"),
("00000000", '1', '0', '1', "01", "01000101"),
("00000000", '1', '1', '1', "01", "10001011"),
("00000000", '0', '0', '1', "01", "10001011"), 
-- ---------------------Shift Right-----------------------
("00000000", '1', '0', '0', "10", "10001011"),
("00000000", '1', '1', '1', "10", "11000101"),
("00000000", '0', '0', '1', "10", "11000101"),
("00000000", '0', '1', '1', "10", "01100010"),
("00000000", '0', '0', '1', "10", "01100010"),
("00000000", '0', '1', '1', "10", "00110001"),
("00000000", '0', '0', '1', "10", "00110001")
);
begin
for n in patterns'range loop
--  Set the inputs.
i <= patterns(n).i;
i_shift_in <= patterns(n).i_shift_in;
sel <= patterns(n).sel;
clk <= patterns(n).clock;
enable <= patterns(n).enable;
wait for 1 ns;
assert o = patterns(n).o
report "bad output value" severity error;
end loop;
assert false report "end of test" severity note;
wait;
end process;
end behav;
