library ieee;
use ieee.numeric_bit.all;

entity pro1 is 
	port ( 
	       a:in bit; 
	       b:in bit ;  
	       c: out bit);
end pro1;

architecture abc of pro1 is
begin
	c <= a and b;
end abc;