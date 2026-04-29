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
    -- Sinais principais
    --------------------------------------------------------------------
    SIGNAL delay_line      : delay_line_t   := (OTHERS => zero_complex);

    SIGNAL XX              : power_vector_t := (OTHERS => zero_complex);
    SIGNAL multiplied      : power_vector_t := (OTHERS => zero_complex);
    SIGNAL multiplied_next : power_vector_t := (OTHERS => zero_complex);

    --------------------------------------------------------------------
    -- Estágio base/msq
    --------------------------------------------------------------------
    SIGNAL base_vec      : delay_line_t := (OTHERS => zero_complex);
    SIGNAL msq_vec       : mag_array_t  := (OTHERS => 0);
    SIGNAL base_vec_next : delay_line_t := (OTHERS => zero_complex);
    SIGNAL msq_vec_next  : mag_array_t  := (OTHERS => 0);

    --------------------------------------------------------------------
    -- Pipeline por ordem
    --------------------------------------------------------------------
    SIGNAL term_pipe      : term_pipe_local_t := (OTHERS => (OTHERS => zero_complex));
    SIGNAL msq_pipe       : mag_pipe_local_t  := (OTHERS => (OTHERS => 0));
    SIGNAL term_pipe_next : term_pipe_local_t := (OTHERS => (OTHERS => zero_complex));
    SIGNAL msq_pipe_next  : mag_pipe_local_t  := (OTHERS => (OTHERS => 0));

    --------------------------------------------------------------------
    -- Alinhamento temporal das ordens
    --------------------------------------------------------------------
    SIGNAL align_pipe      : align_pipe_local_t := (OTHERS => (OTHERS => (OTHERS => zero_complex)));
    SIGNAL align_pipe_next : align_pipe_local_t := (OTHERS => (OTHERS => (OTHERS => zero_complex)));

    --------------------------------------------------------------------
    -- Árvore de soma
    --------------------------------------------------------------------
    SIGNAL sum_tree : sum_tree_t := (OTHERS => (OTHERS => zero_acc_complex));

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

                FOR m IN 1 TO n_signals_used - 1 LOOP
                    temp_delay(m) := delay_line(m - 1);
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
    -- 3. Pipeline por ordem
    --------------------------------------------------------------------
    gen_term_stage0 : FOR m IN 0 TO n_signals_used - 1 GENERATE
    BEGIN
        term_pipe_next(0, m) <= base_vec(m);
        msq_pipe_next(0, m)  <= msq_vec(m);
    END GENERATE;

    gen_term_stages : FOR s IN 1 TO max_poly_degree - 1 GENERATE
        gen_term_delay : FOR m IN 0 TO n_signals_used - 1 GENERATE
        BEGIN
            term_pipe_next(s, m).reall <= clip_data(
                readeq(term_pipe(s - 1, m).reall * msq_pipe(s - 1, m))
            );

            term_pipe_next(s, m).imag <= clip_data(
                readeq(term_pipe(s - 1, m).imag * msq_pipe(s - 1, m))
            );

            msq_pipe_next(s, m) <= msq_pipe(s - 1, m);
        END GENERATE;
    END GENERATE;

    terms_pipe_process : PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                term_pipe <= (OTHERS => (OTHERS => zero_complex));
                msq_pipe  <= (OTHERS => (OTHERS => 0));
            ELSE
                term_pipe <= term_pipe_next;
                msq_pipe  <= msq_pipe_next;
            END IF;
        END IF;
    END PROCESS;

    --------------------------------------------------------------------
    -- 4. Alinhamento temporal das ordens
    --------------------------------------------------------------------
    gen_align_in : FOR p IN 0 TO max_poly_degree - 1 GENERATE
        gen_align_in_delay : FOR m IN 0 TO n_signals_used - 1 GENERATE
        BEGIN
            align_pipe_next(0, p, m) <= term_pipe(p, m);
        END GENERATE;
    END GENERATE;

    gen_align_shift : FOR d IN 1 TO max_poly_degree - 1 GENERATE
        gen_align_order : FOR p IN 0 TO max_poly_degree - 1 GENERATE
            gen_align_delay : FOR m IN 0 TO n_signals_used - 1 GENERATE
            BEGIN
                align_pipe_next(d, p, m) <= align_pipe(d - 1, p, m);
            END GENERATE;
        END GENERATE;
    END GENERATE;

    align_process : PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                align_pipe <= (OTHERS => (OTHERS => (OTHERS => zero_complex)));
            ELSE
                align_pipe <= align_pipe_next;
            END IF;
        END IF;
    END PROCESS;

    --------------------------------------------------------------------
    -- 5. Empacotamento linear dos termos alinhados em XX
    --------------------------------------------------------------------
    pack_xx_process : PROCESS(clk)
        VARIABLE temp_xx : power_vector_t;
        VARIABLE idx     : INTEGER;
        VARIABLE dsel    : INTEGER;
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                XX <= (OTHERS => zero_complex);
            ELSE
                temp_xx := (OTHERS => zero_complex);
                idx := 0;

                FOR m IN 0 TO n_signals_used - 1 LOOP
                    FOR p IN 0 TO poly_degree_per_delay(m) - 1 LOOP
                        dsel := max_poly_degree - 1 - p;
                        temp_xx(idx) := align_pipe(dsel, p, m);
                        idx := idx + 1;
                    END LOOP;
                END LOOP;

                XX <= temp_xx;
            END IF;
        END IF;
    END PROCESS;

    --------------------------------------------------------------------
    -- 6. Multiplicação paralela pelos coeficientes
    --------------------------------------------------------------------
    gen_mult : FOR k IN 0 TO n_total_terms - 1 GENERATE
    BEGIN
        multiplied_next(k) <= cmul(coefficients(k), XX(k));
    END GENERATE;

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
    -- 7. Árvore de soma combinacional
    --------------------------------------------------------------------
    gen_sum_input : FOR k IN 0 TO n_total_terms - 1 GENERATE
    BEGIN
        sum_tree(0, k).reall <= multiplied(k).reall;
        sum_tree(0, k).imag  <= multiplied(k).imag;
    END GENERATE;

    gen_sum_levels : FOR level IN 1 TO SUM_LEVELS GENERATE
        gen_sum_nodes : FOR k IN 0 TO n_total_terms - 1 GENERATE
        BEGIN
            valid_pair : IF (2 * k + 1) < level_size(level - 1) GENERATE
            BEGIN
                sum_tree(level, k).reall <=
                    sum_tree(level - 1, 2 * k).reall +
                    sum_tree(level - 1, 2 * k + 1).reall;

                sum_tree(level, k).imag <=
                    sum_tree(level - 1, 2 * k).imag +
                    sum_tree(level - 1, 2 * k + 1).imag;
            END GENERATE;

            valid_single : IF ((2 * k) < level_size(level - 1)) AND
                              ((2 * k + 1) >= level_size(level - 1)) GENERATE
            BEGIN
                sum_tree(level, k) <= sum_tree(level - 1, 2 * k);
            END GENERATE;

            invalid_node : IF (2 * k) >= level_size(level - 1) GENERATE
            BEGIN
                sum_tree(level, k) <= zero_acc_complex;
            END GENERATE;
        END GENERATE;
    END GENERATE;

    --------------------------------------------------------------------
    -- 8. Registro da soma final
    --------------------------------------------------------------------
    sum_process : PROCESS(clk)
        VARIABLE acc_re, acc_im : INTEGER;
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                UR_out <= (OTHERS => '0');
                UI_out <= (OTHERS => '0');
            ELSE
                acc_re := sum_tree(SUM_LEVELS, 0).reall;
                acc_im := sum_tree(SUM_LEVELS, 0).imag;

                UR_out <= STD_LOGIC_VECTOR(to_signed(clip_data(acc_re), n_bits_resolution));
                UI_out <= STD_LOGIC_VECTOR(to_signed(clip_data(acc_im), n_bits_resolution));
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE;
