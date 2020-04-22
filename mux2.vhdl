library ieee;
use ieee.std_logic_1164.all;

entity mux2 is
port(	
    In0, In1: in std_logic;
    Sel: in std_logic_vector(1 downto 0);
    Z: out std_logic
);
end mux2;

architecture behavMSB of mux2 is
begin
    Z <= '0' when Sel = "00" else --In0 = I(3) and In1 = I_SHIFT_In
    In0 when Sel = "01" else --left 
    In1 when Sel = "10" else --right
    '0' when Sel = "11" else
    '0';
end behavMSB;

architecture behavLSB of mux2 is
begin
    Z <= '0' when Sel = "00" else --In0 = I(4) and In1 = I_SHIFT_In
    In1 when Sel = "01" else --left 
    In0 when Sel = "10" else --right
    '0' when Sel = "11" else
    '0';
end behavLSB;
