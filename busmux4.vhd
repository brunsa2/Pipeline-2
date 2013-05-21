-- Jeff Stubler
-- 31 May 2011
-- 4 bus multiplexer

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- 4 bus multiplexer entity
-- WIDTH: width of input and output buses
-- d0, d1, d2, d3: input buses to select from
-- s: selection bus for lines 0 to 3
-- y: selected output bus
entity busmux4 is
  generic(
    WIDTH: positive := 32
  );
  port(
    d0, d1, d2, d3: in std_logic_vector(WIDTH-1 downto 0);
    s: in std_logic_vector(1 downto 0);
    y: out std_logic_vector(WIDTH-1 downto 0)
  );
end entity busmux4;

-- 4 bus multiplexer architecture
-- selects on select line to pass through appropriate bus
architecture dataflow of busmux4 is
begin
  with s select
    y <= d0 when "00",
         d1 when "01",
         d2 when "10",
         d3 when "11";
end architecture dataflow;
