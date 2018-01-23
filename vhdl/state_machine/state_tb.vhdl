library ieee;
--use ieee.numeric_bit.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
entity state_tb is
end entity;

architecture state of state_tb is
component state_machine is
  port(start, clk :in std_logic;
        done : out bit;
		output: out unsigned(7 downto 0));
end component;
signal start_tb,clk_tb,done_tb:bit;
signal out_tb: unsigned(31 downto 0);

begin
  
u1: state_machine port map(clk => clk_tb,
						   start => start_tb,
						   done => done_tb,
						   output => out_tb);
						   
	process
	begin
	  clk_tb <= not clk_tb;
	  wait for 10 ns;
	end process;
	
	start_tb <= '1' after 10 ns;
end state;