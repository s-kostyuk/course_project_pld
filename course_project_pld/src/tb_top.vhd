library IEEE;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;
use work.pattern_generators.all;

entity tb_barrel_shifter is
end tb_barrel_shifter;

architecture tb_barrel_shifter of tb_barrel_shifter is
	component barrel_shifter is
		generic(
			M: integer := 3
			);
		port(
			A: in  std_logic_vector(2**M-1 downto 0);
			SHIFT: in  std_logic_vector(M-1 downto 0);
			nLE, nOE, COMPLMTO: in std_logic;
			OUTPUT: out std_logic_vector (2**M-1 downto 0)
			);
	end component;
	
	constant SHIFT_WIDTH : integer := 3;
	constant DATA_WIDTH : integer := 2**SHIFT_WIDTH;
	constant DELAY : time := 20 ns;
	constant DELAY_LOOP : time := DELAY*DATA_WIDTH;
	constant DELAY_LOOP_HALF : time := DELAY_LOOP / 2;
	constant DELAY_LOOP_QUARTER : time := DELAY_LOOP / 4;
	constant CHECKERBOARD_PATTERN : std_logic_vector(DATA_WIDTH-1 downto 0) := 	checkerboard_code(DATA_WIDTH);
	
	signal A: std_logic_vector(DATA_WIDTH-1 downto 0);
	signal SHIFT: std_logic_vector(SHIFT_WIDTH-1 downto 0);
	signal nLE, nOE, COMPLMTO: std_logic;
	signal OUTPUT:  std_logic_vector(DATA_WIDTH-1 downto 0);
	
begin
	UUT: barrel_shifter
	generic map(M => SHIFT_WIDTH)
	port map(A => A, SHIFT => SHIFT, nLE => nLE, nOE => nOE, COMPLMTO => COMPLMTO, OUTPUT => OUTPUT);
	
	SetShift : process is
	begin
		for i in 0 to DATA_WIDTH-1 loop
			SHIFT <= conv_std_logic_vector (i, SHIFT_WIDTH);
			wait for DELAY;
		end loop;
	end process;
	
	SetData : process is
	begin
		A    <= (others => '0');
		A(DATA_WIDTH - 1) <= '1';
		wait for DELAY_LOOP * 2;
		
		A    <= CHECKERBOARD_PATTERN;
		wait for DELAY;
		
		A    <= (others => '0');
		wait for DELAY_LOOP - DELAY;
	end process;
	
	SetOutputEnable : process is
	begin
		nOE <= '0'; wait for DELAY_LOOP * 2 + DELAY_LOOP_QUARTER;
		nOE <= '1';	wait for DELAY_LOOP_QUARTER;
		nOE <= '0'; wait for DELAY_LOOP_HALF;
	end process;
	
	SetLatchEnable : process is
	begin
		nLE <= '0'; wait for DELAY_LOOP * 2 + DELAY / 2;
		nLE <= '1';	wait for DELAY_LOOP - DELAY_LOOP_QUARTER - DELAY / 2;
		nLE <= '0'; wait for DELAY_LOOP_QUARTER;
	end process;
	
	SetCompl : process is
	begin
		COMPLMTO <= '0'; wait for DELAY_LOOP;
		COMPLMTO <= '1'; wait for DELAY_LOOP;
		COMPLMTO <= '0'; wait for DELAY_LOOP;
	end process;
end tb_barrel_shifter;

configuration TB_conf_barrel_shifter of tb_barrel_shifter is
	for tb_barrel_shifter
		for UUT : barrel_shifter
			use entity work.barrel_shifter(barrel_shifter);
		end for;
	end for;
end TB_conf_barrel_shifter;