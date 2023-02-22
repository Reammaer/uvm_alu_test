

// DUT interface
interface dut_if (input clk);
    logic [3:0] idata_A = 0;
    logic [3:0] idata_B = 0;
    logic [1:0] sel_op = 0;
    logic [4:0] odata = 0;
endinterface: dut_if


// DPI-C intrface
interface dpi_c_if();
    logic [4:0] idata_A = 0;
    logic [4:0] idata_C = 0;
    logic [8:0] odata_C = 0;
endinterface: dpi_c_if 

// UVM Port Test interface
interface uvm_put_if(input clk);
    logic [5:0] blkPortVar;
endinterface: uvm_put_if