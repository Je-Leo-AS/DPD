LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY work;
USE work.Math_Package.ALL;

ENTITY DPD IS
  GENERIC (
    n_signals_used : INTEGER := 2;
    n_polygnos_degree : INTEGER := 2
  );
  PORT (
    reset : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    UR : IN signed(n_bits_resolution DOWNTO 0);
    UI : IN signed(n_bits_resolution DOWNTO 0);
    UR_out : OUT signed(n_bits_resolution DOWNTO 0);
    UI_out : OUT signed(n_bits_resolution DOWNTO 0));
END DPD;

ARCHITECTURE hardware OF DPD IS
  TYPE Array_signals IS ARRAY (0 TO n_signals_used) OF complex_number;
  TYPE Array_signals_overflow IS ARRAY (0 TO n_signals_used) OF complex_number_overflow;
  TYPE Array_signals_powers IS ARRAY (0 TO n_polygnos_degree) OF Array_signals;
  TYPE Array_signals_powers_overflow IS ARRAY (0 TO n_polygnos_degree) OF Array_signals_overflow;
  SIGNAL U_signal_out : complex_number := (reall => 0, imag => 0); -- sinal de saida
  SIGNAL U_signal_in : complex_number := (reall => 0, imag => 0); -- sinal de entrada
  SIGNAL sum : Array_signals := (OTHERS => (reall => 0, imag => 0));
  SIGNAL confusion_matrix : Array_signals_powers := (OTHERS => (OTHERS => (reall => 0, imag => 0)));
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
			confusion_matrix(j + 1) <= confusion_matrix(j);
		END LOOP;
		confusion_matrix(0)(0) <= U_signal_in;
		FOR j IN n_signals_used - 1 DOWNTO 1 LOOP
--			confusion_matrix(j + 1)(j).reall <= confusion_matrix(count_pot)(0).reall * confusion_matrix(count_pot)(0).reall;
--			confusion_matrix(j + 1)(j).imag <= confusion_matrix(count_pot)(0).imag * confusion_matrix(count_pot)(0).imag;
			confusion_matrix(j + 1)(j) <= power(confusion_matrix(j)(j));
		END LOOP;	
	END IF;
  END PROCESS;
  
  
	generate_multiplications: FOR i IN 0 TO n_signals_used - 1 GENERATE
	  signal_generate: FOR j IN 0 TO n_polygnos_degree - 1 GENERATE
		 BEGIN
			multiplic(i)(j) <= multiplication(confusion_matrix(i)(j), coefficients(i * (i + 1) / 2 + j));
	  END GENERATE signal_generate;
	END GENERATE generate_multiplications;
  
  
  calcula_sum_process : PROCESS (clk, reset)
  VARIABLE U_signals_out_temp : complex_number := (reall => 0, imag => 0);

  BEGIN
	IF reset = '1' THEN
		U_signal_out <= (reall => 0, imag => 0);
	ELSIF rising_edge(clk) THEN
		FOR j IN n_signals_used - 1 DOWNTO 1 LOOP
				sum(j + 1) <= sum(j);
		END LOOP;
		sum(0) <= (reall => 0, imag => 0);
		FOR j IN 0 TO n_signals_used - 1 LOOP -- LOOP PARA CALCULAR A SOMA DO ULTIMO SINAL
			sum(0).reall <= sum(0).reall + multiplic(n_signals_used - 1)(j).reall; 
			sum(0).imag <= sum(0).imag + multiplic(n_signals_used - 1)(j).imag;	
			
		END LOOP;
		FOR j IN 0 TO n_signals_used - 1 LOOP -- LOOP PARA CALCULAR A SOMA DO ULTIMO SINAL
			U_signals_out_temp.reall := U_signals_out_temp.reall +  sum(j).reall; 
			U_signals_out_temp.imag := U_signals_out_temp.imag +  sum(j).imag;	
				
		END LOOP;
		U_signal_out <= U_signals_out_temp;
	end if;
  END PROCESS;

END ARCHITECTURE;