

class Tester_2 extends uvm_component;
    `uvm_component_utils(Tester_2)

    // uvm_put_port_handle
    uvm_put_port #(PairTransaction) command_port;
    // Interface handle
    virtual uvm_put_if v_put_if;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        command_port = new ("command_port", this);
        // Check interface connection
        if (!uvm_config_db#(virtual uvm_put_if)::get(this, "", "uvm_put_if", v_put_if)) begin
            `uvm_fatal("Test", "DPI-C interface is not connected")
        end
    endfunction: build_phase

    task run_phase(uvm_phase phase);    
        int seed;   
        PairTransaction transaction_put_h;
        transaction_put_h = new("transaction_put_h");
        forever begin
            @(posedge v_put_if.clk)
                seed = $random;
                transaction_put_h.blkPortVar = $urandom(seed);
                command_port.put(transaction_put_h); 
        end        
    endtask: run_phase

endclass: Tester_2