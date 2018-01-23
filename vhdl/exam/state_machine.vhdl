library ieee;
use ieee.numeric_bit.all;

entity state_machine is
  port(clk,start,rst : in bit;
       done : out bit;
       readout: out unsigned(31 downto 0));

end state_machine;


architecture behav of state_machine is

component REG is
 port(CLK:in bit;
       RegW:in bit;
	   src_addr : in unsigned(4 downto 0);
	   dest_addr:in unsigned(4 downto 0);
	   Reg_In:in unsigned(31 downto 0);
	   ReadReg:out unsigned(31 downto 0));
end component;

-- component Memory is
-- port(cs,we,clk:in bit;
     -- addr:in unsigned(31 downto 0);
	 -- Mem_Bus:inout unsigned(31 downto 0));
-- end component;

type state is(s0,s1,s2,s3);
signal ps,ns : state := s1;
signal src_addr,dest_addr:unsigned(4 downto 0):= (others => '0');
signal reg_in:unsigned(31 downto 0);
signal reg_out:unsigned(31 downto 0);
--signal out1: unsigned (7 downto 0):= (others => '0');

begin   
l1: REG port map (CLK => clk,
				  regw => start,
				  src_addr => src_addr,
				  dest_addr => dest_addr,
				  Reg_In => reg_in,
				  ReadReg => reg_out);
  process(ns)
  begin
    if(clk'event and clk = '1')then
	  if(rst = '1')then
	    ns <= s0;
	  else 
        ps <= ns;
	  end if;
	end if;
  end process;
  
  
	
  
  process(clk)
  begin
    case (ps) is
	
	  when s0=> dest_addr <= (others => '0');
	            src_addr <= (others => '0');
			   
			   
	  
	  when s1=> if(start = '1')then
	            ns <= s2;
				else 
				ns <= s1;
				end if;
	  when s2=> if(clk'event and clk ='1')then
	              if( start = '1') then
				    reg_in(7 downto 0) <= "000" & dest_addr;
				    reg_in(15 downto 8) <= "000" & dest_addr;
				    reg_in(23 downto 16) <= "000" & dest_addr;
				    reg_in(31 downto 24) <= "000" & dest_addr;
					ns <= s2;
					dest_addr <= dest_addr + "1";
				    if(dest_addr(4) = '1')then
	                  dest_addr <= (others => '0');
					  ns <= s3;
	                end if;
				  end if;
				end if;
	  when s3 => for i in 0 to 15 loop
	               src_addr <= src_addr + "1";
				 end loop;
	  
	end case;
	readout <= reg_out;
  end process;
		   
  end behav;	            
	            
	
    
  