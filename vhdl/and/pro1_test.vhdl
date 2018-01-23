library ieee;
use ieee.numeric_bit.all;
entity pro1_test is
end pro1_test;

architecture one of pro1_test is
	signal a_test,b_test: bit;
	signal c_test: bit;
	component pro1 is 
		port ( 
	      	       a:in bit; 
	      	       b:in bit ;  
	       	       c: out bit);
	end component;
begin
	a1:pro1 port map(
	   	  	  a=>a_test,
	   	 	  b=>b_test,
	   	 	  c=>c_test);
	process
	begin
	   
		a_test<='0';b_test<='0';
	        wait for 100 ns;
		a_test<='0';b_test<='1';
	        wait for 100 ns;
		a_test<='1';b_test<='0';
	        wait for 100 ns;
		a_test<='1';b_test<='1';
	        wait for 100 ns;
	end process;
end one;

