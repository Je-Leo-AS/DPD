LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

PACKAGE functions IS

    --------------------------------------------------------------------
    -- CONSTANTS
    --------------------------------------------------------------------
    CONSTANT n_signals_used    : INTEGER := 3;
    CONSTANT n_polygnos_degree : INTEGER := 5;
    CONSTANT n_bits_resolution : INTEGER := 11;
    CONSTANT n_bits_overflow   : INTEGER := 8;

    --------------------------------------------------------------------
    -- TYPES
    --------------------------------------------------------------------
    TYPE complex_number IS RECORD
        reall : INTEGER;
        imag  : INTEGER;
    END RECORD;

    TYPE delay_line_t IS ARRAY (0 TO n_signals_used - 1)
                                OF complex_number;

    TYPE complex_coefficients IS ARRAY (0 TO n_signals_used - 1,
                                        0 TO n_polygnos_degree - 1)
                                        OF complex_number;

    --------------------------------------------------------------------
    -- COEFFICIENTS
    --------------------------------------------------------------------
    CONSTANT coefficients : complex_coefficients := (
        ((32, -4), (994, 13), (133, -6), (142, -157), (1627, -284)),
        ((-939, 81), (35, 928), (-6732, 1731), (3202, 36), (-1197, -2317)),
        ((11292, -2545), (-5043, -1085), (2289, 2517), (-5790, 2352), (3539, 1838))
    );

    --------------------------------------------------------------------
    -- FUNCTIONS
    --------------------------------------------------------------------
    FUNCTION readeq(input : INTEGER) RETURN INTEGER;

    FUNCTION multiplication(
        A : complex_number;
        B : complex_number
    ) RETURN complex_number;

    FUNCTION cmul(
        A : complex_number;
        B : complex_number
    ) RETURN complex_number;

    FUNCTION magnitude_square(
        A : complex_number
    ) RETURN INTEGER;

END PACKAGE;

----------------------------------------------------------------------
PACKAGE BODY functions IS

    --------------------------------------------------------------------
    -- SAFE CAST
    --------------------------------------------------------------------
    FUNCTION readeq(input : INTEGER) RETURN INTEGER IS
        VARIABLE slv : SIGNED(31 DOWNTO 0);
    BEGIN
        slv := TO_SIGNED(input, slv'LENGTH);
        RETURN TO_INTEGER(slv);
    END FUNCTION;

    --------------------------------------------------------------------
    -- COMPLEX MULTIPLICATION (REAL + IMAG)
    --------------------------------------------------------------------
    FUNCTION multiplication(A : complex_number; B : complex_number)
        RETURN complex_number IS

        VARIABLE r : complex_number;
    BEGIN
        r.reall := readeq(A.reall * B.reall - A.imag * B.imag);
        r.imag  := readeq(A.imag * B.reall + A.reall * B.imag);
        RETURN r;
    END FUNCTION;

    --------------------------------------------------------------------
    -- SCALAR MULTIPLICATION (INTEGER * COMPLEX)
    --------------------------------------------------------------------
    FUNCTION cmul(A : complex_number; B : complex_number)
        RETURN complex_number IS

        VARIABLE r : complex_number;
    BEGIN
        r.reall := readeq(A.reall * B.reall);
        r.imag  := readeq(A.imag * B.imag);
        RETURN r;
    END FUNCTION;

    --------------------------------------------------------------------
    -- POWER BASE
    --------------------------------------------------------------------
    FUNCTION magnitude_square(A : complex_number)
        RETURN INTEGER IS
    BEGIN
        RETURN readeq(A.reall * A.reall + A.imag * A.imag);
    END FUNCTION;

END PACKAGE BODY;