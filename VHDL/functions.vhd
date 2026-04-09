LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

PACKAGE functions IS

    --------------------------------------------------------------------
    -- Configuração do modelo truncado
    --------------------------------------------------------------------
    CONSTANT n_signals_used    : INTEGER := 3;
    CONSTANT n_total_terms     : INTEGER := 9;
    CONSTANT n_bits_resolution : INTEGER := 11;
    CONSTANT n_bits_overflow   : INTEGER := 10;

    TYPE degree_array_t IS ARRAY (0 TO n_signals_used-1) OF INTEGER;
    TYPE offset_array_t IS ARRAY (0 TO n_signals_used-1) OF INTEGER;

    CONSTANT poly_degree_per_delay : degree_array_t := (5, 3, 1);
    CONSTANT coef_offset_per_delay : offset_array_t := (0, 5, 8);

    FUNCTION max_degree_fn(a : degree_array_t) RETURN INTEGER;

    CONSTANT max_poly_degree : INTEGER := 5;

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

    TYPE delay_line_t     IS ARRAY (0 TO n_signals_used-1) OF complex_number;
    TYPE mag_array_t      IS ARRAY (0 TO n_signals_used-1) OF INTEGER;
    TYPE power_vector_t   IS ARRAY (0 TO n_total_terms-1) OF complex_number;
    TYPE coef_array_t     IS ARRAY (0 TO n_total_terms-1) OF complex_number;

    TYPE term_pipe_t IS ARRAY (0 TO max_poly_degree-1) OF delay_line_t;
    TYPE mag_pipe_t  IS ARRAY (0 TO max_poly_degree-1) OF mag_array_t;

    --------------------------------------------------------------------
    -- Coeficientes
    --------------------------------------------------------------------
    CONSTANT coefficients : coef_array_t := (
        (reall => 1022, imag => -21),
        (reall => 591,  imag => -18),
        (reall => -849, imag => 139),
        (reall => 157,  imag => 117),
        (reall => 737,  imag => 289),
        (reall => -123, imag => 15),
        (reall => -318, imag => 9),
        (reall => 268,  imag => 1),
        (reall => 93,   imag => -3)
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

    FUNCTION max_degree_fn(a : degree_array_t) RETURN INTEGER IS
        VARIABLE m : INTEGER := 0;
    BEGIN
        FOR i IN a'RANGE LOOP
            IF a(i) > m THEN
                m := a(i);
            END IF;
        END LOOP;
        RETURN m;
    END FUNCTION;

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
        VARIABLE outv       : complex_number;
        VARIABLE t1, t2     : INTEGER;
        VARIABLE t3, t4     : INTEGER;
        VARIABLE rr, ii     : INTEGER;
    BEGIN
        t1 := readeq(a.reall * b.reall);
        t2 := readeq(a.imag  * b.imag);
        t3 := readeq(a.reall * b.imag);
        t4 := readeq(a.imag  * b.reall);

        rr := t1 - t2;
        ii := t3 + t4;

        outv.reall := clip_data(rr);
        outv.imag  := clip_data(ii);

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