library ieee;
use ieee.std_logic_1164.all;

entity mux8 is
port(	
    In0, In1, In2, In3: in std_logic_vector(7 downto 0);
    Sel: in std_logic_vector(1 downto 0);
    Z: out std_logic_vector(7 downto 0)
);
end mux8;

architecture behav of mux8 is
begin
Z <= In0 when Sel = "00" else
In1 when Sel = "01" else
In2 when Sel = "10" else
In3 when Sel = "11" else
"00000000";
end behav;