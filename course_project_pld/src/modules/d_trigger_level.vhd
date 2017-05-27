library IEEE;
use ieee.std_logic_1164.all;

entity d_trigger_level is
	port(
		D, C: in std_logic;
		Q, notQ: out std_logic);
end entity;

-- D-триггер с синхронизацией по уровню логич. '1'
architecture d_trigger_level of d_trigger_level is
begin
	
	-- Процесс со списком чувствительности, 
	-- в списке обычно указывают все входы схемы
	process(D, C) is
		-- декларативная часть процесса - объявляем переменные
		variable vQ: std_logic;
		
		-- Тело процесса
	begin
		if C = '1' then
			vQ := D;
		end if;
		
		-- Последние операторы параллельного назначения
		--  выставляют полученное значение на выход с задержкой
		Q <= vQ; -- after 10 ns;
		notQ <= not vQ; -- after 10 ns;
	end process;
end architecture;