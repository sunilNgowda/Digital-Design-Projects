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
architecture behave of serial_adder is
  component adder is
	port(A,B: in bit;
		 ci:in bit;
		 S: out bit;
		 Co:out bit);
  end component;
  signal ps,ns,shift:bit;
  signal muxout_Cin,temp_Cin,temp_Cout,temp_Sum:bit;
  signal AREG,BREG: unsigned(N-1 downto 0);
  signal count:unsigned(3 downto 0);
begin
  sum<=AREG;
  cout<=temp_Cout;
  U0:adder port map(A=>AREG(0),
                    B=>BREG(0),
					ci=>muxout_Cin,
					Co=>temp_Cout,
					S=>temp_Sum);
  muxout_Cin<=temp_Cin when (start='0') else Cin;
    process (clk)
    begin
	  if(clk'event and clk='1') then
	    temp_Cin<=temp_Cout;
      end if;
	  if (clk'event and clk='1')then
	    if (start='1')then
		  AREG<=A;
		  BREG<=B;
		elsif (shift='1')then
		  AREG(N-2 downto 0)<=AREG(N-1 downto 1);
		  AREG(N-1)<=AREG(0);
		  BREG(N-2 downto 0)<=BREG(N-1 downto 1);
		  BREG(N-1)<=BREG(0);
		end if;
	  end if;
	end process;
	process(ps,start,count)
	begin
	  shift<='0';done<='0';
	  case ps is
	    when '0'=>if(start='1')then
		         ns<='1';
			 else
			     ns<='0';
			 end if;
		when '1' =>if(count=to_unsigned(N,4))then
		         ns<='0';
				 done<='1';
			  else
			    ns<='1';
			  end if;
			  shift<='1';
	  end case;
	end process;
	process(clk,start)
	begin
	  if(clk'event and clk='1')then
	    if (start='1') then
		  count<=(others=>'0');
		elsif(shift='1')then
		  count<=count + "1";
		end if;
	  end if;
	end process;
end behave;
	
	
		  
	  
		  