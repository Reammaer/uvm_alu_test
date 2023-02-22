
// Environment for Test_Active
class Environment extends uvm_env;
    `uvm_component_utils(Environment)

    // Agent handle
    Agent agent_h; 
    // Agent configuration handle
    Agent_config agent_config_h;

    function new(string name = "Environment", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        // Create a new agent
        agent_h = Agent::type_id::create("agent_h", this);  
        // Create a new configuration for the agent
        agent_config_h = new(.is_active(UVM_ACTIVE));
        // Set a new configuration for the agent
        uvm_config_db#(Agent_config)::set(this, "agent_h*", "config", 
                                                            agent_config_h);
    endfunction: build_phase

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);        
    endfunction: connect_phase

endclass: Environment


// Environment for Test_Passive
class Environment_Passive extends Environment;
    `uvm_component_utils(Environment_Passive)

    function new(string name = "Environment_Passive", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);  
        // Create a new configuration for the agent
        agent_config_h = new(.is_active(UVM_PASSIVE));
        // Set a new configuration for the agent
        uvm_config_db#(Agent_config)::set(this, "agent_h*", "config", 
                                                            agent_config_h);
    endfunction: build_phase

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);        
    endfunction: connect_phase

endclass: Environment_Passive