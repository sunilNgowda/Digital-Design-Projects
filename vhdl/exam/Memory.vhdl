library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_bit.all;

entity Memory is
  port(cs,we,clk:in bit;
       addr:in unsigned(4 downto 0);
	   Mem_Bus:inout unsigned(7 downto 0));
end memory;

architecture internal of Memory is
  type RAMtype is array (0 to 63) of unsigned (7 downto 0);
  signal RAM1:RAMtype:=(others=>(others=>'0'));
  signal output:unsigned(7 downto 0);
begin
  Mem_Bus <= X"zz" when cs='0'  or we='1'
  else output;
  process(clk)
  begin
    if clk='0' and clk'event then
	  if cs='1' and we='1' then
	    RAM1(to_integer(addr(6 downto 0)))<=Mem_Bus;
	  end if;
	  output<=RAM1(to_integer(addr(6 downto 0)));
	end if;
  end process;
end internal;