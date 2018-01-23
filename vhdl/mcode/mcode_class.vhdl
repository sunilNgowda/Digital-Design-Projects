library ieee;
use ieee.numeric_bit.all;
entity mcode_class is
  generic(N:integer:=4);
  port(clk:in bit;
       start:in bit;
       A,B:in unsigned(N-1 downto 0);
       C:out unsigned(2*N-1 downto 0);
       done:out bit);
end entity;
--state|test|next true|next false|load|shift|done|
--3bits|2   |    3    |   3      |  1 |  1  | 1  |

architecture behav of mcode_class is
type t_ucodemem is array (0 to 5) of unsigned(14 downto 0);
signal u_rom:t_ucodemem:=(B"000_00_000_001_0000",
                          B"001_11_010_010_1000",
			              B"010_10_100_011_0000",
			              B"011_11_100_100_0100",
			              B"100_01_010_101_0010",
			              B"101_11_000_001_0001");
signal urom_data:unsigned (14 downto 0);
signal urom_address:unsigned(2 downto 0):="000";
alias test:unsigned(1 downto 0)is urom_data(11 downto 10);
alias nsf:unsigned(2 downto 0)is urom_data(9 downto 7);
alias nst:unsigned(2 downto 0) is urom_data(6 downto 4);
signal test_mux:bit;
signal ns_mux:unsigned (2 downto 0);
signal load,shift,add,k:bit;
signal count:unsigned(1 downto 0);
signal accumulator:unsigned(2*N downto 0);
alias m:bit is accumulator(0);
begin
  test_mux<=start when test="00"
            else k when test="01"
	    else m when test="10"
            else '1' when test="11";
  ns_mux<=nsf when test_mux='0'
          else nst when test_mux='1';
  process(clk)
  begin
    if (clk'event and clk='1')then
      urom_address<=ns_mux;
    end if;
  end process;
  urom_data<=u_rom(to_integer(urom_address));
  c<=accumulator(2*N-1 downto 0);
  load<=urom_data(3);
  add<=urom_data(2);
  shift<=urom_data(1);
  done<=urom_data(0);
  k<='1' when (count="11")else '0';
  process(clk)
  begin
    if(clk'event and clk='1')then
      if(load='1')then
        accumulator(N-1 downto 0)<=B;
        accumulator(2*N downto N )<=(others =>'0');
        count<=(others=>'0');
      elsif(add='1')then
        accumulator(2*N downto N)<="0" & accumulator(2*N-1 downto N)+A;
      elsif(shift='1')then
        accumulator(2*N-1 downto 0)<=accumulator(2*N downto 1);
        accumulator(2*N)<='0';
        count<=count+1;
      end if;
    end if;
  end process;
end behav;

