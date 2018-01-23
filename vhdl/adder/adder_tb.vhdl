library ieee;
use ieee.numeric_bit.all;
entity adder_tb is
end entity;
architecture test of adder_tb is
signal a_tb,b_tb:bit;
signal ci_tb,s_tb:bit;
signal co_tb:bit;
constant result: bit := '1';
component adder is

	port(A,B: in bit;
		 ci:in bit;
		 S: out bit;
		 Co:out bit);
end component;
begin
u0:adder port map(A=>a_tb,
				   B=>b_tb,
				   ci=>ci_tb,
				   S=>s_tb,
				   Co=>co_tb);
	process
	begin
		a_tb<='1';b_tb<='0';ci_tb<='0';
		wait for 100 ns;
		assert(s_tb = result)
		  report "output mismatch:" severity error;
	end process;
end test;