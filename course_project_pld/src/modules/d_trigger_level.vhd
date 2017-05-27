library IEEE;
use ieee.std_logic_1164.all;

entity d_trigger_level is
	port(
		D, C: in std_logic;
		Q, notQ: out std_logic);
end entity;

-- D-������� � �������������� �� ������ �����. '1'
architecture d_trigger_level of d_trigger_level is
begin
	
	-- ������� �� ������� ����������������, 
	-- � ������ ������ ��������� ��� ����� �����
	process(D, C) is
		-- ������������� ����� �������� - ��������� ����������
		variable vQ: std_logic;
		
		-- ���� ��������
	begin
		if C = '1' then
			vQ := D;
		end if;
		
		-- ��������� ��������� ������������� ����������
		--  ���������� ���������� �������� �� ����� � ���������
		Q <= vQ; -- after 10 ns;
		notQ <= not vQ; -- after 10 ns;
	end process;
end architecture;