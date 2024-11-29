LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY work;
USE work.functions.ALL;

ENTITY DPD IS
	PORT (
		reset : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		UR : IN STD_LOGIC_VECTOR(n_bits_resolution - 1 DOWNTO 0);
		UI : IN STD_LOGIC_VECTOR(n_bits_resolution - 1 DOWNTO 0);
		UR_out : OUT STD_LOGIC_VECTOR(n_bits_resolution - 1 DOWNTO 0);
		UI_out : OUT STD_LOGIC_VECTOR(n_bits_resolution - 1 DOWNTO 0));

END DPD;

ARCHITECTURE hardware OF DPD IS
	SIGNAL U_signal_out : complex_number := (reall => 0, imag => 0);
	SIGNAL U_signal_in : complex_number := (reall => 0, imag => 0);
	SIGNAL power_matrix : Array_signals_powers := (OTHERS => (OTHERS => (reall => 0, imag => 0)));
	SIGNAL confusion_matrix : Array_signals_multip := (OTHERS => (OTHERS => (reall => 0, imag => 0)));
	SIGNAL multi, multiplic_temp : Array_signals_multip := (OTHERS => (OTHERS => (reall => 0, imag => 0)));

BEGIN

	calcula_potencia_process : PROCESS (clk, reset, U_signal_in)
		VARIABLE power_matrix_temp : Array_signals_powers;
	BEGIN
		IF reset = '1' THEN
			-- Inicializa a matriz em zero apenas uma vez no reset
			power_matrix_temp := (OTHERS => (OTHERS => (reall => 0, imag => 0)));
		ELSIF rising_edge(clk) THEN
			-- Atualiza a saída com o último elemento
			U_signal_in <= (reall => to_integer(signed(UR)),
				imag => to_integer(signed(UI)));
			power_matrix_temp(0)(0) := U_signal_in;
			-- Shift das fileiras para baixo, excluindo a última fileira
			FOR j IN n_polygnos_degree - 1 DOWNTO 1 LOOP
				power_matrix_temp(j) := power_matrix_temp(j - 1);
				power_matrix_temp(j)(j) := power(power_matrix_temp(j)(j - 1));
			END LOOP;
		END IF;
		power_matrix <= power_matrix_temp;
	END PROCESS;

	att_matrix_process : PROCESS (clk, reset, power_matrix)
		-- Processo que calcula a a matriz de extração
		VARIABLE confusion_matrix_temp : Array_signals_multip;
	BEGIN
		IF reset = '1' THEN
			confusion_matrix_temp := (OTHERS => (OTHERS => (reall => 0, imag => 0)));
		ELSIF rising_edge(clk) THEN
			confusion_matrix <= confusion_matrix_temp;
			-- registra sinal da matriz de confusÃ£o
			FOR j IN n_signals_used - 1 DOWNTO 1 LOOP
				confusion_matrix_temp(j) := confusion_matrix_temp(j - 1);
			END LOOP;
			confusion_matrix_temp(0) := power_matrix(n_polygnos_degree - 1);
			-- adiciona ultma linha da matriz de potência a primeira linha da matriz de confusÃ£o
		END IF;
	END PROCESS;
	generate_signals_used : FOR i IN confusion_matrix'RANGE GENERATE
		generate_polygons_used : FOR j IN confusion_matrix(i)'RANGE GENERATE
			multiplic_temp(i)(j) <= multiplication(confusion_matrix(i)(j), coefficients(j + i * n_signals_used));
			-- realiza a multiplicação de termo em blocos
		END GENERATE generate_polygons_used;
	END GENERATE generate_signals_used;

	multi_matrix_process : PROCESS (clk, reset, multiplic_temp)
		-- Processo que calcula a a matriz de extração
	BEGIN
		IF reset = '1' THEN
			multi <= (OTHERS => (OTHERS => (reall => 0, imag => 0)));
		ELSIF rising_edge(clk) THEN
			multi <= multiplic_temp;
		END IF;
	END PROCESS;

	sum_process : PROCESS (clk, reset, multi)
		VARIABLE real_sum, imag_sum : INTEGER := 0;
	BEGIN
		IF reset = '1' THEN
			U_signal_out <= (reall => 0, imag => 0);
		ELSIF rising_edge(clk) THEN
			real_sum := 0;
			imag_sum := 0;
			FOR i IN multi'RANGE LOOP
				FOR j IN multi(i)'RANGE LOOP
					-- Soma as partes reais e imaginarias
					real_sum := real_sum + multi(i)(j).reall;
					imag_sum := imag_sum + multi(i)(j).imag;
				END LOOP;
			END LOOP;
			UR_out <= STD_LOGIC_VECTOR(to_signed(real_sum, UR_out'length));
			UI_out <= STD_LOGIC_VECTOR(to_signed(imag_sum, UI_out'length));
		END IF;
	END PROCESS;
END ARCHITECTURE;