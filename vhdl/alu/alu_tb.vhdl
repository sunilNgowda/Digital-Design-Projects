library ieee;
use ieee.numeric_bit.all;
entity alu_tb is
end entity;
architecture test of alu_tb is
signal a_tb,b_tb,diff_tb,and1_tb,or1_tb,xor1_tb:unsigned(3 downto 0);
--signal ci_tb:bit;
signal co_tb,bo_tb:bit;
signal s_tb:unsigned (3 downto 0);
component alu is
	generic(N:integer:=4);
	port(a,b: in unsigned(N-1 downto 0);
		sum:out unsigned(N-1 downto 0);
		c:out bit;
		diff:out unsigned(N-1 downto 0);
		bo:out bit;
		and1:out unsigned(N-1 downto 0);
		or1:out unsigned(N-1 downto 0);
		xor1:out unsigned(N-1 downto 0));
end component;
begin
u0:alu port map(a=>a_tb,
				b=>b_tb,
				sum=>s_tb,
				c=>co_tb,
				diff=>diff_tb,
				bo=>bo_tb,
				and1=>and1_tb,
				or1=>or1_tb,
				xor1=>xor1_tb);
	process
	begin
		a_tb<="0001";b_tb<="0010";
		wait for 100 ns;
		a_tb<="1111";b_tb<="0010";
		wait for 100 ns;
		a_tb<="0111";b_tb<="1010";
		wait for 100 ns;
		a_tb<="0001";b_tb<="1010";
		wait for 100 ns;
		a_tb<="0111";b_tb<="0001";
		wait for 100 ns;
		a_tb<="0111";b_tb<="1000";
		wait for 100 ns;
		a_tb<="1010";b_tb<="0011";
		wait for 100 ns;
		a_tb<="0101";b_tb<="1011";
		wait for 100 ns;
	end process;
end test;