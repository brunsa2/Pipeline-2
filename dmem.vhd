-- Jeff Stubler
-- dmem.vhdl
-- 13 April 2011

-- Implements a data memory

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- Data memory entity
-- ADDR_LINES: number of address lines (changes number of lines)
-- DATA_WIDTH: width of each address line
entity dmem is
  generic(
    ADDR_LINES: positive := 10;
    DATA_WIDTH: positive := 32
  );
  port(
    addr: in std_logic_vector(ADDR_LINES-1 downto 0);
    w, clk, rst: in std_logic;
    di: in std_logic_vector(DATA_WIDTH-1 downto 0);
    do: out std_logic_vector(DATA_WIDTH-1 downto 0)
  );
end entity dmem;

-- Data memory architecture
-- Behavioural that writes on rising edge
architecture behavioural of dmem is
  type dataMemoryType is array(2**ADDR_LINES-1 downto 0) of std_logic_vector(DATA_WIDTH-1 downto 0);
  signal dataMemory: dataMemoryType;
begin
  writeToMemory: process(w, rst, clk)
  begin
    if rst = '0' then
      for i in 0 to 2**ADDR_LINES-1 loop
		dataMemory(i) <= conv_std_logic_vector(0, DATA_WIDTH);
      end loop;
    elsif w='0' and rising_edge(clk) then
      dataMemory(conv_integer(unsigned(addr))) <= di;
    end if;
  end process writeToMemory;
  
  do <= dataMemory(conv_integer(unsigned(addr)));
end architecture behavioural;