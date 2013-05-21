-- Jeff Stubler
-- 31 May 2011
-- Register file unit

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Register file entity
-- R0 is always 0
-- ADRR_WIDTH: number of bits for address (changes number of registers)
-- DATA_WIDTH: width of each storage register
-- raddr0, raddr1: register buses to read to outputs
-- rwaddr: register to write to
-- rwdata: new data for register
-- r0, r1: output buses for selected registers
-- w: active low write
-- rst: active low reset of all registers
-- clk: clock (samples on falling edge)
entity regfile is
  generic(
    ADDR_WIDTH: positive := 5;
    DATA_WIDTH: positive := 32
  );
  port(
    raddr0, raddr1, rwaddr: in std_logic_vector(ADDR_WIDTH-1 downto 0);
    rwdata: in std_logic_vector(DATA_WIDTH-1 downto 0);
    r0, r1: out std_logic_vector(DATA_WIDTH-1 downto 0);
    w, rst, clk: in std_logic
  );
end entity regfile;

-- Register file architecture
-- R0 is always 0
-- Asynch active low reset of all registers
-- Synch on clock falling edge write if enabled
-- Parallel access of two selected registers for reading
architecture behavioural of regfile is
  type registerMemoryType is array(2**ADDR_WIDTH-1 downto 0) of std_logic_vector(DATA_WIDTH-1 downto 0);
  signal registerMemory: registerMemoryType;
begin
  registerFileWrite: process(rst, w, clk)
  begin
    if rst = '0' then
      for registerLine in 0 to 2**ADDR_WIDTH-1 loop
        registerMemory(registerLine) <= conv_std_logic_vector(0, DATA_WIDTH);
      end loop;
    elsif rising_edge(clk) then
      if w = '0' and conv_integer(unsigned(rwaddr)) > 0 then
        registerMemory(conv_integer(unsigned(rwaddr))) <= rwdata;
      end if;
    end if;
  end process registerFileWrite;
  
  r0 <= registerMemory(conv_integer(unsigned(raddr0)));
  r1 <= registerMemory(conv_integer(unsigned(raddr1)));
  
end architecture behavioural;
