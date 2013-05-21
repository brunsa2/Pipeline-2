-- Jeff Stubler
-- 31 May 2011
-- Carry extender unit

-- Carry extender entity
-- s: operation select
-- c: carry into the lowest carry in in the ripple adder (1 for subtraction)
entity ce is port(
  s: in bit_vector(2 downto 0);
  c: out bit);
end entity ce;

-- Carry extender architecture
-- When subtract operation is detected, carry in to LSB of ripple adder is
-- turned on
architecture dataflow of ce is
begin
  with s select
    c <= '1' when B"011",
         '0' when others;
end architecture dataflow;