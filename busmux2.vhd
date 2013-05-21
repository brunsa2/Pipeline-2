-- Jeff Stubler
-- 4 May 2011
-- 2 bus multiplexer

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- 2 bus multiplexer entity
-- WIDTH: width of input and output buses
-- d0, d1: input buses to select from
-- s: selection for buses 0 or 1
-- y: selected output bus

entity busmux2 is
  generic(
    WIDTH: positive := 32
  );
  port(
    d0, d1: in std_logic_vector(WIDTH-1 downto 0);
    s: in std_logic;
    y: out std_logic_vector(WIDTH-1 downto 0)
  );
end entity busmux2;

-- 2 bus multiplexer architecture
-- selects on select line to pass through appropriate bus

architecture dataflow of busmux2 is
begin
  with s select
    y <= d0 when '0',
         d1 when '1';
end architecture dataflow;