library ieee;
use ieee.std_logic_1164.all;

entity mux8_tb is
end mux8_tb;

architecture behav of mux8_tb is
component mux8
port (	In0, In1, In2, In3: in std_logic_vector(7 downto 0);
Sel: in std_logic_vector(1 downto 0);
Z: out std_logic_vector(7 downto 0)
);
end component;
signal z, in0, in1, in2, in3 : std_logic_vector(7 downto 0);
signal sel : std_logic_vector(1 downto 0);
begin
--  Component instantiation.
mux8_0: mux8 port map (In0 => in0, In1 => in1, In2 => in2, In3 => in3, Sel => sel, Z => z);

--  This process does the real job.
process
type pattern_type is record
--these below are what is in our for loop
in0, in1, in2, in3: std_logic_vector (7 downto 0);
sel: std_logic_vector(1 downto 0);
z: std_logic_vector (7 downto 0);
end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("00000000", "00000001", "00000010", "00000011", "00", "00000000"),
("00000000", "00000001", "00000010", "00000011", "01", "00000001"),
("00000000", "00000001", "00000010", "00000011", "10", "00000010"),
("00000000", "00000001", "00000010", "00000011", "11", "00000011"));
begin
--  Check each pattern.
for n in patterns'range loop
--  Set the inputs.
in0 <= patterns(n).in0;
in1 <= patterns(n).in1;
in2 <= patterns(n).in2;
in3 <= patterns(n).in3;
sel <= patterns(n).sel;
wait for 1 ns;
assert z = patterns(n).z
report "bad output value" severity error;
end loop;
assert false report "end of test" severity note;
wait;
end process;
end behav;
