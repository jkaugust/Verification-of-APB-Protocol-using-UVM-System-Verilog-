`ifndef SEQUENCER
`define SEQUENCER

`include "uvm_macros.svh"
`include "seq_item.sv"


import uvm_pkg::*;


class sequencer extends uvm_sequencer#(seq_item);
 
  `uvm_component_utils(sequencer)
 
  //constructor
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
   
endclass

`endif // SEQUENCER
