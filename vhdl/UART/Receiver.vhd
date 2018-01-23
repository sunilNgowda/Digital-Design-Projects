entity Receiver is 
  generic(N: integer := 8)
  port(
  )
end entity;

architecture behav of Receiver is
signal count: unsigned(3 downto 0);
type state is (idle,start,data,stop);
signal ps:state:=idle;
begin
  
  if(start = 0)



end;