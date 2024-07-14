LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
LIBRARY work;
USE work.Math_Package.ALL;

ENTITY DPD IS
  GENERIC (
    n_signals_used : INTEGER := 2;
    n_polygnos_degree : INTEGER := 2;
  );
  PORT (
    reset : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    UR : IN signed(n_bits_resolution DOWNTO 0);
    IR : IN signed(n_bits_resolution DOWNTO 0);
    UR_out : OUT signed(n_bits_resolution DOWNTO 0);
    IR_out : OUT signed(n_bits_resolution DOWNTO 0));
END DPD;

ARCHITECTURE hardware OF DPD IS
  TYPE Array_signals IS ARRAY (0 TO n_signals_used) OF complex_number(n_bits_resolution DOWNTO 0);
  TYPE Array_signals_overflow IS ARRAY (0 TO n_signals_used) OF complex_number_overflow(n_bits_resolution DOWNTO 0);
  TYPE Array_signals_powers IS ARRAY (0 TO n_polygnos_degree) OF Array_signals;
  TYPE Array_signals_powers_overflow IS ARRAY (0 TO n_polygnos_degree) OF Array_signals_overflow;
  SIGNAL U_signals : Array_signals := (OTHERS => (real => 0, imag => 0));
  SIGNAL U_signal_out : complex_number := (real => 0, imag => 0);
  SIGNAL U_signal_in : complex_number := (real => 0, imag => 0);
BEGIN

  -- Processo que atualiza novos sinais a cada ciclo de clock
  process_signal : PROCESS (reset, U_signals_out)
  BEGIN
    IF reset = '1' THEN
      UR_out <= (OTHERS => '0');
      IR_out <= (OTHERS => '0');
      U_signals <= (OTHERS => (OTHERS => '0'));
    ELSE
      FOR i IN n_signals_used - 1 DOWNTO 1 :
        U_signals(i) <= U_signals(i - 1)
      END LOOP;
      U_signal_in := (real => to_integer(UR), imag => to_integer(UI));
      U_signals(0) <= U_signal_in;
      UR_out <= to_signed(U_signals_out.real, UR_out'length);
      UI_out <= to_signed(U_signals_out.imag, UI_out'length);
    END IF;
  END PROCESS;

  -- processo que realiza os calculos e adiciona saida
  calcul_process : PROCESS (clk, reset)
    VARIABLE sum : Array_signals := (OTHERS => (real => 0, imag => 0));
    VARIABLE potencias : Array_signals_powers := (OTHERS => (OTHERS => (real => 0, imag => 0)));
    VARIABLE multiplic : Array_signals_powers_overflow := (OTHERS => (OTHERS => (real => 0, imag => 0)));
    VARIABLE count_signal : INTEGER RANGE (0 TO n_signals_used) := 0;
    VARIABLE count_pot : INTEGER RANGE (0 TO n_polygnos_degree) := 0;
    VARIABLE U_signals_out_temp : complex_number := (real => 0, imag => 0);
  BEGIN
    IF reset = '1' THEN
      potencias : Array_signals_powers := (OTHERS => (OTHERS => (real => 0, imag => 0)));
      count_signal := 0;
      count_pot := 0;
      U_signals_out <= 0;
    ELSIF rising_edge(clk) THEN
      potencias(count_pot + 1)(0).real <= potencias(count_pot)(0).real * potencias(count_pot)(0).real
      potencias(count_pot + 1)(0).imag <= potencias(count_pot)(0).imag * potencias(count_pot)(0).imag
      count_pot := count_pot + 1;
      U_signals_out_temp := 0;
      FOR j IN 0 TO n_signals_used - 1 :
        multiplic(count_pot)(j).real := coefficients((j + count_pot) * 2).real * potencias(count_pot)(j).real - coefficients((j + count_pot) * 2).imag * potencias(count_pot)(j).imag
        multiplic(count_pot)(j).imag := coefficients((j + count_pot) * 2).imag * potencias(count_pot)(j).real + coefficients((j + count_pot) * 2).real * potencias(count_pot)(j).imag
        sum(count_pot).real := sum(count_pot).real + multiplic(j).real;
        sum(count_pot).imag := sum(count_pot).imag + multiplic(j).imag;
      END LOOP;
      IF count_pot = n_polygnos_degree THEN
        count_pot := 0;
        FOR k IN 0 TO n_signals_used :
          U_signals_out_temp := U_signals_out_temp + sum(k);
        END LOOP;
        FOR i IN n_polygnos_degree - 1 DOWNTO 1 :
          potencias(i) <= potencias(i - 1)
        END LOOP;
        U_signals_out <= U_signals_out_temp;
      ELSE
        U_signals_out <= U_signals_out;

      END IF;
    END IF;
  END PROCESS;

END ARCHITECTURE;