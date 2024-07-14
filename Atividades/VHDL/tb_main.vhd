LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY tb_main IS
END tb_main;

ARCHITECTURE behavior OF tb_main IS
    CONSTANT n_bits_resolution : INTEGER := 9;
    CONSTANT n_bits_overflow : INTEGER := 10;
    CONSTANT n_signals_used : INTEGER := 2;
    CONSTANT n_polygnos_degree : INTEGER := 2;
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT test_power
        GENERIC (
            n_bits_overflow : INTEGER;
            n_signals_used : INTEGER;
            n_polygnos_degree : INTEGER
        );
        PORT (
            reset : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            U : IN signed;
            U_out_int : OUT INTEGER;
            U_out : OUT signed
        );
    END COMPONENT;

    -- Signals for connecting to UUT
    SIGNAL reset : STD_LOGIC := '0';
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL U : signed(n_bits_resolution DOWNTO 0) := (OTHERS => '0');
    SIGNAL U_out_int : INTEGER;
    SIGNAL U_out : signed(n_bits_resolution DOWNTO 0);

    -- Clock period definition
    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut : test_power
    GENERIC MAP(
        n_bits_overflow => n_bits_overflow,
        n_signals_used => n_signals_used,
        n_polygnos_degree => n_polygnos_degree
    )
    PORT MAP(
        reset => reset,
        clk => clk,
        U => U,
        U_out_int => U_out_int,
        U_out => U_out
    );

    -- Clock process definitions
    clk_process : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR clk_period/2;
        clk <= '1';
        WAIT FOR clk_period/2;
    END PROCESS;

    -- Stimulus process
    stim_proc : PROCESS
    BEGIN
        -- Initialize Inputs
        reset <= '1';
        WAIT FOR clk_period/2;
        reset <= '0';
        WAIT FOR clk_period/2;
        U <= to_signed(2, n_bits_resolution + 1);
        WAIT FOR clk_period;

        U <= to_signed(-3, n_bits_resolution + 1);
        WAIT FOR clk_period;

        U <= to_signed(4, n_bits_resolution + 1);
        WAIT FOR clk_period;

        -- Add stimulus here
        WAIT;
    END PROCESS;

END behavior;