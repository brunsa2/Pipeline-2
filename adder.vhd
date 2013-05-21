-- Jeff Stubler
-- 31 May 2011
-- Adder unit

-- Adder entity
-- WIDTH: width off inputs and outputs
-- a, b: input numbers
-- f: output number added
--entity adder is
--  generic(
--    WIDTH: positive := 32
--  );
--  port(
--    a, b: in std_logic_vector(WIDTH-1 downto 0);
--    f: out std_logic_vector(WIDTH-1 downto 0)
--  );
--end entity adder;

-- Adder architecture
-- Adds two input buses and outputs result ignoring any overflows
--architecture dataflow of adder is
--begin
--  f <= a + b;
--end architecture dataflow;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- Adder entity
-- WIDTH: width of inputs and outputs
-- a, b: input numbers
-- f: output number added
-- c0: input carry
-- cn: output carry
entity adder is
  generic(
    WIDTH: positive := 32
  );
  port(
    a, b: in std_logic_vector(WIDTH-1 downto 0);
    f: out std_logic_vector(WIDTH-1 downto 0)
  );
end entity adder;

-- Adder architecture
-- Chain of full adders that allows 32 bit arithmetic with carry in and out
architecture structural of adder is
  component fa is
    port(
	  a: in std_logic;
      b: in std_logic;
      ci: in std_logic;
      x: out std_logic;
      co: out std_logic
    );
  end component fa;
  
  signal carry: std_logic_vector(WIDTH-1 downto 1);
  signal carry_out_unused: std_logic;
begin
  FA0: fa port map(a(0), b(0), '0', f(0), carry(1));
  cascade: for i in 1 to WIDTH-2 generate
    FAN: fa port map(a(i), b(i), carry(i), f(i), carry(i+1));
  end generate cascade;
  FAWMO: fa port map(a(WIDTH-1), b(WIDTH-1), carry(WIDTH-1), f(WIDTH-1), carry_out_unused);
end architecture structural;