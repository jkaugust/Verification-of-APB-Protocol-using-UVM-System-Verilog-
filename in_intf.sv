
`ifndef IN_INTF
`define IN_INTF

interface in_intf (input logic clk,rst);
 logic [7:0] addr_in;
 logic wr_in, sel;
 logic [31:0] data_in;

clocking cb@(posedge clk);
  default input #1 output #1;
  output addr_in;
  output data_in;
  output wr_in;
  output sel;
endclocking

modport IN(clocking cb, input clk,rst);

endinterface
 

`endif //IN_INTF

