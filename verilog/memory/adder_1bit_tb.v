module adder_tb;
reg a;
reg b;
wire sum;
wire carry;

adder test(.a(a),.b(b),.carry(carry),.sum(sum));
initial begin
  $dumpfile("adder1bit.vcd");
  $dumpvars;
end
initial begin
 a = 1;
 b = 0;
 #10
 a = 0;
 b = 1;
 #10
 a = 0;
 b = 0;
 #10
 a = 1;
 b = 1;
 #10
 $finish;
end

endmodule
  