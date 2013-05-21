-- Jeff Stubler
-- 31 May 2011
-- Full Adder

-- Full adder entity
-- a: line A to add
-- b: line B to add
-- cin: carry in bit
-- x: output bit
-- cout: carry out bit
entity fa is port(
  a: in bit;
  b: in bit;
  ci: in bit;
  x: out bit;
  co: out bit);
end entity fa;

-- Full adder architecture
-- Creates carry out and sum out from carry in, a, and b
architecture dataflow of fa is
begin
  with a&b&ci select
    x <= '1' when B"001",
         '1' when B"010",
         '1' when B"100",
         '1' when B"111",
         '0' when others;
  with a&b&ci select
    co <= '1' when B"011",
          '1' when B"101",
          '1' when B"110",
          '1' when B"111",
          '0' when others;
end architecture dataflow;