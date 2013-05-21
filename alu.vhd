-- Jeff Stubler
-- 31 May 2011
-- ALU without shifter unit

-- ALU entity
-- a: line A of data
-- b: line B of data
-- s: operation select
-- c: carry flag
-- v: overflow flag
-- n: negative flag
-- z: zero flag
-- f: output line of data
entity alu is port(
  a: in bit_vector(31 downto 0);
  b: in bit_vector(31 downto 0);
  s: in bit_vector(2 downto 0);
  c: out bit;
  v: out bit;
  n: out bit;
  z: out bit;
  f: buffer bit_vector(31 downto 0));
end entity alu;

-- ALU architecture
-- connects appropriate blocks together and generates flags
architecture structural of alu is
  signal carry: bit_vector(31 downto 0);
  signal a_le: bit_vector(31 downto 0);
  signal b_ae: bit_vector(31 downto 0);
  
  component fa is port(
    a: in bit;
    b: in bit;
    ci: in bit;
    x: out bit;
    co: out bit);
  end component fa;
  
  component ce is port(
    s: in bit_vector(2 downto 0);
    c: out bit);
  end component ce;

  component ae is port(
    s: in bit_vector(2 downto 0);
    bi: in bit;
    bo: out bit);
  end component ae;

  component le is port(
    s: in bit_vector(2 downto 0);
    ai: in bit;
    bi: in bit;
    ao: out bit);
  end component le;
begin
  ce0: ce port map(s, carry(0));
  ae0: ae port map(s, b(0), b_ae(0));
  le0: le port map(s, a(0), b(0), a_le(0));
  fa0: fa port map(a_le(0), b_ae(0), carry(0), f(0), carry(1));
  
  cascade: for i in 1 to 30 generate
    aei: ae port map(s, b(i), b_ae(i));
    lei: le port map(s, a(i), b(i), a_le(i));
    fai: fa port map(a_le(i), b_ae(i), carry(i), f(i), carry(i+1));
  end generate cascade;
  
  ae31: ae port map(s, b(31), b_ae(31));
  le31: le port map(s, a(31), b(31), a_le(31));
  fa31: fa port map(a_le(31), b_ae(31), carry(31), f(31), c);
  
  v <= carry(30) xor carry(31);
  z <= not (f(0) or f(1) or f(2) or f(3) or
            f(4) or f(5) or f(6) or f(7) or
			f(8) or f(9) or f(10) or f(11) or
			f(12) or f(13) or f(14) or f(15) or
			f(16) or f(17) or f(18) or f(19) or
			f(20) or f(21) or f(22) or f(23) or
			f(24) or f(25) or f(26) or f(27) or
			f(28) or f(29) or f(30) or f(31));
	n <= f(31);
end architecture structural;