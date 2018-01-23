library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Memory is
  port(cs,we,clk:in std_logic;
       addr:in unsigned(31 downto 0);
	   Mem_Bus:inout unsigned(31 downto 0));
end memory;

architecture internal of Memory is
  type RAMtype is array (0 to 127) of unsigned (31 downto 0);
  signal RAM1:RAMtype:=(others=>(others=>'0'));
  signal output:unsigned(31 downto 0);
begin
  Mem_Bus<=(others=>'Z') when cs='0'  or we='1'
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