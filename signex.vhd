-- Jeff Stubler
-- 31 May 2011
-- Sign extender unit

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Sign extender entity
-- IN_WIDTH: width of original number
-- OUT_WIDTH: width of sign-extended number
-- d: input bus
-- y: output bus
-- en: one enable sign extension, zero to zero-extend
entity signex is
  generic(
    IN_WIDTH: positive := 16;
    OUT_WIDTH: positive := 32
  );
  port(
    d: in std_logic_vector(IN_WIDTH-1 downto 0);
    y: out std_logic_vector(OUT_WIDTH-1 downto 0);
    en: in std_logic
  );
end entity signex;

-- Sign extender architecture
-- On change of input or enable fills output bus with sign- or
-- zero-extended number
architecture behavioural of signex is
begin
  assert(OUT_WIDTH >= IN_WIDTH)
    report "Sign extender output must be same or bigger than input"
    severity FAILURE;
  
  y(IN_WIDTH-1 downto 0) <= d(IN_WIDTH-1 downto 0);
  extend: process(en, d)
  begin
    if en = '1' then
      for i in IN_WIDTH to OUT_WIDTH-1 loop
        y(i) <= d(IN_WIDTH-1);
      end loop;
    else
	  for i in IN_WIDTH to OUT_WIDTH-1 loop
        y(i) <= '0';
      end loop;
    end if;
    --for i in IN_WIDTH to OUT_WIDTH-1 loop
    --  Y(i) <= d(IN_WIDTH-1) when en='0',
    --          '0' whe
  end process extend;
end architecture behavioural;