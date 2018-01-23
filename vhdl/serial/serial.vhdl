library ieee;
use ieee.numeric_bit.all;
entity serial_adder is
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
end serial_adder;

architecture behav of serial_adder is
  type state is (s0,s1);
  signal ps,ns:state;
  signal count:unsigned(2 downto 0);
  signal reg_A,reg_B,sum:unsigned(7 downto 0);
  signal shift,cin_Muxout,adder_Cout,adder_Out:bit;
  component adder is
	port(A,B: in bit;
		 ci:in bit;
		 S: out bit;
		 Co:out bit);
  end component;
begin
  sum<=reg_A;
  cout<=adder_Cout;
  process(clk)
  begin
    if (reset='1')then
	  ps<=s0;
	  done<='0';
	  count<="000";
	  reg_A<=A;
	  reg_B<=B;
	end if;
  end process;
  
  process (clk)
  begin  
    if (clk'event and clk='1') then
	  ps<=ns;
	end if;
  end process;
  
  process(clk,ps)
  begin
    case ps is
	  when s0=>if (start='0')then
	    ns<=s1;
		shift<='1';
	  else 
	    ns<=s0;
	  end if;
	  when s1=>if (done='1') then
	    ns<=s0;
	  else
	    ns<=s1;
	  end if;
	end case;
  end process;
  adder1:adder port map(A=>reg_A(0),
                    B=>reg_B(0),
					ci=>cin_Muxout,
					Co=>adder_Cout,
					S=>adder_Out);
  process(clk)
  begin
    if(clk'event and clk='1') then
	  d_Cin<=adder_Cout;
	end if;
  end process;
  
  cin_Muxout<=d_Cin when (start='0') else Cin;
  process(clk)
  begin
    if(start='1')then 
	  reg_A<=A;
	  reg_B<=B;
	elsif(start='0' and shift='1')then
	  reg_A sra 1;
	  reg_B sra 1;
	  reg_A(7)<=adder_Out;
	end if;
	count<=count+"1";
	if(count="111")then
	  count<="000";
	  done<='1';
	end if;
  end process;
end behav;
  
		
	
	  
  