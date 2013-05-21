library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Instruction memory entity
-- addr: 1K selection range address
-- data: 32 bits of data selected from requested address instantly upon address change
entity insmem is
  port(
    addr: in std_logic_vector(9 downto 0);
    data: out std_logic_vector(31 downto 0)
  );
end entity insmem;

-- Instruction memory architecture
-- Constant array stores small program for demonstration purposes and outputs data based on selected line
architecture dataflow of insmem is
  type memoryType is array(2**10-1 downto 0) of std_logic_vector(31 downto 0);
  constant romContents: memoryType := (
    0 => X"34085ac3",
    4 => X"30095ac4",
    8 => X"00000020",
    12 => X"00000020",
    16 => X"00000020",
    20 => X"11000002",
    24 => X"15090001",
    28 => X"1000fff8",
    32 => X"2129ffff",
    36 => X"2129ffff",
    40 => X"2129ffff",
    44 => X"2129ffff",
    48 => X"2129ffff",
    52 => X"2129ffff",
    56 => X"1000ffff",
    others => X"00000000"
  );
begin
  data <= romContents(conv_integer(unsigned(addr)));
end architecture dataflow;