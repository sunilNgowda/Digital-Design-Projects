library ieee;
use ieee.numeric_bit.all;

entity adder is

	port(A,B: in bit;
		 ci:in bit;
		 S: out bit;
		 Co:out bit);
end adder;

architecture one of adder is

begin
	S<=A xor B xor ci;
	Co<=(A and B) or (ci and (A xor B));
end one;