-- Jeff Stubler
-- 31 May 2011
-- Arithmetic extender unit

-- Arithmetic extender entity
-- s: operation select
-- bi: line B input
-- bo: line B out
entity ae is port(
  s: in bit_vector(2 downto 0);
  bi: in bit;
  bo: out bit);
end entity ae;

-- Arithmetic extender architecture
-- Receives b line, prepares for addition, subtraction, and logic
architecture dataflow of ae is
begin
  with s select
    bo <= bi when B"010",
          not bi when B"011",
          '0' when others;
end architecture dataflow;