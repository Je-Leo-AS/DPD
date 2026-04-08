  CONSTANT n_signals_used : INTEGER := 3;
  CONSTANT max_poly_degree : INTEGER := 5;
  CONSTANT n_bits_resolution : INTEGER := 10 + 1; -- +1 para o bit de sinal
  CONSTANT n_bits_overflow   : INTEGER := 10;

  TYPE degree_array_t IS ARRAY (0 TO n_signals_used - 1) OF INTEGER;
  CONSTANT poly_degree_per_delay : degree_array_t := (5, 3, 1);

  TYPE complex_type IS RECORD
    reall : INTEGER;
    imag  : INTEGER;
  END RECORD;

  TYPE complex_array IS ARRAY (0 TO n_signals_used - 1, 0 TO n_polygnos_degree - 1) OF complex_type;

  CONSTANT coefficients : complex_array := (
    ((reall => 1022, imag => -20), (reall => 590, imag => -18), (reall => -849, imag => 138), (reall => 156, imag => 117), (reall => 737, imag => 289)),
    ((reall => -122, imag => 15), (reall => -317, imag => 9), (reall => 267, imag => 0), (reall => 0, imag => 0), (reall => 0, imag => 0)),
    ((reall => 92, imag => -2), (reall => 0, imag => 0), (reall => 0, imag => 0), (reall => 0, imag => 0), (reall => 0, imag => 0))
  );
