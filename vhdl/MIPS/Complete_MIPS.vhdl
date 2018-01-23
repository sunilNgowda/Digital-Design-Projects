library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Complete_MIPS is
  port(clk,rst:in std_logic;
       A_Out,D_Out:out unsigned(31 downto 0));
end Complete_MIPS;

architecture model of Complete_MIPS is
  component MIPS is
    port(clk,rst:in std_logic;
	     cs,we:out std_logic;
		 addr:out unsigned(31 downto 0);
		 Mem_Bus:inout unsigned(31 downto 0));
  end component;
  component Memory is
    port(cs,we,clk:in std_logic;
         addr:in unsigned(31 downto 0);
	     Mem_Bus:inout unsigned(31 downto 0));
  end component;
  signal cs,we:std_logic;
  signal addr,Mem_Bus:unsigned(31 downto 0);
begin
  CPU:MIPS port map(clk,rst,cs,we,addr,Mem_Bus);
  MEM:Memory port map(cs,we,clk,addr,Mem_Bus);
  A_Out<=addr;
  D_Out<=Mem_Bus;
end model;