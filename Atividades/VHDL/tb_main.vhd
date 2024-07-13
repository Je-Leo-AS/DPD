library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_main is
end tb_main;

architecture behavior of tb_main is
    constant n_bits_resolution : INTEGER := 9;
    constant n_bits_overflow : INTEGER := 10;
    constant n_signals_used : INTEGER := 2;
    constant n_polygnos_degree : INTEGER := 2;
    -- Component Declaration for the Unit Under Test (UUT)
    component test_power
        generic(
            n_bits_overflow : INTEGER;
            n_signals_used : INTEGER;
            n_polygnos_degree : INTEGER
        );
        port(
            reset : in std_logic;
            clk : in std_logic;
            U : in signed;
	    U_out_int : out integer;
            U_out : out signed
        );
    end component;

    -- Signals for connecting to UUT
    signal reset : std_logic := '0';
    signal clk : std_logic := '0';
    signal U : signed(n_bits_resolution downto 0) := (others => '0');
    signal U_out_int : integer;
    signal U_out : signed(n_bits_resolution downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: test_power
        generic map(
            n_bits_overflow => n_bits_overflow,
            n_signals_used => n_signals_used,
            n_polygnos_degree => n_polygnos_degree
        )
        port map(
            reset => reset,
            clk => clk,
            U => U,
	    U_out_int => U_out_int,
            U_out => U_out
        );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initialize Inputs
        reset <= '1';
        wait for clk_period/2;
        reset <= '0';
	wait for clk_period/2;
        U <= to_signed(2, n_bits_resolution + 1);
        wait for clk_period;
        
        U <= to_signed(-3, n_bits_resolution + 1);
        wait for clk_period;
        
        U <= to_signed(4, n_bits_resolution + 1);
        wait for clk_period;
        
        -- Add stimulus here
        wait;
    end process;

end behavior;
