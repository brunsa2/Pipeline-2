-- Jeff Stubler
-- 31 May 2011
-- Shift by 2 unit


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- shift by 2 entity
-- WIDTH: width of input and output buses
-- i: input bus of WIDTH bits
-- o: output bus of WIDTH bits
entity shift2 is
  generic(
    WIDTH: positive := 32
  );
  port(
    a: in std_logic_vector(WIDTH-1 downto 0);
    f: out std_logic_vector(WIDTH-1 downto 0)
  );
end entity shift2;

-- shift by 2 architecture
-- loops through bits to copy them over
architecture behavioural of shift2 is
begin
  shift: process(a)
  begin
    for i in 2 to WIDTH-1 loop
      f(i) <= a(i-2);
    end loop;
    f(0) <= '0';
    f(1) <= '0';
  end process shift;
end architecture behavioural;