module d_ff(clk,d,q,qb);
input clk,d;
output q,qb;
wire clk,d;
reg q,qb;

always @(posedge clk)
begin
  q <= d;
  qb <= !d;
  $display ("sucessful");
end
 
endmodule