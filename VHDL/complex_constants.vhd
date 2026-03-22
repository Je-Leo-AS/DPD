  CONSTANT n_signals_used : INTEGER := 3;
  CONSTANT n_polygnos_degree : INTEGER := 5;
  CONSTANT n_bits_resolution : INTEGER := 10 + 1;
  CONSTANT n_bits_overflow : INTEGER := 8;
  CONSTANT max_value : INTEGER := 2 ** (n_bits_resolution - 1) - 1;
  CONSTANT max_value_overflow : INTEGER := 2 ** (n_bits_resolution + n_bits_overflow - 1) - 1;
  SUBTYPE limited_integer IS INTEGER RANGE -max_value TO max_value;
  SUBTYPE overflow_integer IS INTEGER RANGE -max_value_overflow TO max_value_overflow;
  TYPE complex_number IS RECORD
    reall : limited_integer;
    imag : limited_integer;
  END RECORD;
  TYPE complex_number_overflow IS RECORD
    reall : overflow_integer;
    imag : overflow_integer;
  END RECORD;
  TYPE complex_coefficients IS ARRAY (0 TO n_signals_used - 1, 0 TO n_polygnos_degree - 1) OF complex_number;
  CONSTANT coefficients : complex_coefficients := (
    ((reall => 32, imag => -4), (reall => 994, imag => 13), (reall => 133, imag => -6), (reall => 142, imag => -157), (reall => 1627, imag => -284)),
    ((reall => -939, imag => 81), (reall => 35, imag => 928), (reall => -6732, imag => 1731), (reall => 3202, imag => 36), (reall => -1197, imag => -2317)),
    ((reall => 11292, imag => -2545), (reall => -5043, imag => -1085), (reall => 2289, imag => 2517), (reall => -5790, imag => 2352), (reall => 3539, imag => 1838))
  );
