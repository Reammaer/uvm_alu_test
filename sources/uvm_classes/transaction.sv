

class Transaction extends uvm_sequence_item;
    `uvm_object_utils(Transaction)

    randc logic [3:0]   idata_A;
    randc logic [3:0]   idata_B;
    logic [1:0]         sel_op;
    logic [4:0]         odata;

    // Constrains declaration (if required) //

    // *********************** //

    function new(string name = "");
        super.new(name);
    endfunction: new 

    // Additional functions
    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        Transaction tested;
        bit same;

        if (rhs == null) begin
            `uvm_fatal(get_type_name(), "Tried to do comparison to a null pointer!");
        end

        if (!$cast(tested, rhs)) begin
            same = 0;
        end
        else begin
            same = super.do_compare(rhs, comparer) &&
                    (tested.idata_A == idata_A) &&
                    (tested.idata_B == idata_B) &&
                    (tested.sel_op == sel_op) &&
                    (tested.odata == odata);
            return same;
        end
    endfunction: do_compare

    function void do_copy(uvm_object rhs);
        Transaction rhs_copy;
        assert(rhs != null) else $fatal(1, "Tried to copy null transaction!");
        super.do_copy(rhs);
        assert($cast(rhs_copy, rhs)) else $fatal(1, "Failed cast in do_copy");
        // Copy Data
        idata_A = rhs_copy.idata_A;
        idata_B = rhs_copy.idata_B;
        sel_op  = rhs_copy.sel_op;
        odata   = rhs_copy.odata;
    endfunction: do_copy

endclass: Transaction


// Extension for Transaction
class DpiTransaction extends Transaction;
    `uvm_object_utils(DpiTransaction)

    randc logic [4:0]   idata_C;
    logic [4:0]         idata_A;
    logic [8:0]         odata_C;

    function new(string name = "");
        super.new(name);
    endfunction: new

endclass: DpiTransaction


// Composition for both transactions
class PairTransaction extends uvm_sequence_item;
    `uvm_object_utils(PairTransaction)

    rand Transaction transaction_dut_h;
    rand DpiTransaction transaction_dpi_h;

    logic [5:0] blkPortVar;

    function new(string name = "");
        super.new(name);
        transaction_dut_h = Transaction::type_id::create("transaction_dut_h");
        transaction_dpi_h = DpiTransaction::type_id::create("transaction_dut_h");
    endfunction: new

endclass:PairTransaction