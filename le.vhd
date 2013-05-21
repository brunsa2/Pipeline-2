-- Jeff Stubler
-- 31 May 2011
-- Logic extender unit

-- Logic extender entity
-- s: operation select
-- ai: line A input
-- bi: line B input
-- ao: line A output
entity le is port(
  s: in bit_vector(2 downto 0);
  ai: in bit;
  bi: in bit;
  ao: out bit);
end entity le;

-- Logic extended architecture
-- Based on select line, processes A and B for logic or A for arithmetic
architecture dataflow of le is
begin
  with s select
    ao <= ai when B"001",
          ai when B"010",
          ai when B"011",
          ai and bi when B"100",
          ai or bi when B"101",
          ai nor bi when B"110",
          bi when B"111",
          '0' when others;
end architecture dataflow;
