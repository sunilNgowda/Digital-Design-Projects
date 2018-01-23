library ieee;
use ieee.numeric_bit.all;
entity adder4_tb is
end entity;
architecture test of adder4_tb is
signal a_tb,b_tb:unsigned(7 downto 0);
signal ci_tb:bit;
signal co_tb:bit;
signal s_tb:unsigned (7 downto 0);
component adder4 is
generic(N:integer:=8);
	port(A,B: in unsigned(N-1 downto 0);
		 ci:in bit;
		 S: out unsigned(N-1 downto 0);
		 Co:out bit);
end component;
begin
u0:adder4 port map(A=>a_tb,
				   B=>b_tb,
				   ci=>ci_tb,
				   S=>s_tb,
				   Co=>co_tb);
	process
	begin
		a_tb<="00000001";b_tb<="00000010";ci_tb<='0';
		wait for 100 ns;
		a_tb<="01001111";b_tb<="11110010";ci_tb<='0';
		wait for 100 ns;
		a_tb<="11000111";b_tb<="01101010";ci_tb<='0';
		wait for 100 ns;
		a_tb<="11010001";b_tb<="10011010";ci_tb<='0';
		wait for 100 ns;
		a_tb<="10010111";b_tb<="01100001";ci_tb<='1';
		wait for 100 ns;
		a_tb<="00110111";b_tb<="10101000";ci_tb<='1';
		wait for 100 ns;
		a_tb<="10011010";b_tb<="11000011";ci_tb<='1';
		wait for 100 ns;
		a_tb<="00110101";b_tb<="01111011";ci_tb<='0';
		wait for 100 ns;
	end process;
end test;