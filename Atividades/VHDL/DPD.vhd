LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY work;
USE work.Math_Package.ALL;

ENTITY DPD IS
  PORT (
    reset : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    UR : IN signed(n_bits_resolution DOWNTO 0);
    UI : IN signed(n_bits_resolution DOWNTO 0);
    UR_out : OUT signed(n_bits_resolution DOWNTO 0);
    UI_out : OUT signed(n_bits_resolution DOWNTO 0));
END DPD;

ARCHITECTURE hardware OF DPD IS
  SIGNAL U_signal_out : complex_number := (reall => 0, imag => 0); -- sinal de saida
  SIGNAL U_signal_in : complex_number := (reall => 0, imag => 0); -- sinal de entrada
  SIGNAL sum : Array_signals := (OTHERS => (reall => 0, imag => 0));
  SIGNAL confusion_matrix, power_matrix : Array_signals_powers := (OTHERS => (OTHERS => (reall => 0, imag => 0)));
  SIGNAL multiplic : Array_signals_powers := (OTHERS => (OTHERS => (reall => 0, imag => 0)));
  signal final_signal: Array_signals := (OTHERS => (reall => 0, imag => 0));
BEGIN
  -- Processo que atualiza novos sinais a cada ciclo de clock
  U_signal_in <= (reall => to_integer(UR), imag => to_integer(UI));
  UR_out <= to_signed(U_signal_out.reall, UR_out'length);
  UI_out <= to_signed(U_signal_out.imag, UI_out'length);
  
  
  calcula_potencia_process : PROCESS (clk, reset)
  BEGIN
	IF reset = '1' THEN
		confusion_matrix <= (OTHERS => (OTHERS => (reall => 0, imag => 0)));
	 ELSIF rising_edge(clk) THEN
		FOR j IN n_signals_used - 1 DOWNTO 1 LOOP
			power_matrix(j + 1) <= power_matrix(j);
		END LOOP;
		power_matrix(0)(0) <= U_signal_in;
		FOR j IN n_signals_used - 1 DOWNTO 1 LOOP
			power_matrix(j)(j+1) <= power(power_matrix(j)(j));
		END LOOP;
		FOR j IN n_signals_used - 1 DOWNTO 1 LOOP
			confusion_matrix(j + 1) <= confusion_matrix(j);
		END LOOP;
		confusion_matrix(0) <= power_matrix(n_signals_used - 1);
	END IF;
  END PROCESS;
  
  
	generate_signals_used: FOR i IN 0 TO n_signals_used - 1 GENERATE
	  generate_polygons_used: FOR j IN 0 TO n_polygnos_degree - 1 GENERATE
		 BEGIN
			multiplic(i)(j) <= multiplication(confusion_matrix(i)(j), coefficients(i * n_polygnos_degree + j));
	  END GENERATE generate_polygons_used;
	END GENERATE generate_signals_used;
  
  
  calcula_sum_process : PROCESS (clk, reset)
  VARIABLE U_signals_out_temp : complex_number := (reall => 0, imag => 0);

  BEGIN
	IF reset = '1' THEN
		sum <= (OTHERS => (reall => 0, imag => 0));
		U_signal_out <= (reall => 0, imag => 0);
	ELSIF rising_edge(clk) THEN
		FOR i IN 0 TO n_signals_used - 1 LOOP
				sum(i) <= sum_array(multiplic(i));
		END LOOP;
		U_signal_out <= sum_array(sum);
	end if;
  END PROCESS;
  

  

END ARCHITECTURE;