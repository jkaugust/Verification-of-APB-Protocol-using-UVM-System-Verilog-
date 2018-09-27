`timescale 1ns/1ns

module test_top();
  reg clk,rst,wr_in,ready,sel;
  reg [7:0] addr_in;
  reg [31:0] data_in;
  wire wr_out1,wr_out2,wr_out3,wr_out4;
  wire [7:0] addr_out1,addr_out2,addr_out3,addr_out4;
  wire [31:0] data_out1,data_out2,data_out3,data_out4;
  
  top top_test (clk,rst,addr_in,wr_in,sel,data_in,
  wr_out1,addr_out1,data_out1,wr_out2,addr_out2,data_out2,
  wr_out3,addr_out3,data_out3,wr_out4,addr_out4,data_out4);

   always
         begin
          clk=0;
        #10 clk= 1;
      end
    
  initial 
    begin
    @(posedge clk)
    #5 rst=0;addr_in = 8'b00000000; wr_in = 1;
    ready =1; sel=1; data_in = '1;
    @(posedge clk)
    #5 rst=1;addr_in = 8'b01000000; wr_in = 1;
    ready =1; sel=1; data_in = '1;
    @(posedge clk)
    #5 rst=1;addr_in = 8'b10000000; wr_in = 1;
    ready =0; sel=1; data_in = '1;
    @(posedge clk)
    #5 rst=1;addr_in = 8'b11000000; wr_in = 0;
    ready =1; sel=1; data_in = '1;
    @(posedge clk)
    #5 rst=1;addr_in = 8'b11001110; wr_in = 1;
    ready =1;sel=1;data_in = '0;
    end
endmodule
