-- Jeff Stubler
-- 16 May 2011
-- Pipelined MIPS contoller

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Controller entity
-- opcode: opcode field from instruction
-- shamt: shift amount field from instruction
-- func: function field from instruction
-- ds: decode stage signals (write register select)
-- xs: execute stage signals (shift amount, alu op, alubsel)
-- ms: memory stage signals (branch, brance not equal, memory write)
-- ws: writeback stage signals (register write, data select)
entity pipecu is
  port(
    opcode: in std_logic_vector(5 downto 0);
    shamt: in std_logic_vector(4 downto 0);
    func: in std_logic_vector(5 downto 0);
    
    ds: out std_logic_vector(1 downto 0);
    xs: out std_logic_vector(8 downto 0);
    ms: out std_logic_vector(2 downto 0);
    ws: out std_logic_vector(2 downto 0)
  );
end entity pipecu;

-- Controller architecture
-- Dataflow that finds shift/op from field, then overrides from opcode
architecture dataflow of pipecu is
  signal funcshamt: std_logic_vector(4 downto 0);
  signal funcop: std_logic_vector(2 downto 0);
  signal funcregsel: std_logic_vector(1 downto 0);
  
  signal sx: std_logic;
  signal wregsel: std_logic;
  signal sh: std_logic_vector(4 downto 0);
  signal op: std_logic_vector(2 downto 0);
  signal alubsel: std_logic;
  signal br, bne: std_logic;
  signal wmem, wreg: std_logic;
  signal regsel: std_logic_vector(1 downto 0);
begin
  with func select
    funcshamt <= '0' & shamt(3 downto 0) when "000000",
                 '1' & shamt(3 downto 0) when "000010",
                 "00000" when others;
  
  with func select
    funcop <= "010" when "100000" | "100001",
              "100" when "100100",
              "110" when "100111",
              "101" when "100101",
              "011" when "101010" | "101011",
              "111" when "000000" | "000010",
              "011" when "100010" | "100011",
              "000" when others;
              
  with func select
    funcregsel <= "10" when "101010",
                  "11" when "101011",
                  "00" when others;
            
  with opcode select
    sx <= '1' when "001000" | "001001" | "000100" | "000101" | "100011" | "001010" | "001011" | "101011",
          '0' when others;
                  
  with opcode select
    wregsel <= '0' when "000000",
               '1' when others;
              
  with opcode select
    sh <= funcshamt when "000000",
          "00000" when others;
          
  with opcode select
    op <= funcop when "000000",
          "010" when "001000" | "001001" | "100011" | "101011",
          "011" when "000100" | "000101" | "001010" | "001011",
          "100" when "001100",
          "101" when "001101",
          "000" when others;
          
  with opcode select
    alubsel <= '0' when "000000" | "000100" | "000101",
               '1' when others;
               
  with opcode select
    br <= '0' when "000100" | "000101",
          '1' when others;
          
  with opcode select
    bne <= '1' when "000101",
           '0' when others;
           
  with opcode select
    wmem <= '0' when "101011",
            '1' when others;
            
  with opcode select
    wreg <= '1' when "000100" | "000101" | "101011",
            '0' when others;
            
  with opcode select
    regsel <= funcregsel when "000000",
              "01" when "100011",
              "10" when "001010",
              "11" when "001011",
              "00" when others;
              
  ds <= sx & wregsel;
  xs <= sh & op & alubsel;
  ms <= br & bne & wmem;
  ws <= wreg & regsel;
end architecture dataflow;
  