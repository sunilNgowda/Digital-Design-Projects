module memory_tb;
reg clk;
reg wr_rd;
reg [2:0]address;
wire [7:0] data;
reg [7:0] out;
memory dut(.clk (clk),.wr_rd (wr_rd),.address (address),.data (data));

initial
begin
  clk = 0;
  wr_rd = 0;
  address = 0;
end
always begin
  #5 clk = !clk;
end
initial  
begin
  $dumpfile ("memory.vcd"); 
  $dumpvars; 
end 

initial
begin
  wr_rd = 0;
  address = 3'b000;
  out = 8'b00000001;
  #10
  address = 3'b001;
  out = 8'b00000010;
  #10 
  address = 3'b010;
  out = 8'b00000011;
  #10
  wr_rd = 1;
  #10
  address = 3'b000;
  #10
  address = 3'b001;
  #10 
  address = 3'b010;
  $finish;
  
end
assign data = out;

endmodule
  
