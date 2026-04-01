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

    SIGNAL delay_line : delay_line_t  := (OTHERS => (reall => 0, imag => 0));
    SIGNAL mag2       : mag_array_t   := (OTHERS => 0);
    SIGNAL XX         : power_matrix_t := (OTHERS => (OTHERS => (reall => 0, imag => 0)));
    SIGNAL multiplied : power_matrix_t := (OTHERS => (OTHERS => (reall => 0, imag => 0)));

BEGIN

    --------------------------------------------------------------------
    -- 1. Delay line: x[n], x[n-1], x[n-2], ...
    --------------------------------------------------------------------
    delay_process : PROCESS(clk)
        VARIABLE din        : complex_number;
        VARIABLE temp_delay : delay_line_t;
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                delay_line <= (OTHERS => (reall => 0, imag => 0));
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
    -- 2. Cálculo de |x[n-m]|² para cada atraso
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
    -- 3. Geração da matriz XX no estilo mp_int
    --
    -- XX(m,0) = x[n-m]
    -- XX(m,1) = x[n-m] * |x[n-m]|²
    -- XX(m,2) = x[n-m] * |x[n-m]|⁴
    -- ...
    --
    -- Se p exceder poly_degree_per_delay(m), o termo é zerado.
    --------------------------------------------------------------------
    power_process : PROCESS(clk)
        VARIABLE temp_xx : power_matrix_t;
        VARIABLE rr, ii  : INTEGER;
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                XX <= (OTHERS => (OTHERS => (reall => 0, imag => 0)));
            ELSE
                FOR m IN 0 TO n_signals_used-1 LOOP

                    -- termo linear sempre existe se grau >= 1
                    IF poly_degree_per_delay(m) >= 1 THEN
                        temp_xx(m,0) := delay_line(m);
                    ELSE
                        temp_xx(m,0) := zero_complex;
                    END IF;

                    -- termos de ordem superior
                    FOR p IN 1 TO max_poly_degree-1 LOOP
                        IF p < poly_degree_per_delay(m) THEN
                            rr := readeq(temp_xx(m,p-1).reall * mag2(m));
                            ii := readeq(temp_xx(m,p-1).imag  * mag2(m));

                            temp_xx(m,p).reall := clip_data(rr);
                            temp_xx(m,p).imag  := clip_data(ii);
                        ELSE
                            temp_xx(m,p) := zero_complex;
                        END IF;
                    END LOOP;

                END LOOP;

                XX <= temp_xx;
            END IF;
        END IF;
    END PROCESS;

    --------------------------------------------------------------------
    -- 4. Multiplicação complexa por coeficientes
    -- equivalente ao MultiplicadorMatrizes
    --------------------------------------------------------------------
    mult_process : PROCESS(clk)
        VARIABLE temp_mult : power_matrix_t;
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                multiplied <= (OTHERS => (OTHERS => (reall => 0, imag => 0)));
            ELSE
                FOR m IN 0 TO n_signals_used-1 LOOP
                    FOR p IN 0 TO max_poly_degree-1 LOOP
                        IF p < poly_degree_per_delay(m) THEN
                            temp_mult(m,p) := cmul(coefficients(m,p), XX(m,p));
                        ELSE
                            temp_mult(m,p) := zero_complex;
                        END IF;
                    END LOOP;
                END LOOP;

                multiplied <= temp_mult;
            END IF;
        END IF;
    END PROCESS;

    --------------------------------------------------------------------
    -- 5. Soma final de todos os termos
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

                FOR m IN 0 TO n_signals_used-1 LOOP
                    FOR p IN 0 TO max_poly_degree-1 LOOP
                        acc_re := acc_re + multiplied(m,p).reall;
                        acc_im := acc_im + multiplied(m,p).imag;
                    END LOOP;
                END LOOP;

                UR_out <= STD_LOGIC_VECTOR(to_signed(clip_data(acc_re), n_bits_resolution));
                UI_out <= STD_LOGIC_VECTOR(to_signed(clip_data(acc_im), n_bits_resolution));
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE;