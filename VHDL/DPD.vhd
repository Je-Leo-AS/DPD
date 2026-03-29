LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.functions.ALL;

ENTITY DPD IS
PORT (
    clk   : IN STD_LOGIC;
    reset : IN STD_LOGIC;

    UR    : IN STD_LOGIC_VECTOR(n_bits_resolution - 1 DOWNTO 0);
    UI    : IN STD_LOGIC_VECTOR(n_bits_resolution - 1 DOWNTO 0);

    UR_out : OUT STD_LOGIC_VECTOR(n_bits_resolution - 1 DOWNTO 0);
    UI_out : OUT STD_LOGIC_VECTOR(n_bits_resolution - 1 DOWNTO 0)
);
END ENTITY;

ARCHITECTURE rtl OF DPD IS

    TYPE term_matrix_t IS ARRAY (
        0 TO n_signals_used - 1,
        0 TO n_polygnos_degree - 1
    ) OF complex_number;

    SIGNAL x_in       : complex_number;
    SIGNAL delay_line : delay_line_t := (OTHERS => ZERO_COMPLEX);
    TYPE mag_array_t IS ARRAY (0 TO n_signals_used-1) OF data_t;
    SIGNAL mag2       : mag_array_t;
    SIGNAL terms      : term_matrix_t := (OTHERS => (OTHERS => ZERO_COMPLEX));

BEGIN

----------------------------------------------------------------------
-- INPUT
----------------------------------------------------------------------
process(clk)
begin
    if rising_edge(clk) then
        if reset = '1' then
            x_in <= ZERO_COMPLEX;
        else
            x_in <= (
                reall => signed(UR),
                imag  => signed(UI)
            );
        end if;
    end if;
end process;

----------------------------------------------------------------------
-- DELAY LINE
----------------------------------------------------------------------
process(clk)
begin
    if rising_edge(clk) then
        if reset = '1' then
            delay_line <= (OTHERS => ZERO_COMPLEX);
        else
            delay_line(0) <= x_in;

            for i in 1 to n_signals_used-1 loop
                delay_line(i) <= delay_line(i-1);
            end loop;
        end if;
    end if;
end process;

----------------------------------------------------------------------
-- |x|^2
----------------------------------------------------------------------
process(clk)
begin
    if rising_edge(clk) then
        for i in 0 to n_signals_used-1 loop
            mag2(i) <= shift_right(
                delay_line(i).reall * delay_line(i).reall +
                delay_line(i).imag  * delay_line(i).imag,
                n_bits_resolution/2
            );
        end loop;
    end if;
end process;

----------------------------------------------------------------------
-- NONLINEAR TERMS
----------------------------------------------------------------------
process(clk)
begin
    if rising_edge(clk) then

        for i in 0 to n_signals_used-1 loop

            -- p = 0 (linear)
            terms(i,0) <= delay_line(i);

            -- p > 0
            for j in 1 to n_polygnos_degree-1 loop

                terms(i,j).reall <= shift_right(
                    terms(i,j-1).reall * mag2(i),
                    n_bits_resolution/2
                );

                terms(i,j).imag <= shift_right(
                    terms(i,j-1).imag * mag2(i),
                    n_bits_resolution/2
                );

            end loop;
        end loop;

    end if;
end process;

----------------------------------------------------------------------
-- MULTIPLY BY COEFFICIENTS + SUM
----------------------------------------------------------------------
process(clk)
    variable acc_re : acc_t;
    variable acc_im : acc_t;

    variable mult_re, mult_im : acc_t;

begin
    if rising_edge(clk) then

        acc_re := (others => '0');
        acc_im := (others => '0');

        for i in 0 to n_signals_used-1 loop
            for j in 0 to n_polygnos_degree-1 loop

                -- multiplicação complexa manual
                mult_re := resize(
                    shift_right(
                        coefficients(i,j).reall * terms(i,j).reall -
                        coefficients(i,j).imag  * terms(i,j).imag,
                        n_bits_resolution/2
                    ),
                    acc_re'length
                );

                mult_im := resize(
                    shift_right(
                        coefficients(i,j).reall * terms(i,j).imag +
                        coefficients(i,j).imag  * terms(i,j).reall,
                        n_bits_resolution/2
                    ),
                    acc_im'length
                );

                acc_re := acc_re + mult_re;
                acc_im := acc_im + mult_im;

            end loop;
        end loop;

        UR_out <= std_logic_vector(resize(acc_re, n_bits_resolution));
        UI_out <= std_logic_vector(resize(acc_im, n_bits_resolution));

    end if;
end process;

END ARCHITECTURE;