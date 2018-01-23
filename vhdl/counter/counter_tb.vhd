library ieee;
use ieee.numeric_bit.all;

entity counter_tb is
end entity;

architecture test of counter_tb is
component counter is
  port(clk, start: in bit;
       count: out bit);
end component;

signal clk,start : bit;
signal count : bit;
begin
 u0: counter port map(clk => clk,
					  start => start,
					  count => count);
  process
  begin
    clk <= not clk;
	wait for 10 ns;
	start <= '1';
  end process;
  
  
end test;