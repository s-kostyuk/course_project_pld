library IEEE;
use ieee.std_logic_1164.all;

entity d_tigger_level is
	port(
		D, C: in std_logic;
		Q, notQ: out std_logic);
end entity;

-- D-������� � �������������� �� ������ �����. '1'
architecture d_tigger_level of d_tigger_level is
begin
	
	-- ������� �� ������� ����������������, 
	-- � ������ ������ ��������� ��� ����� �����
	--process(R, S, C, J, K) is
--		-- ������������� ����� �������� - ��������� ����������
--		variable vQ: std_logic;
--		
--		-- ���� ��������
--	begin
--		if R = '0' and S = '0' then
--			-- ����������� ��������� ����������� �����
--			vQ := 'X';
--		elsif R = '0' then
--			-- ����������� ����� � '0'
--			vQ := '0';
--		elsif S = '0' then
--			-- ����������� ��������� � '1'
--			vQ := '1';
--		elsif falling_edge(c) then
--			-- ���������� �����
--			if J = '1' and K = '1' then
--				-- ������������ � ��������������� ���������
--				vQ := not vQ;
--			elsif J = '1' then
--				-- ��������� � 1-��
--				vQ := '1';
--			elsif K = '1' then
--				-- ����� � ����
--				vQ := '0';
--			end if;
--		end if;
--		
--		-- ��������� ��������� ������������� ����������
--		--  ���������� ���������� �������� �� ����� � ���������
--		Q <= vQ after 10 ns;
--		notQ <= not vQ after 10 ns;
--	end process;
end architecture;