library IEEE;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;

entity barrel_shifter is
	generic(
		M: integer := 3
		);
	port(
		A: in  std_logic_vector(2**M-1 downto 0);
		SHIFT: in  std_logic_vector(M-1 downto 0);
		nLE, nOE, COMPLMTO: in std_logic;
		OUTPUT: out std_logic_vector (2**M-1 downto 0)
		);
	
	constant N : integer := 2**M;
	
end entity;

architecture barrel_shifter of barrel_shifter is
	component mx_n_1 is
		generic(
			M: integer
			);
		port(
			A: in std_logic_vector(M-1 downto 0);
			D: in std_logic_vector(2**M-1 downto 0);
			Q: out std_logic
			);
	end component;
	
	component d_trigger_level is
		port(
			D, C: in std_logic;
			Q, notQ: out std_logic
			);
	end component;
	
	component xor_3state is
		port(
			x1, x2, nEn: in std_logic;
			y: out std_logic
			);
	end component;
	
	type shifted_data is array (N-1 downto 0) of std_logic_vector(N-1 downto 0);
	
	signal LE        : std_logic;
	signal mx_d      : shifted_data;
	signal mx_q      : std_logic_vector(N-1 downto 0);
	signal latches_q : std_logic_vector(N-1 downto 0);
	signal xor_q     : std_logic_vector(N-1 downto 0);
begin
	LE <= not nLE;
	
	gen_shifted_data:
	 	for i in 0 to N-1 generate
		mx_d(i) <= A(i-1 downto 0) & A(N-1 downto i);
	end generate;
	
	gen_mxs:
		for i in 0 to N-1 generate
		gen_mx : mx_n_1 
		generic map (
			M => M
			)
		port map(
			  D => mx_d(i)
			, A => SHIFT
			, Q => mx_q(i)
			);
	end generate;
	
	gen_latches:
		for i in 0 to N-1 generate
		gen_latch : d_trigger_level 
		port map(
			D => mx_q(i), C => LE, Q => latches_q(i)
			);
	end generate;
	
	gen_xors:
		for i in 0 to N-1 generate
		gen_xor : xor_3state 
		port map(
			x1 => latches_q(i), x2 => COMPLMTO, nEn => nOE, y => xor_q(i)
			);
	end generate;
	
	OUTPUT <= xor_q;
	
end architecture;


