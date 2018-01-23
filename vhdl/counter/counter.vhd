library ieee;
use ieee.numeric_bit.all;

entity counter is
  port(clk, start: in bit;
       count: out bit);
end counter;

architecture behav of counter is
signal counter: unsigned(2 downto 0):= (others => '0');
signal count1 : bit := '1';
begin
  process(clk)
  begin
    if(clk'event and clk ='1') then
	  if(start = '1') then
	    counter <= counter + "1";
		
	    if(counter(2) = '1') then
	      counter <= (others => '0');
		  count1 <= not count1;
	    end if;
	  end if;
	end if;
  end process;
  count <= count1;
  
end behav;