library IEEE;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;

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
			OUTPUT: out std_logic_vector (7 downto 0)
			);
	end component;
	
	constant SHIFT_WIDTH : integer := 3;
	constant DATA_WIDTH : integer := 2**SHIFT_WIDTH;
	constant DELAY : time := 20 ns;
	
	signal A: std_logic_vector(DATA_WIDTH-1 downto 0);
	signal SHIFT: std_logic_vector(SHIFT_WIDTH-1 downto 0);
	signal nLE, nOE, COMPLMTO: std_logic;
	signal OUTPUT:  std_logic_vector(DATA_WIDTH-1 downto 0);
	
begin
	UUT: barrel_shifter
	generic map(M => SHIFT_WIDTH)
	port map(A => A, SHIFT => SHIFT, nLE => nLE, nOE => nOE, COMPLMTO => COMPLMTO, OUTPUT => OUTPUT);
	
	SetData : process is
	begin
		for i in 0 to DATA_WIDTH-1 loop
			A    <= (others => '0');
			A(i) <= '1';
			
			wait for DELAY;
		end loop;
	end process;
	
	SetOutputEnable : process is
	begin
		for i in 0 to DATA_WIDTH-1 loop
			OE <= not OE;
			
			wait for DELAY*DATA_WIDTH;
		end loop;
	end process;
	
	SetLatchEnable : process is
	begin
		for i in 0 to DATA_WIDTH-1 loop
			--A <= conv_std_logic_vector (i, SHIFT_WIDTH);
			
			wait for DELAY*DATA_WIDTH;
		end loop;
	end process;
	
	SetCompl : process is
	begin
		for i in 0 to DATA_WIDTH-1 loop
			--A <= conv_std_logic_vector (i, SHIFT_WIDTH);
			
			wait for DELAY*DATA_WIDTH;
		end loop;
	end process;
	
	SetShift : process is
	begin
		for i in 0 to DATA_WIDTH-1 loop
			--A <= conv_std_logic_vector (i, SHIFT_WIDTH);
			
			wait for DELAY*DATA_WIDTH;
		end loop;
	end process;
	
	
end tb_barrel_shifter;

configuration TB_conf_barrel_shifter of tb_barrel_shifter is
	for tb_barrel_shifter
		for UUT : barrel_shifter
			use entity work.barrel_shifter(barrel_shifter);
		end for;
	end for;
end TB_conf_barrel_shifter;