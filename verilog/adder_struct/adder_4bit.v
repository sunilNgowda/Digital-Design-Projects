module adder_4bit(input [3:0]a, input [3:0]b, output [3:0]result,output carry);

  wire [2:0]cout = 0;
  
  full_adder f0(a[0], b[0], result[0], cout[0]);
  full_adder f1(a[1], b[1], result[1], cout[1]);
  full_adder f2(a[2], b[2], result[2], cout[2]);
  full_adder f3(a[3], b[3], result[3], carry);
endmodule 