LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

PACKAGE functions IS

    --------------------------------------------------------------------
    -- Configuração do modelo
    --------------------------------------------------------------------
    CONSTANT n_signals_used    : INTEGER := 2;   -- M + 1
    CONSTANT max_poly_degree   : INTEGER := 2;   -- grau máximo entre os atrasos
    CONSTANT n_bits_resolution : INTEGER := 11;  -- largura de entrada/saída
    CONSTANT n_bits_overflow   : INTEGER := 10;  -- p_bits do Python

    TYPE degree_array_t IS ARRAY (0 TO n_signals_used-1) OF INTEGER;
    CONSTANT poly_degree_per_delay : degree_array_t := (2, 2);

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
        ((reall => 1017, imag => -52), (reall => 177, imag => 201)),
        ((reall => -28, imag => 11), (reall => -39, imag => 1))
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