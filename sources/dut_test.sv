

module dut_test
(
    input logic         iclk
,   input logic [3:0]   idata_A
,   input logic [3:0]   idata_B
,   input logic [1:0]   sel_op
,   output logic [4:0]  odata
);

    // Sel_op variations
    typedef enum logic [1:0] {
        TRIG_A  = 2'd0,
        SUM     = 2'd1,
        DIFF    = 2'd2,
        TRIG_B  = 2'd3
    } sel_op_t;

    always_ff @(posedge iclk) begin
        case(sel_op)
            TRIG_A  : odata <= idata_A;
            SUM     : odata <= idata_A + idata_B;
            DIFF    : odata <= idata_A - idata_B;
            TRIG_B  : odata <= idata_B;
        endcase
    end


endmodule: dut_test