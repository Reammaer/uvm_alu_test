

class SumSequence extends uvm_sequence #(PairTransaction);
    `uvm_object_utils(SumSequence)

    // Transaction handle
    PairTransaction transaction_h;

    function new(string name = "SumSequence");
        super.new(name);
    endfunction: new

    task body();
        repeat(20) begin: short_loop
            // Create a new transaction
            transaction_h = PairTransaction::type_id::create("transaction_h");
            // Start a new transaction
            start_item(transaction_h);
            transaction_h.transaction_dut_h.sel_op = SUM;
            assert(transaction_h.randomize());
            // Finish transaction
            finish_item(transaction_h);
        end: short_loop
    endtask: body

endclass: SumSequence