
class Test_Active extends Base_test;
    `uvm_component_utils(Test_Active)

    // Environment handle
    Environment env_h;

    function new(string name, uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Create a new environment
        env_h = Environment::type_id::create("env_h", this);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        // Starting transactions
        phase.raise_objection(this);      
        // Run transactions      
        runallsequence_h.start(env_h.agent_h.uvm_sequencer_h);
        // Finishing transactions
        phase.drop_objection(this);
    endtask: run_phase

endclass: Test_Active 


class Test_Passive extends Test_Active;
    `uvm_component_utils(Test_Passive)

    // Environment handle
    Environment_Passive env_passive_h;

    function new(string name, uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Override current environment in factory
        set_type_override_by_type(Environment::get_type(), Environment_Passive::get_type());
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        // Starting transactions
        super.run_phase(phase);
    endtask: run_phase

endclass: Test_Passive