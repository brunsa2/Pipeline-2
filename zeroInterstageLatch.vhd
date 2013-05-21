-- Jeff Stubler
-- 11 May 2011
-- Interstage latch definition that outputs 0 rather than 1 on flush (for PC)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Interstage latch entity
-- WIDTH: number of bits in latch
-- d: Input values
-- q: Output values
-- rst, clk: reset amd clock (works on falling edge, resets to 1)
-- flush, stall: flush pipeline stage by passing 1, stall by preventing new value latching in

entity zeroInterstageLatch is
  generic(
    WIDTH: positive := 32
  );
  port(
    d: in std_logic_vector(WIDTH-1 downto 0);
    q: out std_logic_vector(WIDTH-1 downto 0);
    rst, clk: in std_logic;
    flush, stall: in std_logic
  );
end entity zeroInterstageLatch;

-- Interstage latch entity
-- On falling edge transmits value unless stall, sends value or 1 if flush
architecture behavioural of zeroInterstageLatch is
  signal shouldStall: std_logic;
begin
  interstageLatch: process(clk, rst, shouldStall)
  begin
    if rst = '0' then
      q <= conv_std_logic_vector(0, WIDTH);
    elsif shouldStall = '1' and falling_edge(clk) then
      if flush = '1' then
        q <= d;
      else
        q <= conv_std_logic_vector(0, WIDTH);
      end if;
    end if;
  end process interstageLatch;
  
  staller: process(clk, rst, stall)
  begin
    if rst = '0' then
      shouldStall <= '0';
    elsif rising_edge(clk) then
      shouldStall <= stall;
    end if;
  end process staller;
end architecture behavioural;