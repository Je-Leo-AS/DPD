LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY work;
USE work.Math_Package.ALL;

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
	SIGNAL multiplic : Array_signals_multip := (OTHERS => (OTHERS => (reall => 0, imag => 0)));

BEGIN

	update_signals_process : PROCESS (clk, reset)
	BEGIN
		IF reset = '1' THEN
			U_signal_in <= (reall => 0, imag => 0);
			UR_out <= (OTHERS => '0');
			UI_out <= (OTHERS => '0');
		ELSIF rising_edge(clk) THEN
			U_signal_in <= (reall => to_integer(signed(UR)),
				imag => to_integer(signed(UI)));
			UR_out <= STD_LOGIC_VECTOR(to_signed(U_signal_out.reall, UR_out'length));
			UI_out <= STD_LOGIC_VECTOR(to_signed(U_signal_out.imag, UI_out'length));
		END IF;
	END PROCESS;

	calcula_potencia_process : PROCESS (clk, reset)
		VARIABLE power_matrix_temp : Array_signals_powers := (OTHERS => (OTHERS => (reall => 0, imag => 0)));
	BEGIN
		power_matrix <= power_matrix_temp;
		IF reset = '1' THEN
			power_matrix <= (OTHERS => (OTHERS => (reall => 0, imag => 0)));
		ELSIF rising_edge(clk) THEN
			FOR j IN n_polygnos_degree - 1 DOWNTO 1 LOOP
				power_matrix_temp(j) := power_matrix_temp(j - 1);
			END LOOP;
			power_matrix_temp(0)(0) := U_signal_in;
			FOR j IN n_polygnos_degree - 2 DOWNTO 0 LOOP
				power_matrix_temp(j)(j + 1) := power(power_matrix_temp(j)(j));
			END LOOP;
		END IF;
	END PROCESS;

	att_matrix_process : PROCESS (clk, reset)
		VARIABLE confusion_matrix_temp : Array_signals_multip := (OTHERS => (OTHERS => (reall => 0, imag => 0)));
	BEGIN
		IF reset = '1' THEN
			confusion_matrix <= (OTHERS => (OTHERS => (reall => 0, imag => 0)));
		ELSIF rising_edge(clk) THEN
			confusion_matrix <= confusion_matrix_temp;
			FOR j IN n_signals_used - 1 DOWNTO 1 LOOP
				confusion_matrix_temp(j) := confusion_matrix_temp(j - 1);
			END LOOP;
			confusion_matrix_temp(0) := power_matrix(n_polygnos_degree - 1);
		END IF;
	END PROCESS;
	
	generate_signals_used : FOR i IN confusion_matrix'RANGE GENERATE
		generate_polygons_used : FOR j IN confusion_matrix(i)'RANGE GENERATE
			multiplic(i)(j) <=  multiplication(confusion_matrix(i)(j), coefficients(i * n_polygnos_degree + j));
		END GENERATE generate_polygons_used;
	END GENERATE generate_signals_used;

	sum_process : PROCESS(clk, reset)
	variable vsum : complex_number;
    	BEGIN
		sum_matrix_elements(multiplic, vsum);
		U_signal_out <= vsum;
    	END PROCESS;


END ARCHITECTURE;