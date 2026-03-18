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

  TYPE complex_coefficients IS ARRAY (0 TO 3) OF complex_number;

  CONSTANT coefficients : complex_coefficients := (
    (reall => 1816, imag => -2),
    (reall => 2346, imag => -510),
    (reall => -5336, imag => 1990),
    (reall => 4854, imag => -2260),
    (reall => -564, imag => 1770),
    (reall => 98, imag => 4),
    (reall => -1538, imag => 140),
    (reall => 2062, imag => 76),
    (reall => -450, imag => -902),
    (reall => -580, imag => 652),
    (reall => 32, imag => 8),
    (reall => 126, imag => -142),
    (reall => 644, imag => 696),
    (reall => -1818, imag => -1348),
    (reall => 1208, imag => 956)
  );
