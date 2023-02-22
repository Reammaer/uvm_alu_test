

class DifSequence extends uvm_sequence#(PairTransaction);
    `uvm_object_utils(DifSequence)

    PairTransaction transaction_h;

    function new(string name = "DifSequence");
        super.new(name);
    endfunction: new

    task body();
        repeat(20) begin: short_loop
            // Create a new Transaction
            transaction_h = PairTransaction::type_id::create("transaction_h");
            // Start transaction
            start_item(transaction_h);
            transaction_h.transaction_dut_h.sel_op = DIFF;
            // Ranomize transaction
            assert(transaction_h.randomize());
            // Finish transaction
            finish_item(transaction_h);
        end: short_loop
    endtask: body

endclass: DifSequence