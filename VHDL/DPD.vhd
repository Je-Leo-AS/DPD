LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.functions.ALL;

ENTITY DPD IS
    PORT (
        clk    : IN  STD_LOGIC;
        reset  : IN  STD_LOGIC;
        UR     : IN  STD_LOGIC_VECTOR(n_bits_resolution-1 DOWNTO 0);
        UI     : IN  STD_LOGIC_VECTOR(n_bits_resolution-1 DOWNTO 0);
        UR_out : OUT STD_LOGIC_VECTOR(n_bits_resolution-1 DOWNTO 0);
        UI_out : OUT STD_LOGIC_VECTOR(n_bits_resolution-1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF DPD IS

    --------------------------------------------------------------------
    -- Estágio 1: delay line
    --------------------------------------------------------------------
    SIGNAL delay_line : delay_line_t := (OTHERS => zero_complex);

    --------------------------------------------------------------------
    -- Estágio 2: base + |x|²
    --------------------------------------------------------------------
    SIGNAL base_s2 : delay_line_t := (OTHERS => zero_complex);
    SIGNAL mag2_s2 : mag_array_t  := (OTHERS => 0);

    --------------------------------------------------------------------
    -- Pipeline genérico por ordem
    -- term_pipe(0) = x
    -- term_pipe(1) = x|x|²
    -- term_pipe(2) = x|x|⁴
    -- ...
    --------------------------------------------------------------------
    SIGNAL term_pipe : term_pipe_t := (OTHERS => (OTHERS => zero_complex));
    SIGNAL mag_pipe  : mag_pipe_t  := (OTHERS => (OTHERS => 0));

    SIGNAL XX         : power_vector_t := (OTHERS => zero_complex);
    SIGNAL multiplied : power_vector_t := (OTHERS => zero_complex);

BEGIN

    --------------------------------------------------------------------
    -- 1. Delay line
    --------------------------------------------------------------------
    delay_process : PROCESS(clk)
        VARIABLE din        : complex_number;
        VARIABLE temp_delay : delay_line_t;
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                delay_line <= (OTHERS => zero_complex);
            ELSE
                din.reall := clip_data(to_integer(signed(UR)));
                din.imag  := clip_data(to_integer(signed(UI)));

                temp_delay := delay_line;
                temp_delay(0) := din;

                FOR m IN 1 TO n_signals_used-1 LOOP
                    temp_delay(m) := delay_line(m-1);
                END LOOP;

                delay_line <= temp_delay;
            END IF;
        END IF;
    END PROCESS;

    --------------------------------------------------------------------
    -- 2. Quadrados + msq
    --------------------------------------------------------------------
    mag2_process : PROCESS(clk)
        VARIABLE temp_base : delay_line_t;
        VARIABLE temp_mag2 : mag_array_t;
        VARIABLE A, B      : INTEGER;
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                base_s2 <= (OTHERS => zero_complex);
                mag2_s2 <= (OTHERS => 0);
            ELSE
                FOR m IN 0 TO n_signals_used-1 LOOP
                    A := clip_data(delay_line(m).reall);
                    B := clip_data(delay_line(m).imag);

                    temp_base(m).reall := A;
                    temp_base(m).imag  := B;
                    temp_mag2(m)       := readeq(A*A) + readeq(B*B);
                END LOOP;

                base_s2 <= temp_base;
                mag2_s2 <= temp_mag2;
            END IF;
        END IF;
    END PROCESS;

    --------------------------------------------------------------------
    -- 3. Pipeline genérico das ordens
    --------------------------------------------------------------------
    pipe_process : PROCESS(clk)
        VARIABLE temp_term : term_pipe_t;
        VARIABLE temp_mag  : mag_pipe_t;
        VARIABLE rr, ii    : INTEGER;
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                term_pipe <= (OTHERS => (OTHERS => zero_complex));
                mag_pipe  <= (OTHERS => (OTHERS => 0));
            ELSE
                ----------------------------------------------------------------
                -- ordem 1: x
                ----------------------------------------------------------------
                FOR m IN 0 TO n_signals_used-1 LOOP
                    temp_term(0)(m) := base_s2(m);
                    temp_mag(0)(m)  := mag2_s2(m);
                END LOOP;

                ----------------------------------------------------------------
                -- ordens 2..max_poly_degree
                ----------------------------------------------------------------
                FOR s IN 1 TO max_poly_degree-1 LOOP
                    FOR m IN 0 TO n_signals_used-1 LOOP
                        rr := readeq(term_pipe(s-1)(m).reall * mag_pipe(s-1)(m));
                        ii := readeq(term_pipe(s-1)(m).imag  * mag_pipe(s-1)(m));

                        temp_term(s)(m).reall := clip_data(rr);
                        temp_term(s)(m).imag  := clip_data(ii);

                        temp_mag(s)(m) := mag_pipe(s-1)(m);
                    END LOOP;
                END LOOP;

                term_pipe <= temp_term;
                mag_pipe  <= temp_mag;
            END IF;
        END IF;
    END PROCESS;

    --------------------------------------------------------------------
    -- 4. Empacota XX conforme poly_degree_per_delay e coef_offset_per_delay
    --------------------------------------------------------------------
    pack_process : PROCESS(clk)
        VARIABLE temp_xx : power_vector_t;
        VARIABLE idx     : INTEGER;
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                XX <= (OTHERS => zero_complex);
            ELSE
                temp_xx := (OTHERS => zero_complex);

                FOR m IN 0 TO n_signals_used-1 LOOP
                    idx := coef_offset_per_delay(m);

                    FOR p IN 0 TO poly_degree_per_delay(m)-1 LOOP
                        temp_xx(idx + p) := term_pipe(p)(m);
                    END LOOP;
                END LOOP;

                XX <= temp_xx;
            END IF;
        END IF;
    END PROCESS;

    --------------------------------------------------------------------
    -- 5. Multiplicação pelos coeficientes
    --------------------------------------------------------------------
    mult_process : PROCESS(clk)
        VARIABLE temp_mult : power_vector_t;
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                multiplied <= (OTHERS => zero_complex);
            ELSE
                FOR k IN 0 TO n_total_terms-1 LOOP
                    temp_mult(k) := cmul(coefficients(k), XX(k));
                END LOOP;

                multiplied <= temp_mult;
            END IF;
        END IF;
    END PROCESS;

    --------------------------------------------------------------------
    -- 6. Soma final
    --------------------------------------------------------------------
    sum_process : PROCESS(clk)
        VARIABLE acc_re, acc_im : INTEGER;
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                UR_out <= (OTHERS => '0');
                UI_out <= (OTHERS => '0');
            ELSE
                acc_re := 0;
                acc_im := 0;

                FOR k IN 0 TO n_total_terms-1 LOOP
                    acc_re := acc_re + multiplied(k).reall;
                    acc_im := acc_im + multiplied(k).imag;
                END LOOP;

                UR_out <= STD_LOGIC_VECTOR(to_signed(clip_data(acc_re), n_bits_resolution));
                UI_out <= STD_LOGIC_VECTOR(to_signed(clip_data(acc_im), n_bits_resolution));
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE;