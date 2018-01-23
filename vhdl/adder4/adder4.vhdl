library ieee;
use ieee.numeric_bit.all;

entity adder4 is
generic(N:integer:=8);
	port(A,B: in unsigned(N-1 downto 0);
		 ci:in bit;
		 S: out unsigned(N-1 downto 0);
		 Co:out bit);
end adder4;

architecture overload of adder4 is
signal sum5:unsigned (N downto 0);
begin
	sum5<='0' & A + B + unsigned'(0=>ci);
	s<=sum5(N-1 downto 0);
	Co<=sum5(N);
end overload;