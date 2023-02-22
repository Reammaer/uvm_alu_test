
class TrigBSequence extends uvm_sequence #(PairTransaction);
    `uvm_object_utils(TrigBSequence)

    // Transaction handle
    PairTransaction transaction_h;

    function new(string name = "TrigBSequence");
        super.new(name);
    endfunction: new

    task body();
        // Create a new transaction
        repeat(20) begin: short_loop
            transaction_h = PairTransaction::type_id::create("transaction_h");
            // Start a new transaction
            start_item(transaction_h);
            transaction_h.transaction_dut_h.sel_op = TRIG_B;
            assert( transaction_h.randomize() );
            finish_item(transaction_h);
        end: short_loop
    endtask: body

endclass: TrigBSequence