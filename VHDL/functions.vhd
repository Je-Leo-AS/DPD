LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

PACKAGE functions IS

    --------------------------------------------------------------------
    -- Configuração do modelo
    --------------------------------------------------------------------
    CONSTANT n_signals_used    : INTEGER := 2 + 1;
    CONSTANT max_poly_degree   : INTEGER := 5;
    CONSTANT n_bits_resolution : INTEGER := 10 + 1;
    CONSTANT n_bits_overflow   : INTEGER := 10;

    TYPE degree_array_t IS ARRAY (0 TO n_signals_used-1) OF INTEGER;
    CONSTANT poly_degree_per_delay : degree_array_t := (5, 5, 5);

    --------------------------------------------------------------------
    -- Faixa de saturação
    --------------------------------------------------------------------
    CONSTANT max_data : INTEGER := 2**(n_bits_resolution-1) - 1;
    CONSTANT min_data : INTEGER := -2**(n_bits_resolution-1);

    SUBTYPE data_t IS INTEGER RANGE min_data TO max_data;

    --------------------------------------------------------------------
    -- Tipos
    --------------------------------------------------------------------
    TYPE complex_number IS RECORD
        reall : data_t;
        imag  : data_t;
    END RECORD;

    TYPE delay_line_t IS ARRAY (0 TO n_signals_used-1) OF complex_number;
    TYPE mag_array_t  IS ARRAY (0 TO n_signals_used-1) OF INTEGER;

    -- XX(m,p) = termo do atraso m e ordem p
    TYPE power_matrix_t IS ARRAY (
        0 TO n_signals_used-1,
        0 TO max_poly_degree-1
    ) OF complex_number;

    TYPE coef_array_t IS ARRAY (
        0 TO n_signals_used-1,
        0 TO max_poly_degree-1
    ) OF complex_number;

    --------------------------------------------------------------------
    -- Coeficientes
    -- Ajuste conforme seu caso real.
    --------------------------------------------------------------------
    CONSTANT coefficients : coef_array_t := (
        ((reall => 1020, imag => -15), (reall => 570, imag => -81), (reall => -583, imag => 252), (reall => -114, imag => 215), (reall => 735, imag => 178)),
        ((reall => -116, imag => 8), (reall => -327, imag => 55), (reall => -53, imag => -84), (reall => 103, imag => -103), (reall => 315, imag => 12)),
        ((reall => 87, imag => -4), (reall => -31, imag => 10), (reall => 369, imag => -21), (reall => -404, imag => -3), (reall => 36, imag => 111))
    );

    --------------------------------------------------------------------
    -- Funções auxiliares
    --------------------------------------------------------------------
    FUNCTION clip_data(x : INTEGER) RETURN data_t;
    FUNCTION readeq(x : INTEGER) RETURN INTEGER;
    FUNCTION calc_mag2(a : complex_number) RETURN INTEGER;
    FUNCTION cmul(a, b : complex_number) RETURN complex_number;
    FUNCTION zero_complex RETURN complex_number;

END PACKAGE;


PACKAGE BODY functions IS

    FUNCTION clip_data(x : INTEGER) RETURN data_t IS
    BEGIN
        IF x > max_data THEN
            RETURN max_data;
        ELSIF x < min_data THEN
            RETURN min_data;
        ELSE
            RETURN x;
        END IF;
    END FUNCTION;

    FUNCTION readeq(x : INTEGER) RETURN INTEGER IS
    BEGIN
        -- Reescala do ponto fixo:
        -- equivalente ao shift right por n_bits_overflow
        RETURN x / (2 ** n_bits_overflow);
    END FUNCTION;

    FUNCTION calc_mag2(a : complex_number) RETURN INTEGER IS
        VARIABLE r2, i2 : INTEGER;
    BEGIN
        r2 := readeq(a.reall * a.reall);
        i2 := readeq(a.imag  * a.imag);
        RETURN r2 + i2;
    END FUNCTION;

    FUNCTION cmul(a, b : complex_number) RETURN complex_number IS
        VARIABLE outv : complex_number;
        VARIABLE rr, ii : INTEGER;
    BEGIN
        rr := readeq(a.reall * b.reall) - readeq(a.imag * b.imag);
        ii := readeq(a.reall * b.imag) + readeq(a.imag * b.reall);

        outv.reall := rr;
        outv.imag  := ii;

        RETURN outv;
    END FUNCTION;

    FUNCTION zero_complex RETURN complex_number IS
        VARIABLE z : complex_number;
    BEGIN
        z.reall := 0;
        z.imag  := 0;
        RETURN z;
    END FUNCTION;

END PACKAGE BODY;