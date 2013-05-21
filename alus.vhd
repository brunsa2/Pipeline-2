-- Jeff Stubler
-- 31 May 2011
-- ALU and shifter unit

-- ALU+shifter entity
-- a: line A of data
-- b: line B of data
-- s: operation select
-- shamt: shift amount for output
-- c: carry flag
-- v: overflow flag
-- n: negative flag
-- z: zero flag
-- f: output line of data
entity alus is port(
  a: in bit_vector(31 downto 0);
  b: in bit_vector(31 downto 0);
  s: in bit_vector(2 downto 0);
  shamt: in bit_vector(4 downto 0);
  c: out bit;
  v: out bit;
  n: out bit;
  z: out bit;
  f: buffer bit_vector(31 downto 0));
end entity alus;

-- ALU+shifter architecture
-- Connects ALU structure and shifter entity to all ALU output to be shifted
architecture structural of alus is
  signal alu_out: bit_vector(31 downto 0);
	
  component alu is port(
    a: in bit_vector(31 downto 0);
    b: in bit_vector(31 downto 0);
    s: in bit_vector(2 downto 0);
    c: out bit;
    v: out bit;
    n: out bit;
    z: out bit;
    f: buffer bit_vector(31 downto 0));
  end component alu;
	
  component shifter is port(
    i: in bit_vector(31 downto 0);
    shamt: in bit_vector(4 downto 0);
    o: out bit_vector(31 downto 0));
  end component shifter;
begin
  ALU0: alu port map(a, b, s, c, v, n, z, alu_out);
  SH0: shifter port map(alu_out, shamt, f);
end architecture structural;