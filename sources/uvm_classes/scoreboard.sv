

class Scoreboard extends uvm_scoreboard;
    `uvm_component_utils(Scoreboard)

    function new(string name = "Scoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    uvm_analysis_imp #(Transaction, Scoreboard) m_analysis_imp;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_analysis_imp = new("m_analysis_imp", this);
    endfunction: build_phase

    // Predicted result from DUT
    function logic [4:0] predict_result(Transaction item_h);
        bit [4:0] predicted;
        case (item_h.sel_op)
            TRIG_A  : predicted = item_h.idata_A;
            SUM     : predicted = item_h.idata_A + item_h.idata_B;
            DIFF    : predicted = item_h.idata_A - item_h.idata_B;
            TRIG_B  : predicted = item_h.idata_B;
        endcase
        return predicted;
    endfunction: predict_result    


    function void write(Transaction item_h);          
        // Check data from DUT
        logic [4:0] predicted;
        predicted = predict_result(item_h);     

        if (predicted != item_h.odata) begin
            `uvm_error("Scoreboard", $sformatf("Wrong output data predicted=%0d odata=%d",
                            predicted, item_h.odata))
        end    
        else begin
            `uvm_info("Scoreboard", $sformatf("Correct output data predicted=%0d odata=%d",
                            predicted, item_h.odata), UVM_HIGH)
        end

    endfunction: write

endclass: Scoreboard