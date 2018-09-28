`ifndef OUT_INTF
`define OUT_INTF

interface out_intf (input logic clk);
logic [7:0] addr_out;
logic [31:0] data_out;
logic wr_out;

clocking cb@(posedge clk);
  default input #1 output #1;
  input addr_out;
  input data_out;
  input wr_out;
endclocking

modport OUT (clocking cb);

endinterface 
  
`endif //OUT_INTF
