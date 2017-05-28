library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity mx_n_1 is
	generic(
		N: integer
		);
	port(
		A: in std_logic_vector(N-1 downto 0);
		D: in std_logic_vector(2**N-1 downto 0);
		Q: out std_logic
		);
end entity;

architecture mx_n_1 of mx_n_1 is
	signal index: integer := 0;
	signal sQ: std_logic;
begin
	index <= conv_integer(A);
	sQ <= D(index);
	
	Q <= sQ; --after 10 ns;
end architecture;