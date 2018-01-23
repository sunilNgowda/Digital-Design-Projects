module memory(input clk,input wr_rd,input [2:0]address, inout[7:0]data);

//wire clk;
//wire wr_rd;
//wire address;
reg [7:0] mem [7:0];
reg [7:0] out;
//reg [7:0]data;




assign data = (wr_rd)?out : 8'bZ;

always @(posedge clk)begin
  if(wr_rd == 0) begin
    mem[address] <= data;
  end else begin
    out <= mem[address];
  end
end

endmodule