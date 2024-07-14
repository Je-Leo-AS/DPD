library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_main is
end tb_main;

architecture behavior of tb_main is
    constant n_bits_resolution : INTEGER := 9;
    constant n_signals_used : INTEGER := 2;
    constant n_polygnos_degree : INTEGER := 2;

    -- Component Declaration for the Unit Under Test (UUT)
    component DPD
        generic(
            n_signals_used : INTEGER;
            n_polygnos_degree : INTEGER
        );
        port(
            reset : in std_logic;
            clk : in std_logic;
            UR : in signed(n_bits_resolution downto 0);
            UI : in signed(n_bits_resolution downto 0);
            UR_out : out signed(n_bits_resolution downto 0);
            UI_out : out signed(n_bits_resolution downto 0)
        );
    end component;

    -- Signals for connecting to UUT
    signal reset : std_logic := '0';
    signal clk : std_logic := '0';
    signal UR : signed(n_bits_resolution downto 0) := (others => '0');
    signal UI : signed(n_bits_resolution downto 0) := (others => '0');
    signal UR_out : signed(n_bits_resolution downto 0);
    signal UI_out : signed(n_bits_resolution downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: DPD
        generic map(
            n_signals_used => n_signals_used,
            n_polygnos_degree => n_polygnos_degree
        )
        port map(
            reset => reset,
            clk => clk,
            UR => UR,
            UI => UI,
            UR_out => UR_out,
            UI_out => UI_out
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
        wait for clk_period;
        reset <= '0';
        wait for clk_period;

        -- Apply test vectors
        UR <= to_signed(2, n_bits_resolution + 1);
        UI <= to_signed(1, n_bits_resolution + 1);
        wait for n_polygnos_degree * clk_period;

        UR <= to_signed(-3, n_bits_resolution + 1);
        UI <= to_signed(0, n_bits_resolution + 1);
        wait for n_polygnos_degree * clk_period;

        UR <= to_signed(4, n_bits_resolution + 1);
        UI <= to_signed(-2, n_bits_resolution + 1);
        wait for n_polygnos_degree * clk_period;

        -- Add more stimulus here if necessary
        wait;
    end process;

end behavior;

