module adder_test;
  reg [3:0]a,b;
  wire [3:0]result;
  adder  dut(.a(a), .b(b), .result(result));
  initial begin
    $display("output = %b",result);
  end
  initial begin
    $dumpfile("adder.vcd");
	$dumpvars;
  end
  initial begin
    a = 4'd1;
	b = 4'd2;
	#10
	a = 4'd3;
	b = 4'd4;
	#10
	$finish;
  end
  
endmodule