library ieee;
use ieee.numeric_bit.all;

entity alu is
	generic(N:integer:=4);
	port(a,b: in unsigned(N-1 downto 0);
		sum:out unsigned(N-1 downto 0);
		c:out bit;
		diff:out unsigned(N-1 downto 0);
		bo:out bit;
		and1:out unsigned(N-1 downto 0);
		or1:out unsigned(N-1 downto 0);
		xor1:out unsigned(N-1 downto 0));
end alu;

architecture behav of alu is
	signal s,d: unsigned(N downto 0);
	
begin
	
		s<='0' & a + b;
		sum<=s(N-1 downto 0);
		c<=s(N);
		d<='0' & a - b;
		diff<=d(N-1 downto 0);
		bo<=d(N);
		and1<=a and b;
		or1<=a or b;
		xor1<=a xor b;
		
	
end behav;