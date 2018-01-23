library ieee;
use ieee.numeric_bit.all;

entity mcode_testbench is
  generic(N:integer:=4);
end entity;

architecture test of mcode_testbench is 
component mcode_class is
  
  port(clk:in bit;
       start:in bit;
       A,B:in unsigned(N-1 downto 0);
       C:out unsigned(2*N-1 downto 0);
       done:out bit);
end component;
signal A_tb,B_tb:unsigned(N-1 downto 0);
signal clk,start_tb,done_tb:bit;
signal C_tb:unsigned(2*N-1 downto 0);
begin
  a0:mcode_class port map(clk=>clk,
			  start=>start_tb,
			  A=>A_tb,
			  B=>B_tb,
			  C=>C_tb,
			  done=>done_tb);
  process
  begin
    clk<='1';
    wait for 5 ns;
    clk<='0';
    wait for 5 ns;
  end process;
  main:process
       begin
         start_tb<='1';
         wait for 100 ns;
         A_tb<="0100";
         B_tb<="1000";
       end process main;
end test;
