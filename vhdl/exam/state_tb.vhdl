library ieee;
use ieee.numeric_bit.all;

entity state_tb is
end entity;

architecture test of state_tb is
component state_machine is
  port(clk,start,rst : in bit;
       done: out bit;
       readout: out unsigned(31 downto 0));

end component;

signal clk1,start,rst: bit:= '0';
signal readout:unsigned(31 downto 0);


begin 
u1: state_machine port map(clk => clk1,
						   start => start,
						   rst => rst,
                           readout => readout);
	process
	begin
	  clk1 <= not clk1;
	  rst <= '0';
	  start <= '1';
	end process;
	
end test;
