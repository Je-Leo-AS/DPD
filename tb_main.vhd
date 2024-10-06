--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY tb IS
END tb;
 
ARCHITECTURE behavior OF tb IS 
    CONSTANT n_bits_resolution : INTEGER := 9;
    CONSTANT n_bits_overflow : INTEGER := 8;
    CONSTANT n_signals_used : INTEGER := 2;
    CONSTANT n_polygnos_degree : INTEGER := 2;
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT dpd
        PORT (
            reset : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            UR : IN STD_LOGIC_VECTOR(n_bits_resolution - 1 DOWNTO 0);
            UI : IN STD_LOGIC_VECTOR(n_bits_resolution - 1 DOWNTO 0);
            UR_out : OUT STD_LOGIC_VECTOR(n_bits_resolution - 1 DOWNTO 0);
            UI_out : OUT STD_LOGIC_VECTOR(n_bits_resolution - 1 DOWNTO 0)
        );
    END COMPONENT;

    -- Signals for connecting to UUT
    SIGNAL reset : STD_LOGIC := '0';
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL UR : STD_LOGIC_VECTOR(n_bits_resolution - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL UI : STD_LOGIC_VECTOR(n_bits_resolution - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL UR_out : STD_LOGIC_VECTOR(n_bits_resolution - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL UI_out : STD_LOGIC_VECTOR(n_bits_resolution - 1 DOWNTO 0);

    -- Clock period definition
    CONSTANT clk_period : TIME := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DPD PORT MAP (
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
      wait;
   end process;

      -- in process
   calc_proc: process
   begin		
      reset <= '1';
      wait for 2 * clk_period;	
      reset <= '0';
      WAIT FOR clk_period;
      
UR <= "000111101";
UI <= "010100000";
WAIT FOR clk_period;
UR <= "000011100";
UI <= "010100101";
WAIT FOR clk_period;
UR <= "111111001";
UI <= "010100001";
WAIT FOR clk_period;
UR <= "111011010";
UI <= "010010111";
WAIT FOR clk_period;
UR <= "110111101";
UI <= "010001000";
WAIT FOR clk_period;
UR <= "110100101";
UI <= "001110100";
WAIT FOR clk_period;
UR <= "110001111";
UI <= "001011110";
WAIT FOR clk_period;
UR <= "101111110";
UI <= "001001000";
WAIT FOR clk_period;
UR <= "101110000";
UI <= "000110101";
WAIT FOR clk_period;
UR <= "101100110";
UI <= "000100100";
WAIT FOR clk_period;
UR <= "101011111";
UI <= "000011010";
WAIT FOR clk_period;
UR <= "101011011";
UI <= "000010101";
WAIT FOR clk_period;
UR <= "101011010";
UI <= "000010111";
WAIT FOR clk_period;
UR <= "101011011";
UI <= "000011100";
WAIT FOR clk_period;
UR <= "101011100";
UI <= "000100110";
WAIT FOR clk_period;
UR <= "101011110";
UI <= "000101111";
WAIT FOR clk_period;
UR <= "101100000";
UI <= "000111001";
WAIT FOR clk_period;
UR <= "101100010";
UI <= "000111110";
WAIT FOR clk_period;
UR <= "101100001";
UI <= "000111111";
WAIT FOR clk_period;
UR <= "101011111";
UI <= "000111011";
WAIT FOR clk_period;
UR <= "101011010";
UI <= "000110010";
WAIT FOR clk_period;
UR <= "101010100";
UI <= "000100101";
WAIT FOR clk_period;
UR <= "101010000";
UI <= "000010110";
WAIT FOR clk_period;
UR <= "101001011";
UI <= "000001011";
WAIT FOR clk_period;
UR <= "101000111";
UI <= "000000011";
WAIT FOR clk_period;
UR <= "101001001";
UI <= "000000001";
WAIT FOR clk_period;
UR <= "101001111";
UI <= "000001000";
WAIT FOR clk_period;
UR <= "101011011";
UI <= "000011000";
WAIT FOR clk_period;
UR <= "101101101";
UI <= "000110001";
WAIT FOR clk_period;
UR <= "110000011";
UI <= "001010000";
WAIT FOR clk_period;
UR <= "110011110";
UI <= "001110010";
WAIT FOR clk_period;
UR <= "110111101";
UI <= "010010011";
WAIT FOR clk_period;
UR <= "111011011";
UI <= "010110001";
WAIT FOR clk_period;
UR <= "111111000";
UI <= "011000101";
WAIT FOR clk_period;
UR <= "000010011";
UI <= "011001011";
WAIT FOR clk_period;
UR <= "000101000";
UI <= "011000011";
WAIT FOR clk_period;
UR <= "000111000";
UI <= "010101100";
WAIT FOR clk_period;
UR <= "001000000";
UI <= "010000111";
WAIT FOR clk_period;
UR <= "001000001";
UI <= "001010101";
WAIT FOR clk_period;
UR <= "000111100";
UI <= "000011110";
WAIT FOR clk_period;
UR <= "000101111";
UI <= "111100100";
WAIT FOR clk_period;
UR <= "000011100";
UI <= "110101101";
WAIT FOR clk_period;
UR <= "000000110";
UI <= "110000000";
WAIT FOR clk_period;
UR <= "111101111";
UI <= "101011100";
WAIT FOR clk_period;
UR <= "111010110";
UI <= "101001010";
WAIT FOR clk_period;
UR <= "110111100";
UI <= "101001001";
WAIT FOR clk_period;
UR <= "110100011";
UI <= "101010101";
WAIT FOR clk_period;
UR <= "110001111";
UI <= "101110001";
WAIT FOR clk_period;
UR <= "101111101";
UI <= "110010110";
WAIT FOR clk_period;
UR <= "101101101";
UI <= "111000001";
WAIT FOR clk_period;

      -- insert stimulus here 
      wait;
   end process;
    
END;
