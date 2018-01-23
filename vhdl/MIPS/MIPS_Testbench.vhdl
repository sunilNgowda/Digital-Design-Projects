library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MIPS_Testbench is
end MIPS_Testbench;


architecture test of MIPS_Testbench is
  component MIPS is
    port(clk,rst:in std_logic;
	     cs,we:out std_logic;
		 addr:out unsigned (31 downto 0);
		 Mem_Bus:inout unsigned(31 downto 0));
  end component;
  component Memory is
    port(cs,we,clk:in std_logic;
	     addr:in unsigned(31 downto 0);
		 Mem_Bus:inout unsigned(31 downto 0));
  end component;
  constant N: integer := 8;
  constant W: integer := 26;
  type Iarr is array (1 to W ) of unsigned (31 downto 0);
  constant Instr_List: Iarr := (
  x"30000000",
  x"20010006",
  x"34020012",
  x"00221820",
  x"00412022",
  x"00222824",
  x"00223025",
  x"0022382A",
  x"00024100",
  x"00014842",
  x"10220001",
  x"8C0A0004",
  x"14220001",
  x"30210000",
  x"08000010",
  x"30420000",
  x"00400008",
  x"30630000",
  x"AC030040",
  x"AC040041",
  x"AC040042",
  x"AC040043",
  x"AC040044",
  x"AC040045",
  x"AC040046",
  x"AC040047");
  type output_arr is array (1 to N) of integer;
  constant expected : output_arr := (24,12,2,22,1,288,3,4268066);
  signal cs,we,clk: std_logic := '0';
  signal Mem_Bus, address,addresstb,address_mux: unsigned(31 downto 0);
  signal rst,init,we_mux,cs_mux,we_tb,cs_tb:std_logic;
begin
  CPU:MIPS port map(clk,rst,cs,we,address,Mem_Bus);
  MEM:Memory port map(cs_mux,we_mux,clk,address_mux,Mem_Bus);
  clk <= not clk after 10 ns;
  address_mux <= addresstb when init = '1' else address;
  we_mux <= we_tb when init = '1' else we;
  cs_mux <= cs_tb when init = '1' else cs;
  process
  begin
    rst <= '1';
	wait until clk'event and clk = '1';
	init <= '1';
	cs_tb <= '1'; we_tb <= '1';
	for i in 1 to W loop
	  wait until clk ='1' and clk'event;
	  addresstb <= to_unsigned(i-1,32);
	  Mem_Bus <= Instr_List(i);
	end loop;
	wait until clk = '1' and clk'event;
	Mem_Bus <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
	cs_tb <= '0'; we_tb <= '0';
	init <= '0';
	wait until clk = '1' and clk'event;
	rst <= '0';
	for i in 1 to N loop
	  wait until we = '1' and we'event;
      wait until clk = '0' and clk'event;
      assert(to_integer(Mem_Bus) = expected(i));
        report "output mismatch:" severity error;
    end loop;
    report"testing finished:";
  end process;
end test;  
  
	