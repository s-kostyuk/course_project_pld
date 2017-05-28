library IEEE;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;

entity tb_xor_3state is
end tb_xor_3state;

architecture tb_xor_3state of tb_xor_3state is
	component xor_3state is
		port(x1, x2, nEn: in std_logic;
		y: out std_logic);
	end component;
	
	signal x1, x2:   std_logic;
	signal nEn : std_logic;
	signal y : std_logic;
	
begin
	UUT: xor_3state
	port map(x1 => x1, x2 => x2, nEn => nEn, y => y );
	
	En : process is
	begin
		nEn <= '0'; wait for 80 ns;
		nEn <= '1'; wait for 80 ns;
	end process;
	
	Data : process is
	begin
		x1 <= '0' ; x2 <= '0' ; wait for 20 ns;
		x1 <= '0' ; x2 <= '1' ; wait for 20 ns;
		x1 <= '1' ; x2 <= '0' ; wait for 20 ns;
		x1 <= '1' ; x2 <= '1' ; wait for 20 ns;
	end process;
end tb_xor_3state;

configuration TB_conf_xor_3state of tb_xor_3state is
	for tb_xor_3state
		for UUT : xor_3state
			use entity work.xor_3state(xor_3state);
		end for;
	end for;
end TB_conf_xor_3state;