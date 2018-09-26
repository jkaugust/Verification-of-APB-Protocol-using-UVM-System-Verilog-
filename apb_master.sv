module apb_master (clk,rst,addr_in,wr_in,ready,sel,data_in,sel_port,en,wr_out,addr_out,data_out);
  input clk;
  input rst;
  input [7:0] addr_in;
  input wr_in; //write when 1 and read when 0
  input ready;
  input sel;
  input [31:0] data_in;
  output reg [1:0] sel_port;
  output reg en;
  output reg wr_out;
  output reg [7:0] addr_out;
  output reg [31:0] data_out;
  
  reg [2:0] state;
  typedef bit [1:0] sel_bit;
  typedef bit [7:0] add_bit;
  int a,b;
  sel_bit qa;
  
  localparam [2:0]  IDLE    = 3'b000,
                    SETUP   = 3'b001,
                    ACCESS  = 3'b010,
                    READ    = 3'b011,
                    WRITE   = 3'b100,
                    WAIT    = 3'b101;
                    
                    
  always @(posedge clk)
    begin
      if (rst == 0) 
        begin 
          state    <= IDLE;
          addr_out <= 8'b0;
          data_out <= 32'b0;
          sel_port <= 0;
          en       <= 0;
          wr_out   <= 0;   
        end
    else
      begin
        case (state)
          IDLE: begin
            addr_out   <= 8'b0;
            data_out   <= 32'b0;
            sel_port   <= 2'b0;
            en         <= 0;
            wr_out   <= 0;
            if (sel == 1) begin
              state  <= SETUP;
              end
              else begin
                state <= IDLE;
              end
            end
            
            SETUP: begin           
              sel_port   <= sel_sig (addr_in);
              en         <= 0;
              if (sel == 1) begin
                 state  <= ACCESS;
                end
                  else begin
                  state <= SETUP;
                end
              end
                
            ACCESS: begin
              en     <= 1; 
              if (wr_in == 0)
                begin
                  state  <= READ;
                end
                  else begin
                  state <= WRITE;
                end
              end
              
             READ: begin
               if (ready == 1)
                 begin
                   addr_out <= addr_in;
                   data_out <= data_in;
                   wr_out   <= 0;
                   state <= WAIT;
                 end
                else
                  begin
                    state <= READ;
                  end
                end
                
             WRITE: begin
               if (ready == 1)
                 begin
                   addr_out <= addr_in;
                   data_out <= data_in;
                   wr_out   <= 1;
                   state <= WAIT;
                 end
                else
                  begin
                    state <= WRITE;
                  end
                end
                
              WAIT: begin
                if (sel == 0)
                  begin
                    state <= IDLE;
                  end
                else 
                  begin
                    state <= ACCESS;
                  end
                end
            endcase
          end
        end
            
  function sel_bit sel_sig (input add_bit ad_in);
    a = ad_in[7];
    b = ad_in[6];
    qa = {>>{a,b}};
    return qa;
  endfunction
  
endmodule
      