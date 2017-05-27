library IEEE;
use ieee.std_logic_1164.all;

entity barrel_shifter is
	port(
		A: in  std_logic_vector(7 downto 0);
		SHIFT: in  std_logic_vector(2 downto 0);
		nLE, nOE, COMPLMT0: in std_logic;
		OUTPUT: out std_logic_vector (7 downto 0)
		);
end entity;


