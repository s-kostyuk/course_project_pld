library ieee;
use ieee.std_logic_1164.all;

entity xor_3state is
	port(x1, x2, nEn: in std_logic;
	y: out std_logic);
end entity;

architecture xor_3state of xor_3state is
begin
	y <= x1 xor x2 when nEn = '0' else 'Z';
end architecture;