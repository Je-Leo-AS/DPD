  CONSTANT n_signals_used : INTEGER := 2;
  CONSTANT n_polygnos_degree : INTEGER := 2;
  
  CONSTANT n_bits_resolution : INTEGER := 8 + 1;
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
    (reall => 1, imag => 1),
    (reall => 7, imag => -1),
    (reall => -3, imag => -1),
    (reall => 1, imag => 1)
  );
