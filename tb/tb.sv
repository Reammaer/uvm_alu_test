
// ******************************************************** //
// **************** Tiny ALU testbench ******************** //
// Current ALU (dut_test) receives random sequences generated via UVM 
// then sends them into tinyALUtest.c via DPI-C interface.
// Output data from dut_test.sv and tinyALUtest.c is also received
// by Monitor and analysed by Scoreboard
// Tester and Teste_2 are used to practise using uvm_put_port and
// uvm_get_port
// Test_pool is uesd to practise using uvm_pool method
// ******************************************************** //

// Initialize UVM package
import uvm_pkg::*;
`include "uvm_macros.svh"
// Initialize User-file links package
`include "../sources/uvm_class_pkg.svh"
import uvm_class_pkg::*;

`define CLK_PERIOD 10
module tb;

    // Initialize timeunits
    timeunit 1ns;
    timeprecision 1ns;

    // Initialize global clock
    bit clk;
    always #(`CLK_PERIOD) clk = ~clk;

    // Initialize interface
    dut_if      _if (clk);
    dpi_c_if    _c_if(); 
    uvm_put_if  _put_if(clk);

    // Initialize DUT
    dut_test
    DUT
    (
        .iclk       (_if.clk)
    ,   .idata_A    (_if.idata_A)
    ,   .idata_B    (_if.idata_B)
    ,   .sel_op     (_if.sel_op)
    ,   .odata      (_if.odata)
    );

    // Run stimulus
    initial begin
        // Configure database
        uvm_config_db #(virtual dut_if)::set(null, "uvm_test_top", "dut_if", _if);
        uvm_config_db #(virtual dpi_c_if)::set(null, "uvm_test_top", "dpi_c_if", _c_if);
        uvm_config_db#(virtual uvm_put_if)::set(null, "uvm_test_top", "uvm_put_if", _put_if);
        // Run corresponding test
        run_test("Test_Active");     // Test with tester
        // run_test("Test_Passive");    // Test with tester_2
        // run_test("Test_pool");       // Test with a random pool
    end

endmodule: tb