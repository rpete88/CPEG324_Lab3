library ieee;
use ieee.std_logic_1164.all;

entity shift_reg8 is
port(		I:		in std_logic_vector(7 downto 0); -- for loading
		I_SHIFT_IN:	in std_logic; -- shifted in bit for both left and right
		SEL:		in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		CLOCK:		in std_logic; -- positive level triggering in problem 3
		ENABLE:		in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
        O:		out std_logic_vector(7 downto 0) -- output the current register content. HINT: should be combinational.
);
end shift_reg8;

architecture arch of shift_reg8 is
--entity and architecture for shift_reg in shift_reg.vhdl and mux2 in mux2.vhdl
component shift_reg4 is
    port(
            i: in std_logic_vector(3 downto 0); 
            i_shift_in:	in std_logic; 
            sel: in std_logic_vector(1 downto 0); 
            clock: in std_logic;
            enable: in std_logic;
            o: out std_logic_vector(3 downto 0);
            SHIFT_OUT : out std_logic
    );
end component;

component mux2 is
    port(
        In0: in std_logic;
        In1: in std_logic;
        Sel: in std_logic_vector(1 downto 0);
        Z: out std_logic
    );
end component;

--internal signals used when we need an output from one component for an input to another component
signal mux_to_MSB: std_logic;
signal mux_to_LSB: std_logic;
signal MSB_SHIFT_OUT: std_logic;
signal LSB_SHIFT_OUT: std_logic;

begin
    --MSB_SHIFT_OUT is mapped to In0,  I_SHIFT_IN is mapped to In1, etc...
    --one entity, two architectures, use behavMSB as defined in mux2
    mux2_MSB: entity work.mux2(behavMSB) port map(LSB_SHIFT_OUT, I_SHIFT_IN, SEL, mux_to_MSB);
    --one entity, two architectures, use behavMSB as defined in mux2
    mux2_LSB: entity work.mux2(behavLSB) port map(MSB_SHIFT_OUT, I_SHIFT_IN, SEL, mux_to_LSB);
    shift_reg4_MSBs: shift_reg4 port map(I(7 downto 4), mux_to_MSB, SEL, CLOCK, ENABLE, O(7 downto 4), MSB_SHIFT_OUT);
    shift_reg4_LSBs: shift_reg4 port map(I(3 downto 0), mux_to_LSB, SEL, CLOCK, ENABLE, O(3 downto 0), LSB_SHIFT_OUT);
end arch;
