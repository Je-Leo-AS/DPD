LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY work;
USE work.Math_Package.ALL;

ENTITY test_power IS
  GENERIC (
    n_bits_overflow : INTEGER := 10;
    n_signals_used : INTEGER := 2;
    n_polygnos_degree : INTEGER := 2);
  PORT (
    reset : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    U : IN signed(n_bits_resolution DOWNTO 0);
    U_out_int : OUT INTEGER;
    U_out : OUT signed(n_bits_resolution DOWNTO 0));
END test_power;

ARCHITECTURE hardware OF test_power IS
  SIGNAL complex_signal_in : complex_number;
  SIGNAL u_int : limited_integer;
BEGIN
  u_int <= to_integer(U);
  calcul_process : PROCESS (clk, reset)
    VARIABLE int_out : INTEGER := 0;
  BEGIN
    IF reset = '1' THEN
      U_out <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN
      int_out := u_int * u_int;
      U_out_int <= int_out;
      U_out <= to_signed(int_out, U_out'length);
    END IF;
  END PROCESS;
END hardware;