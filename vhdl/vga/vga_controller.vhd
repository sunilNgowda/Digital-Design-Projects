
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_bit.all;
entity vga_sync is
   port(
      clk, reset: in bit;
      hsync, vsync: out bit;
      video_on:buffer bit; 
      
     --pixel_x, pixel_y: out unsigned (9 downto 0);
	  vgaRed:out unsigned(3 downto 0);
	  vgaGreen:out unsigned(3 downto 0);
	 vgaBlue:out unsigned(3 downto 0)
	  );
end vga_sync;
architecture arch of vga_sync is
   
   constant HD: integer:=640; 
   constant HF: integer:=16 ;
   constant HB: integer:=16 ;
   constant HR: integer:=128; 
   constant VD: integer:=480;
   constant VF: integer:=10;
   constant VB: integer:=29;  
   constant VR: integer:=2;

 
   signal clk_25: bit:='0';
   signal counter:unsigned(2 downto 0);

   signal v_count_reg: unsigned(9 downto 0);
   signal h_count_reg: unsigned(9 downto 0);
   
   signal v_sync_reg, h_sync_reg:bit;


   signal h_end, v_end: bit;
begin
    process (clk)
    begin 
        if(clk'event and clk='1')then
            counter <= counter + 1;
            if (counter(2)='1') then
                clk_25<=not clk_25;
                counter<="000";
            end if;
    end if;
    
    end process;

   process (clk,reset)
   begin
      if(clk'event and clk='1')then
        if reset='1' then
		
		  v_count_reg <="0000000000";
		  h_count_reg <="0000000000";
		  v_sync_reg <= '0';
		  h_sync_reg <= '0';
    
        end if;
      else
        v_count_reg <=v_count_reg;
        h_count_reg <=h_count_reg;
        v_sync_reg <=v_sync_reg;
        h_sync_reg <= h_sync_reg;
      end if;    
   end process;
   --process(clk)
   --begin
   --if( clk'event and clk='1') then
      --clk_50<= not clk;
   --end if;
    
    --if (clk_50'event and clk_50='1') then
        --clk_25<=not clk_50;
     --end if;
    --end process;
   

   

   process (clk_25,reset)
   begin
	  
	  
      if (clk_25'event and clk_25='1') then 
         if h_end='1' then
            h_count_reg <="0000000000";
         else
            h_count_reg<= h_count_reg + 1;
         end if;
      
      end if;
   end process;
   

   process (clk_25,reset,h_end,v_end)
   begin
	  
      if (clk_25'event and clk_25='1') and h_end='1' then
         if (v_end='1') then
            v_count_reg <="0000000000";
         else
            v_count_reg<= v_count_reg+ 1;
        end if;
      
      end if;
   end process;
   
   h_end <= '1' when h_count_reg = (HD+HF+HB+HR-1) else  '0';
   v_end <= '1' when v_count_reg = (VD+VF+VB+VR-1) else '0';
   
   h_sync_reg <='1' when (h_count_reg>=(HD+HF)) and (h_count_reg<=(HD+HF+HR-1)) else '0';
   v_sync_reg <='1' when (v_count_reg>=(VD+VF)) and (v_count_reg<=(VD+VF+VR-1)) else '0';
   
   video_on <='1' when (h_count_reg<HD) and (v_count_reg<VD) else'0';
   
  
   hsync <= h_sync_reg;
   vsync <= v_sync_reg;
  -- pixel_x <= h_count_reg;
  --pixel_y <= v_count_reg;
   
   
   process (clk_25)
   begin
	if video_on='1' then
		vgaRed<="1111";
		vgaGreen<="0000";
		vgaBlue<="0000";
	else
		vgaRed<="0000";
		vgaGreen<="0000";
		vgaBlue<="0000";
	end if;
	
   end process;
end arch;
