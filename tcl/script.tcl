
quit -sim

cd ../modelsim

vlib work

vlog -work work ../sources/interface.sv
vlog -work work ../sources/dut_test.sv
vlog -work work ../tb/tb.sv

# Linking C files with SV testbench and creating dpiheader
vlog -sv -dpiheader ../sources/c/dpiheader.h ../tb/tb.sv ../sources/c/tinyALUtest.c

vsim -sv_seed random -novopt -t 1ns -coverage work.tb

add wave -divider "Top-level signals"
add wave -radix unsigned tb/*

add wave -divider "DUT signals"
add wave -radix unsigned tb/_if/*

add wave -divider "DPI-C signals"
add wave -radix unsigned tb/_c_if/*

add wave -divider "Put port signals"
add wave -radix unsigned tb/_put_if/*

run 10 ms