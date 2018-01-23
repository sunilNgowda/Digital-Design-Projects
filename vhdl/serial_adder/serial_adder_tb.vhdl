library ieee;
use ieee.numeric_bit.all;
entity serial_adder_tb is 
end entity;
architecture behav of serial_adder_tb is
  component serial_adder is
  generic(N:integer:=8);
  port(A:in unsigned(N-1 downto 0);
       B:in unsigned(N-1 downto 0);
	   Cin:in bit;
	   clk:in bit;
	   reset:in bit;
	   start:in bit;
	   done:out bit;
	   cout:out bit;
	   sum:out unsigned(N-1 downto 0));
  end component; 
  signal A_tb,B_tb,Sum_tb:unsigned(7 downto 0);
  signal Cin_tb,clk,reset,start,done,Cout_tb:bit;
begin  
  u1:serial_adder port map (A=>A_tb,
							B=>B_tb,
							Cin=>Cin_tb,
							clk=>clk,
							reset=>reset,
							start=>start,
							done=>done,
							cout=>Cout_tb,
							sum=>Sum_tb);
  process
  begin
   clk<='1';
   wait for 5 ns;
   clk<='0';
   wait for 5 ns;
  end process;
  main:process
  begin
    reset<='1';
	start<='0';
	wait for 100 ns;
	A_tb<=X"10";
	B_tb<=x"20";
	Cin_tb<='0';
	wait for 100 ns;
	assert false report "simulation end " severity failure;
  end process main;
 end behav;