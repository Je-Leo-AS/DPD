LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

PACKAGE functions IS

    CONSTANT n_signals_used    : INTEGER := 3;
    CONSTANT n_polygnos_degree : INTEGER := 5;
    CONSTANT n_bits_resolution : INTEGER := 16;
    CONSTANT n_bits_overflow   : INTEGER := 8;

    SUBTYPE data_t IS SIGNED(n_bits_resolution-1 DOWNTO 0);

    TYPE complex_number IS RECORD
        reall : data_t;
        imag  : data_t;
    END RECORD;

    TYPE complex_coefficients IS ARRAY (
        0 TO n_signals_used - 1,
        0 TO n_polygnos_degree - 1
    ) OF complex_number;

    CONSTANT coefficients : complex_coefficients := (
        ((reall => to_signed(908, n_bits_resolution), imag => to_signed(-1, n_bits_resolution)), (reall => to_signed(1173, n_bits_resolution), imag => to_signed(-255, n_bits_resolution)), (reall => to_signed(-2668, n_bits_resolution), imag => to_signed(995, n_bits_resolution)), (reall => to_signed(2427, n_bits_resolution), imag => to_signed(-1130, n_bits_resolution)), (reall => to_signed(-282, n_bits_resolution), imag => to_signed(885, n_bits_resolution))),
        ((reall => to_signed(49, n_bits_resolution), imag => to_signed(2, n_bits_resolution)), (reall => to_signed(-769, n_bits_resolution), imag => to_signed(70, n_bits_resolution)), (reall => to_signed(1031, n_bits_resolution), imag => to_signed(38, n_bits_resolution)), (reall => to_signed(-225, n_bits_resolution), imag => to_signed(-451, n_bits_resolution)), (reall => to_signed(-290, n_bits_resolution), imag => to_signed(326, n_bits_resolution))),
        ((reall => to_signed(16, n_bits_resolution), imag => to_signed(4, n_bits_resolution)), (reall => to_signed(63, n_bits_resolution), imag => to_signed(-71, n_bits_resolution)), (reall => to_signed(322, n_bits_resolution), imag => to_signed(348, n_bits_resolution)), (reall => to_signed(-909, n_bits_resolution), imag => to_signed(-674, n_bits_resolution)), (reall => to_signed(604, n_bits_resolution), imag => to_signed(478, n_bits_resolution)))
    );

END PACKAGE;
