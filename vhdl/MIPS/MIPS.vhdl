library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MIPS is
  port(clk,rst:in std_logic;
       cs,we:out std_logic;
	   addr:out unsigned(31 downto 0);
	   Mem_Bus:inout unsigned(31 downto 0));
end MIPS;

architecture structure of MIPS is
  component REG is
    port(CLK:in std_logic;
         RegW:in std_logic;
	     DR,SR1,SR2:in unsigned(4 downto 0);
	     Reg_In:in unsigned(31 downto 0);
	     ReadReg1,ReadReg2:out unsigned(31 downto 0));
  end component;
  type operation is (and1,or1,add,sub,slt,shr,shl,jr);
  signal Op,OpSave:operation:=and1;
  type instr_format is(R,I,J);
  signal Format:instr_format:=R;
  signal Instr,Imm_Ext:unsigned(31 downto 0);
  signal PC,nPC,ReadReg1,ReadReg2,Reg_In:unsigned(31 downto 0);
  signal alu_ina,alu_inb,alu_result:unsigned(31 downto 0);
  signal alu_Result_save:unsigned(31 downto 0);
  signal ALUorMEM,RegW,FetchdorI,writing,REGorIMM:std_logic:='0';
  signal REGorIMM_save,ALUorMEM_save:std_logic:='0';
  signal DR:unsigned(4 downto 0);
  signal State,nState:integer range 0 to 4:=0;
  constant addi:unsigned(5 downto 0):="001000"; --8
  constant andi:unsigned(5 downto 0):="001100"; --12
  constant ori:unsigned(5 downto 0):="001101"; --13
  constant lw:unsigned(5 downto 0):="100011"; --35
  constant sw:unsigned(5 downto 0):="101011"; --43
  constant beq:unsigned(5 downto 0):="000100"; --4
  constant bne:unsigned(5 downto 0):="000101"; --5
  constant jump:unsigned(5 downto 0):="000010"; --2
  alias opcode:unsigned(5 downto 0) is Instr(31 downto 26);
  alias SR1:unsigned(4 downto 0) is Instr(25 downto 21);
  alias SR2:unsigned(4 downto 0) is Instr(20 downto 16);
  alias F_Code:unsigned(5 downto 0) is Instr(5 downto 0);
  alias NumShift:unsigned(4 downto 0) is Instr(10 downto 6);
  alias ImmField:unsigned(15 downto 0) is Instr(15 downto 0);
begin
  A1:REG port map(clk,RegW,DR,SR1,SR2,Reg_In,ReadReg1,ReadReg2);
  Imm_Ext <= x"FFFF" & Instr(15 downto 0) when Instr(15)='1'
    else x"0000" & Instr(15 downto 0);
  DR<=Instr(15 downto 11) when Format=R
    else Instr(20 downto 16);
  alu_ina <= ReadReg1;
  alu_inb <= Imm_Ext when REGorIMM_save='1' 
    else ReadReg2;
  Reg_In<=Mem_Bus when ALUorMEM_save='1' 
    else  alu_Result_save;
  Format<=R when opcode=0 else J when opcode=2 else I;
  Mem_Bus<=ReadReg2 when writing = '1' else
    "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
  addr <= PC when FetchdorI = '1' else alu_Result_save;
  process(State,PC,Instr,Format,F_Code,opcode,Op,alu_ina,alu_inb,Imm_Ext)
  begin
    FetchdorI<='0';cs<='0';we<='0';RegW<='0';writing<='0';
    alu_result<="00000000000000000000000000000000";
    nPC <= PC; Op <= jr; REGorIMM <= '0'; ALUorMEM <= '0';
    case state is
      when 0 => 
        nPC <= PC + 1; cs <= '1'; nState <= 1;
        FetchdorI <= '1';
      when 1 =>
        nState <= 2; REGorIMM <= '0'; ALUorMEM <= '0';
        if Format = J then
          nPC <= "000000" & Instr(25 downto 0); nState <= 0;
        elsif Format = R then
          if F_Code="100000" then Op <= add;

		  elsif F_Code="100010" then Op <= sub;
		  elsif F_Code="100100" then Op <= and1;
		  elsif F_Code="100101" then Op <= or1;
		  elsif F_Code="101010" then Op <= slt;
		  elsif F_Code="000010" then Op <= shr;
		  elsif F_Code="000000" then Op <= shl;
		  elsif F_Code="001000" then Op <= jr;
		  end if;
		elsif Format = I then
		  REGorIMM <= '1';
		  if opcode = lw or opcode = sw or opcode = addi then Op <= add;
		  elsif opcode = beq or opcode = bne then Op <= sub; REGorIMM <= '0';
		  elsif opcode = andi then Op <= and1;
		  elsif opcode = ori then Op <= or1;
		  end if;
		  if opcode = lw then ALUorMEM <= '1'; end if;
		end if;
      when 2 =>
	    nState <= 3;
		if OpSave = and1 then alu_result <= alu_ina and alu_inb;
		elsif OpSave = or1 then alu_result <= alu_ina or alu_inb;
		elsif OpSave = add then alu_result <= alu_ina + alu_inb;
		elsif OpSave = sub then alu_result <= alu_ina - alu_inb;
		elsif OpSave = shr then alu_result <= alu_inb srl to_integer(NumShift);
		elsif OpSave = shl then alu_result <= alu_inb sll to_integer(NumShift);
		elsif OpSave = slt then 
		  if alu_ina < alu_inb then alu_result <= X"00000001";
		  else alu_result <= X"00000000";
		  end if;
		end if;
		if ((alu_ina = alu_inb) and opcode = beq) or 
		   ((alu_ina /= alu_inb)and  opcode= bne) then
		   nPC <= PC + Imm_Ext; nState <= 0;
		elsif opcode = bne or opcode = beq then nState <= 0;
		elsif OpSave = jr then nPC <= alu_ina; nState <= 0;
		end if;
      when 3 =>
	    nState <= 0;
		if Format = R or opcode = addi or opcode = andi or opcode = ori then 
		  RegW <= '1';
		elsif opcode = sw then cs <= '1' ; we <= '1' ; writing <= '1';
		elsif opcode = lw then cs <= '1' ; nState <= 4;
		end if;
	  when 4 =>
	    nState <= 0; cs <='1';
		if opcode =lw then RegW <= '1' ; end if;
	end case;
  end process;
  
  process(clk)
  begin
	if clk='1' and clk'event then
	  if rst = '1' then
		state <= 0;
		PC <= X"00000000";
      else
		state <= nState;
		PC <= nPC;
	  end if;
	  if state= 0 then Instr <= Mem_Bus; end if;
	  if state = 1 then 
		OpSave <= Op;
		REGorIMM_save <= REGorIMM;
		ALUorMEM_save <= ALUorMEM;
	  end if;
	  if state = 2 then alu_Result_save <= alu_result; end if;
    end if;
  end process;
end structure;
	 
	
	    
		  
		  
  