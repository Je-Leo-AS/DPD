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
  SIGNAL U_signals : Array_signals := (OTHERS => (real => 0, imag => 0));
  SIGNAL U_signal_out : complex_number := (real => 0, imag => 0);
  SIGNAL U_signal_in : complex_number := (real => 0, imag => 0);
BEGIN
  -- Processo que atualiza novos sinais a cada ciclo de clock
  U_signal_in <= (real => to_integer(UR), imag => to_integer(UI));
  process_signal : PROCESS (reset, U_signal_out)
    VARIABLE count_signal : INTEGER RANGE 0 TO n_signals_used := 0;
  BEGIN
    IF reset = '1' THEN
      UR_out <= (OTHERS => '0');
      UI_out <= (OTHERS => '0');
      U_signals <= (OTHERS => (real => 0, imag => 0));
    ELSE
      FOR count_signal IN n_signals_used - 1 DOWNTO 1 LOOP
        U_signals(count_signal) <= U_signals(count_signal - 1);
      END LOOP;
      
      U_signals(0) <= U_signal_in;
      UR_out <= to_signed(U_signal_out.real, UR_out'length);
      UI_out <= to_signed(U_signal_out.imag, UI_out'length);
    END IF;
  END PROCESS;

  -- processo que realiza os calculos e adiciona saida
  calcul_process : PROCESS (clk, reset)
    VARIABLE sum : Array_signals := (OTHERS => (real => 0, imag => 0));
    VARIABLE potencias : Array_signals_powers := (OTHERS => (OTHERS => (real => 0, imag => 0)));
    VARIABLE multiplic : Array_signals_powers_overflow := (OTHERS => (OTHERS => (real => 0, imag => 0)));
    VARIABLE count_signal : INTEGER RANGE 0 TO n_signals_used - 1 := 0;
    VARIABLE count_pot : INTEGER RANGE 0 TO n_polygnos_degree - 1:= 0;
    VARIABLE index : INTEGER RANGE 0 TO n_polygnos_degree *  n_signals_used - 1 := 0;
    VARIABLE U_signals_out_temp : complex_number := (real => 0, imag => 0);
  BEGIN
    IF reset = '1' THEN
      potencias := (OTHERS => (OTHERS => (real => 0, imag => 0)));
      count_signal := 0;
      count_pot := 0;
      U_signal_out <= (real => 0, imag => 0);
    ELSIF rising_edge(clk) THEN
      potencias(count_pot + 1)(0).real := potencias(count_pot)(0).real * potencias(count_pot)(0).real;
      potencias(count_pot + 1)(0).imag := potencias(count_pot)(0).imag * potencias(count_pot)(0).imag;
      FOR j IN 0 TO n_signals_used - 1 LOOP
	index := (j + count_pot) * n_polygnos_degree;
        multiplic(count_pot)(j).real := coefficients(index).real * potencias(count_pot)(j).real - coefficients(index).imag * potencias(count_pot)(j).imag;
        multiplic(count_pot)(j).imag := coefficients(index).imag * potencias(count_pot)(j).real + coefficients(index).real * potencias(count_pot)(j).imag;
        sum(count_pot).real := sum(count_pot).real + multiplic(count_pot)(j).real;
        sum(count_pot).imag := sum(count_pot).imag + multiplic(count_pot)(j).imag;
      END LOOP;
      count_pot := count_pot + 1;
      U_signals_out_temp := (real => 0, imag => 0);
      IF count_pot = n_polygnos_degree THEN
        count_pot := 0;
        FOR k IN 0 TO n_signals_used LOOP
          U_signals_out_temp.real := U_signals_out_temp.real + sum(k).real;
	  U_signals_out_temp.imag := U_signals_out_temp.imag + sum(k).imag;
        END LOOP;
        FOR i IN n_polygnos_degree - 1 DOWNTO 1 LOOP
          potencias(i) := potencias(i - 1);
        END LOOP;
        U_signal_out <= U_signals_out_temp;
      END IF;
    END IF;
  END PROCESS;

END ARCHITECTURE;