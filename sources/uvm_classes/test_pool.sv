

class Test_pool extends uvm_test;
    `uvm_component_utils(Test_pool)

    // uvm_pool handle
    uvm_pool #(string, int) animal_zoo;
    string key;

    function new(string name, uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    task run_phase(uvm_phase phase);
        // Create anew pool
        animal_zoo = new("number");
        animal_zoo.add("Tigers", 5);
        animal_zoo.add("Rabbits", 10);
        animal_zoo.add("Frogs", 20);

        // Get some information from test_pool into console
        `uvm_info("Test_pool", $sformatf("animal species in the zoo : %0d", 
                                        animal_zoo.num()),UVM_LOW)
        
        `uvm_info("Test_pool", $sformatf("Tigers in the zoo         : %0d",
                                        animal_zoo.get("Tigers")), UVM_LOW)
        
        `uvm_info("Test_pool", $sformatf("Rabbits in the zoo        : %0d",
                                        animal_zoo.get("Rabbits")), UVM_LOW)
        
        `uvm_info("Test_pool", $sformatf("Frogs in the zoo          : %0d",
                                        animal_zoo.get("Frogs")), UVM_LOW)
        
        `uvm_info("Test_pool", $sformatf("Snakes in the zoo         ? %0d",
                                        animal_zoo.exists("Snakes")), UVM_LOW)
    endtask: run_phase

endclass: Test_pool