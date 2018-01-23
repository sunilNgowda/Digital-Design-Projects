--Sunil Nagaraj Gowda
--CWID-802827535

library ieee;
use ieee.numeric_bit.all;

entity unique_circuit is 
  port(clk,a,b,c,d,e:in bit;
       p,q,r:out bit);
end entity;

architecture behav of unique_circuit is
  signal s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14:bit;
begin
  s1<=a and b;
  s2<=a or b;
  s3<=s1 xor s2;
  s4<=c and d;
  s5<=c or (not d);
  s6<=s4 and s5;
  s10<=s7 and s8;
  s11<=s8 and s9;
  s13<=s12 and s14;
  process(clk)
  begin 
    if (clk'event and clk='1') then
	  s8<=c;
	  s7<=s3;
	  s9<=s6;
	  s12<=s10;
	  s11<=s14;
	end if;
  end process;
  p<=s12;
  q<=s13;
  r<=s14;
end behav;
	  
	