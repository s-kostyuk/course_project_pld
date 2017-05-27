library IEEE;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;

entity tb_d_trigger_level is
end tb_d_trigger_level;

architecture tb_d_trigger_level of tb_d_trigger_level is
	component d_trigger_level is
		port(
			D, C: in std_logic;
			Q, notQ: out std_logic
			);
	end component;
	
	signal D, C:   std_logic;
	signal Q, notQ : std_logic;
begin
	UUT: d_trigger_level
	port map(D => D, C => C, Q => Q, notQ => NotQ);
	
	Clock : process is
	begin
		C <= '1'; wait for 100 ns;
		C <= '0'; wait for 60 ns;
	end process;
	
	Data : process is
	begin
		D <= '0' ; wait for 10 ns;
		D <= '1' ; wait for 10 ns;
		end process;
end tb_d_trigger_level;

configuration TB_conf_dtrl of tb_d_trigger_level is
	for tb_d_trigger_level
		for UUT : d_trigger_level
			use entity work.d_trigger_level(d_trigger_level);
		end for;
	end for;
end TB_conf_dtrl;