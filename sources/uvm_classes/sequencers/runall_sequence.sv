

class RunAllSequence extends uvm_sequence #(uvm_sequence_item);
    `uvm_object_utils(RunAllSequence)

    // Sequence handles
    TrigASequence   trigAsequence_h;
    TrigBSequence   trigBsequence_h;
    SumSequence     sumsequence_h;
    DifSequence     difsequence_h;

     function new(string name = "RunAllSequence");
        super.new(name);       
     endfunction: new

    task pre_body();
        trigAsequence_h = TrigASequence::type_id::create("trigAsequence_h");
        trigBsequence_h = TrigBSequence::type_id::create("trigBsequence_h");
        sumsequence_h   = SumSequence::type_id::create("sumsequence_h");
        difsequence_h   = DifSequence::type_id::create("difsequence_h");
    endtask: pre_body

    task body();
        trigAsequence_h.start(m_sequencer);
        trigBsequence_h.start(m_sequencer);
        sumsequence_h.start(m_sequencer);
        difsequence_h.start(m_sequencer);
    endtask: body

endclass: RunAllSequence