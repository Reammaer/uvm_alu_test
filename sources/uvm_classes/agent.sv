

class Agent extends uvm_agent;
    `uvm_component_utils(Agent)

    // Agent configuration handle
    Agent_config agent_config_h;
    // Driver handle
    Driver driver_h;    
    // Scoreboard handle
    Scoreboard scoreboard_h; 
    // Dpi_Scoreboard handle
    DpiScoreboard dpiscoreboard_h;
    // Monitor handle
    Monitor monitor_h;      
    // Coverage handle
    Coverage coverage_h;  
    // uvm_sequencer handle
    sequencer uvm_sequencer_h;    
    // Tester handle
    Tester tester_h;
    Tester_2 tester_2_h;
    // Fifo handle
    uvm_tlm_fifo #(PairTransaction) command_f;


    function new(string name = "Agent", uvm_component parent);
        super.new(name, parent);
    endfunction: new


    function void build_phase(uvm_phase phase);
        // Initialize agent configuration
        if (!uvm_config_db#(Agent_config)::get(this, "", "config", agent_config_h)) begin
            `uvm_fatal("Agent", "Failed to get agent configuration object")
        end
        is_active = agent_config_h.get_is_active();        
        // Create a new driver
        driver_h = Driver::type_id::create("driver_h", this);           
        // Create a new scoreboard
        scoreboard_h = Scoreboard::type_id::create("scoreboard_h", this); 
        // Create a new dpi scoreboard 
        dpiscoreboard_h = DpiScoreboard::type_id::create("dpiscoreboard_h", this);   
        // Create a new monitor
        monitor_h = Monitor::type_id::create("monitor_h", this);         
        // Create a new coverage
        coverage_h = Coverage::type_id::create("coverage_h", this);  
        // Create a new uvm_sequencer
        uvm_sequencer_h = sequencer::type_id::create("uvm_sequencer", this);
        // Create a new fifo
        command_f = new("command_f", this);
        if (get_is_active() == UVM_ACTIVE) begin: tester
            // Create a new tester
            tester_h = Tester::type_id::create("tester_h", this);
        end: tester
        else begin: tester_2
            // Create a new tester_2
            tester_2_h = Tester_2::type_id::create("tester_2_h", this);
        end: tester_2
    endfunction: build_phase


    function void end_of_elaboration_phase(uvm_phase phase);
    // Driver verbosity level
    //    driver_h.set_report_verbosity_level_hier(UVM_HIGH);
    // Scoreboard verbosity level
    //    scoreboard_h.set_report_verbosity_level_hier(UVM_HIGH);
    // Dpi Scoreboard verbosity level
    //    dpiscoreboard_h.set_report_verbosity_level_hier(UVM_HIGH);
    // Coverrage verbosity level
        coverage_h.set_report_verbosity_level_hier(UVM_HIGH);
    endfunction: end_of_elaboration_phase


    function void connect_phase(uvm_phase phase);
        // Connect driver with sequencer
        driver_h.seq_item_port.connect(uvm_sequencer_h.seq_item_export);
        // Connect monitor with scoreboard
        monitor_h.analysis_port_h.connect(scoreboard_h.m_analysis_imp);
        monitor_h.analysis_port_dpi_h.connect(dpiscoreboard_h.m_analysis_imp_dpi);
        // Connect monitor and coverage
        monitor_h.analysis_port_h.connect(coverage_h.m_analysis_imp_coverage);
        // Connects driver with tester via tlm fifo
        driver_h.command_port.connect(command_f.get_export);
        if (get_is_active()  == UVM_ACTIVE) begin
            tester_h.command_port.connect(command_f.put_export);
        end
        else begin
            tester_2_h.command_port.connect(command_f.put_export);
        end
    endfunction: connect_phase

endclass: Agent