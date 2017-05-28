library IEEE;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;

entity tb_mx_n_1 is
end tb_mx_n_1;

architecture tb_mx_n_1 of tb_mx_n_1 is
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
	
	constant A_WIDTH : integer := 3;
	constant D_WIDTH : integer := 2**A_WIDTH;
	constant DELAY : time := 20 ns;
	
	signal A: std_logic_vector(A_WIDTH-1 downto 0);
	signal D: std_logic_vector(D_WIDTH-1 downto 0);
	signal Q: std_logic;
	
begin
	UUT: mx_n_1
	generic map(M => A_WIDTH)
	port map(A => A, D => D, Q => Q);
	
	Address : process is
	begin
		for i in 0 to D_WIDTH-1 loop
		A <= conv_std_logic_vector (i, A_WIDTH);
		
		wait for DELAY*D_WIDTH;
	end loop;
	end process;
	
	Data : process is
	begin
		for i in 0 to 2**A_WIDTH-1 loop
		D <= (others => '0');
		D(i) <= '1';
		
		wait for DELAY;
	end loop;
	end process;
end tb_mx_n_1;

configuration TB_conf_mx_n_1 of tb_mx_n_1 is
	for tb_mx_n_1
		for UUT : mx_n_1
			use entity work.mx_n_1(mx_n_1);
		end for;
	end for;
end TB_conf_mx_n_1;