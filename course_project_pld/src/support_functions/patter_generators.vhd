library IEEE;
use ieee.std_logic_1164.all;  

package pattern_generators is
	function checkerboard_code (size : integer) 
	return std_logic_vector;
end pattern_generators;

package body pattern_generators is
	
	function checkerboard_code (size : integer) 
		return std_logic_vector 
	is
		variable result : std_logic_vector(size - 1 downto 0);
		variable temp : std_logic;
	begin
		temp := '1';
		
		for i in 0 to size - 1 loop
			result(i) := temp;
			temp := not temp;
		end loop;
		return result;
	end checkerboard_code;
	
end pattern_generators;




