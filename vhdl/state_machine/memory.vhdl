library ieee;
--use ieee.numeric_bit.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
entity memory is 
  port(clk:in std_logic;
       mem_w: in std_logic;
       mem_bus : inout unsigned(7 downto 0);
	   src_addr : in unsigned(4 downto 0);
	   dest_addr : in unsigned(4 downto 0));
end entity;

architecture behav of memory is
type mem is array(0 to 31) of unsigned(7 downto 0);
signal memory1: mem := (others =>(others => '0'));
signal output: unsigned(7 downto 0);
begin

  mem_bus <= "ZZZZZZZZ" when mem_w = '1' else output;
  process(clk,mem_w)
  begin
    if(clk'event and clk ='1')then
	  if(mem_w ='1')then
	    memory1(to_integer(dest_addr)) <= mem_bus;
	  end if;
	  output <= memory1(to_integer(src_addr));
	end if;
  end process;
  
  
end behav;