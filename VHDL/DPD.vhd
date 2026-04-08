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

    SIGNAL delay_line : delay_line_t    := (OTHERS => zero_complex);
    SIGNAL mag2       : mag_array_t     := (OTHERS => 0);
    SIGNAL XX         : power_vector_t  := (OTHERS => zero_complex);
    SIGNAL multiplied : power_vector_t  := (OTHERS => zero_complex);

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
    -- 2. |x[n-m]|? usando o delay_line registrado anterior
    --------------------------------------------------------------------
    mag2_process : PROCESS(clk)
        VARIABLE temp_mag2 : mag_array_t;
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                mag2 <= (OTHERS => 0);
            ELSE
                FOR m IN 0 TO n_signals_used-1 LOOP
                    temp_mag2(m) := calc_mag2(delay_line(m));
                END LOOP;
                mag2 <= temp_mag2;
            END IF;
        END IF;
    END PROCESS;

    --------------------------------------------------------------------
    -- 3. Gera??o compacta de XX igual ao Python mp_int_trunc
    -- Ordem: m=0 p=1..5, m=1 p=1..3, m=2 p=1
    -- Usa delay_line e mag2 REGISTRADOS do ciclo anterior.
    --------------------------------------------------------------------
    power_process : PROCESS(clk)
        VARIABLE temp_xx : power_vector_t;
        VARIABLE idx     : INTEGER;
        VARIABLE rr, ii  : INTEGER;
        VARIABLE A, B    : INTEGER;
        VARIABLE msq     : INTEGER;
        VARIABLE base    : complex_number;
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                XX <= (OTHERS => zero_complex);
            ELSE
                temp_xx := (OTHERS => zero_complex);
                idx := 0;

                FOR m IN 0 TO n_signals_used - 1 LOOP
                    -- Igual ao Python: clip na entrada do atraso antes da recurs?o
                    A := clip_data(delay_line(m).reall);
                    B := clip_data(delay_line(m).imag);

                    -- Igual ao Python: modulo_square = readeq(A^2) + readeq(B^2)
                    msq := readeq(A * A) + readeq(B * B);

                    base.reall := A;
                    base.imag  := B;

                    -- Gera exatamente ordens(m) termos para este atraso
                    FOR p IN 0 TO poly_degree_per_delay(m) - 1 LOOP
                        IF p = 0 THEN
                            temp_xx(idx) := base;
                        ELSE
                            rr := readeq(base.reall * msq);
                            ii := readeq(base.imag  * msq);

                            base.reall := clip_data(rr);
                            base.imag  := clip_data(ii);

                            temp_xx(idx) := base;
                        END IF;

                        idx := idx + 1;
                    END LOOP;
                END LOOP;

                XX <= temp_xx;
            END IF;
        END IF;
    END PROCESS;

    --------------------------------------------------------------------
    -- 4. Multiplica??o compacta igual ao Python MultiplicadorMatrizes
    -- Usa XX REGISTRADO do ciclo anterior.
    --------------------------------------------------------------------
    mult_process : PROCESS(clk)
        VARIABLE temp_mult : power_vector_t;
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                multiplied <= (OTHERS => zero_complex);
            ELSE
                temp_mult := (OTHERS => zero_complex);

                FOR k IN 0 TO n_total_terms - 1 LOOP
                    temp_mult(k) := cmul(coefficients(k), XX(k));
                END LOOP;

                multiplied <= temp_mult;
            END IF;
        END IF;
    END PROCESS;

    --------------------------------------------------------------------
    -- 5. Soma final igual ao Python:
    -- soma todos os termos e clipa s? no final.
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

                FOR k IN 0 TO n_total_terms - 1 LOOP
                    acc_re := acc_re + multiplied(k).reall;
                    acc_im := acc_im + multiplied(k).imag;
                END LOOP;

                UR_out <= STD_LOGIC_VECTOR(to_signed(clip_data(acc_re), n_bits_resolution));
                UI_out <= STD_LOGIC_VECTOR(to_signed(clip_data(acc_im), n_bits_resolution));
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE;
