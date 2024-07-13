LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
LIBRARY work;
USE work.Math_Package.ALL;
-- TODO tera uma entrada exclusiva para sinal?

ENTITY DPD IS
  GENERIC (
    n_bits_overflow : INTEGER := 10;
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
  TYPE Array_powers IS ARRAY (0 TO n_polygnos_degree) OF Array_signals;
  TYPE Array_multiplication IS ARRAY (0 TO n_signals_used * n_polygnos_degree) OF complex_number_overflow;
  SIGNAL U_signals : Array_signals := (OTHERS => (real => 0, imag => 0));
  SIGNAL sum : IS ARRAY (0 TO n_signals_used * n_polygnos_degree) OF complex_number (OTHERS => (real => 0, imag => 0));
BEGIN

  -- Processo que atualiza novos sinais a cada ciclo de clock
  process_signal : PROCESS (clk, reset)
    VARIABLE U_signal_in : complex_number(n_bits_resolution DOWNTO 0) := (real => 0, imag => 0);
  BEGIN
    IF reset = '1' THEN
      UR_out <= (OTHERS => '0');
      IR_out <= (OTHERS => '0');
      U_signals <= (OTHERS => (OTHERS => '0'));
    ELSIF rising_edge(clk) THEN
      FOR i IN n_signals_used - 1 DOWNTO 1 :
        U_signals(i) <= U_signals(i - 1)
      END LOOP;
      U_signal_in <= (real => to_integer(UR), imag => to_integer(UI));
      U_signals(0) <= U_signal_in;
    END IF;
  END PROCESS;

  -- processo que realiza os calculos e adiciona saida
  calcul_process : PROCESS (clk, reset)
    VARIABLE potencias : Array_powers := (OTHERS => (OTHERS => (real => 0, imag => 0)))
  BEGIN
    IF reset = '1' THEN
      
    ELSIF rising_edge(clk) THEN

    END IF;
  END PROCESS;

END ARCHITECTURE;