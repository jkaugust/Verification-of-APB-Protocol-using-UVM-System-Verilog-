`ifndef SEQ
`define SEQ

`include "uvm_macros.svh"
`include "seq_item.sv"
`include "sequencer.sv"

import uvm_pkg::*;

class seq extends uvm_sequence#(seq_item);
   
  `uvm_sequence_utils(seq,sequencer)
   
  //Constructor
  function new(string name = "seq");
    super.new(name);
  endfunction
  
  virtual task body();
 
    req = seq_item::type_id::create("req");
    wait_for_grant();
    req.randomize();
    send_request(req);
    wait_for_item_done();
    
  endtask
     
endclass
  


`endif //SEQ


