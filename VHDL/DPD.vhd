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

    SIGNAL delay_line      : delay_line_t   := (OTHERS => zero_complex);

    SIGNAL XX              : power_vector_t := (OTHERS => zero_complex);
    SIGNAL multiplied      : power_vector_t := (OTHERS => zero_complex);
    SIGNAL multiplied_next : power_vector_t := (OTHERS => zero_complex);

    SIGNAL base_vec      : delay_line_t := (OTHERS => zero_complex);
    SIGNAL msq_vec       : mag_array_t  := (OTHERS => 0);
    SIGNAL base_vec_next : delay_line_t := (OTHERS => zero_complex);
    SIGNAL msq_vec_next  : mag_array_t  := (OTHERS => 0);

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
    -- 2. Geração combinacional paralela de base_vec_next e msq_vec_next
    --------------------------------------------------------------------
    gen_prep_power : FOR m IN 0 TO n_signals_used - 1 GENERATE
    BEGIN
        base_vec_next(m).reall <= clip_data(delay_line(m).reall);
        base_vec_next(m).imag  <= clip_data(delay_line(m).imag);

        msq_vec_next(m) <=
            readeq(clip_data(delay_line(m).reall) * clip_data(delay_line(m).reall)) +
            readeq(clip_data(delay_line(m).imag)  * clip_data(delay_line(m).imag));
    END GENERATE;

    --------------------------------------------------------------------
    -- 2b. Registro de base_vec e msq_vec
    --------------------------------------------------------------------
    prep_power_process : PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                base_vec <= (OTHERS => zero_complex);
                msq_vec  <= (OTHERS => 0);
            ELSE
                base_vec <= base_vec_next;
                msq_vec  <= msq_vec_next;
            END IF;
        END IF;
    END PROCESS;

    --------------------------------------------------------------------
    -- 3. Geração de XX usando base_vec e msq_vec
    --------------------------------------------------------------------
    power_process : PROCESS(clk)
        VARIABLE temp_xx : power_vector_t;
        VARIABLE idx     : INTEGER;
        VARIABLE rr, ii  : INTEGER;
        VARIABLE base    : complex_number;
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                XX <= (OTHERS => zero_complex);
            ELSE
                temp_xx := (OTHERS => zero_complex);
                idx := 0;

                FOR m IN 0 TO n_signals_used - 1 LOOP

                    base := base_vec(m);

                    FOR p IN 0 TO poly_degree_per_delay(m) - 1 LOOP
                        IF p = 0 THEN
                            temp_xx(idx) := base;
                        ELSE
                            rr := readeq(base.reall * msq_vec(m));
                            ii := readeq(base.imag  * msq_vec(m));

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
    -- 4. Multiplicação compacta igual ao Python MultiplicadorMatrizes
    -- Usa XX REGISTRADO do ciclo anterior.
    -- Parte combinacional paralela
    --------------------------------------------------------------------
    gen_mult : FOR k IN 0 TO n_total_terms - 1 GENERATE
    BEGIN
        multiplied_next(k) <= cmul(coefficients(k), XX(k));
    END GENERATE;

    --------------------------------------------------------------------
    -- 4b. Registro da multiplicação
    --------------------------------------------------------------------
    mult_process : PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                multiplied <= (OTHERS => zero_complex);
            ELSE
                multiplied <= multiplied_next;
            END IF;
        END IF;
    END PROCESS;

    --------------------------------------------------------------------
    -- 5. Soma final igual ao Python:
    -- soma todos os termos e clipa só no final.
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