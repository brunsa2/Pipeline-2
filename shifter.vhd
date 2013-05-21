-- Jeff Stubler
-- 31 May 2011
-- Shifter unit

-- Shifter entity
-- i: input lines
-- shamt: amount to shift (MSB=0 is left, MSB=1 is right)
-- o: output lines that are shifted
entity shifter is port(
  i: in bit_vector(31 downto 0);
  shamt: in bit_vector(4 downto 0);
  o: out bit_vector(31 downto 0));
end entity shifter;

-- Shifter architecture
-- Selecting from shift amount, concatenates proper bits with proper amount of
-- zeroes
architecture dataflow of shifter is
begin
  with shamt select
    o <= i when B"00000",
         i(30 downto 0) & "0" when B"00001",
		 i(29 downto 0) & "00" when B"00010",
	     i(28 downto 0) & "000" when B"00011",
		 i(27 downto 0) & "0000" when B"00100",
		 i(26 downto 0) & "00000" when B"00101",
		 i(25 downto 0) & "000000" when B"00110",
		 i(24 downto 0) & "0000000" when B"00111",
		 i(23 downto 0) & "00000000" when B"01000",
		 i(22 downto 0) & "000000000" when B"01001",
		 i(21 downto 0) & "0000000000" when B"01010",
		 i(20 downto 0) & "00000000000" when B"01011",
		 i(19 downto 0) & "000000000000" when B"01100",
		 i(18 downto 0) & "0000000000000" when B"01101",
		 i(17 downto 0) & "00000000000000" when B"01110",
		 i(16 downto 0) & "000000000000000" when B"01111",
		 i when B"10000",
		 "0" & i(31 downto 1) when B"10001",
		 "00" & i(31 downto 2) when B"10010",
		 "000" & i(31 downto 3) when B"10011",
		 "0000" & i(31 downto 4) when B"10100",
		 "00000" & i(31 downto 5) when B"10101",
		 "000000" & i(31 downto 6) when B"10110",
		 "0000000" & i(31 downto 7) when B"10111",
		 "00000000" & i(31 downto 8) when B"11000",
		 "000000000" & i(31 downto 9) when B"11001",
		 "0000000000" & i(31 downto 10) when B"11010",
		 "00000000000" & i(31 downto 11) when B"11011",
		 "000000000000" & i(31 downto 12) when B"11100",
		 "0000000000000" & i(31 downto 13) when B"11101",
		 "00000000000000" & i(31 downto 14) when B"11110",
		 "000000000000000" & i(31 downto 15) when B"11111";
end architecture dataflow;