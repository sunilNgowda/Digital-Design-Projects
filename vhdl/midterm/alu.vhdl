--Sunil Nagaraj Gowda
--CWID-802827535
library ieee;
use ieee.numeric_bit.all;

entity alu is
  port(next1:in bit;
       clk,a,b:in bit;
       p,q,r:out bit);
end entity;

architecture behav of alu is
type state is (s0,s1,s2,s3,s4);
signal ns:state;
signal ps:state := s0;
begin
  process(clk)
  begin  
    if(clk'event and clk='1')then
	  ps<=ns;
	end if;
  end process;

  process(ps)
  begin
    case ps is
	  when s0=>if (next1='1')then
	             ns<=s1;
			   else
			     ns<=s0;
			   end if;
	  when s1=>if (next1='1')then
	             ns<=s2;
	             p<=a and b;
			   else
			     ns<=s1;
			   end if;
	  when s2=>if (next1='1')then
	             ns<=s3;
	             q<=a or b;
			   else
			     ns<=s2;
			   end if;
	  when s3=>if (next1='1')then
	             ns<=s4;
	             r<=a xor b;
			   else
			     ns<=s0;
			   end if;
	  when s4=>ns<=s0;
	end case;
  end process;
end behav;
	  
	  
