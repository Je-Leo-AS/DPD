    CONSTANT n_signals_used    : INTEGER := 1 + 1;
    CONSTANT n_polygnos_degree : INTEGER := 2;
    CONSTANT n_bits_resolution : INTEGER := 10 + 1;
    CONSTANT n_bits_overflow   : INTEGER := 10;

    CONSTANT coefficients : coef_array_t := (
        ((reall => 1017, imag => -52), (reall => 177, imag => 201)),
        ((reall => -28, imag => 11), (reall => -39, imag => 1))
    );

END PACKAGE;
