

class Base_test extends uvm_test;
    `uvm_component_utils(Base_test)

    // Interface handle
    virtual dut_if vif;
    virtual dpi_c_if v_c_if;
    virtual uvm_put_if  v_put_if;
    // RunAllSequencer handle
    RunAllSequence runallsequence_h;


    function new(string name, uvm_component parent = null);
        super.new(name, parent);
    endfunction: new


    function void build_phase(uvm_phase phase);        
        // Check interface connection
        if (!uvm_config_db#(virtual dut_if)::get(this, "", "dut_if", vif)) begin
            `uvm_fatal("Test", "DUT interface is not connected")
        end
        if (!uvm_config_db#(virtual dpi_c_if)::get(this, "", "dpi_c_if", v_c_if)) begin
            `uvm_fatal("Test", "DPI-C interface is not connected")
        end
        if (!uvm_config_db#(virtual uvm_put_if)::get(this, "", "uvm_put_if", v_put_if)) begin
            `uvm_fatal("Test", "DPI-C interface is not connected")
        end
        // Connect interface with other uvm_objects
        uvm_config_db#(virtual dut_if)::set(this, "*", "dut_if", vif);
        uvm_config_db#(virtual dpi_c_if)::set(this, "*", "dpi_c_if", v_c_if);
        uvm_config_db#(virtual uvm_put_if)::set(this, "*", "uvm_put_if", v_put_if);  
        // Create a new sequence
        runallsequence_h = RunAllSequence::type_id::create("runallsequence_h");
    endfunction: build_phase   


endclass: Base_test;