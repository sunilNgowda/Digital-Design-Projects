library ieee;
--use ieee.numeric_bit.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

entity register1 is
  port(clk: in std_logic;
       src_addr,dest_addr:in unsigned(4 downto 0);
       register_in: in unsigned(31 downto 0);
	   register_out: out unsigned(31 downto 0);
	   regw:in std_logic);
end entity;

architecture behav of register1 is 
type reg is array (0 to 15) of unsigned(31 downto 0);
signal resgister: reg := (others => (others => '1'));


begin
  process(clk,src_addr,dest_addr)
  begin
    if (clk'event and clk ='1')then
	  if(regw = '1')then
	    resgister(to_integer(dest_addr)) <= register_in;
	  end if;
	end if;
  end process;
	register_out <= resgister(to_integer(src_addr));
end behav;
	    
 