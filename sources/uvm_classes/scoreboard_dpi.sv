

class DpiScoreboard extends uvm_scoreboard;
    `uvm_component_utils(DpiScoreboard)  
    
    uvm_analysis_imp #(DpiTransaction, DpiScoreboard) m_analysis_imp_dpi;

    function new(string name = "DpiScoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);        
        m_analysis_imp_dpi = new("m_analysis_imp_dpi", this);
    endfunction: build_phase

    // Predicted result from DPI-C module
    function logic [8:0] predict_result_dpi(DpiTransaction item_dpi_h);
        logic [8:0] predicted_dpi;
        case (item_dpi_h.sel_op)
            TRIG_A  : predicted_dpi = item_dpi_h.idata_A;
            SUM     : predicted_dpi = item_dpi_h.idata_A + item_dpi_h.idata_C;
            MULT    : predicted_dpi = item_dpi_h.idata_A * item_dpi_h.idata_C;
            TRIG_B  : predicted_dpi = item_dpi_h.idata_C;
        endcase

        return predicted_dpi;
    endfunction: predict_result_dpi

    function void write(DpiTransaction item_dpi_h);
        // Check data from DPI-C
        logic [8:0] predicted_dpi;
        predicted_dpi = predict_result_dpi(item_dpi_h);

        if (predicted_dpi != item_dpi_h.odata_C) begin
            `uvm_error("Scoreboard DPI", $sformatf("Wrong outpit data predicted dpi=%0d odata_dpi=%0d",
                            predicted_dpi, item_dpi_h.odata_C))
        end
        else begin
            `uvm_info("Scoreboard DPI", $sformatf("Correct output dpi-c data predicted=%0d odata=%0d",
                            predicted_dpi, item_dpi_h.odata_C), UVM_HIGH)
        end
    endfunction: write

endclass: DpiScoreboard