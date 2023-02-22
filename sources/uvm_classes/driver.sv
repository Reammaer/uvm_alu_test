

class Driver extends uvm_driver#(PairTransaction);
    `uvm_component_utils(Driver)

    // Interface handle
    virtual dut_if vif;
    virtual dpi_c_if v_c_if;
    virtual uvm_put_if  v_put_if;
    // Uvm_get_port handle
    uvm_get_port #(PairTransaction) command_port;

    function new(string name, uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        // Check interface connection
        if (!uvm_config_db#(virtual dut_if)::get(this, "", "dut_if", vif)) begin
            `uvm_fatal("Driver", "Could not get interface connection")
        end
        if (!uvm_config_db#(virtual dpi_c_if)::get(this, "", "dpi_c_if", v_c_if)) begin
            `uvm_fatal("Driver", "Could not get dpi-c interface connection")
        end
        if (!uvm_config_db#(virtual uvm_put_if)::get(this, "", "uvm_put_if", v_put_if)) begin
            `uvm_fatal("Test", "DPI-C interface is not connected")
        end
        command_port = new("command_port", this);
    endfunction: build_phase    

    task run_phase(uvm_phase phase);  

        PairTransaction transaction_h;
        logic [8:0] test;       

        forever begin    
            fork     
                begin       
                @(posedge vif.clk)                
                    `uvm_info("Driver", "Get a new data from sequencer", UVM_HIGH);
                    // Get a new transaction                         
                    seq_item_port.get_next_item(transaction_h);
                    vif.idata_A <= transaction_h.transaction_dut_h.idata_A;
                    vif.idata_B <= transaction_h.transaction_dut_h.idata_B;
                    vif.sel_op  <= transaction_h.transaction_dut_h.sel_op;
                    // Put a new transaction into a DPI
                    v_c_if.idata_A <= vif.odata;
                    v_c_if.idata_C <= transaction_h.transaction_dpi_h.idata_C;
                    tinyALUtest(v_c_if.idata_A, v_c_if.idata_C, vif.sel_op, v_c_if.odata_C);
                    // Waiting for the new data
                    seq_item_port.item_done();
                end
                begin
                @(posedge v_put_if.clk)
                    command_port.get(transaction_h);    
                    v_put_if.blkPortVar <= transaction_h.blkPortVar; 
                end
            join_any
        end
    endtask: run_phase

endclass: Driver