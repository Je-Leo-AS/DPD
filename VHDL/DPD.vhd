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

    TYPE term_matrix_t IS ARRAY (0 TO n_signals_used - 1,
                                 0 TO n_polygnos_degree - 1)
                                 OF complex_number;

    SIGNAL x_in       : complex_number;
    SIGNAL delay_line : delay_line_t := (OTHERS => (0,0));
    SIGNAL terms      : term_matrix_t := (OTHERS => (OTHERS => (0,0)));

BEGIN

----------------------------------------------------------------------
-- INPUT
----------------------------------------------------------------------
process(clk)
begin
    if rising_edge(clk) then
        if reset = '1' then
            x_in <= (0,0);
        else
            x_in <= (
                reall => to_integer(signed(UR)),
                imag  => to_integer(signed(UI))
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
            delay_line <= (OTHERS => (0,0));
        else
            delay_line(0) <= x_in;

            for i in 1 to n_signals_used-1 loop
                delay_line(i) <= delay_line(i-1);
            end loop;
        end if;
    end if;
end process;

----------------------------------------------------------------------
-- TERMS (FIXADO: SEM "*")
----------------------------------------------------------------------
gen_i: for i in 0 to n_signals_used-1 generate
    gen_j: for j in 0 to n_polygnos_degree-1 generate

        terms(i, j) <= multiplication(
            delay_line(i),
            (reall => 1, imag => 0)
        );

    end generate;
end generate;

----------------------------------------------------------------------
-- SUM
----------------------------------------------------------------------
process(clk)
    variable rsum, isum : integer := 0;
begin
    if rising_edge(clk) then
        if reset = '1' then
            UR_out <= (others => '0');
            UI_out <= (others => '0');
        else

            rsum := 0;
            isum := 0;

            for i in 0 to n_signals_used-1 loop
                for j in 0 to n_polygnos_degree-1 loop
                    rsum := rsum + terms(i, j).reall;
                    isum := isum + terms(i, j).imag;
                end loop;
            end loop;

            UR_out <= std_logic_vector(to_signed(rsum, UR_out'length));
            UI_out <= std_logic_vector(to_signed(isum, UI_out'length));

        end if;
    end if;
end process;

END ARCHITECTURE;