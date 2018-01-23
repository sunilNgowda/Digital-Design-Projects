library ieee;
use ieee.numeric_bit.all;

entity ALU is
  port(A,B:in unsigned(31 downto 0);
       op:in unsigned(2 downto 0);
	   flag:out unsigned(3 downto 0);
	   carry:out bit;
	   result:out unsigned(31 downto 0));
end entity;

architecture test of ALU is
signal out1:unsigned(32 downto 0);
begin
  process(op)
  begin
    case op is 
    when"000" =>
      out1<= '0' & A and B;
    when "001" =>
      out1<='0' & A or B;
    when "010"=>
      out1<='0' & A + B;
    when "011"=>
      out1 <= '0' & A - B;
	when "100"=>
      out1<= '0' & shift_right(A,to_integer(B));
    when "101"=>
      out1<= '0' & shift_left(A,to_integer(B));
	when others =>  out1 <= (others=>'0');
  end case;
  end process;
  flag(0) <= '1' when (out1 = "0" ) else '0';
  flag(3 downto 1) <= (others => '0');
  result <= out1(31 downto 0);
  carry <= out1 (32);
end test;