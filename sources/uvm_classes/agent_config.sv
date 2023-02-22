

class Agent_config;

    protected uvm_active_passive_enum is_active;

    function new(uvm_active_passive_enum is_active);
        // this.v_put_if = v_put_if;
        this.is_active = is_active;
    endfunction: new

    function uvm_active_passive_enum get_is_active();
        return is_active;
    endfunction: get_is_active

endclass: Agent_config