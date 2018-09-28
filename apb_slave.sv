module apb_slave (clk,rst,wr_in,en,sel_port,addr_in,data_in,ready,
  wr_out1,addr_out1,data_out1,wr_out2,addr_out2,data_out2,
  wr_out3,addr_out3,data_out3,wr_out4,addr_out4,data_out4);
  input clk;
  input rst;
  input wr_in;
  input en;
  input [1:0] sel_port;
  input [7:0] addr_in;
  input [31:0] data_in;
  output reg ready;
  output reg wr_out1,wr_out2,wr_out3,wr_out4;
  output reg [7:0] addr_out1,addr_out2,addr_out3,addr_out4;
  output reg [31:0] data_out1,data_out2,data_out3,data_out4;
  
  reg [2:0] port,state;
  
  localparam [2:0] INIT = 3'b000,
                   PORT1 = 3'b001,
                   PORT2 = 3'b010,
                   PORT3 = 3'b011,
                   PORT4 = 3'b100;
                
  
  localparam [2:0]  IDLE    = 3'b000,
                    SETUP   = 3'b001,
                    ACCESS  = 3'b010,
                    WAIT    = 3'b101;
                    
                      
  always @(posedge clk)
    begin
      if (rst == 0) 
        begin 
          state    <= IDLE;
          ready    <= 0;
          port     <= INIT;
        end
    else
      begin
        case (state)
          IDLE : begin      
            ready    <= 0;
            port <= INIT;
            if (en == 1)
              begin
                state <= SETUP;
              end
            else
              begin
                state <= IDLE;
              end
            end
            
            SETUP: begin
              ready <= 1;
              state <= ACCESS;
              end
              
             ACCESS: begin
               case (sel_port)
                00: begin
                  wr_out1 <=  wr_in;
                  wr_out2 <= 0;
                  wr_out3 <= 0;
                  wr_out4 <= 0;
                  addr_out1 <= addr_in;
                  addr_out2 <= 8'b0;
                  addr_out3 <= 8'b0;
                  addr_out4 <= 8'b0;
                  data_out1 <= data_in;
                  data_out2 <= 32'b0;
                  data_out3 <= 32'b0;
                  data_out4 <= 32'b0;
                 end
                 
                01: begin
                     wr_out1 <= 0;
                     wr_out2 <= wr_in;
                     wr_out3 <= 0;
                     wr_out4 <= 0;
                    addr_out1 <= 8'b0;
                    addr_out2 <= addr_in;
                    addr_out3 <= 8'b0;
                    addr_out4 <= 8'b0;
                    data_out1 <= 32'b0;
                    data_out2 <= data_in;
                    data_out3 <= 32'b0;
                    data_out4 <= 32'b0; 
                  end   
                     
                10: begin
                    wr_out1 <= 0;
                    wr_out2 <= 0;
                    wr_out3 <= wr_in;
                    wr_out4 <= 0;
                    addr_out1 <= 8'b0;
                    addr_out2 <= 8'b0;
                    addr_out3 <= addr_in;
                    addr_out4 <= 8'b0;
                    data_out1 <= 32'b0;
                    data_out2 <= 32'b0;
                    data_out3 <= data_in;
                    data_out4 <= 32'b0;
                  end
                  
                11: begin
                    wr_out1 <= 0;
                    wr_out2 <= 0;
                    wr_out3 <= 0;
                    wr_out4 <= wr_in;
                    addr_out1 <= 8'b0;
                    addr_out2 <= 8'b0;
                    addr_out3 <= 8'b0;
                    addr_out4 <= addr_in;
                    data_out1 <= 32'b0;
                    data_out2 <= 32'b0;
                    data_out3 <= 32'b0;
                    data_out4 <= data_in;
                  end
                  
                default:begin
                    wr_out1 <= 0;
                    wr_out2 <= 0;
                    wr_out3 <= 0;
                    wr_out4 <= 0;
                    addr_out1 <= 8'b0;
                    addr_out2 <= 8'b0;
                    addr_out3 <= 8'b0;
                    addr_out4 <= 8'b0;
                    data_out1 <= 32'b0;
                    data_out2 <= 32'b0;
                    data_out3 <= 32'b0;
                    data_out4 <= 32'b0;
                  end 
              endcase
               state <= WAIT;
             end
             
             WAIT: begin
               ready <= 0;
               if (en == 0)
                 begin
                   state <= IDLE;
                 end
               else
                 begin
                   state <= WAIT;
                 end
               end
             endcase
           end
         end

endmodule   
            
            




