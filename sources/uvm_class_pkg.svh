

package uvm_class_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    // Export functions into C program
    import "DPI-C" context task tinyALUtest (input logic [4:0] idata_A, input logic [4:0] idata_C,
                                    input logic [1:0] sel_op, output logic [8:0] odata_C);

    // Sel_op variations
    typedef enum logic [1:0] {
        TRIG_A  = 2'd0,
        SUM     = 2'd1,
        DIFF    = 2'd2,
        TRIG_B  = 2'd3
    } sel_op_t;

    typedef enum logic [1:0] {
        MULT    = 2'd2
    } sel_op_dpi;

    `include "uvm_classes/transaction.sv"
    // typedef uvm_sequencer #(Transaction) sequencer;
    typedef uvm_sequencer #(PairTransaction) sequencer;

    `include "uvm_classes/sequencers/trigA_sequence.sv" 
    `include "uvm_classes/sequencers/sum_sequencer.sv"
    `include "uvm_classes/sequencers/dif_sequencer.sv"
    `include "uvm_classes/sequencers/trigB_sequence.sv"  
    `include "uvm_classes/sequencers/runall_sequence.sv" 
    `include "uvm_classes/coverage.sv"
    `include "uvm_classes/tester.sv"
    `include "uvm_classes/tester_2.sv"
    `include "uvm_classes/driver.sv"   
    `include "uvm_classes/scoreboard.sv" 
    `include "uvm_classes/scoreboard_dpi.sv" 
    `include "uvm_classes/monitor.sv"
    `include "uvm_classes/agent_config.sv"
    `include "uvm_classes/agent.sv"
    `include "uvm_classes/environment.sv"   
    `include "uvm_classes/base_test.sv" 
    `include "uvm_classes/test.sv"
    `include "uvm_classes/test_pool.sv"

endpackage: uvm_class_pkg