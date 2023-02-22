

class Coverage extends uvm_subscriber#(Transaction);
    `uvm_component_utils(Coverage)

    uvm_analysis_imp #(Transaction, Coverage) m_analysis_imp_coverage;

    logic [3:0] idata_A;
    logic [3:0] idata_B;
    logic [1:0] sel_op;

    covergroup data_cov;
        coverpoint idata_A {
            bins zeros = {'d0};
            bins common[] = {[1:$]};
        }
        coverpoint idata_B {
            bins zeros = {'d0};
            bins common[] = {[1:$]};
        }
    endgroup: data_cov

    function new(string name = "Coverage", uvm_component parent);
        super.new(name, parent);
        m_analysis_imp_coverage = new("m_analysis_imp_coverage", this);
        data_cov = new();
    endfunction: new

    function void write(Transaction t);
        idata_A = t.idata_A;
        idata_B = t.idata_B;
        sel_op = t.sel_op;
        // Launch coverage
        data_cov.sample();
        // $display("Coverage=%0.2f %%", data_cov.get_inst_coverage());
    endfunction: write

    function void report_phase (uvm_phase phase);
        `uvm_info("Coverage", $sformatf("Functional coverage=%0.2f %%", 
                                data_cov.get_inst_coverage()), UVM_HIGH);
    endfunction: report_phase


endclass: Coverage