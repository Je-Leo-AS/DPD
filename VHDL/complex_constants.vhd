    CONSTANT n_signals_used    : INTEGER := 2 + 1;
    CONSTANT max_poly_degree   : INTEGER := 5;
    CONSTANT n_bits_resolution : INTEGER := 10 + 1;
    CONSTANT n_bits_overflow   : INTEGER := 10;
    
        ((reall => 1020, imag => -15), (reall => 570, imag => -81), (reall => -583, imag => 252), (reall => -114, imag => 215), (reall => 735, imag => 178)),
        ((reall => -116, imag => 8), (reall => -327, imag => 55), (reall => -53, imag => -84), (reall => 103, imag => -103), (reall => 315, imag => 12)),
        ((reall => 87, imag => -4), (reall => -31, imag => 10), (reall => 369, imag => -21), (reall => -404, imag => -3), (reall => 36, imag => 111))
    );

END PACKAGE;
