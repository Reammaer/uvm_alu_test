
class Monitor extends uvm_monitor;
    `uvm_component_utils(Monitor)

    // Interface handle
    virtual dut_if vif;
    virtual dpi_c_if v_c_if;
    // Analysis port handle
    uvm_analysis_port #(Transaction) analysis_port_h;
    uvm_analysis_port #(DpiTransaction) analysis_port_dpi_h;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        // Check interface connection
        if (!uvm_config_db#(virtual dut_if)::get(this, "", "dut_if", vif)) begin
            `uvm_fatal("Monitor", "Could not get interface connection")
        end
        if (!uvm_config_db#(virtual dpi_c_if)::get(this, "", "dpi_c_if", v_c_if)) begin
            `uvm_fatal("Monitor", "Could not get DPI-C interface connection")
        end
        // Initialize new analysis port
        analysis_port_h = new("analysis_port_h", this);
        // Initialize dpi analysis port
        analysis_port_dpi_h = new("analisys_port_dpi_h", this);
    endfunction: build_phase
    
    task run_phase(uvm_phase phase);
        Transaction item_h = Transaction::type_id::create("item_h");    
        DpiTransaction item_dpi_h = DpiTransaction::type_id::create("item_dpi_h");  
        forever begin
            @(posedge vif.clk);   
                // Item from DUT             
                item_h.idata_A  = vif.idata_A;
                item_h.idata_B  = vif.idata_B;   
                item_h.sel_op   = vif.sel_op;  
                // Item from DPI-
                item_dpi_h.idata_A = v_c_if.idata_A ;
                item_dpi_h.idata_C = v_c_if.idata_C ;
                item_dpi_h.sel_op = vif.sel_op;
            @(negedge vif.clk);
                item_h.odata = vif.odata;                
                item_dpi_h.odata_C = v_c_if.odata_C;
                analysis_port_h.write(item_h);
                analysis_port_dpi_h.write(item_dpi_h);                
        end
    endtask: run_phase

endclass: Monitor