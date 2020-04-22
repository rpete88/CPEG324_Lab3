# CPEG324_Lab3
8-bit shift register code in VHDL. Components include the 8-bit shift register(structural code), 4-bit shift register (behavioral code), and MUXs (behavioral code).

Commands to run 8-bit Shift Register test bench code 

Waveform can be viewed using the vcd file produced

-- compile files

ghdl -a shift_reg4.vhdl

ghdl -a mux2.vhdl

ghdl -a shift_reg8.vhdl

ghdl -a shift_reg8_tb.vhdl

-- generate executeable for test bench

ghdl -e shift_reg_tb

-- run the test bench

ghdl -r shift_reg_tb --vcd=shift_reg8.vcd

