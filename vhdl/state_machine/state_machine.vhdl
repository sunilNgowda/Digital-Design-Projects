library ieee;
--use ieee.numeric_bit.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
entity state_machine is
  port(start, clk :in bit;
        done : out bit;
		output: out unsigned(7 downto 0));
end entity;


architecture behav1 of state_machine is
component register1 is
  port(clk: in std_logic;
       src_addr,dest_addr:in unsigned(4 downto 0);
       register_in: in unsigned(31 downto 0);
	   register_out: out unsigned(31 downto 0);
	   regw:in bit);
end component;
component memory is 
  port(clk:in std_logic;
       mem_w: in std_logic;
       mem_bus : inout unsigned(7 downto 0);
	   src_addr : in unsigned(4 downto 0);
	   dest_addr : in unsigned(4 downto 0));
end component;
type states is (s1, s2, s3, s4);
signal ns: states:= s1;
signal ps: states;
signal counter1, counter2: unsigned(4 downto 0):= (others => '0');
signal reg_in, reg_out: unsigned(31 downto 0);
signal memory_in: unsigned(7 downto 0);
signal counter3: unsigned(7 downto 0);
signal done1,start1: bit;
begin
a1: register1 port map(clk => clk,
					   src_addr => counter1,
					   dest_addr => counter2,
					   register_in => reg_in,
					   register_out => reg_out,
					   regw => start);
a2: memory port map(clk => clk,
					mem_w => done1,
					   src_addr => counter1,
					   dest_addr => counter2,
					   mem_in => memory_in);
  process(clk)
  begin
    if(clk'event and clk = '1')then
      ps <= ns;
	end if;
  end process;
  
  process(clk,ps)
  begin
    if (clk'event and clk= '1') then  
      case (ps) is
        when s1 => if(start = '1')then
		             ns <= s2;
					 start1 <= '1';
				   else
				     ns <= s1;
				   end if;
		when s2 => if(counter2 = "01111")then
		             ns <= s3;
					 done1 <= '1';
		             start1 <= '0';
					 counter2 <= (others => '0');
				   else
				     if(start1 = '1')then
				       ns <= s2;
				       
					   reg_in(31 downto 24) <= counter3;
					   reg_in(23 downto 16) <= counter3;
					   reg_in(15 downto 8) <= counter3;
					   reg_in(7 downto 0 ) <= counter3;
					   counter2 <= counter2 + "1";
					   counter3 <= counter3 + "1";
					 end if;
				   end if;
		when s3=> if(done1 = '1')then
		            memory_in <= reg_out(7 downto 0);
		            counter2 <= counter2 + "1";
					counter1 <= counter1 + "1";
					if (counter2 = "11111")then
					  done1<='0';
					  ns <= s4;
					  counter1 <= "00000";
					  counter2 <= "00000";
					end if;
				  end if;
		when s4 => if(counter1 /= "11111")then
                     output <=  memory_in;
				     counter1 <= counter1 + "1";
				   end if;
					
					
				  
		-- when s4 => for i in 0 to 15 loop
		             -- counter1 <= to_unsigned(i,counter1'length);
				   -- end loop;
	  end case;
	end if;
  end process;
  
  
  -- process(clk)
  -- begin
    -- if(done1 = '1')then
	  -- counter1 <= counter1 + "1";
	  -- if(counter1 = "01111")then
	    
        -- done <= '1';	
      -- end if;
    -- end if;
  -- end process;	
  -- counter1 <= "00000";
  
end behav1;
				   
    
	  
  
  
	  
	  
	