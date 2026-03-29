LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

PACKAGE functions IS

    --------------------------------------------------------------------
    -- CONSTANTS
    --------------------------------------------------------------------
    CONSTANT n_signals_used    : INTEGER := 3;  -- M
    CONSTANT n_polygnos_degree : INTEGER := 5;  -- P
    CONSTANT n_bits_resolution : INTEGER := 10 + 1;
    CONSTANT n_bits_overflow   : INTEGER := 8;

    --------------------------------------------------------------------
    -- TYPES
    --------------------------------------------------------------------
    SUBTYPE data_t IS SIGNED(n_bits_resolution-1 DOWNTO 0);

    SUBTYPE acc_t IS SIGNED(
        2*n_bits_resolution + n_bits_overflow DOWNTO 0
    );

    TYPE complex_number IS RECORD
        reall : data_t;
        imag  : data_t;
    END RECORD;

    TYPE delay_line_t IS ARRAY (0 TO n_signals_used - 1)
                                OF complex_number;

    TYPE complex_coefficients IS ARRAY (
        0 TO n_signals_used - 1,
        0 TO n_polygnos_degree - 1
    ) OF complex_number;

    --------------------------------------------------------------------
    -- COEFFICIENTS
    --------------------------------------------------------------------
    CONSTANT coefficients : complex_coefficients := (
        ((reall => to_signed(49, n_bits_resolution), imag => to_signed(2, n_bits_resolution)), (reall => to_signed(-769, n_bits_resolution), imag => to_signed(70, n_bits_resolution)), (reall => to_signed(1031, n_bits_resolution), imag => to_signed(38, n_bits_resolution)), (reall => to_signed(-225, n_bits_resolution), imag => to_signed(-451, n_bits_resolution)), (reall => to_signed(-290, n_bits_resolution), imag => to_signed(326, n_bits_resolution))),
        ((reall => to_signed(908, n_bits_resolution), imag => to_signed(-1, n_bits_resolution)), (reall => to_signed(1173, n_bits_resolution), imag => to_signed(-255, n_bits_resolution)), (reall => to_signed(-2668, n_bits_resolution), imag => to_signed(995, n_bits_resolution)), (reall => to_signed(2427, n_bits_resolution), imag => to_signed(-1130, n_bits_resolution)), (reall => to_signed(-282, n_bits_resolution), imag => to_signed(885, n_bits_resolution))),
        ((reall => to_signed(16, n_bits_resolution), imag => to_signed(4, n_bits_resolution)), (reall => to_signed(63, n_bits_resolution), imag => to_signed(-71, n_bits_resolution)), (reall => to_signed(322, n_bits_resolution), imag => to_signed(348, n_bits_resolution)), (reall => to_signed(-909, n_bits_resolution), imag => to_signed(-674, n_bits_resolution)), (reall => to_signed(604, n_bits_resolution), imag => to_signed(478, n_bits_resolution)))
    );

    constant ZERO_COMPLEX : complex_number := (
        reall => to_signed(0, n_bits_resolution),
        imag  => to_signed(0, n_bits_resolution)
    );
    --------------------------------------------------------------------
    -- FUNCTIONS
    --------------------------------------------------------------------
    FUNCTION scale(x : acc_t) RETURN data_t;

    FUNCTION multiplication(
        A : complex_number;
        B : complex_number
    ) RETURN complex_number;

    FUNCTION cmul(
        A : complex_number;
        scalar : data_t
    ) RETURN complex_number;

    FUNCTION magnitude_square(
        A : complex_number
    ) RETURN data_t;

END PACKAGE;


PACKAGE BODY functions IS

    --------------------------------------------------------------------
    -- SCALING (ESSENCIAL)
    --------------------------------------------------------------------
    FUNCTION scale(x : acc_t) RETURN data_t IS
        VARIABLE tmp : acc_t;
    BEGIN
        -- 🔥 scaling automático
        tmp := shift_right(x, n_bits_overflow);

        RETURN resize(tmp, n_bits_resolution);
    END FUNCTION;

    --------------------------------------------------------------------
    -- COMPLEX MULTIPLICATION
    --------------------------------------------------------------------
    FUNCTION multiplication(
        A : complex_number;
        B : complex_number
    ) RETURN complex_number IS

        VARIABLE r : complex_number;
        VARIABLE ar, ai, br, bi : acc_t;

    BEGIN
        ar := resize(A.reall, acc_t'length);
        ai := resize(A.imag,  acc_t'length);
        br := resize(B.reall, acc_t'length);
        bi := resize(B.imag,  acc_t'length);

        r.reall := scale(ar * br - ai * bi);
        r.imag  := scale(ai * br + ar * bi);

        RETURN r;
    END FUNCTION;

    --------------------------------------------------------------------
    -- SCALAR * COMPLEX
    --------------------------------------------------------------------
    FUNCTION cmul(
        A : complex_number;
        scalar : data_t
    ) RETURN complex_number IS

        VARIABLE r : complex_number;
        VARIABLE s : acc_t;

    BEGIN
        s := resize(scalar, acc_t'length);

        r.reall := scale(resize(A.reall, acc_t'length) * s);
        r.imag  := scale(resize(A.imag,  acc_t'length) * s);

        RETURN r;
    END FUNCTION;

    --------------------------------------------------------------------
    -- |x|²
    --------------------------------------------------------------------
    FUNCTION magnitude_square(
        A : complex_number
    ) RETURN data_t IS

        VARIABLE r2, i2 : acc_t;

    BEGIN
        r2 := resize(A.reall, acc_t'length) * resize(A.reall, acc_t'length);
        i2 := resize(A.imag,  acc_t'length) * resize(A.imag,  acc_t'length);

        RETURN scale(r2 + i2);
    END FUNCTION;

END PACKAGE BODY;