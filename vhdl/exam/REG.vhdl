library IEEE;
--use IEEE.std_logic_1164.all;
use IEEE.numeric_bit.all;

entity REG is
  port(CLK:in bit;
       RegW:in bit;
	   src_addr : in unsigned(4 downto 0);
	   dest_addr:in unsigned(4 downto 0);
	   Reg_In:in unsigned(31 downto 0);
	   ReadReg:out unsigned(31 downto 0));
end REG;

architecture Behavioral of REG is
type RAM is array(0 to 15) of unsigned(31 downto 0);
signal Regs:RAM:=(others=>(others=>'1'));
begin
  process(clk)
  begin
    if clk='1' and clk'event then 
	  if RegW='1' then
	    Regs(to_integer(dest_addr))<=Reg_In;
	  end if;
	end if;
	
  end process;
  ReadReg<=Regs(to_integer(src_addr));
  
end behavioral;