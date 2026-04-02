--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE ieee.std_logic_textio.ALL;
LIBRARY std;
USE std.env.all;
USE std.textio.ALL;
LIBRARY work;
USE work.functions.ALL;

ENTITY tb IS
END tb;
 
ARCHITECTURE behavior OF tb IS 
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
    CONSTANT clk_period : TIME := 16 ns;
    FILE output_file : TEXT OPEN WRITE_MODE IS "simulation_output.txt";
 
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
 
    write_output : PROCESS(clk)
        VARIABLE line_buffer : LINE;
        VARIABLE data : INTEGER;
    BEGIN
        IF reset = '0' and rising_edge(clk) THEN
            WRITE(line_buffer, to_integer(signed(UR_out)));
            WRITE(line_buffer, STRING'(","));
            WRITE(line_buffer, to_integer(signed(UI_out)));
            WRITE(line_buffer, STRING'("j"));
            WRITELINE(output_file, line_buffer);
        END IF;
    END PROCESS;

      -- in process
   calc_proc: process
   begin		
      reset <= '1';
      wait for 2 * clk_period;	
      reset <= '0';
      WAIT FOR clk_period;
      
    UR <= "00001110011";
    UI <= "11010101010";
    WAIT FOR clk_period;

    UR <= "00001110111";
    UI <= "11010100110";
    WAIT FOR clk_period;

    UR <= "00001110011";
    UI <= "11010111110";
    WAIT FOR clk_period;

    UR <= "00001101000";
    UI <= "11011110001";
    WAIT FOR clk_period;

    UR <= "00001011010";
    UI <= "11100110111";
    WAIT FOR clk_period;

    UR <= "00001001101";
    UI <= "11110000111";
    WAIT FOR clk_period;

    UR <= "00001000100";
    UI <= "11111011010";
    WAIT FOR clk_period;

    UR <= "00001000001";
    UI <= "00000100100";
    WAIT FOR clk_period;

    UR <= "00001000101";
    UI <= "00001011110";
    WAIT FOR clk_period;

    UR <= "00001010010";
    UI <= "00010000010";
    WAIT FOR clk_period;

    UR <= "00001100100";
    UI <= "00010001101";
    WAIT FOR clk_period;

    UR <= "00001111100";
    UI <= "00001111101";
    WAIT FOR clk_period;

    UR <= "00010010110";
    UI <= "00001011000";
    WAIT FOR clk_period;

    UR <= "00010110001";
    UI <= "00000100000";
    WAIT FOR clk_period;

    UR <= "00011001011";
    UI <= "11111011111";
    WAIT FOR clk_period;

    UR <= "00011100010";
    UI <= "11110011011";
    WAIT FOR clk_period;

    UR <= "00011110110";
    UI <= "11101011011";
    WAIT FOR clk_period;

    UR <= "00100000111";
    UI <= "11100100111";
    WAIT FOR clk_period;

    UR <= "00100010100";
    UI <= "11100000000";
    WAIT FOR clk_period;

    UR <= "00100011110";
    UI <= "11011101010";
    WAIT FOR clk_period;

    UR <= "00100100101";
    UI <= "11011100100";
    WAIT FOR clk_period;

    UR <= "00100100111";
    UI <= "11011101011";
    WAIT FOR clk_period;

    UR <= "00100100101";
    UI <= "11011111101";
    WAIT FOR clk_period;

    UR <= "00100011100";
    UI <= "11100010101";
    WAIT FOR clk_period;

    UR <= "00100001100";
    UI <= "11100101111";
    WAIT FOR clk_period;

    UR <= "00011110101";
    UI <= "11101001011";
    WAIT FOR clk_period;

    UR <= "00011010111";
    UI <= "11101100111";
    WAIT FOR clk_period;

    UR <= "00010110010";
    UI <= "11110000100";
    WAIT FOR clk_period;

    UR <= "00010001000";
    UI <= "11110100011";
    WAIT FOR clk_period;

    UR <= "00001011100";
    UI <= "11111001000";
    WAIT FOR clk_period;

    UR <= "00000110001";
    UI <= "11111110100";
    WAIT FOR clk_period;

    UR <= "00000001011";
    UI <= "00000101010";
    WAIT FOR clk_period;

    UR <= "11111101010";
    UI <= "00001101001";
    WAIT FOR clk_period;

    UR <= "11111010010";
    UI <= "00010110000";
    WAIT FOR clk_period;

    UR <= "11111000001";
    UI <= "00011111011";
    WAIT FOR clk_period;

    UR <= "11110110111";
    UI <= "00101000100";
    WAIT FOR clk_period;

    UR <= "11110110010";
    UI <= "00110000100";
    WAIT FOR clk_period;

    UR <= "11110101110";
    UI <= "00110110101";
    WAIT FOR clk_period;

    UR <= "11110101000";
    UI <= "00111010000";
    WAIT FOR clk_period;

    UR <= "11110011101";
    UI <= "00111001111";
    WAIT FOR clk_period;

    UR <= "11110001010";
    UI <= "00110110000";
    WAIT FOR clk_period;

    UR <= "11101110000";
    UI <= "00101110011";
    WAIT FOR clk_period;

    UR <= "11101001110";
    UI <= "00100011101";
    WAIT FOR clk_period;

    UR <= "11100101000";
    UI <= "00010110010";
    WAIT FOR clk_period;

    UR <= "11100000000";
    UI <= "00000111101";
    WAIT FOR clk_period;

    UR <= "11011011100";
    UI <= "11111000110";
    WAIT FOR clk_period;

    UR <= "11011000000";
    UI <= "11101011001";
    WAIT FOR clk_period;

    UR <= "11010101110";
    UI <= "11011111110";
    WAIT FOR clk_period;

    UR <= "11010101011";
    UI <= "11010111011";
    WAIT FOR clk_period;

    UR <= "11010110110";
    UI <= "11010010010";
    WAIT FOR clk_period;

    UR <= "11011001110";
    UI <= "11010000100";
    WAIT FOR clk_period;

    UR <= "11011110000";
    UI <= "11010001101";
    WAIT FOR clk_period;

    UR <= "11100011000";
    UI <= "11010100101";
    WAIT FOR clk_period;

    UR <= "11101000010";
    UI <= "11011000100";
    WAIT FOR clk_period;

    UR <= "11101101001";
    UI <= "11011100010";
    WAIT FOR clk_period;

    UR <= "11110001010";
    UI <= "11011110111";
    WAIT FOR clk_period;

    UR <= "11110100011";
    UI <= "11011111110";
    WAIT FOR clk_period;

    UR <= "11110110100";
    UI <= "11011110101";
    WAIT FOR clk_period;

    UR <= "11110111110";
    UI <= "11011100000";
    WAIT FOR clk_period;

    UR <= "11111000101";
    UI <= "11011000101";
    WAIT FOR clk_period;

    UR <= "11111001100";
    UI <= "11010101011";
    WAIT FOR clk_period;

    UR <= "11111011000";
    UI <= "11010011110";
    WAIT FOR clk_period;

    UR <= "11111101010";
    UI <= "11010100111";
    WAIT FOR clk_period;

    UR <= "00000000110";
    UI <= "11011001101";
    WAIT FOR clk_period;

    UR <= "00000101010";
    UI <= "11100010100";
    WAIT FOR clk_period;

    UR <= "00001010110";
    UI <= "11101111011";
    WAIT FOR clk_period;

    UR <= "00010000011";
    UI <= "11111111010";
    WAIT FOR clk_period;

    UR <= "00010101111";
    UI <= "00010001000";
    WAIT FOR clk_period;

    UR <= "00011010010";
    UI <= "00100010101";
    WAIT FOR clk_period;

    UR <= "00011101000";
    UI <= "00110010001";
    WAIT FOR clk_period;

    UR <= "00011101100";
    UI <= "00111101101";
    WAIT FOR clk_period;

    UR <= "00011011011";
    UI <= "01000011100";
    WAIT FOR clk_period;

    UR <= "00010110110";
    UI <= "01000010111";
    WAIT FOR clk_period;

    UR <= "00001111111";
    UI <= "00111011101";
    WAIT FOR clk_period;

    UR <= "00000111001";
    UI <= "00101110011";
    WAIT FOR clk_period;

    UR <= "11111101011";
    UI <= "00011100110";
    WAIT FOR clk_period;

    UR <= "11110011100";
    UI <= "00001000101";
    WAIT FOR clk_period;

    UR <= "11101010010";
    UI <= "11110100100";
    WAIT FOR clk_period;

    UR <= "11100010110";
    UI <= "11100010101";
    WAIT FOR clk_period;

    UR <= "11011101011";
    UI <= "11010100111";
    WAIT FOR clk_period;

    UR <= "11011011000";
    UI <= "11001100101";
    WAIT FOR clk_period;

    UR <= "11011011110";
    UI <= "11001010100";
    WAIT FOR clk_period;

    UR <= "11011111101";
    UI <= "11001101111";
    WAIT FOR clk_period;

    UR <= "11100110101";
    UI <= "11010101111";
    WAIT FOR clk_period;

    UR <= "11110000001";
    UI <= "11100000110";
    WAIT FOR clk_period;

    UR <= "11111011110";
    UI <= "11101100010";
    WAIT FOR clk_period;

    UR <= "00001000110";
    UI <= "11110110100";
    WAIT FOR clk_period;

    UR <= "00010110011";
    UI <= "11111101110";
    WAIT FOR clk_period;

    UR <= "00100011110";
    UI <= "00000000111";
    WAIT FOR clk_period;

    UR <= "00101111111";
    UI <= "11111111010";
    WAIT FOR clk_period;

    UR <= "00111010001";
    UI <= "11111001011";
    WAIT FOR clk_period;

    UR <= "01000001110";
    UI <= "11110000001";
    WAIT FOR clk_period;

    UR <= "01000101111";
    UI <= "11100101001";
    WAIT FOR clk_period;

    UR <= "01000110010";
    UI <= "11011010000";
    WAIT FOR clk_period;

    UR <= "01000010101";
    UI <= "11010000100";
    WAIT FOR clk_period;

    UR <= "00111011000";
    UI <= "11001010000";
    WAIT FOR clk_period;

    UR <= "00101111110";
    UI <= "11000111011";
    WAIT FOR clk_period;

    UR <= "00100001101";
    UI <= "11001001001";
    WAIT FOR clk_period;

    UR <= "00010001101";
    UI <= "11001110101";
    WAIT FOR clk_period;

    UR <= "00000001000";
    UI <= "11010111011";
    WAIT FOR clk_period;

    UR <= "11110001000";
    UI <= "11100001111";
    WAIT FOR clk_period;

    UR <= "11100011000";
    UI <= "11101100110";
    WAIT FOR clk_period;

    UR <= "11011000001";
    UI <= "11110110111";
    WAIT FOR clk_period;

    UR <= "11010001100";
    UI <= "11111110111";
    WAIT FOR clk_period;

    UR <= "11001111100";
    UI <= "00000100000";
    WAIT FOR clk_period;

    UR <= "11010010010";
    UI <= "00000101111";
    WAIT FOR clk_period;

    UR <= "11011001100";
    UI <= "00000100100";
    WAIT FOR clk_period;

    UR <= "11100100011";
    UI <= "00000000010";
    WAIT FOR clk_period;

    UR <= "11110001101";
    UI <= "11111001110";
    WAIT FOR clk_period;

    UR <= "00000000000";
    UI <= "11110001101";
    WAIT FOR clk_period;

    UR <= "00001110000";
    UI <= "11101000110";
    WAIT FOR clk_period;

    UR <= "00011010011";
    UI <= "11011111111";
    WAIT FOR clk_period;

    UR <= "00100011111";
    UI <= "11010111100";
    WAIT FOR clk_period;

    UR <= "00101010000";
    UI <= "11010000011";
    WAIT FOR clk_period;

    UR <= "00101100011";
    UI <= "11001010111";
    WAIT FOR clk_period;

    UR <= "00101011001";
    UI <= "11000111011";
    WAIT FOR clk_period;

    UR <= "00100110110";
    UI <= "11000110010";
    WAIT FOR clk_period;

    UR <= "00011111111";
    UI <= "11000111110";
    WAIT FOR clk_period;

    UR <= "00010111110";
    UI <= "11001011111";
    WAIT FOR clk_period;

    UR <= "00001111001";
    UI <= "11010010110";
    WAIT FOR clk_period;

    UR <= "00000110111";
    UI <= "11011100001";
    WAIT FOR clk_period;

    UR <= "11111111111";
    UI <= "11100111011";
    WAIT FOR clk_period;

    UR <= "11111010100";
    UI <= "11110011110";
    WAIT FOR clk_period;

    UR <= "11110111000";
    UI <= "00000000011";
    WAIT FOR clk_period;

    UR <= "11110101010";
    UI <= "00001100000";
    WAIT FOR clk_period;

    UR <= "11110101001";
    UI <= "00010101011";
    WAIT FOR clk_period;

    UR <= "11110110010";
    UI <= "00011011011";
    WAIT FOR clk_period;

    UR <= "11111000001";
    UI <= "00011101100";
    WAIT FOR clk_period;

    UR <= "11111010100";
    UI <= "00011011001";
    WAIT FOR clk_period;

    UR <= "11111100110";
    UI <= "00010100101";
    WAIT FOR clk_period;

    UR <= "11111110101";
    UI <= "00001010111";
    WAIT FOR clk_period;

    UR <= "00000000000";
    UI <= "11111111000";
    WAIT FOR clk_period;

    UR <= "00000000100";
    UI <= "11110010110";
    WAIT FOR clk_period;

    UR <= "00000000001";
    UI <= "11100111110";
    WAIT FOR clk_period;

    UR <= "11111110110";
    UI <= "11100000000";
    WAIT FOR clk_period;

    UR <= "11111100011";
    UI <= "11011100100";
    WAIT FOR clk_period;

    UR <= "11111001000";
    UI <= "11011110011";
    WAIT FOR clk_period;

    UR <= "11110101000";
    UI <= "11100101100";
    WAIT FOR clk_period;

    UR <= "11110000100";
    UI <= "11110001100";
    WAIT FOR clk_period;

    UR <= "11101011110";
    UI <= "00000001001";
    WAIT FOR clk_period;

    UR <= "11100111100";
    UI <= "00010010100";
    WAIT FOR clk_period;

    UR <= "11100100000";
    UI <= "00100011110";
    WAIT FOR clk_period;

    UR <= "11100010000";
    UI <= "00110010111";
    WAIT FOR clk_period;

    UR <= "11100001110";
    UI <= "00111110010";
    WAIT FOR clk_period;

    UR <= "11100011110";
    UI <= "01000100101";
    WAIT FOR clk_period;

    UR <= "11101000000";
    UI <= "01000101001";
    WAIT FOR clk_period;

    UR <= "11101110100";
    UI <= "01000000001";
    WAIT FOR clk_period;

    UR <= "11110110110";
    UI <= "00110110010";
    WAIT FOR clk_period;

    UR <= "00000000000";
    UI <= "00101000110";
    WAIT FOR clk_period;

    UR <= "00001001100";
    UI <= "00011001010";
    WAIT FOR clk_period;

    UR <= "00010010010";
    UI <= "00001001010";
    WAIT FOR clk_period;

    UR <= "00011001011";
    UI <= "11111010101";
    WAIT FOR clk_period;

    UR <= "00011110000";
    UI <= "11101110101";
    WAIT FOR clk_period;

    UR <= "00011111111";
    UI <= "11100110010";
    WAIT FOR clk_period;

    UR <= "00011110110";
    UI <= "11100010001";
    WAIT FOR clk_period;

    UR <= "00011011000";
    UI <= "11100010010";
    WAIT FOR clk_period;

    UR <= "00010101000";
    UI <= "11100110011";
    WAIT FOR clk_period;

    UR <= "00001110000";
    UI <= "11101101111";
    WAIT FOR clk_period;

    UR <= "00000110111";
    UI <= "11110111111";
    WAIT FOR clk_period;

    UR <= "00000000100";
    UI <= "00000011011";
    WAIT FOR clk_period;

    UR <= "11111100001";
    UI <= "00001111100";
    WAIT FOR clk_period;

    UR <= "11111010000";
    UI <= "00011011010";
    WAIT FOR clk_period;

    UR <= "11111010011";
    UI <= "00100101111";
    WAIT FOR clk_period;

    UR <= "11111101001";
    UI <= "00101110100";
    WAIT FOR clk_period;

    UR <= "00000001100";
    UI <= "00110100110";
    WAIT FOR clk_period;

    UR <= "00000110111";
    UI <= "00111000001";
    WAIT FOR clk_period;

    UR <= "00001100011";
    UI <= "00111000100";
    WAIT FOR clk_period;

    UR <= "00010000111";
    UI <= "00110101110";
    WAIT FOR clk_period;

    UR <= "00010100000";
    UI <= "00110000010";
    WAIT FOR clk_period;

    UR <= "00010101011";
    UI <= "00101000010";
    WAIT FOR clk_period;

    UR <= "00010100111";
    UI <= "00011110011";
    WAIT FOR clk_period;

    UR <= "00010011010";
    UI <= "00010011011";
    WAIT FOR clk_period;

    UR <= "00010001001";
    UI <= "00001000011";
    WAIT FOR clk_period;

    UR <= "00001111010";
    UI <= "11111110000";
    WAIT FOR clk_period;

    UR <= "00001110101";
    UI <= "11110101100";
    WAIT FOR clk_period;

    UR <= "00001111111";
    UI <= "11101111010";
    WAIT FOR clk_period;

    UR <= "00010011010";
    UI <= "11101100001";
    WAIT FOR clk_period;

    UR <= "00011000101";
    UI <= "11101100001";
    WAIT FOR clk_period;

    UR <= "00011111010";
    UI <= "11101111001";
    WAIT FOR clk_period;

    UR <= "00100110010";
    UI <= "11110100111";
    WAIT FOR clk_period;

    UR <= "00101100010";
    UI <= "11111100110";
    WAIT FOR clk_period;

    UR <= "00101111110";
    UI <= "00000101110";
    WAIT FOR clk_period;

    UR <= "00101111110";
    UI <= "00001111001";
    WAIT FOR clk_period;

    UR <= "00101011001";
    UI <= "00010111111";
    WAIT FOR clk_period;

    UR <= "00100001111";
    UI <= "00011111011";
    WAIT FOR clk_period;

    UR <= "00010100000";
    UI <= "00100101000";
    WAIT FOR clk_period;

    UR <= "00000010110";
    UI <= "00101000010";
    WAIT FOR clk_period;

    UR <= "11101111011";
    UI <= "00101001010";
    WAIT FOR clk_period;

    UR <= "11011011111";
    UI <= "00100111111";
    WAIT FOR clk_period;

    UR <= "11001010011";
    UI <= "00100100011";
    WAIT FOR clk_period;

    UR <= "10111100101";
    UI <= "00011111010";
    WAIT FOR clk_period;

    UR <= "10110100001";
    UI <= "00011000111";
    WAIT FOR clk_period;

    UR <= "10110010000";
    UI <= "00010001101";
    WAIT FOR clk_period;

    UR <= "10110110010";
    UI <= "00001010001";
    WAIT FOR clk_period;

    UR <= "11000000011";
    UI <= "00000010101";
    WAIT FOR clk_period;

    UR <= "11001111001";
    UI <= "11111011110";
    WAIT FOR clk_period;

    UR <= "11100000110";
    UI <= "11110101110";
    WAIT FOR clk_period;

    UR <= "11110011010";
    UI <= "11110001000";
    WAIT FOR clk_period;

    UR <= "00000100100";
    UI <= "11101101110";
    WAIT FOR clk_period;

    UR <= "00010010100";
    UI <= "11101100010";
    WAIT FOR clk_period;

    UR <= "00011100001";
    UI <= "11101100010";
    WAIT FOR clk_period;

    UR <= "00100000011";
    UI <= "11101101111";
    WAIT FOR clk_period;

    UR <= "00011111011";
    UI <= "11110000101";
    WAIT FOR clk_period;

    UR <= "00011001101";
    UI <= "11110011111";
    WAIT FOR clk_period;

    UR <= "00010000010";
    UI <= "11110111000";
    WAIT FOR clk_period;

    UR <= "00000100111";
    UI <= "11111001010";
    WAIT FOR clk_period;

    UR <= "11111001000";
    UI <= "11111010000";
    WAIT FOR clk_period;

    UR <= "11101110001";
    UI <= "11111000110";
    WAIT FOR clk_period;

    UR <= "11100101101";
    UI <= "11110101010";
    WAIT FOR clk_period;

    UR <= "11100000010";
    UI <= "11101111110";
    WAIT FOR clk_period;

    UR <= "11011110001";
    UI <= "11101000111";
    WAIT FOR clk_period;

    UR <= "11011111010";
    UI <= "11100001011";
    WAIT FOR clk_period;

    UR <= "11100010101";
    UI <= "11011010100";
    WAIT FOR clk_period;

    UR <= "11100111110";
    UI <= "11010101100";
    WAIT FOR clk_period;

    UR <= "11101101010";
    UI <= "11010011101";
    WAIT FOR clk_period;

    UR <= "11110010011";
    UI <= "11010101100";
    WAIT FOR clk_period;

    UR <= "11110110010";
    UI <= "11011011101";
    WAIT FOR clk_period;

    UR <= "11111000100";
    UI <= "11100101110";
    WAIT FOR clk_period;

    UR <= "11111001001";
    UI <= "11110011000";
    WAIT FOR clk_period;

    UR <= "11111000011";
    UI <= "00000001110";
    WAIT FOR clk_period;

    UR <= "11110110111";
    UI <= "00010000100";
    WAIT FOR clk_period;

    UR <= "11110101001";
    UI <= "00011101000";
    WAIT FOR clk_period;

    UR <= "11110100000";
    UI <= "00100101100";
    WAIT FOR clk_period;

    UR <= "11110011111";
    UI <= "00101000100";
    WAIT FOR clk_period;

    UR <= "11110101001";
    UI <= "00100101010";
    WAIT FOR clk_period;

    UR <= "11110111110";
    UI <= "00011011100";
    WAIT FOR clk_period;

    UR <= "11111011011";
    UI <= "00001100010";
    WAIT FOR clk_period;

    UR <= "11111111110";
    UI <= "11111000110";
    WAIT FOR clk_period;

    UR <= "00000100001";
    UI <= "11100011011";
    WAIT FOR clk_period;

    UR <= "00000111110";
    UI <= "11001110100";
    WAIT FOR clk_period;

    UR <= "00001010000";
    UI <= "10111100100";
    WAIT FOR clk_period;

    UR <= "00001010110";
    UI <= "10101111100";
    WAIT FOR clk_period;

    UR <= "00001001100";
    UI <= "10101001010";
    WAIT FOR clk_period;

    UR <= "00000110101";
    UI <= "10101010001";
    WAIT FOR clk_period;

    UR <= "00000010100";
    UI <= "10110010011";
    WAIT FOR clk_period;

    UR <= "11111101101";
    UI <= "11000001000";
    WAIT FOR clk_period;

    UR <= "11111000101";
    UI <= "11010100011";
    WAIT FOR clk_period;

    UR <= "11110100001";
    UI <= "11101010011";
    WAIT FOR clk_period;

    UR <= "11110000111";
    UI <= "00000000110";
    WAIT FOR clk_period;

    UR <= "11101111000";
    UI <= "00010101011";
    WAIT FOR clk_period;

    UR <= "11101110111";
    UI <= "00100110011";
    WAIT FOR clk_period;

    UR <= "11110000011";
    UI <= "00110010101";
    WAIT FOR clk_period;

    UR <= "11110011011";
    UI <= "00111001011";
    WAIT FOR clk_period;

    UR <= "11110111100";
    UI <= "00111010101";
    WAIT FOR clk_period;

    UR <= "11111100010";
    UI <= "00110110111";
    WAIT FOR clk_period;

    UR <= "00000001010";
    UI <= "00101111001";
    WAIT FOR clk_period;

    UR <= "00000110010";
    UI <= "00100100101";
    WAIT FOR clk_period;

    UR <= "00001011000";
    UI <= "00011000110";
    WAIT FOR clk_period;

    UR <= "00001111010";
    UI <= "00001100110";
    WAIT FOR clk_period;

    UR <= "00010010111";
    UI <= "00000001101";
    WAIT FOR clk_period;

    UR <= "00010110000";
    UI <= "11111000001";
    WAIT FOR clk_period;

    UR <= "00011000100";
    UI <= "11110000110";
    WAIT FOR clk_period;

    UR <= "00011010100";
    UI <= "11101011110";
    WAIT FOR clk_period;

    UR <= "00011011101";
    UI <= "11101001001";
    WAIT FOR clk_period;

    UR <= "00011100001";
    UI <= "11101000100";
    WAIT FOR clk_period;

    UR <= "00011011110";
    UI <= "11101001111";
    WAIT FOR clk_period;

    UR <= "00011010110";
    UI <= "11101100111";
    WAIT FOR clk_period;

    UR <= "00011000111";
    UI <= "11110001001";
    WAIT FOR clk_period;

    UR <= "00010110101";
    UI <= "11110110011";
    WAIT FOR clk_period;

    UR <= "00010100010";
    UI <= "11111100010";
    WAIT FOR clk_period;

    UR <= "00010010001";
    UI <= "00000010101";
    WAIT FOR clk_period;

    UR <= "00010000110";
    UI <= "00001001001";
    WAIT FOR clk_period;

    UR <= "00010000100";
    UI <= "00001111010";
    WAIT FOR clk_period;

    UR <= "00010001110";
    UI <= "00010100110";
    WAIT FOR clk_period;

    UR <= "00010100101";
    UI <= "00011001010";
    WAIT FOR clk_period;

    UR <= "00011000111";
    UI <= "00011100011";
    WAIT FOR clk_period;

    UR <= "00011110010";
    UI <= "00011101110";
    WAIT FOR clk_period;

    UR <= "00100011111";
    UI <= "00011101011";
    WAIT FOR clk_period;

    UR <= "00101001001";
    UI <= "00011011010";
    WAIT FOR clk_period;

    UR <= "00101100111";
    UI <= "00010111100";
    WAIT FOR clk_period;

    UR <= "00101110011";
    UI <= "00010010011";
    WAIT FOR clk_period;

    UR <= "00101100111";
    UI <= "00001100100";
    WAIT FOR clk_period;

    UR <= "00101000011";
    UI <= "00000110011";
    WAIT FOR clk_period;

    UR <= "00100000111";
    UI <= "00000000101";
    WAIT FOR clk_period;

    UR <= "00010111001";
    UI <= "11111011110";
    WAIT FOR clk_period;

    UR <= "00001011111";
    UI <= "11111000011";
    WAIT FOR clk_period;

    UR <= "00000000101";
    UI <= "11110110110";
    WAIT FOR clk_period;

    UR <= "11110110110";
    UI <= "11110111010";
    WAIT FOR clk_period;

    UR <= "11101111011";
    UI <= "11111001110";
    WAIT FOR clk_period;

    UR <= "11101011101";
    UI <= "11111110000";
    WAIT FOR clk_period;

    UR <= "11101011111";
    UI <= "00000011111";
    WAIT FOR clk_period;

    UR <= "11110000011";
    UI <= "00001010100";
    WAIT FOR clk_period;

    UR <= "11111000011";
    UI <= "00010001010";
    WAIT FOR clk_period;

    UR <= "00000010111";
    UI <= "00010111010";
    WAIT FOR clk_period;

    UR <= "00001110011";
    UI <= "00011011111";
    WAIT FOR clk_period;

    UR <= "00011001011";
    UI <= "00011110011";
    WAIT FOR clk_period;

    UR <= "00100010001";
    UI <= "00011110000";
    WAIT FOR clk_period;

    UR <= "00100111011";
    UI <= "00011010100";
    WAIT FOR clk_period;

    UR <= "00101000011";
    UI <= "00010011110";
    WAIT FOR clk_period;

    UR <= "00100100111";
    UI <= "00001010000";
    WAIT FOR clk_period;

    UR <= "00011101000";
    UI <= "11111101110";
    WAIT FOR clk_period;

    UR <= "00010001111";
    UI <= "11110000000";
    WAIT FOR clk_period;

    UR <= "00000100101";
    UI <= "11100001101";
    WAIT FOR clk_period;

    UR <= "11110110111";
    UI <= "11010011110";
    WAIT FOR clk_period;

    UR <= "11101010000";
    UI <= "11000111111";
    WAIT FOR clk_period;

    UR <= "11011111101";
    UI <= "10111110110";
    WAIT FOR clk_period;

    UR <= "11011000101";
    UI <= "10111001011";
    WAIT FOR clk_period;

    UR <= "11010101110";
    UI <= "10111000001";
    WAIT FOR clk_period;

    UR <= "11010111000";
    UI <= "10111010111";
    WAIT FOR clk_period;

    UR <= "11011100000";
    UI <= "11000001011";
    WAIT FOR clk_period;

    UR <= "11100100010";
    UI <= "11001010101";
    WAIT FOR clk_period;

    UR <= "11101110101";
    UI <= "11010101101";
    WAIT FOR clk_period;

    UR <= "11111010000";
    UI <= "11100001000";
    WAIT FOR clk_period;

    UR <= "00000101011";
    UI <= "11101011101";
    WAIT FOR clk_period;

    UR <= "00010000000";
    UI <= "11110100010";
    WAIT FOR clk_period;

    UR <= "00011000111";
    UI <= "11111010010";
    WAIT FOR clk_period;

    UR <= "00011111111";
    UI <= "11111101001";
    WAIT FOR clk_period;

    UR <= "00100100101";
    UI <= "11111101010";
    WAIT FOR clk_period;

    UR <= "00100111010";
    UI <= "11111011000";
    WAIT FOR clk_period;

    UR <= "00100111110";
    UI <= "11110111010";
    WAIT FOR clk_period;

    UR <= "00100110100";
    UI <= "11110011000";
    WAIT FOR clk_period;

    UR <= "00100011111";
    UI <= "11101111011";
    WAIT FOR clk_period;

    UR <= "00100000010";
    UI <= "11101101000";
    WAIT FOR clk_period;

    UR <= "00011011111";
    UI <= "11101100100";
    WAIT FOR clk_period;

    UR <= "00010111010";
    UI <= "11101110000";
    WAIT FOR clk_period;

    UR <= "00010010101";
    UI <= "11110001011";
    WAIT FOR clk_period;

    UR <= "00001110100";
    UI <= "11110101111";
    WAIT FOR clk_period;

    UR <= "00001011001";
    UI <= "11111010101";
    WAIT FOR clk_period;

    UR <= "00001001000";
    UI <= "11111110111";
    WAIT FOR clk_period;

    UR <= "00001000011";
    UI <= "00000001111";
    WAIT FOR clk_period;

    UR <= "00001001011";
    UI <= "00000010111";
    WAIT FOR clk_period;

    UR <= "00001100000";
    UI <= "00000001111";
    WAIT FOR clk_period;

    UR <= "00010000000";
    UI <= "11111111010";
    WAIT FOR clk_period;

    UR <= "00010101001";
    UI <= "11111011101";
    WAIT FOR clk_period;

    UR <= "00011010111";
    UI <= "11110111111";
    WAIT FOR clk_period;

    UR <= "00100000011";
    UI <= "11110101010";
    WAIT FOR clk_period;

    UR <= "00100101001";
    UI <= "11110100110";
    WAIT FOR clk_period;

    UR <= "00101000011";
    UI <= "11110111001";
    WAIT FOR clk_period;

    UR <= "00101001110";
    UI <= "11111100111";
    WAIT FOR clk_period;

    UR <= "00101001000";
    UI <= "00000101110";
    WAIT FOR clk_period;

    UR <= "00100110001";
    UI <= "00010001001";
    WAIT FOR clk_period;

    UR <= "00100001101";
    UI <= "00011110000";
    WAIT FOR clk_period;

    UR <= "00011100000";
    UI <= "00101011000";
    WAIT FOR clk_period;

    UR <= "00010101111";
    UI <= "00110110011";
    WAIT FOR clk_period;

    UR <= "00010000001";
    UI <= "00111110110";
    WAIT FOR clk_period;

    UR <= "00001011011";
    UI <= "01000011010";
    WAIT FOR clk_period;

    UR <= "00001000010";
    UI <= "01000010111";
    WAIT FOR clk_period;

    UR <= "00000110111";
    UI <= "00111101111";
    WAIT FOR clk_period;

    UR <= "00000111001";
    UI <= "00110100101";
    WAIT FOR clk_period;

    UR <= "00001000110";
    UI <= "00101000010";
    WAIT FOR clk_period;

    UR <= "00001011001";
    UI <= "00011010001";
    WAIT FOR clk_period;

    UR <= "00001101011";
    UI <= "00001011111";
    WAIT FOR clk_period;

    UR <= "00001111000";
    UI <= "11111111001";
    WAIT FOR clk_period;

    UR <= "00001111010";
    UI <= "11110101001";
    WAIT FOR clk_period;

    UR <= "00001101101";
    UI <= "11101110100";
    WAIT FOR clk_period;

    UR <= "00001010001";
    UI <= "11101011111";
    WAIT FOR clk_period;

    UR <= "00000100110";
    UI <= "11101100111";
    WAIT FOR clk_period;

    UR <= "11111110000";
    UI <= "11110000111";
    WAIT FOR clk_period;

    UR <= "11110110100";
    UI <= "11110110111";
    WAIT FOR clk_period;

    UR <= "11101110111";
    UI <= "11111101101";
    WAIT FOR clk_period;

    UR <= "11101000000";
    UI <= "00000011111";
    WAIT FOR clk_period;

    UR <= "11100010011";
    UI <= "00001000101";
    WAIT FOR clk_period;

    UR <= "11011110010";
    UI <= "00001011011";
    WAIT FOR clk_period;

    UR <= "11011100001";
    UI <= "00001011110";
    WAIT FOR clk_period;

    UR <= "11011011111";
    UI <= "00001001111";
    WAIT FOR clk_period;

    UR <= "11011101001";
    UI <= "00000110010";
    WAIT FOR clk_period;

    UR <= "11011111110";
    UI <= "00000001110";
    WAIT FOR clk_period;

    UR <= "11100011001";
    UI <= "11111101000";
    WAIT FOR clk_period;

    UR <= "11100111000";
    UI <= "11111001001";
    WAIT FOR clk_period;

    UR <= "11101010110";
    UI <= "11110110110";
    WAIT FOR clk_period;

    UR <= "11101110010";
    UI <= "11110110001";
    WAIT FOR clk_period;

    UR <= "11110001010";
    UI <= "11110111101";
    WAIT FOR clk_period;

    UR <= "11110011011";
    UI <= "11111010111";
    WAIT FOR clk_period;

    UR <= "11110100110";
    UI <= "11111111100";
    WAIT FOR clk_period;

    UR <= "11110101001";
    UI <= "00000100111";
    WAIT FOR clk_period;

    UR <= "11110100100";
    UI <= "00001010011";
    WAIT FOR clk_period;

    UR <= "11110010110";
    UI <= "00001111010";
    WAIT FOR clk_period;

    UR <= "11101111111";
    UI <= "00010010111";
    WAIT FOR clk_period;

    UR <= "11101100001";
    UI <= "00010101000";
    WAIT FOR clk_period;

    UR <= "11100111101";
    UI <= "00010101001";
    WAIT FOR clk_period;

    UR <= "11100010101";
    UI <= "00010011010";
    WAIT FOR clk_period;

    UR <= "11011110000";
    UI <= "00001111101";
    WAIT FOR clk_period;

    UR <= "11011010001";
    UI <= "00001010011";
    WAIT FOR clk_period;

    UR <= "11010111110";
    UI <= "00000011111";
    WAIT FOR clk_period;

    UR <= "11010111101";
    UI <= "11111100011";
    WAIT FOR clk_period;

    UR <= "11011010010";
    UI <= "11110100100";
    WAIT FOR clk_period;

    UR <= "11011111111";
    UI <= "11101100101";
    WAIT FOR clk_period;

    UR <= "11101000100";
    UI <= "11100101000";
    WAIT FOR clk_period;

    UR <= "11110011011";
    UI <= "11011110010";
    WAIT FOR clk_period;

    UR <= "11111111110";
    UI <= "11011000101";
    WAIT FOR clk_period;

    UR <= "00001100011";
    UI <= "11010100100";
    WAIT FOR clk_period;

    UR <= "00010111110";
    UI <= "11010010000";
    WAIT FOR clk_period;

    UR <= "00100000110";
    UI <= "11010001101";
    WAIT FOR clk_period;

    UR <= "00100101111";
    UI <= "11010011000";
    WAIT FOR clk_period;

    UR <= "00100110101";
    UI <= "11010110011";
    WAIT FOR clk_period;

    UR <= "00100010100";
    UI <= "11011011010";
    WAIT FOR clk_period;

    UR <= "00011010000";
    UI <= "11100001010";
    WAIT FOR clk_period;

    UR <= "00001110001";
    UI <= "11100111110";
    WAIT FOR clk_period;

    UR <= "00000000010";
    UI <= "11101110001";
    WAIT FOR clk_period;

    UR <= "11110010010";
    UI <= "11110011100";
    WAIT FOR clk_period;

    UR <= "11100101110";
    UI <= "11110111011";
    WAIT FOR clk_period;

    UR <= "11011100101";
    UI <= "11111001001";
    WAIT FOR clk_period;

    UR <= "11010111110";
    UI <= "11111000110";
    WAIT FOR clk_period;

    UR <= "11010111111";
    UI <= "11110101111";
    WAIT FOR clk_period;

    UR <= "11011100110";
    UI <= "11110001001";
    WAIT FOR clk_period;

    UR <= "11100101110";
    UI <= "11101011000";
    WAIT FOR clk_period;

    UR <= "11110001001";
    UI <= "11100100000";
    WAIT FOR clk_period;

    UR <= "11111101100";
    UI <= "11011101010";
    WAIT FOR clk_period;

    UR <= "00001000101";
    UI <= "11010111011";
    WAIT FOR clk_period;

    UR <= "00010001010";
    UI <= "11010011010";
    WAIT FOR clk_period;

    UR <= "00010101111";
    UI <= "11010001010";
    WAIT FOR clk_period;

    UR <= "00010110010";
    UI <= "11010001110";
    WAIT FOR clk_period;

    UR <= "00010010010";
    UI <= "11010100100";
    WAIT FOR clk_period;

    UR <= "00001011000";
    UI <= "11011001100";
    WAIT FOR clk_period;

    UR <= "00000001110";
    UI <= "11100000000";
    WAIT FOR clk_period;

    UR <= "11111000010";
    UI <= "11100111011";
    WAIT FOR clk_period;

    UR <= "11110000001";
    UI <= "11101111000";
    WAIT FOR clk_period;

    UR <= "11101011000";
    UI <= "11110110001";
    WAIT FOR clk_period;

    UR <= "11101001110";
    UI <= "11111100011";
    WAIT FOR clk_period;

    UR <= "11101100110";
    UI <= "00000001010";
    WAIT FOR clk_period;

    UR <= "11110011100";
    UI <= "00000100101";
    WAIT FOR clk_period;

    UR <= "11111101000";
    UI <= "00000110100";
    WAIT FOR clk_period;

    UR <= "00000111101";
    UI <= "00000111000";
    WAIT FOR clk_period;

    UR <= "00010001101";
    UI <= "00000110010";
    WAIT FOR clk_period;

    UR <= "00011001011";
    UI <= "00000100101";
    WAIT FOR clk_period;

    UR <= "00011101011";
    UI <= "00000010100";
    WAIT FOR clk_period;

    UR <= "00011100111";
    UI <= "00000000000";
    WAIT FOR clk_period;

    UR <= "00010111101";
    UI <= "11111101100";
    WAIT FOR clk_period;

    UR <= "00001110011";
    UI <= "11111011010";
    WAIT FOR clk_period;

    UR <= "00000010011";
    UI <= "11111001100";
    WAIT FOR clk_period;

    UR <= "11110101001";
    UI <= "11111000011";
    WAIT FOR clk_period;

    UR <= "11101000111";
    UI <= "11111000001";
    WAIT FOR clk_period;

    UR <= "11011111011";
    UI <= "11111000111";
    WAIT FOR clk_period;

    UR <= "11011001111";
    UI <= "11111010110";
    WAIT FOR clk_period;

    UR <= "11011001100";
    UI <= "11111101111";
    WAIT FOR clk_period;

    UR <= "11011110100";
    UI <= "00000001110";
    WAIT FOR clk_period;

    UR <= "11101000000";
    UI <= "00000110011";
    WAIT FOR clk_period;

    UR <= "11110101000";
    UI <= "00001011010";
    WAIT FOR clk_period;

    UR <= "00000011111";
    UI <= "00001111101";
    WAIT FOR clk_period;

    UR <= "00010010100";
    UI <= "00010010111";
    WAIT FOR clk_period;

    UR <= "00011111000";
    UI <= "00010100100";
    WAIT FOR clk_period;

    UR <= "00101000001";
    UI <= "00010011111";
    WAIT FOR clk_period;

    UR <= "00101100100";
    UI <= "00010001000";
    WAIT FOR clk_period;

    UR <= "00101100000";
    UI <= "00001011110";
    WAIT FOR clk_period;

    UR <= "00100110111";
    UI <= "00000100101";
    WAIT FOR clk_period;

    UR <= "00011110000";
    UI <= "11111100101";
    WAIT FOR clk_period;

    UR <= "00010010101";
    UI <= "11110100101";
    WAIT FOR clk_period;

    UR <= "00000110101";
    UI <= "11101110001";
    WAIT FOR clk_period;

    UR <= "11111011101";
    UI <= "11101010001";
    WAIT FOR clk_period;

    UR <= "11110010111";
    UI <= "11101001101";
    WAIT FOR clk_period;

    UR <= "11101101101";
    UI <= "11101101010";
    WAIT FOR clk_period;

    UR <= "11101100010";
    UI <= "11110101000";
    WAIT FOR clk_period;

    UR <= "11101111000";
    UI <= "00000000011";
    WAIT FOR clk_period;

    UR <= "11110101001";
    UI <= "00001110001";
    WAIT FOR clk_period;

    UR <= "11111110000";
    UI <= "00011100110";
    WAIT FOR clk_period;

    UR <= "00001000001";
    UI <= "00101010100";
    WAIT FOR clk_period;

    UR <= "00010010100";
    UI <= "00110101010";
    WAIT FOR clk_period;

    UR <= "00011011110";
    UI <= "00111011110";
    WAIT FOR clk_period;

    UR <= "00100011000";
    UI <= "00111100101";
    WAIT FOR clk_period;

    UR <= "00100111101";
    UI <= "00110111110";
    WAIT FOR clk_period;

    UR <= "00101001001";
    UI <= "00101101010";
    WAIT FOR clk_period;

    UR <= "00100111100";
    UI <= "00011110100";
    WAIT FOR clk_period;

    UR <= "00100011001";
    UI <= "00001101010";
    WAIT FOR clk_period;

    UR <= "00011100011";
    UI <= "11111011011";
    WAIT FOR clk_period;

    UR <= "00010100000";
    UI <= "11101011011";
    WAIT FOR clk_period;

    UR <= "00001010011";
    UI <= "11011110111";
    WAIT FOR clk_period;

    UR <= "00000000010";
    UI <= "11010111101";
    WAIT FOR clk_period;

    UR <= "11110110010";
    UI <= "11010110000";
    WAIT FOR clk_period;

    UR <= "11101100100";
    UI <= "11011010010";
    WAIT FOR clk_period;

    UR <= "11100011110";
    UI <= "11100011001";
    WAIT FOR clk_period;

    UR <= "11011100000";
    UI <= "11101111010";
    WAIT FOR clk_period;

    UR <= "11010101110";
    UI <= "11111100101";
    WAIT FOR clk_period;

    UR <= "11010001001";
    UI <= "00001001001";
    WAIT FOR clk_period;

    UR <= "11001110011";
    UI <= "00010011000";
    WAIT FOR clk_period;

    UR <= "11001101101";
    UI <= "00011000110";
    WAIT FOR clk_period;

    UR <= "11001111001";
    UI <= "00011001111";
    WAIT FOR clk_period;

    UR <= "11010010101";
    UI <= "00010110011";
    WAIT FOR clk_period;

    UR <= "11011000010";
    UI <= "00001111000";
    WAIT FOR clk_period;

    UR <= "11011111100";
    UI <= "00000101010";
    WAIT FOR clk_period;

    UR <= "11101000000";
    UI <= "11111010111";
    WAIT FOR clk_period;

    UR <= "11110001000";
    UI <= "11110001101";
    WAIT FOR clk_period;

    UR <= "11111010001";
    UI <= "11101010110";
    WAIT FOR clk_period;

    UR <= "00000010011";
    UI <= "11100111101";
    WAIT FOR clk_period;

    UR <= "00001001100";
    UI <= "11101000010";
    WAIT FOR clk_period;

    UR <= "00001110110";
    UI <= "11101100100";
    WAIT FOR clk_period;

    UR <= "00010010001";
    UI <= "11110011010";
    WAIT FOR clk_period;

    UR <= "00010011101";
    UI <= "11111011001";
    WAIT FOR clk_period;

    UR <= "00010011010";
    UI <= "00000010011";
    WAIT FOR clk_period;

    UR <= "00010001011";
    UI <= "00000111011";
    WAIT FOR clk_period;

    UR <= "00001110110";
    UI <= "00001001000";
    WAIT FOR clk_period;

    UR <= "00001011101";
    UI <= "00000110011";
    WAIT FOR clk_period;

    UR <= "00001000101";
    UI <= "11111111011";
    WAIT FOR clk_period;

    UR <= "00000110000";
    UI <= "11110100111";
    WAIT FOR clk_period;

    UR <= "00000100000";
    UI <= "11100111110";
    WAIT FOR clk_period;

    UR <= "00000010110";
    UI <= "11011001110";
    WAIT FOR clk_period;

    UR <= "00000010000";
    UI <= "11001100110";
    WAIT FOR clk_period;

    UR <= "00000001101";
    UI <= "11000010001";
    WAIT FOR clk_period;

    UR <= "00000001011";
    UI <= "10111011011";
    WAIT FOR clk_period;

    UR <= "00000001010";
    UI <= "10111001011";
    WAIT FOR clk_period;

    UR <= "00000001001";
    UI <= "10111100001";
    WAIT FOR clk_period;

    UR <= "00000001001";
    UI <= "11000011011";
    WAIT FOR clk_period;

    UR <= "00000001100";
    UI <= "11001110000";
    WAIT FOR clk_period;

    UR <= "00000010100";
    UI <= "11011010101";
    WAIT FOR clk_period;

    UR <= "00000100110";
    UI <= "11100111110";
    WAIT FOR clk_period;

    UR <= "00001000010";
    UI <= "11110100000";
    WAIT FOR clk_period;

    UR <= "00001101010";
    UI <= "11111101111";
    WAIT FOR clk_period;

    UR <= "00010011111";
    UI <= "00000100100";
    WAIT FOR clk_period;

    UR <= "00011011101";
    UI <= "00000111100";
    WAIT FOR clk_period;

    UR <= "00100011111";
    UI <= "00000111000";
    WAIT FOR clk_period;

    UR <= "00101100000";
    UI <= "00000011100";
    WAIT FOR clk_period;

    UR <= "00110011000";
    UI <= "11111101110";
    WAIT FOR clk_period;

    UR <= "00111000000";
    UI <= "11110110110";
    WAIT FOR clk_period;

    UR <= "00111010010";
    UI <= "11101111110";
    WAIT FOR clk_period;

    UR <= "00111001011";
    UI <= "11101001011";
    WAIT FOR clk_period;

    UR <= "00110101001";
    UI <= "11100100101";
    WAIT FOR clk_period;

    UR <= "00101101111";
    UI <= "11100010000";
    WAIT FOR clk_period;

    UR <= "00100100011";
    UI <= "11100001011";
    WAIT FOR clk_period;

    UR <= "00011001011";
    UI <= "11100010111";
    WAIT FOR clk_period;

    UR <= "00001110010";
    UI <= "11100110001";
    WAIT FOR clk_period;

    UR <= "00000100010";
    UI <= "11101010101";
    WAIT FOR clk_period;

    UR <= "11111100011";
    UI <= "11110000000";
    WAIT FOR clk_period;

    UR <= "11110111101";
    UI <= "11110101101";
    WAIT FOR clk_period;

    UR <= "11110110100";
    UI <= "11111011000";
    WAIT FOR clk_period;

    UR <= "11111000111";
    UI <= "11111111110";
    WAIT FOR clk_period;

    UR <= "11111110011";
    UI <= "00000011110";
    WAIT FOR clk_period;

    UR <= "00000110011";
    UI <= "00000110110";
    WAIT FOR clk_period;

    UR <= "00001111111";
    UI <= "00001000101";
    WAIT FOR clk_period;

    UR <= "00011001100";
    UI <= "00001001011";
    WAIT FOR clk_period;

    UR <= "00100010010";
    UI <= "00001000111";
    WAIT FOR clk_period;

    UR <= "00101001010";
    UI <= "00000111100";
    WAIT FOR clk_period;

    UR <= "00101101101";
    UI <= "00000101001";
    WAIT FOR clk_period;

    UR <= "00101111010";
    UI <= "00000010000";
    WAIT FOR clk_period;

    UR <= "00101110000";
    UI <= "11111110010";
    WAIT FOR clk_period;

    UR <= "00101010011";
    UI <= "11111010001";
    WAIT FOR clk_period;

    UR <= "00100100111";
    UI <= "11110101110";
    WAIT FOR clk_period;

    UR <= "00011110010";
    UI <= "11110001101";
    WAIT FOR clk_period;

    UR <= "00010111100";
    UI <= "11101101111";
    WAIT FOR clk_period;

    UR <= "00010001001";
    UI <= "11101010111";
    WAIT FOR clk_period;

    UR <= "00001100000";
    UI <= "11101000101";
    WAIT FOR clk_period;

    UR <= "00001000100";
    UI <= "11100111010";
    WAIT FOR clk_period;

    UR <= "00000110111";
    UI <= "11100110111";
    WAIT FOR clk_period;

    UR <= "00000111000";
    UI <= "11100111011";
    WAIT FOR clk_period;

    UR <= "00001001000";
    UI <= "11101000110";
    WAIT FOR clk_period;

    UR <= "00001100010";
    UI <= "11101010110";
    WAIT FOR clk_period;

    UR <= "00010000101";
    UI <= "11101101001";
    WAIT FOR clk_period;

    UR <= "00010101100";
    UI <= "11101111110";
    WAIT FOR clk_period;

    UR <= "00011010011";
    UI <= "11110010010";
    WAIT FOR clk_period;

    UR <= "00011110110";
    UI <= "11110100110";
    WAIT FOR clk_period;

    UR <= "00100010001";
    UI <= "11110110111";
    WAIT FOR clk_period;

    UR <= "00100100001";
    UI <= "11111000101";
    WAIT FOR clk_period;

    UR <= "00100100011";
    UI <= "11111010000";
    WAIT FOR clk_period;

    UR <= "00100010100";
    UI <= "11111011001";
    WAIT FOR clk_period;

    UR <= "00011110011";
    UI <= "11111011110";
    WAIT FOR clk_period;

    UR <= "00010111111";
    UI <= "11111100001";
    WAIT FOR clk_period;

    UR <= "00001111001";
    UI <= "11111100001";
    WAIT FOR clk_period;

    UR <= "00000100100";
    UI <= "11111100000";
    WAIT FOR clk_period;

    UR <= "11111000011";
    UI <= "11111011111";
    WAIT FOR clk_period;

    UR <= "11101011110";
    UI <= "11111011111";
    WAIT FOR clk_period;

    UR <= "11011111001";
    UI <= "11111100000";
    WAIT FOR clk_period;

    UR <= "11010011100";
    UI <= "11111100101";
    WAIT FOR clk_period;

    UR <= "11001001101";
    UI <= "11111110000";
    WAIT FOR clk_period;

    UR <= "11000010011";
    UI <= "00000000000";
    WAIT FOR clk_period;

    UR <= "10111110001";
    UI <= "00000010110";
    WAIT FOR clk_period;

    UR <= "10111101001";
    UI <= "00000110001";
    WAIT FOR clk_period;

    UR <= "10111111001";
    UI <= "00001010001";
    WAIT FOR clk_period;

    UR <= "11000011110";
    UI <= "00001110010";
    WAIT FOR clk_period;

    UR <= "11001010100";
    UI <= "00010010000";
    WAIT FOR clk_period;

    UR <= "11010010010";
    UI <= "00010101000";
    WAIT FOR clk_period;

    UR <= "11011010001";
    UI <= "00010110101";
    WAIT FOR clk_period;

    UR <= "11100001010";
    UI <= "00010110100";
    WAIT FOR clk_period;

    UR <= "11100111000";
    UI <= "00010100100";
    WAIT FOR clk_period;

    UR <= "11101010110";
    UI <= "00010000100";
    WAIT FOR clk_period;

    UR <= "11101100101";
    UI <= "00001010110";
    WAIT FOR clk_period;

    UR <= "11101100101";
    UI <= "00000011110";
    WAIT FOR clk_period;

    UR <= "11101011010";
    UI <= "11111100010";
    WAIT FOR clk_period;

    UR <= "11101001010";
    UI <= "11110101010";
    WAIT FOR clk_period;

    UR <= "11100111100";
    UI <= "11101111011";
    WAIT FOR clk_period;

    UR <= "11100110011";
    UI <= "11101011100";
    WAIT FOR clk_period;

    UR <= "11100110110";
    UI <= "11101010000";
    WAIT FOR clk_period;

    UR <= "11101000111";
    UI <= "11101011000";
    WAIT FOR clk_period;

    UR <= "11101100101";
    UI <= "11101110010";
    WAIT FOR clk_period;

    UR <= "11110001101";
    UI <= "11110011000";
    WAIT FOR clk_period;

    UR <= "11110111100";
    UI <= "11111000100";
    WAIT FOR clk_period;

    UR <= "11111101100";
    UI <= "11111101011";
    WAIT FOR clk_period;

    UR <= "00000010110";
    UI <= "00000000110";
    WAIT FOR clk_period;

    UR <= "00000110110";
    UI <= "00000001110";
    WAIT FOR clk_period;

    UR <= "00001000110";
    UI <= "11111111101";
    WAIT FOR clk_period;

    UR <= "00001000110";
    UI <= "11111010011";
    WAIT FOR clk_period;

    UR <= "00000110111";
    UI <= "11110010100";
    WAIT FOR clk_period;

    UR <= "00000011100";
    UI <= "11101000111";
    WAIT FOR clk_period;

    UR <= "11111111011";
    UI <= "11011110110";
    WAIT FOR clk_period;

    UR <= "11111011010";
    UI <= "11010101110";
    WAIT FOR clk_period;

    UR <= "11111000000";
    UI <= "11001111001";
    WAIT FOR clk_period;

    UR <= "11110110100";
    UI <= "11001100010";
    WAIT FOR clk_period;

    UR <= "11110111001";
    UI <= "11001101111";
    WAIT FOR clk_period;

    UR <= "11111010010";
    UI <= "11010100000";
    WAIT FOR clk_period;

    UR <= "11111111101";
    UI <= "11011110011";
    WAIT FOR clk_period;

    UR <= "00000111000";
    UI <= "11101011111";
    WAIT FOR clk_period;

    UR <= "00001111101";
    UI <= "11111010110";
    WAIT FOR clk_period;

    UR <= "00011000100";
    UI <= "00001001101";
    WAIT FOR clk_period;

    UR <= "00100001001";
    UI <= "00010110011";
    WAIT FOR clk_period;

    UR <= "00101000100";
    UI <= "00011111110";
    WAIT FOR clk_period;

    UR <= "00101110000";
    UI <= "00100100100";
    WAIT FOR clk_period;

    UR <= "00110001011";
    UI <= "00100100010";
    WAIT FOR clk_period;

    UR <= "00110010110";
    UI <= "00011111010";
    WAIT FOR clk_period;

    UR <= "00110010001";
    UI <= "00010110011";
    WAIT FOR clk_period;

    UR <= "00110000001";
    UI <= "00001011000";
    WAIT FOR clk_period;

    UR <= "00101101010";
    UI <= "11111110101";
    WAIT FOR clk_period;

    UR <= "00101010011";
    UI <= "11110011001";
    WAIT FOR clk_period;

    UR <= "00100111101";
    UI <= "11101001111";
    WAIT FOR clk_period;

    UR <= "00100101110";
    UI <= "11100100000";
    WAIT FOR clk_period;

    UR <= "00100100100";
    UI <= "11100010000";
    WAIT FOR clk_period;

    UR <= "00100100000";
    UI <= "11100011110";
    WAIT FOR clk_period;

    UR <= "00100011110";
    UI <= "11101000101";
    WAIT FOR clk_period;

    UR <= "00100011001";
    UI <= "11101111101";
    WAIT FOR clk_period;

    UR <= "00100001110";
    UI <= "11110111100";
    WAIT FOR clk_period;

    UR <= "00011110111";
    UI <= "11111110111";
    WAIT FOR clk_period;

    UR <= "00011010011";
    UI <= "00000100101";
    WAIT FOR clk_period;

    UR <= "00010011111";
    UI <= "00001000000";
    WAIT FOR clk_period;

    UR <= "00001011110";
    UI <= "00001000111";
    WAIT FOR clk_period;

    UR <= "00000010010";
    UI <= "00000111011";
    WAIT FOR clk_period;

    UR <= "11111000010";
    UI <= "00000100010";
    WAIT FOR clk_period;

    UR <= "11101110100";
    UI <= "00000000010";
    WAIT FOR clk_period;

    UR <= "11100101111";
    UI <= "11111100101";
    WAIT FOR clk_period;

    UR <= "11011111011";
    UI <= "11111010011";
    WAIT FOR clk_period;

    UR <= "11011011100";
    UI <= "11111010011";
    WAIT FOR clk_period;

    UR <= "11011010110";
    UI <= "11111101000";
    WAIT FOR clk_period;

    UR <= "11011100111";
    UI <= "00000010011";
    WAIT FOR clk_period;

    UR <= "11100001111";
    UI <= "00001010001";
    WAIT FOR clk_period;

    UR <= "11101001001";
    UI <= "00010011100";
    WAIT FOR clk_period;

    UR <= "11110001100";
    UI <= "00011101100";
    WAIT FOR clk_period;

    UR <= "11111010011";
    UI <= "00100111001";
    WAIT FOR clk_period;

    UR <= "00000010101";
    UI <= "00101111010";
    WAIT FOR clk_period;

    UR <= "00001001101";
    UI <= "00110101001";
    WAIT FOR clk_period;

    UR <= "00001110100";
    UI <= "00111000000";
    WAIT FOR clk_period;

    UR <= "00010001001";
    UI <= "00110111101";
    WAIT FOR clk_period;

    UR <= "00010001100";
    UI <= "00110100001";
    WAIT FOR clk_period;

    UR <= "00010000000";
    UI <= "00101101100";
    WAIT FOR clk_period;

    UR <= "00001101000";
    UI <= "00100100011";
    WAIT FOR clk_period;

    UR <= "00001001010";
    UI <= "00011001011";
    WAIT FOR clk_period;

    UR <= "00000101100";
    UI <= "00001101010";
    WAIT FOR clk_period;

    UR <= "00000010010";
    UI <= "00000000101";
    WAIT FOR clk_period;

    UR <= "00000000001";
    UI <= "11110100000";
    WAIT FOR clk_period;

    UR <= "11111111010";
    UI <= "11101000001";
    WAIT FOR clk_period;

    UR <= "11111111100";
    UI <= "11011101011";
    WAIT FOR clk_period;

    UR <= "00000000111";
    UI <= "11010100001";
    WAIT FOR clk_period;

    UR <= "00000010101";
    UI <= "11001100111";
    WAIT FOR clk_period;

    UR <= "00000100100";
    UI <= "11000111110";
    WAIT FOR clk_period;

    UR <= "00000101110";
    UI <= "11000101001";
    WAIT FOR clk_period;

    UR <= "00000110001";
    UI <= "11000100111";
    WAIT FOR clk_period;

    UR <= "00000101001";
    UI <= "11000111010";
    WAIT FOR clk_period;

    UR <= "00000011000";
    UI <= "11001100001";
    WAIT FOR clk_period;

    UR <= "00000000000";
    UI <= "11010011000";
    WAIT FOR clk_period;

    UR <= "11111100011";
    UI <= "11011011100";
    WAIT FOR clk_period;

    UR <= "11111001000";
    UI <= "11100101001";
    WAIT FOR clk_period;

    UR <= "11110110100";
    UI <= "11101111000";
    WAIT FOR clk_period;

    UR <= "11110101101";
    UI <= "11111000101";
    WAIT FOR clk_period;

    UR <= "11110110111";
    UI <= "00000001010";
    WAIT FOR clk_period;

    UR <= "11111010101";
    UI <= "00001000011";
    WAIT FOR clk_period;

    UR <= "00000001000";
    UI <= "00001101110";
    WAIT FOR clk_period;

    UR <= "00001001011";
    UI <= "00010001010";
    WAIT FOR clk_period;

    UR <= "00010011100";
    UI <= "00010011000";
    WAIT FOR clk_period;

    UR <= "00011110010";
    UI <= "00010011011";
    WAIT FOR clk_period;

    UR <= "00101000101";
    UI <= "00010011000";
    WAIT FOR clk_period;

    UR <= "00110001110";
    UI <= "00010010011";
    WAIT FOR clk_period;

    UR <= "00111000100";
    UI <= "00010010000";
    WAIT FOR clk_period;

    UR <= "00111100011";
    UI <= "00010010010";
    WAIT FOR clk_period;

    UR <= "00111100110";
    UI <= "00010011011";
    WAIT FOR clk_period;

    UR <= "00111001111";
    UI <= "00010101010";
    WAIT FOR clk_period;

    UR <= "00110011111";
    UI <= "00010111100";
    WAIT FOR clk_period;

    UR <= "00101011011";
    UI <= "00011001111";
    WAIT FOR clk_period;

    UR <= "00100001010";
    UI <= "00011011101";
    WAIT FOR clk_period;

    UR <= "00010110101";
    UI <= "00011100010";
    WAIT FOR clk_period;

    UR <= "00001100001";
    UI <= "00011011010";
    WAIT FOR clk_period;

    UR <= "00000010101";
    UI <= "00011000011";
    WAIT FOR clk_period;

    UR <= "11111010110";
    UI <= "00010011101";
    WAIT FOR clk_period;

    UR <= "11110100110";
    UI <= "00001101010";
    WAIT FOR clk_period;

    UR <= "11110000100";
    UI <= "00000110000";
    WAIT FOR clk_period;

    UR <= "11101101101";
    UI <= "11111110011";
    WAIT FOR clk_period;

    UR <= "11101011101";
    UI <= "11110111010";
    WAIT FOR clk_period;

    UR <= "11101010001";
    UI <= "11110001101";
    WAIT FOR clk_period;

    UR <= "11101000011";
    UI <= "11101110001";
    WAIT FOR clk_period;

    UR <= "11100110001";
    UI <= "11101101010";
    WAIT FOR clk_period;

    UR <= "11100011011";
    UI <= "11101111000";
    WAIT FOR clk_period;

    UR <= "11100000000";
    UI <= "11110011100";
    WAIT FOR clk_period;

    UR <= "11011100100";
    UI <= "11111010010";
    WAIT FOR clk_period;

    UR <= "11011001011";
    UI <= "00000010100";
    WAIT FOR clk_period;

    UR <= "11010111011";
    UI <= "00001011101";
    WAIT FOR clk_period;

    UR <= "11010111000";
    UI <= "00010100110";
    WAIT FOR clk_period;

    UR <= "11011000110";
    UI <= "00011101001";
    WAIT FOR clk_period;

    UR <= "11011100111";
    UI <= "00100100001";
    WAIT FOR clk_period;

    UR <= "11100011001";
    UI <= "00101001001";
    WAIT FOR clk_period;

    UR <= "11101011011";
    UI <= "00101100000";
    WAIT FOR clk_period;

    UR <= "11110100101";
    UI <= "00101100111";
    WAIT FOR clk_period;

    UR <= "11111110001";
    UI <= "00101011100";
    WAIT FOR clk_period;

    UR <= "00000111000";
    UI <= "00101000100";
    WAIT FOR clk_period;

    UR <= "00001110011";
    UI <= "00100100000";
    WAIT FOR clk_period;

    UR <= "00010011100";
    UI <= "00011110100";
    WAIT FOR clk_period;

    UR <= "00010110010";
    UI <= "00011000010";
    WAIT FOR clk_period;

    UR <= "00010110100";
    UI <= "00010001100";
    WAIT FOR clk_period;

    UR <= "00010100110";
    UI <= "00001010100";
    WAIT FOR clk_period;

    UR <= "00010001101";
    UI <= "00000011101";
    WAIT FOR clk_period;

    UR <= "00001110001";
    UI <= "11111100111";
    WAIT FOR clk_period;

    UR <= "00001011010";
    UI <= "11110110101";
    WAIT FOR clk_period;

    UR <= "00001001110";
    UI <= "11110001000";
    WAIT FOR clk_period;

    UR <= "00001010011";
    UI <= "11101100000";
    WAIT FOR clk_period;

    UR <= "00001101011";
    UI <= "11101000001";
    WAIT FOR clk_period;

    UR <= "00010010110";
    UI <= "11100101010";
    WAIT FOR clk_period;

    UR <= "00011010000";
    UI <= "11100011100";
    WAIT FOR clk_period;

    UR <= "00100010011";
    UI <= "11100011000";
    WAIT FOR clk_period;

    UR <= "00101010111";
    UI <= "11100011100";
    WAIT FOR clk_period;

    UR <= "00110010011";
    UI <= "11100100111";
    WAIT FOR clk_period;

    UR <= "00111000001";
    UI <= "11100110110";
    WAIT FOR clk_period;

    UR <= "00111011010";
    UI <= "11101000110";
    WAIT FOR clk_period;

    UR <= "00111011100";
    UI <= "11101010101";
    WAIT FOR clk_period;

    UR <= "00111000100";
    UI <= "11101100000";
    WAIT FOR clk_period;

    UR <= "00110011000";
    UI <= "11101100111";
    WAIT FOR clk_period;

    UR <= "00101011010";
    UI <= "11101100111";
    WAIT FOR clk_period;

    UR <= "00100010011";
    UI <= "11101100010";
    WAIT FOR clk_period;

    UR <= "00011001010";
    UI <= "11101011001";
    WAIT FOR clk_period;

    UR <= "00010000101";
    UI <= "11101001110";
    WAIT FOR clk_period;

    UR <= "00001001100";
    UI <= "11101000011";
    WAIT FOR clk_period;

    UR <= "00000100010";
    UI <= "11100111011";
    WAIT FOR clk_period;

    UR <= "00000001001";
    UI <= "11100111000";
    WAIT FOR clk_period;

    UR <= "00000000001";
    UI <= "11100111001";
    WAIT FOR clk_period;

    UR <= "00000000111";
    UI <= "11101000000";
    WAIT FOR clk_period;

    UR <= "00000011000";
    UI <= "11101001010";
    WAIT FOR clk_period;

    UR <= "00000101101";
    UI <= "11101010110";
    WAIT FOR clk_period;

    UR <= "00001000011";
    UI <= "11101100010";
    WAIT FOR clk_period;

    UR <= "00001010011";
    UI <= "11101101100";
    WAIT FOR clk_period;

    UR <= "00001011010";
    UI <= "11101110100";
    WAIT FOR clk_period;

    UR <= "00001010101";
    UI <= "11101111001";
    WAIT FOR clk_period;

    UR <= "00001000011";
    UI <= "11101111110";
    WAIT FOR clk_period;

    UR <= "00000100100";
    UI <= "11110000100";
    WAIT FOR clk_period;

    UR <= "11111111001";
    UI <= "11110010000";
    WAIT FOR clk_period;

    UR <= "11111000101";
    UI <= "11110100101";
    WAIT FOR clk_period;

    UR <= "11110001100";
    UI <= "11111000111";
    WAIT FOR clk_period;

    UR <= "11101010001";
    UI <= "11111110111";
    WAIT FOR clk_period;

    UR <= "11100011000";
    UI <= "00000110101";
    WAIT FOR clk_period;

    UR <= "11011101000";
    UI <= "00001111110";
    WAIT FOR clk_period;

    UR <= "11011000011";
    UI <= "00011001110";
    WAIT FOR clk_period;

    UR <= "11010101110";
    UI <= "00100011111";
    WAIT FOR clk_period;

    UR <= "11010101100";
    UI <= "00101100111";
    WAIT FOR clk_period;

    UR <= "11011000000";
    UI <= "00110100000";
    WAIT FOR clk_period;

    UR <= "11011101001";
    UI <= "00111000010";
    WAIT FOR clk_period;

    UR <= "11100100110";
    UI <= "00111001000";
    WAIT FOR clk_period;

    UR <= "11101110110";
    UI <= "00110110000";
    WAIT FOR clk_period;

    UR <= "11111010011";
    UI <= "00101111001";
    WAIT FOR clk_period;

    UR <= "00000110111";
    UI <= "00100101001";
    WAIT FOR clk_period;

    UR <= "00010011011";
    UI <= "00011000100";
    WAIT FOR clk_period;

    UR <= "00011111000";
    UI <= "00001010101";
    WAIT FOR clk_period;

    UR <= "00101000101";
    UI <= "11111100100";
    WAIT FOR clk_period;

    UR <= "00101111101";
    UI <= "11101111011";
    WAIT FOR clk_period;

    UR <= "00110011011";
    UI <= "11100100001";
    WAIT FOR clk_period;

    UR <= "00110011011";
    UI <= "11011011101";
    WAIT FOR clk_period;

    UR <= "00101111110";
    UI <= "11010110000";
    WAIT FOR clk_period;

    UR <= "00101000101";
    UI <= "11010011011";
    WAIT FOR clk_period;

    UR <= "00011110110";
    UI <= "11010011011";
    WAIT FOR clk_period;

    UR <= "00010010110";
    UI <= "11010101100";
    WAIT FOR clk_period;

    UR <= "00000101110";
    UI <= "11011000110";
    WAIT FOR clk_period;

    UR <= "11111000111";
    UI <= "11011100100";
    WAIT FOR clk_period;

    UR <= "11101100111";
    UI <= "11100000001";
    WAIT FOR clk_period;

    UR <= "11100010101";
    UI <= "11100011000";
    WAIT FOR clk_period;

    UR <= "11011010111";
    UI <= "11100100111";
    WAIT FOR clk_period;

    UR <= "11010110000";
    UI <= "11100101101";
    WAIT FOR clk_period;

    UR <= "11010100001";
    UI <= "11100101011";
    WAIT FOR clk_period;

    UR <= "11010101001";
    UI <= "11100100100";
    WAIT FOR clk_period;

    UR <= "11011000110";
    UI <= "11100011100";
    WAIT FOR clk_period;

    UR <= "11011110011";
    UI <= "11100010101";
    WAIT FOR clk_period;

    UR <= "11100101101";
    UI <= "11100010011";
    WAIT FOR clk_period;

    UR <= "11101101110";
    UI <= "11100011000";
    WAIT FOR clk_period;

    UR <= "11110110001";
    UI <= "11100100110";
    WAIT FOR clk_period;

    UR <= "11111110001";
    UI <= "11100111111";
    WAIT FOR clk_period;

    UR <= "00000101100";
    UI <= "11101100011";
    WAIT FOR clk_period;

    UR <= "00001011100";
    UI <= "11110010010";
    WAIT FOR clk_period;

    UR <= "00010000001";
    UI <= "11111001011";
    WAIT FOR clk_period;

    UR <= "00010011000";
    UI <= "00000010000";
    WAIT FOR clk_period;

    UR <= "00010100011";
    UI <= "00001011101";
    WAIT FOR clk_period;

    UR <= "00010100001";
    UI <= "00010110010";
    WAIT FOR clk_period;

    UR <= "00010010110";
    UI <= "00100001011";
    WAIT FOR clk_period;

    UR <= "00010000101";
    UI <= "00101100101";
    WAIT FOR clk_period;

    UR <= "00001110010";
    UI <= "00110111011";
    WAIT FOR clk_period;

    UR <= "00001100010";
    UI <= "01000000111";
    WAIT FOR clk_period;

    UR <= "00001011000";
    UI <= "01001000100";
    WAIT FOR clk_period;

    UR <= "00001011010";
    UI <= "01001101011";
    WAIT FOR clk_period;

    UR <= "00001101010";
    UI <= "01001111000";
    WAIT FOR clk_period;

    UR <= "00010001001";
    UI <= "01001101000";
    WAIT FOR clk_period;

    UR <= "00010110110";
    UI <= "01000111011";
    WAIT FOR clk_period;

    UR <= "00011101110";
    UI <= "00111110011";
    WAIT FOR clk_period;

    UR <= "00100101100";
    UI <= "00110010110";
    WAIT FOR clk_period;

    UR <= "00101101001";
    UI <= "00100101101";
    WAIT FOR clk_period;

    UR <= "00110011111";
    UI <= "00011000001";
    WAIT FOR clk_period;

    UR <= "00111000101";
    UI <= "00001011101";
    WAIT FOR clk_period;

    UR <= "00111010101";
    UI <= "00000001010";
    WAIT FOR clk_period;

    UR <= "00111001101";
    UI <= "11111010000";
    WAIT FOR clk_period;

    UR <= "00110101010";
    UI <= "11110110001";
    WAIT FOR clk_period;

    UR <= "00101101111";
    UI <= "11110101111";
    WAIT FOR clk_period;

    UR <= "00100100011";
    UI <= "11111000100";
    WAIT FOR clk_period;

    UR <= "00011001100";
    UI <= "11111101010";
    WAIT FOR clk_period;

    UR <= "00001110110";
    UI <= "00000010110";
    WAIT FOR clk_period;

    UR <= "00000101010";
    UI <= "00000111110";
    WAIT FOR clk_period;

    UR <= "11111110011";
    UI <= "00001011010";
    WAIT FOR clk_period;

    UR <= "11111011000";
    UI <= "00001100010";
    WAIT FOR clk_period;

    UR <= "11111011100";
    UI <= "00001010101";
    WAIT FOR clk_period;

    UR <= "11111111111";
    UI <= "00000110101";
    WAIT FOR clk_period;

    UR <= "00000111101";
    UI <= "00000001001";
    WAIT FOR clk_period;

    UR <= "00010001100";
    UI <= "11111011100";
    WAIT FOR clk_period;

    UR <= "00011100010";
    UI <= "11110111010";
    WAIT FOR clk_period;

    UR <= "00100110010";
    UI <= "11110101110";
    WAIT FOR clk_period;

    UR <= "00101110010";
    UI <= "11111000011";
    WAIT FOR clk_period;

    UR <= "00110010111";
    UI <= "11111111110";
    WAIT FOR clk_period;

    UR <= "00110011011";
    UI <= "00001011110";
    WAIT FOR clk_period;

    UR <= "00101111110";
    UI <= "00011011110";
    WAIT FOR clk_period;

    UR <= "00101000001";
    UI <= "00101110001";
    WAIT FOR clk_period;

    UR <= "00011101100";
    UI <= "01000001000";
    WAIT FOR clk_period;

    UR <= "00010001001";
    UI <= "01010010010";
    WAIT FOR clk_period;

    UR <= "00000100011";
    UI <= "01011111101";
    WAIT FOR clk_period;

    UR <= "11111000101";
    UI <= "01100111010";
    WAIT FOR clk_period;

    UR <= "11101111001";
    UI <= "01101000010";
    WAIT FOR clk_period;

    UR <= "11101000100";
    UI <= "01100010010";
    WAIT FOR clk_period;

    UR <= "11100101000";
    UI <= "01010110000";
    WAIT FOR clk_period;

    UR <= "11100100010";
    UI <= "01000101000";
    WAIT FOR clk_period;

    UR <= "11100101101";
    UI <= "00110001010";
    WAIT FOR clk_period;

    UR <= "11101000000";
    UI <= "00011101011";
    WAIT FOR clk_period;

    UR <= "11101010001";
    UI <= "00001011111";
    WAIT FOR clk_period;

    UR <= "11101011000";
    UI <= "11111110111";
    WAIT FOR clk_period;

    UR <= "11101010000";
    UI <= "11110111101";
    WAIT FOR clk_period;

    UR <= "11100110110";
    UI <= "11110111000";
    WAIT FOR clk_period;

    UR <= "11100001110";
    UI <= "11111100101";
    WAIT FOR clk_period;

    UR <= "11011011101";
    UI <= "00000111001";
    WAIT FOR clk_period;

    UR <= "11010101101";
    UI <= "00010100110";
    WAIT FOR clk_period;

    UR <= "11010001000";
    UI <= "00100011010";
    WAIT FOR clk_period;

    UR <= "11001111001";
    UI <= "00110000001";
    WAIT FOR clk_period;

    UR <= "11010001001";
    UI <= "00111001101";
    WAIT FOR clk_period;

    UR <= "11010111011";
    UI <= "00111110000";
    WAIT FOR clk_period;

    UR <= "11100001111";
    UI <= "00111100110";
    WAIT FOR clk_period;

    UR <= "11101111101";
    UI <= "00110110000";
    WAIT FOR clk_period;

    UR <= "11111111100";
    UI <= "00101010111";
    WAIT FOR clk_period;

    UR <= "00001111100";
    UI <= "00011100110";
    WAIT FOR clk_period;

    UR <= "00011101111";
    UI <= "00001101101";
    WAIT FOR clk_period;

    UR <= "00101000110";
    UI <= "11111111110";
    WAIT FOR clk_period;

    UR <= "00101110110";
    UI <= "11110100101";
    WAIT FOR clk_period;

    UR <= "00101111010";
    UI <= "11101101101";
    WAIT FOR clk_period;

    UR <= "00101010010";
    UI <= "11101011010";
    WAIT FOR clk_period;

    UR <= "00100000100";
    UI <= "11101101100";
    WAIT FOR clk_period;

    UR <= "00010011110";
    UI <= "11110011011";
    WAIT FOR clk_period;

    UR <= "00000101111";
    UI <= "11111011101";
    WAIT FOR clk_period;

    UR <= "11111001010";
    UI <= "00000100101";
    WAIT FOR clk_period;

    UR <= "11110000000";
    UI <= "00001100101";
    WAIT FOR clk_period;

    UR <= "11101011100";
    UI <= "00010010010";
    WAIT FOR clk_period;

    UR <= "11101100111";
    UI <= "00010100100";
    WAIT FOR clk_period;

    UR <= "11110100000";
    UI <= "00010011000";
    WAIT FOR clk_period;

    UR <= "00000000010";
    UI <= "00001101111";
    WAIT FOR clk_period;

    UR <= "00001111110";
    UI <= "00000101110";
    WAIT FOR clk_period;

    UR <= "00100000101";
    UI <= "11111100000";
    WAIT FOR clk_period;

    UR <= "00110000011";
    UI <= "11110001111";
    WAIT FOR clk_period;

    UR <= "00111100101";
    UI <= "11101000101";
    WAIT FOR clk_period;

    UR <= "01000011111";
    UI <= "11100001101";
    WAIT FOR clk_period;

    UR <= "01000100110";
    UI <= "11011101011";
    WAIT FOR clk_period;

    UR <= "00111111001";
    UI <= "11011100011";
    WAIT FOR clk_period;

    UR <= "00110011101";
    UI <= "11011110011";
    WAIT FOR clk_period;

    UR <= "00100011110";
    UI <= "11100010110";
    WAIT FOR clk_period;

    UR <= "00010001100";
    UI <= "11101000101";
    WAIT FOR clk_period;

    UR <= "11111111001";
    UI <= "11101110111";
    WAIT FOR clk_period;

    UR <= "11101111000";
    UI <= "11110100101";
    WAIT FOR clk_period;

    UR <= "11100010110";
    UI <= "11111000111";
    WAIT FOR clk_period;

    UR <= "11011011111";
    UI <= "11111011010";
    WAIT FOR clk_period;

    UR <= "11011010110";
    UI <= "11111011100";
    WAIT FOR clk_period;

    UR <= "11011111000";
    UI <= "11111001111";
    WAIT FOR clk_period;

    UR <= "11100111101";
    UI <= "11110110110";
    WAIT FOR clk_period;

    UR <= "11110010111";
    UI <= "11110011001";
    WAIT FOR clk_period;

    UR <= "11111110111";
    UI <= "11101111100";
    WAIT FOR clk_period;

    UR <= "00001001101";
    UI <= "11101101000";
    WAIT FOR clk_period;

    UR <= "00010001010";
    UI <= "11101011111";
    WAIT FOR clk_period;

    UR <= "00010100110";
    UI <= "11101100110";
    WAIT FOR clk_period;

    UR <= "00010011010";
    UI <= "11101111101";
    WAIT FOR clk_period;

    UR <= "00001100110";
    UI <= "11110100001";
    WAIT FOR clk_period;

    UR <= "00000010001";
    UI <= "11111001111";
    WAIT FOR clk_period;

    UR <= "11110100010";
    UI <= "00000000010";
    WAIT FOR clk_period;

    UR <= "11100100110";
    UI <= "00000110100";
    WAIT FOR clk_period;

    UR <= "11010101001";
    UI <= "00001011111";
    WAIT FOR clk_period;

    UR <= "11000111001";
    UI <= "00001111111";
    WAIT FOR clk_period;

    UR <= "10111011110";
    UI <= "00010010001";
    WAIT FOR clk_period;

    UR <= "10110100011";
    UI <= "00010010100";
    WAIT FOR clk_period;

    UR <= "10110001010";
    UI <= "00010001001";
    WAIT FOR clk_period;

    UR <= "10110010101";
    UI <= "00001110011";
    WAIT FOR clk_period;

    UR <= "10111000011";
    UI <= "00001010100";
    WAIT FOR clk_period;

    UR <= "11000001101";
    UI <= "00000110001";
    WAIT FOR clk_period;

    UR <= "11001101111";
    UI <= "00000001111";
    WAIT FOR clk_period;

    UR <= "11011100001";
    UI <= "11111110001";
    WAIT FOR clk_period;

    UR <= "11101011010";
    UI <= "11111011011";
    WAIT FOR clk_period;

    UR <= "11111010010";
    UI <= "11111001101";
    WAIT FOR clk_period;

    UR <= "00001000001";
    UI <= "11111000111";
    WAIT FOR clk_period;

    UR <= "00010100001";
    UI <= "11111001010";
    WAIT FOR clk_period;

    UR <= "00011101010";
    UI <= "11111010010";
    WAIT FOR clk_period;

    UR <= "00100011000";
    UI <= "11111011101";
    WAIT FOR clk_period;

    UR <= "00100100101";
    UI <= "11111101001";
    WAIT FOR clk_period;

    UR <= "00100010001";
    UI <= "11111110010";
    WAIT FOR clk_period;

    UR <= "00011011010";
    UI <= "11111110111";
    WAIT FOR clk_period;

    UR <= "00010000100";
    UI <= "11111110101";
    WAIT FOR clk_period;

    UR <= "00000010011";
    UI <= "11111101101";
    WAIT FOR clk_period;

    UR <= "11110001111";
    UI <= "11111011111";
    WAIT FOR clk_period;

    UR <= "11100000001";
    UI <= "11111001100";
    WAIT FOR clk_period;

    UR <= "11001110100";
    UI <= "11110110110";
    WAIT FOR clk_period;

    UR <= "10111110011";
    UI <= "11110011111";
    WAIT FOR clk_period;

    UR <= "10110001000";
    UI <= "11110001010";
    WAIT FOR clk_period;

    UR <= "10100111100";
    UI <= "11101111000";
    WAIT FOR clk_period;

    UR <= "10100010011";
    UI <= "11101101011";
    WAIT FOR clk_period;

    UR <= "10100010010";
    UI <= "11101100011";
    WAIT FOR clk_period;

    UR <= "10100110100";
    UI <= "11101100010";
    WAIT FOR clk_period;

    UR <= "10101110110";
    UI <= "11101100101";
    WAIT FOR clk_period;

    UR <= "10111001111";
    UI <= "11101101101";
    WAIT FOR clk_period;

    UR <= "11000110100";
    UI <= "11101110111";
    WAIT FOR clk_period;

    UR <= "11010011001";
    UI <= "11110000100";
    WAIT FOR clk_period;

    UR <= "11011110110";
    UI <= "11110010001";
    WAIT FOR clk_period;

    UR <= "11101000000";
    UI <= "11110011110";
    WAIT FOR clk_period;

    UR <= "11101110011";
    UI <= "11110101100";
    WAIT FOR clk_period;

    UR <= "11110001100";
    UI <= "11110111001";
    WAIT FOR clk_period;

    UR <= "11110001101";
    UI <= "11111000111";
    WAIT FOR clk_period;

    UR <= "11101111001";
    UI <= "11111010111";
    WAIT FOR clk_period;

    UR <= "11101011000";
    UI <= "11111101001";
    WAIT FOR clk_period;

    UR <= "11100110000";
    UI <= "11111111100";
    WAIT FOR clk_period;

    UR <= "11100001011";
    UI <= "00000010001";
    WAIT FOR clk_period;

    UR <= "11011101110";
    UI <= "00000100101";
    WAIT FOR clk_period;

    UR <= "11011011101";
    UI <= "00000111000";
    WAIT FOR clk_period;

    UR <= "11011011011";
    UI <= "00001000101";
    WAIT FOR clk_period;

    UR <= "11011101000";
    UI <= "00001001011";
    WAIT FOR clk_period;

    UR <= "11100000001";
    UI <= "00001000111";
    WAIT FOR clk_period;

    UR <= "11100100010";
    UI <= "00000110111";
    WAIT FOR clk_period;

    UR <= "11101001000";
    UI <= "00000011010";
    WAIT FOR clk_period;

    UR <= "11101101110";
    UI <= "11111110000";
    WAIT FOR clk_period;

    UR <= "11110010010";
    UI <= "11110111100";
    WAIT FOR clk_period;

    UR <= "11110110100";
    UI <= "11110000001";
    WAIT FOR clk_period;

    UR <= "11111010010";
    UI <= "11101000010";
    WAIT FOR clk_period;

    UR <= "11111110000";
    UI <= "11100000101";
    WAIT FOR clk_period;

    UR <= "00000001111";
    UI <= "11011001111";
    WAIT FOR clk_period;

    UR <= "00000110001";
    UI <= "11010100101";
    WAIT FOR clk_period;

    UR <= "00001011000";
    UI <= "11010001010";
    WAIT FOR clk_period;

    UR <= "00010000010";
    UI <= "11001111111";
    WAIT FOR clk_period;

    UR <= "00010101110";
    UI <= "11010000100";
    WAIT FOR clk_period;

    UR <= "00011010111";
    UI <= "11010011000";
    WAIT FOR clk_period;

    UR <= "00011110110";
    UI <= "11010111000";
    WAIT FOR clk_period;

    UR <= "00100000110";
    UI <= "11011011110";
    WAIT FOR clk_period;

    UR <= "00100000000";
    UI <= "11100000110";
    WAIT FOR clk_period;

    UR <= "00011011111";
    UI <= "11100101011";
    WAIT FOR clk_period;

    UR <= "00010100010";
    UI <= "11101001000";
    WAIT FOR clk_period;

    UR <= "00001001011";
    UI <= "11101011100";
    WAIT FOR clk_period;

    UR <= "11111011110";
    UI <= "11101100011";
    WAIT FOR clk_period;

    UR <= "11101100101";
    UI <= "11101011110";
    WAIT FOR clk_period;

    UR <= "11011101011";
    UI <= "11101001111";
    WAIT FOR clk_period;

    UR <= "11001111101";
    UI <= "11100111001";
    WAIT FOR clk_period;

    UR <= "11000101000";
    UI <= "11100100000";
    WAIT FOR clk_period;

    UR <= "10111110101";
    UI <= "11100000110";
    WAIT FOR clk_period;

    UR <= "10111101100";
    UI <= "11011110000";
    WAIT FOR clk_period;

    UR <= "11000001111";
    UI <= "11011100010";
    WAIT FOR clk_period;

    UR <= "11001011101";
    UI <= "11011011100";
    WAIT FOR clk_period;

    UR <= "11011001100";
    UI <= "11011100001";
    WAIT FOR clk_period;

    UR <= "11101010010";
    UI <= "11011110001";
    WAIT FOR clk_period;

    UR <= "11111100000";
    UI <= "11100001100";
    WAIT FOR clk_period;

    UR <= "00001100110";
    UI <= "11100110001";
    WAIT FOR clk_period;

    UR <= "00011010101";
    UI <= "11101011110";
    WAIT FOR clk_period;

    UR <= "00100100010";
    UI <= "11110010011";
    WAIT FOR clk_period;

    UR <= "00101000110";
    UI <= "11111001110";
    WAIT FOR clk_period;

    UR <= "00100111101";
    UI <= "00000001100";
    WAIT FOR clk_period;

    UR <= "00100001101";
    UI <= "00001001011";
    WAIT FOR clk_period;

    UR <= "00010111011";
    UI <= "00010001011";
    WAIT FOR clk_period;

    UR <= "00001010110";
    UI <= "00011001001";
    WAIT FOR clk_period;

    UR <= "11111101010";
    UI <= "00100000010";
    WAIT FOR clk_period;

    UR <= "11110000111";
    UI <= "00100110101";
    WAIT FOR clk_period;

    UR <= "11100111000";
    UI <= "00101100001";
    WAIT FOR clk_period;

    UR <= "11100001000";
    UI <= "00110000011";
    WAIT FOR clk_period;

    UR <= "11011111011";
    UI <= "00110011010";
    WAIT FOR clk_period;

    UR <= "11100010011";
    UI <= "00110101000";
    WAIT FOR clk_period;

    UR <= "11101001010";
    UI <= "00110101100";
    WAIT FOR clk_period;

    UR <= "11110011001";
    UI <= "00110101000";
    WAIT FOR clk_period;

    UR <= "11111110100";
    UI <= "00110011110";
    WAIT FOR clk_period;

    UR <= "00001010001";
    UI <= "00110010000";
    WAIT FOR clk_period;

    UR <= "00010100101";
    UI <= "00101111111";
    WAIT FOR clk_period;

    UR <= "00011100101";
    UI <= "00101101101";
    WAIT FOR clk_period;

    UR <= "00100001100";
    UI <= "00101011010";
    WAIT FOR clk_period;

    UR <= "00100010111";
    UI <= "00101000110";
    WAIT FOR clk_period;

    UR <= "00100001000";
    UI <= "00100101110";
    WAIT FOR clk_period;

    UR <= "00011100001";
    UI <= "00100010001";
    WAIT FOR clk_period;

    UR <= "00010101001";
    UI <= "00011101100";
    WAIT FOR clk_period;

    UR <= "00001101000";
    UI <= "00010111101";
    WAIT FOR clk_period;

    UR <= "00000100110";
    UI <= "00010000010";
    WAIT FOR clk_period;

    UR <= "11111101010";
    UI <= "00000111011";
    WAIT FOR clk_period;

    UR <= "11110111001";
    UI <= "11111101011";
    WAIT FOR clk_period;

    UR <= "11110010111";
    UI <= "11110010100";
    WAIT FOR clk_period;

    UR <= "11110000101";
    UI <= "11100111100";
    WAIT FOR clk_period;

    UR <= "11110000011";
    UI <= "11011101011";
    WAIT FOR clk_period;

    UR <= "11110010000";
    UI <= "11010100110";
    WAIT FOR clk_period;

    UR <= "11110101000";
    UI <= "11001110101";
    WAIT FOR clk_period;

    UR <= "11111001000";
    UI <= "11001011100";
    WAIT FOR clk_period;

    UR <= "11111101110";
    UI <= "11001100000";
    WAIT FOR clk_period;

    UR <= "00000010110";
    UI <= "11010000001";
    WAIT FOR clk_period;

    UR <= "00000111101";
    UI <= "11010111101";
    WAIT FOR clk_period;

    UR <= "00001100010";
    UI <= "11100001110";
    WAIT FOR clk_period;

    UR <= "00010000010";
    UI <= "11101101110";
    WAIT FOR clk_period;

    UR <= "00010011101";
    UI <= "11111010101";
    WAIT FOR clk_period;

    UR <= "00010101111";
    UI <= "00000111001";
    WAIT FOR clk_period;

    UR <= "00010111000";
    UI <= "00010010010";
    WAIT FOR clk_period;

    UR <= "00010110111";
    UI <= "00011011010";
    WAIT FOR clk_period;

    UR <= "00010101010";
    UI <= "00100001100";
    WAIT FOR clk_period;

    UR <= "00010010001";
    UI <= "00100101000";
    WAIT FOR clk_period;

    UR <= "00001101100";
    UI <= "00100101101";
    WAIT FOR clk_period;

    UR <= "00000111100";
    UI <= "00100100001";
    WAIT FOR clk_period;

    UR <= "00000000010";
    UI <= "00100001001";
    WAIT FOR clk_period;

    UR <= "11111000011";
    UI <= "00011101011";
    WAIT FOR clk_period;

    UR <= "11110000001";
    UI <= "00011001100";
    WAIT FOR clk_period;

    UR <= "11101000000";
    UI <= "00010110010";
    WAIT FOR clk_period;

    UR <= "11100000110";
    UI <= "00010100000";
    WAIT FOR clk_period;

    UR <= "11011010110";
    UI <= "00010011000";
    WAIT FOR clk_period;

    UR <= "11010110010";
    UI <= "00010011000";
    WAIT FOR clk_period;

    UR <= "11010011101";
    UI <= "00010011111";
    WAIT FOR clk_period;

    UR <= "11010011001";
    UI <= "00010101000";
    WAIT FOR clk_period;

    UR <= "11010100011";
    UI <= "00010110000";
    WAIT FOR clk_period;

    UR <= "11010111100";
    UI <= "00010110011";
    WAIT FOR clk_period;

    UR <= "11011100000";
    UI <= "00010110000";
    WAIT FOR clk_period;

    UR <= "11100001101";
    UI <= "00010100110";
    WAIT FOR clk_period;

    UR <= "11101000000";
    UI <= "00010010110";
    WAIT FOR clk_period;

    UR <= "11101110110";
    UI <= "00010000011";
    WAIT FOR clk_period;

    UR <= "11110101011";
    UI <= "00001110000";
    WAIT FOR clk_period;

    UR <= "11111011111";
    UI <= "00001100010";
    WAIT FOR clk_period;

    UR <= "00000010000";
    UI <= "00001011101";
    WAIT FOR clk_period;

    UR <= "00000111011";
    UI <= "00001100011";
    WAIT FOR clk_period;

    UR <= "00001100000";
    UI <= "00001110111";
    WAIT FOR clk_period;

    UR <= "00001111111";
    UI <= "00010010110";
    WAIT FOR clk_period;

    UR <= "00010010110";
    UI <= "00010111111";
    WAIT FOR clk_period;

    UR <= "00010100101";
    UI <= "00011101100";
    WAIT FOR clk_period;

    UR <= "00010101010";
    UI <= "00100011000";
    WAIT FOR clk_period;

    UR <= "00010100110";
    UI <= "00100111101";
    WAIT FOR clk_period;

    UR <= "00010011001";
    UI <= "00101010101";
    WAIT FOR clk_period;

    UR <= "00010000011";
    UI <= "00101011011";
    WAIT FOR clk_period;

    UR <= "00001100100";
    UI <= "00101001101";
    WAIT FOR clk_period;

    UR <= "00001000000";
    UI <= "00100101011";
    WAIT FOR clk_period;

    UR <= "00000011001";
    UI <= "00011110111";
    WAIT FOR clk_period;

    UR <= "11111110001";
    UI <= "00010110110";
    WAIT FOR clk_period;

    UR <= "11111001101";
    UI <= "00001101101";
    WAIT FOR clk_period;

    UR <= "11110110000";
    UI <= "00000100101";
    WAIT FOR clk_period;

    UR <= "11110011100";
    UI <= "11111100100";
    WAIT FOR clk_period;

    UR <= "11110010101";
    UI <= "11110101111";
    WAIT FOR clk_period;

    UR <= "11110011010";
    UI <= "11110001100";
    WAIT FOR clk_period;

    UR <= "11110101101";
    UI <= "11101111100";
    WAIT FOR clk_period;

    UR <= "11111001011";
    UI <= "11110000000";
    WAIT FOR clk_period;

    UR <= "11111110011";
    UI <= "11110010100";
    WAIT FOR clk_period;

    UR <= "00000100010";
    UI <= "11110110110";
    WAIT FOR clk_period;

    UR <= "00001010101";
    UI <= "11111011111";
    WAIT FOR clk_period;

    UR <= "00010001000";
    UI <= "00000001010";
    WAIT FOR clk_period;

    UR <= "00010110111";
    UI <= "00000110010";
    WAIT FOR clk_period;

    UR <= "00011100010";
    UI <= "00001010100";
    WAIT FOR clk_period;

    UR <= "00100000101";
    UI <= "00001101110";
    WAIT FOR clk_period;

    UR <= "00100100001";
    UI <= "00001111111";
    WAIT FOR clk_period;

    UR <= "00100110110";
    UI <= "00010001001";
    WAIT FOR clk_period;

    UR <= "00101000011";
    UI <= "00010001110";
    WAIT FOR clk_period;

    UR <= "00101001011";
    UI <= "00010010011";
    WAIT FOR clk_period;

    UR <= "00101001110";
    UI <= "00010011100";
    WAIT FOR clk_period;

    UR <= "00101001110";
    UI <= "00010101010";
    WAIT FOR clk_period;

    UR <= "00101001010";
    UI <= "00011000000";
    WAIT FOR clk_period;

    UR <= "00101000100";
    UI <= "00011011111";
    WAIT FOR clk_period;

    UR <= "00100111011";
    UI <= "00100000100";
    WAIT FOR clk_period;

    UR <= "00100101101";
    UI <= "00100101101";
    WAIT FOR clk_period;

    UR <= "00100011100";
    UI <= "00101010101";
    WAIT FOR clk_period;

    UR <= "00100000110";
    UI <= "00101110111";
    WAIT FOR clk_period;

    UR <= "00011101010";
    UI <= "00110010000";
    WAIT FOR clk_period;

    UR <= "00011001001";
    UI <= "00110011011";
    WAIT FOR clk_period;

    UR <= "00010100011";
    UI <= "00110010101";
    WAIT FOR clk_period;

    UR <= "00001111001";
    UI <= "00101111110";
    WAIT FOR clk_period;

    UR <= "00001001101";
    UI <= "00101011000";
    WAIT FOR clk_period;

    UR <= "00000100000";
    UI <= "00100100101";
    WAIT FOR clk_period;

    UR <= "11111110100";
    UI <= "00011101001";
    WAIT FOR clk_period;

    UR <= "11111001010";
    UI <= "00010101001";
    WAIT FOR clk_period;

    UR <= "11110100011";
    UI <= "00001101001";
    WAIT FOR clk_period;

    UR <= "11110000000";
    UI <= "00000101110";
    WAIT FOR clk_period;

    UR <= "11101100010";
    UI <= "11111111010";
    WAIT FOR clk_period;

    UR <= "11101001001";
    UI <= "11111010000";
    WAIT FOR clk_period;

    UR <= "11100110011";
    UI <= "11110101110";
    WAIT FOR clk_period;

    UR <= "11100100010";
    UI <= "11110010101";
    WAIT FOR clk_period;

    UR <= "11100010101";
    UI <= "11110000001";
    WAIT FOR clk_period;

    UR <= "11100001100";
    UI <= "11101110001";
    WAIT FOR clk_period;

    UR <= "11100000111";
    UI <= "11101100010";
    WAIT FOR clk_period;

    UR <= "11100000110";
    UI <= "11101010010";
    WAIT FOR clk_period;

    UR <= "11100001000";
    UI <= "11101000000";
    WAIT FOR clk_period;

    UR <= "11100001110";
    UI <= "11100101101";
    WAIT FOR clk_period;

    UR <= "11100010111";
    UI <= "11100011011";
    WAIT FOR clk_period;

    UR <= "11100100010";
    UI <= "11100001100";
    WAIT FOR clk_period;

    UR <= "11100101101";
    UI <= "11100000011";
    WAIT FOR clk_period;

    UR <= "11100110110";
    UI <= "11100000100";
    WAIT FOR clk_period;

    UR <= "11100111101";
    UI <= "11100010000";
    WAIT FOR clk_period;

    UR <= "11101000001";
    UI <= "11100101011";
    WAIT FOR clk_period;

    UR <= "11100111111";
    UI <= "11101010100";
    WAIT FOR clk_period;

    UR <= "11100111010";
    UI <= "11110001010";
    WAIT FOR clk_period;

    UR <= "11100110010";
    UI <= "11111001001";
    WAIT FOR clk_period;

    UR <= "11100101011";
    UI <= "00000001101";
    WAIT FOR clk_period;

    UR <= "11100100110";
    UI <= "00001010010";
    WAIT FOR clk_period;

    UR <= "11100101001";
    UI <= "00010010000";
    WAIT FOR clk_period;

    UR <= "11100110110";
    UI <= "00011000011";
    WAIT FOR clk_period;

    UR <= "11101001111";
    UI <= "00011100100";
    WAIT FOR clk_period;

    UR <= "11101110111";
    UI <= "00011110000";
    WAIT FOR clk_period;

    UR <= "11110101101";
    UI <= "00011100101";
    WAIT FOR clk_period;

    UR <= "11111101101";
    UI <= "00011000011";
    WAIT FOR clk_period;

    UR <= "00000110010";
    UI <= "00010001011";
    WAIT FOR clk_period;

    UR <= "00001110111";
    UI <= "00001000001";
    WAIT FOR clk_period;

    UR <= "00010110101";
    UI <= "11111101010";
    WAIT FOR clk_period;

    UR <= "00011100100";
    UI <= "11110001100";
    WAIT FOR clk_period;

    UR <= "00011111111";
    UI <= "11100101101";
    WAIT FOR clk_period;

    UR <= "00100000011";
    UI <= "11011010100";
    WAIT FOR clk_period;

    UR <= "00011101110";
    UI <= "11010000111";
    WAIT FOR clk_period;

    UR <= "00011000001";
    UI <= "11001001001";
    WAIT FOR clk_period;

    UR <= "00010000011";
    UI <= "11000011111";
    WAIT FOR clk_period;

    UR <= "00000111010";
    UI <= "11000001000";
    WAIT FOR clk_period;

    UR <= "11111101110";
    UI <= "11000000111";
    WAIT FOR clk_period;

    UR <= "11110101000";
    UI <= "11000011000";
    WAIT FOR clk_period;

    UR <= "11101110000";
    UI <= "11000111011";
    WAIT FOR clk_period;

    UR <= "11101001011";
    UI <= "11001101011";
    WAIT FOR clk_period;

    UR <= "11100111100";
    UI <= "11010100111";
    WAIT FOR clk_period;

    UR <= "11101000011";
    UI <= "11011101001";
    WAIT FOR clk_period;

    UR <= "11101011100";
    UI <= "11100110001";
    WAIT FOR clk_period;

    UR <= "11110000010";
    UI <= "11101111001";
    WAIT FOR clk_period;

    UR <= "11110101101";
    UI <= "11111000001";
    WAIT FOR clk_period;

    UR <= "11111010111";
    UI <= "00000000101";
    WAIT FOR clk_period;

    UR <= "11111111001";
    UI <= "00001000100";
    WAIT FOR clk_period;

    UR <= "00000001110";
    UI <= "00001111010";
    WAIT FOR clk_period;

    UR <= "00000010110";
    UI <= "00010100100";
    WAIT FOR clk_period;

    UR <= "00000010001";
    UI <= "00011000000";
    WAIT FOR clk_period;

    UR <= "00000000010";
    UI <= "00011001100";
    WAIT FOR clk_period;

    UR <= "11111110000";
    UI <= "00011000011";
    WAIT FOR clk_period;

    UR <= "11111100000";
    UI <= "00010100101";
    WAIT FOR clk_period;

    UR <= "11111010111";
    UI <= "00001110010";
    WAIT FOR clk_period;

    UR <= "11111011010";
    UI <= "00000101011";
    WAIT FOR clk_period;

    UR <= "11111101010";
    UI <= "11111010011";
    WAIT FOR clk_period;

    UR <= "00000000110";
    UI <= "11101110000";
    WAIT FOR clk_period;

    UR <= "00000101001";
    UI <= "11100001010";
    WAIT FOR clk_period;

    UR <= "00001001110";
    UI <= "11010101000";
    WAIT FOR clk_period;

    UR <= "00001101101";
    UI <= "11001010100";
    WAIT FOR clk_period;

    UR <= "00001111110";
    UI <= "11000010101";
    WAIT FOR clk_period;

    UR <= "00001111011";
    UI <= "10111110011";
    WAIT FOR clk_period;

    UR <= "00001011111";
    UI <= "10111110001";
    WAIT FOR clk_period;

    UR <= "00000101011";
    UI <= "11000010000";
    WAIT FOR clk_period;

    UR <= "11111011110";
    UI <= "11001001110";
    WAIT FOR clk_period;

    UR <= "11110000001";
    UI <= "11010100100";
    WAIT FOR clk_period;

    UR <= "11100011001";
    UI <= "11100001001";
    WAIT FOR clk_period;

    UR <= "11010110010";
    UI <= "11101110010";
    WAIT FOR clk_period;

    UR <= "11001010111";
    UI <= "11111010011";
    WAIT FOR clk_period;

    UR <= "11000001111";
    UI <= "00000100001";
    WAIT FOR clk_period;

    UR <= "10111100101";
    UI <= "00001010100";
    WAIT FOR clk_period;

    UR <= "10111011101";
    UI <= "00001100101";
    WAIT FOR clk_period;

    UR <= "10111111010";
    UI <= "00001010010";
    WAIT FOR clk_period;

    UR <= "11000111011";
    UI <= "00000011101";
    WAIT FOR clk_period;

    UR <= "11010011100";
    UI <= "11111001011";
    WAIT FOR clk_period;

    UR <= "11100010110";
    UI <= "11101100110";
    WAIT FOR clk_period;

    UR <= "11110100010";
    UI <= "11011110111";
    WAIT FOR clk_period;

    UR <= "00000110101";
    UI <= "11010001001";
    WAIT FOR clk_period;

    UR <= "00011000110";
    UI <= "11000100111";
    WAIT FOR clk_period;

    UR <= "00101001011";
    UI <= "10111011000";
    WAIT FOR clk_period;

    UR <= "00110111101";
    UI <= "10110100100";
    WAIT FOR clk_period;

    UR <= "01000010101";
    UI <= "10110001100";
    WAIT FOR clk_period;

    UR <= "01001001101";
    UI <= "10110010001";
    WAIT FOR clk_period;

    UR <= "01001100010";
    UI <= "10110110001";
    WAIT FOR clk_period;

    UR <= "01001010101";
    UI <= "10111100101";
    WAIT FOR clk_period;

    UR <= "01000100110";
    UI <= "11000101010";
    WAIT FOR clk_period;

    UR <= "00111011001";
    UI <= "11001110111";
    WAIT FOR clk_period;

    UR <= "00101110100";
    UI <= "11011000111";
    WAIT FOR clk_period;

    UR <= "00011111101";
    UI <= "11100010101";
    WAIT FOR clk_period;

    UR <= "00001111101";
    UI <= "11101011101";
    WAIT FOR clk_period;

    UR <= "11111111110";
    UI <= "11110011010";
    WAIT FOR clk_period;

    UR <= "11110001000";
    UI <= "11111001100";
    WAIT FOR clk_period;

    UR <= "11100100110";
    UI <= "11111110001";
    WAIT FOR clk_period;

    UR <= "11011011110";
    UI <= "00000001010";
    WAIT FOR clk_period;

    UR <= "11010110101";
    UI <= "00000010111";
    WAIT FOR clk_period;

    UR <= "11010110000";
    UI <= "00000011000";
    WAIT FOR clk_period;

    UR <= "11011001101";
    UI <= "00000010001";
    WAIT FOR clk_period;

    UR <= "11100001001";
    UI <= "00000000010";
    WAIT FOR clk_period;

    UR <= "11101011111";
    UI <= "11111101111";
    WAIT FOR clk_period;

    UR <= "11111000101";
    UI <= "11111011010";
    WAIT FOR clk_period;

    UR <= "00000110010";
    UI <= "11111000111";
    WAIT FOR clk_period;

    UR <= "00010011011";
    UI <= "11110111001";
    WAIT FOR clk_period;

    UR <= "00011110111";
    UI <= "11110110011";
    WAIT FOR clk_period;

    UR <= "00100111101";
    UI <= "11110110111";
    WAIT FOR clk_period;

    UR <= "00101100111";
    UI <= "11111000101";
    WAIT FOR clk_period;

    UR <= "00101110001";
    UI <= "11111011101";
    WAIT FOR clk_period;

    UR <= "00101011011";
    UI <= "11111111100";
    WAIT FOR clk_period;

    UR <= "00100101000";
    UI <= "00000011111";
    WAIT FOR clk_period;

    UR <= "00011011101";
    UI <= "00001000001";
    WAIT FOR clk_period;

    UR <= "00010000001";
    UI <= "00001011101";
    WAIT FOR clk_period;

    UR <= "00000011011";
    UI <= "00001101110";
    WAIT FOR clk_period;

    UR <= "11110110110";
    UI <= "00001110000";
    WAIT FOR clk_period;

    UR <= "11101010111";
    UI <= "00001100100";
    WAIT FOR clk_period;

    UR <= "11100000111";
    UI <= "00001000111";
    WAIT FOR clk_period;

    UR <= "11011001010";
    UI <= "00000011111";
    WAIT FOR clk_period;

    UR <= "11010100011";
    UI <= "11111101111";
    WAIT FOR clk_period;

    UR <= "11010010100";
    UI <= "11110111110";
    WAIT FOR clk_period;

    UR <= "11010011100";
    UI <= "11110010011";
    WAIT FOR clk_period;

    UR <= "11010111000";
    UI <= "11101110011";
    WAIT FOR clk_period;

    UR <= "11011100101";
    UI <= "11101100100";
    WAIT FOR clk_period;

    UR <= "11100011111";
    UI <= "11101101000";
    WAIT FOR clk_period;

    UR <= "11101011111";
    UI <= "11110000000";
    WAIT FOR clk_period;

    UR <= "11110100010";
    UI <= "11110100111";
    WAIT FOR clk_period;

    UR <= "11111100010";
    UI <= "11111011001";
    WAIT FOR clk_period;

    UR <= "00000011010";
    UI <= "00000010000";
    WAIT FOR clk_period;

    UR <= "00001000111";
    UI <= "00001000100";
    WAIT FOR clk_period;

    UR <= "00001100110";
    UI <= "00001101111";
    WAIT FOR clk_period;

    UR <= "00001110110";
    UI <= "00010001011";
    WAIT FOR clk_period;

    UR <= "00001110110";
    UI <= "00010010110";
    WAIT FOR clk_period;

    UR <= "00001100110";
    UI <= "00010001111";
    WAIT FOR clk_period;

    UR <= "00001001000";
    UI <= "00001111001";
    WAIT FOR clk_period;

    UR <= "00000011111";
    UI <= "00001011001";
    WAIT FOR clk_period;

    UR <= "11111101101";
    UI <= "00000110011";
    WAIT FOR clk_period;

    UR <= "11110110111";
    UI <= "00000001111";
    WAIT FOR clk_period;

    UR <= "11110000000";
    UI <= "11111110010";
    WAIT FOR clk_period;

    UR <= "11101001011";
    UI <= "11111011111";
    WAIT FOR clk_period;

    UR <= "11100011101";
    UI <= "11111011001";
    WAIT FOR clk_period;

    UR <= "11011111001";
    UI <= "11111011110";
    WAIT FOR clk_period;

    UR <= "11011011111";
    UI <= "11111101100";
    WAIT FOR clk_period;

    UR <= "11011010011";
    UI <= "11111111111";
    WAIT FOR clk_period;

    UR <= "11011010101";
    UI <= "00000010010";
    WAIT FOR clk_period;

    UR <= "11011100100";
    UI <= "00000011111";
    WAIT FOR clk_period;

    UR <= "11011111111";
    UI <= "00000100100";
    WAIT FOR clk_period;

    UR <= "11100100100";
    UI <= "00000011110";
    WAIT FOR clk_period;

    UR <= "11101001111";
    UI <= "00000001101";
    WAIT FOR clk_period;

    UR <= "11101111101";
    UI <= "11111110110";
    WAIT FOR clk_period;

    UR <= "11110101010";
    UI <= "11111011011";
    WAIT FOR clk_period;

    UR <= "11111010001";
    UI <= "11111000010";
    WAIT FOR clk_period;

    UR <= "11111101111";
    UI <= "11110110010";
    WAIT FOR clk_period;

    UR <= "00000000011";
    UI <= "11110101111";
    WAIT FOR clk_period;

    UR <= "00000001001";
    UI <= "11110111101";
    WAIT FOR clk_period;

    UR <= "00000000011";
    UI <= "11111011110";
    WAIT FOR clk_period;

    UR <= "11111110010";
    UI <= "00000010001";
    WAIT FOR clk_period;

    UR <= "11111011001";
    UI <= "00001010010";
    WAIT FOR clk_period;

    UR <= "11110111111";
    UI <= "00010011100";
    WAIT FOR clk_period;

    UR <= "11110101000";
    UI <= "00011100111";
    WAIT FOR clk_period;

    UR <= "11110011011";
    UI <= "00100101101";
    WAIT FOR clk_period;

    UR <= "11110011011";
    UI <= "00101100110";
    WAIT FOR clk_period;

    UR <= "11110101110";
    UI <= "00110001101";
    WAIT FOR clk_period;

    UR <= "11111010100";
    UI <= "00110011101";
    WAIT FOR clk_period;

    UR <= "00000001010";
    UI <= "00110010100";
    WAIT FOR clk_period;

    UR <= "00001001110";
    UI <= "00101110100";
    WAIT FOR clk_period;

    UR <= "00010011000";
    UI <= "00100111110";
    WAIT FOR clk_period;

    UR <= "00011100000";
    UI <= "00011111010";
    WAIT FOR clk_period;

    UR <= "00100011011";
    UI <= "00010101011";
    WAIT FOR clk_period;

    UR <= "00101000000";
    UI <= "00001011001";
    WAIT FOR clk_period;

    UR <= "00101001001";
    UI <= "00000001001";
    WAIT FOR clk_period;

    UR <= "00100110000";
    UI <= "11111000010";
    WAIT FOR clk_period;

    UR <= "00011110101";
    UI <= "11110000110";
    WAIT FOR clk_period;

    UR <= "00010011011";
    UI <= "11101011000";
    WAIT FOR clk_period;

    UR <= "00000101001";
    UI <= "11100110111";
    WAIT FOR clk_period;

    UR <= "11110101010";
    UI <= "11100100010";
    WAIT FOR clk_period;

    UR <= "11100101010";
    UI <= "11100010110";
    WAIT FOR clk_period;

    UR <= "11010110110";
    UI <= "11100010000";
    WAIT FOR clk_period;

    UR <= "11001011001";
    UI <= "11100001101";
    WAIT FOR clk_period;

    UR <= "11000011100";
    UI <= "11100001001";
    WAIT FOR clk_period;

    UR <= "11000000101";
    UI <= "11100000011";
    WAIT FOR clk_period;

    UR <= "11000010011";
    UI <= "11011111011";
    WAIT FOR clk_period;

    UR <= "11001000010";
    UI <= "11011110001";
    WAIT FOR clk_period;

    UR <= "11010001010";
    UI <= "11011100111";
    WAIT FOR clk_period;

    UR <= "11011100000";
    UI <= "11011100001";
    WAIT FOR clk_period;

    UR <= "11100111001";
    UI <= "11011100000";
    WAIT FOR clk_period;

    UR <= "11110001000";
    UI <= "11011101001";
    WAIT FOR clk_period;

    UR <= "11111000110";
    UI <= "11011111100";
    WAIT FOR clk_period;

    UR <= "11111101100";
    UI <= "11100011101";
    WAIT FOR clk_period;

    UR <= "11111111000";
    UI <= "11101001001";
    WAIT FOR clk_period;

    UR <= "11111101101";
    UI <= "11110000000";
    WAIT FOR clk_period;

    UR <= "11111010001";
    UI <= "11110111111";
    WAIT FOR clk_period;

    UR <= "11110101100";
    UI <= "00000000001";
    WAIT FOR clk_period;

    UR <= "11110000111";
    UI <= "00001000011";
    WAIT FOR clk_period;

    UR <= "11101101011";
    UI <= "00010000001";
    WAIT FOR clk_period;

    UR <= "11101011111";
    UI <= "00010110111";
    WAIT FOR clk_period;

    UR <= "11101100110";
    UI <= "00011100100";
    WAIT FOR clk_period;

    UR <= "11101111111";
    UI <= "00100000111";
    WAIT FOR clk_period;

    UR <= "11110101001";
    UI <= "00100100000";
    WAIT FOR clk_period;

    UR <= "11111011100";
    UI <= "00100110000";
    WAIT FOR clk_period;

    UR <= "00000010000";
    UI <= "00100111010";
    WAIT FOR clk_period;

    UR <= "00000111111";
    UI <= "00100111110";
    WAIT FOR clk_period;

    UR <= "00001100001";
    UI <= "00100111111";
    WAIT FOR clk_period;

    UR <= "00001110010";
    UI <= "00100111100";
    WAIT FOR clk_period;

    UR <= "00001110000";
    UI <= "00100110100";
    WAIT FOR clk_period;

    UR <= "00001011110";
    UI <= "00100100111";
    WAIT FOR clk_period;

    UR <= "00001000001";
    UI <= "00100010001";
    WAIT FOR clk_period;

    UR <= "00000100001";
    UI <= "00011101111";
    WAIT FOR clk_period;

    UR <= "00000000100";
    UI <= "00011000000";
    WAIT FOR clk_period;

    UR <= "11111110100";
    UI <= "00010000010";
    WAIT FOR clk_period;

    UR <= "11111110110";
    UI <= "00000110110";
    WAIT FOR clk_period;

    UR <= "00000001100";
    UI <= "11111011111";
    WAIT FOR clk_period;

    UR <= "00000110111";
    UI <= "11110000001";
    WAIT FOR clk_period;

    UR <= "00001110001";
    UI <= "11100100011";
    WAIT FOR clk_period;

    UR <= "00010110010";
    UI <= "11011001100";
    WAIT FOR clk_period;

    UR <= "00011110011";
    UI <= "11010000011";
    WAIT FOR clk_period;

    UR <= "00100101000";
    UI <= "11001010001";
    WAIT FOR clk_period;

    UR <= "00101000111";
    UI <= "11000111010";
    WAIT FOR clk_period;

    UR <= "00101001011";
    UI <= "11001000000";
    WAIT FOR clk_period;

    UR <= "00100101110";
    UI <= "11001100100";
    WAIT FOR clk_period;

    UR <= "00011110001";
    UI <= "11010100001";
    WAIT FOR clk_period;

    UR <= "00010011001";
    UI <= "11011110011";
    WAIT FOR clk_period;

    UR <= "00000101100";
    UI <= "11101010000";
    WAIT FOR clk_period;

    UR <= "11110110101";
    UI <= "11110110000";
    WAIT FOR clk_period;

    UR <= "11101000000";
    UI <= "00000001000";
    WAIT FOR clk_period;

    UR <= "11011010111";
    UI <= "00001001111";
    WAIT FOR clk_period;

    UR <= "11010000100";
    UI <= "00010000000";
    WAIT FOR clk_period;

    UR <= "11001001110";
    UI <= "00010010100";
    WAIT FOR clk_period;

    UR <= "11000110111";
    UI <= "00010001011";
    WAIT FOR clk_period;

    UR <= "11000111111";
    UI <= "00001100101";
    WAIT FOR clk_period;

    UR <= "11001100010";
    UI <= "00000100111";
    WAIT FOR clk_period;

    UR <= "11010011001";
    UI <= "11111010101";
    WAIT FOR clk_period;

    UR <= "11011011100";
    UI <= "11101110110";
    WAIT FOR clk_period;

    UR <= "11100100011";
    UI <= "11100010100";
    WAIT FOR clk_period;

    UR <= "11101100101";
    UI <= "11010110101";
    WAIT FOR clk_period;

    UR <= "11110011110";
    UI <= "11001100010";
    WAIT FOR clk_period;

    UR <= "11111001001";
    UI <= "11000100001";
    WAIT FOR clk_period;

    UR <= "11111100101";
    UI <= "10111111000";
    WAIT FOR clk_period;

    UR <= "11111110101";
    UI <= "10111101100";
    WAIT FOR clk_period;

    UR <= "11111111010";
    UI <= "10111111110";
    WAIT FOR clk_period;

    UR <= "11111111010";
    UI <= "11000110000";
    WAIT FOR clk_period;

    UR <= "11111111000";
    UI <= "11010000000";
    WAIT FOR clk_period;

    UR <= "11111111000";
    UI <= "11011101011";
    WAIT FOR clk_period;

    UR <= "11111111100";
    UI <= "11101101011";
    WAIT FOR clk_period;

    UR <= "00000000101";
    UI <= "11111111000";
    WAIT FOR clk_period;

    UR <= "00000010001";
    UI <= "00010001001";
    WAIT FOR clk_period;

    UR <= "00000011111";
    UI <= "00100010001";
    WAIT FOR clk_period;

    UR <= "00000101010";
    UI <= "00110000111";
    WAIT FOR clk_period;

    UR <= "00000101110";
    UI <= "00111100000";
    WAIT FOR clk_period;

    UR <= "00000101001";
    UI <= "01000010010";
    WAIT FOR clk_period;

    UR <= "00000010111";
    UI <= "01000011000";
    WAIT FOR clk_period;

    UR <= "11111111001";
    UI <= "00111101111";
    WAIT FOR clk_period;

    UR <= "11111001110";
    UI <= "00110011011";
    WAIT FOR clk_period;

    UR <= "11110011011";
    UI <= "00100100001";
    WAIT FOR clk_period;

    UR <= "11101100001";
    UI <= "00010001100";
    WAIT FOR clk_period;

    UR <= "11100100110";
    UI <= "11111101010";
    WAIT FOR clk_period;

    UR <= "11011101111";
    UI <= "11101001011";
    WAIT FOR clk_period;

    UR <= "11010111111";
    UI <= "11010111101";
    WAIT FOR clk_period;

    UR <= "11010011010";
    UI <= "11001001101";
    WAIT FOR clk_period;

    UR <= "11010000011";
    UI <= "11000000110";
    WAIT FOR clk_period;

    UR <= "11001111011";
    UI <= "10111101100";
    WAIT FOR clk_period;

    UR <= "11010000011";
    UI <= "10111111101";
    WAIT FOR clk_period;

    UR <= "11010011000";
    UI <= "11000110101";
    WAIT FOR clk_period;

    UR <= "11010111010";
    UI <= "11010001001";
    WAIT FOR clk_period;

    UR <= "11011100110";
    UI <= "11011101010";
    WAIT FOR clk_period;

    UR <= "11100011000";
    UI <= "11101001011";
    WAIT FOR clk_period;

    UR <= "11101001111";
    UI <= "11110011011";
    WAIT FOR clk_period;

    UR <= "11110001000";
    UI <= "11111010001";
    WAIT FOR clk_period;

    UR <= "11111000000";
    UI <= "11111100100";
    WAIT FOR clk_period;

    UR <= "11111110100";
    UI <= "11111010001";
    WAIT FOR clk_period;

    UR <= "00000100010";
    UI <= "11110011011";
    WAIT FOR clk_period;

    UR <= "00001000111";
    UI <= "11101001001";
    WAIT FOR clk_period;

    UR <= "00001100010";
    UI <= "11011100101";
    WAIT FOR clk_period;

    UR <= "00001110001";
    UI <= "11001111011";
    WAIT FOR clk_period;

    UR <= "00001110100";
    UI <= "11000011001";
    WAIT FOR clk_period;

    UR <= "00001101001";
    UI <= "10111000111";
    WAIT FOR clk_period;

    UR <= "00001010011";
    UI <= "10110001111";
    WAIT FOR clk_period;

    UR <= "00000110011";
    UI <= "10101110011";
    WAIT FOR clk_period;

    UR <= "00000001100";
    UI <= "10101110100";
    WAIT FOR clk_period;

    UR <= "11111100010";
    UI <= "10110001110";
    WAIT FOR clk_period;

    UR <= "11110111000";
    UI <= "10110111010";
    WAIT FOR clk_period;

    UR <= "11110010100";
    UI <= "10111110000";
    WAIT FOR clk_period;

    UR <= "11101110111";
    UI <= "11000101001";
    WAIT FOR clk_period;

    UR <= "11101100100";
    UI <= "11001011110";
    WAIT FOR clk_period;

    UR <= "11101011100";
    UI <= "11010001100";
    WAIT FOR clk_period;

    UR <= "11101011101";
    UI <= "11010110001";
    WAIT FOR clk_period;

    UR <= "11101100110";
    UI <= "11011001110";
    WAIT FOR clk_period;

    UR <= "11101110011";
    UI <= "11011101000";
    WAIT FOR clk_period;

    UR <= "11101111111";
    UI <= "11100000011";
    WAIT FOR clk_period;

    UR <= "11110001001";
    UI <= "11100100100";
    WAIT FOR clk_period;

    UR <= "11110001011";
    UI <= "11101001111";
    WAIT FOR clk_period;

    UR <= "11110000110";
    UI <= "11110000101";
    WAIT FOR clk_period;

    UR <= "11101111000";
    UI <= "11111000101";
    WAIT FOR clk_period;

    UR <= "11101100100";
    UI <= "00000001011";
    WAIT FOR clk_period;

    UR <= "11101001101";
    UI <= "00001010010";
    WAIT FOR clk_period;

    UR <= "11100110111";
    UI <= "00010010001";
    WAIT FOR clk_period;

    UR <= "11100101000";
    UI <= "00011000010";
    WAIT FOR clk_period;

    UR <= "11100100100";
    UI <= "00011011111";
    WAIT FOR clk_period;

    UR <= "11100101111";
    UI <= "00011100010";
    WAIT FOR clk_period;

    UR <= "11101001011";
    UI <= "00011001100";
    WAIT FOR clk_period;

    UR <= "11101111000";
    UI <= "00010011110";
    WAIT FOR clk_period;

    UR <= "11110110010";
    UI <= "00001011110";
    WAIT FOR clk_period;

    UR <= "11111110110";
    UI <= "00000010101";
    WAIT FOR clk_period;

    UR <= "00000111101";
    UI <= "11111001010";
    WAIT FOR clk_period;

    UR <= "00010000010";
    UI <= "11110001000";
    WAIT FOR clk_period;

    UR <= "00010111100";
    UI <= "11101010111";
    WAIT FOR clk_period;

    UR <= "00011100110";
    UI <= "11100111100";
    WAIT FOR clk_period;

    UR <= "00011111100";
    UI <= "11100111011";
    WAIT FOR clk_period;

    UR <= "00011111010";
    UI <= "11101010001";
    WAIT FOR clk_period;

    UR <= "00011100010";
    UI <= "11101111100";
    WAIT FOR clk_period;

    UR <= "00010110101";
    UI <= "11110110101";
    WAIT FOR clk_period;

    UR <= "00001110101";
    UI <= "11111110010";
    WAIT FOR clk_period;

    UR <= "00000101010";
    UI <= "00000101011";
    WAIT FOR clk_period;

    UR <= "11111011000";
    UI <= "00001011001";
    WAIT FOR clk_period;

    UR <= "11110000101";
    UI <= "00001110101";
    WAIT FOR clk_period;

    UR <= "11100111001";
    UI <= "00001111101";
    WAIT FOR clk_period;

    UR <= "11011110111";
    UI <= "00001110000";
    WAIT FOR clk_period;

    UR <= "11011000100";
    UI <= "00001010001";
    WAIT FOR clk_period;

    UR <= "11010100100";
    UI <= "00000100110";
    WAIT FOR clk_period;

    UR <= "11010011000";
    UI <= "11111110101";
    WAIT FOR clk_period;

    UR <= "11010100001";
    UI <= "11111001000";
    WAIT FOR clk_period;

    UR <= "11010111111";
    UI <= "11110100100";
    WAIT FOR clk_period;

    UR <= "11011110000";
    UI <= "11110001111";
    WAIT FOR clk_period;

    UR <= "11100110010";
    UI <= "11110001111";
    WAIT FOR clk_period;

    UR <= "11110000000";
    UI <= "11110100101";
    WAIT FOR clk_period;

    UR <= "11111011000";
    UI <= "11111010000";
    WAIT FOR clk_period;

    UR <= "00000110010";
    UI <= "00000001110";
    WAIT FOR clk_period;

    UR <= "00010001010";
    UI <= "00001011100";
    WAIT FOR clk_period;

    UR <= "00011011000";
    UI <= "00010110011";
    WAIT FOR clk_period;

    UR <= "00100011000";
    UI <= "00100001110";
    WAIT FOR clk_period;

    UR <= "00101000100";
    UI <= "00101101000";
    WAIT FOR clk_period;

    UR <= "00101011001";
    UI <= "00110111011";
    WAIT FOR clk_period;

    UR <= "00101010101";
    UI <= "01000000010";
    WAIT FOR clk_period;

    UR <= "00100111001";
    UI <= "01000111010";
    WAIT FOR clk_period;

    UR <= "00100001000";
    UI <= "01001011111";
    WAIT FOR clk_period;

    UR <= "00011000111";
    UI <= "01001101110";
    WAIT FOR clk_period;

    UR <= "00001111101";
    UI <= "01001100110";
    WAIT FOR clk_period;

    UR <= "00000110000";
    UI <= "01001000111";
    WAIT FOR clk_period;

    UR <= "11111101001";
    UI <= "01000010010";
    WAIT FOR clk_period;

    UR <= "11110101110";
    UI <= "00111001001";
    WAIT FOR clk_period;

    UR <= "11110000011";
    UI <= "00101110000";
    WAIT FOR clk_period;

    UR <= "11101101101";
    UI <= "00100001101";
    WAIT FOR clk_period;

    UR <= "11101101011";
    UI <= "00010100111";
    WAIT FOR clk_period;

    UR <= "11101111010";
    UI <= "00001000101";
    WAIT FOR clk_period;

    UR <= "11110010111";
    UI <= "11111110000";
    WAIT FOR clk_period;

    UR <= "11110111100";
    UI <= "11110101101";
    WAIT FOR clk_period;

    UR <= "11111100011";
    UI <= "11110000101";
    WAIT FOR clk_period;

    UR <= "00000000101";
    UI <= "11101111001";
    WAIT FOR clk_period;

    UR <= "00000011111";
    UI <= "11110001010";
    WAIT FOR clk_period;

    UR <= "00000101101";
    UI <= "11110110110";
    WAIT FOR clk_period;

    UR <= "00000101111";
    UI <= "11111110111";
    WAIT FOR clk_period;

    UR <= "00000100101";
    UI <= "00001000110";
    WAIT FOR clk_period;

    UR <= "00000010010";
    UI <= "00010011000";
    WAIT FOR clk_period;

    UR <= "11111111010";
    UI <= "00011100100";
    WAIT FOR clk_period;

    UR <= "11111100001";
    UI <= "00100100001";
    WAIT FOR clk_period;

    UR <= "11111001001";
    UI <= "00101001000";
    WAIT FOR clk_period;

    UR <= "11110110011";
    UI <= "00101010110";
    WAIT FOR clk_period;

    UR <= "11110100010";
    UI <= "00101001100";
    WAIT FOR clk_period;

    UR <= "11110010011";
    UI <= "00100101100";
    WAIT FOR clk_period;

    UR <= "11110000100";
    UI <= "00011111110";
    WAIT FOR clk_period;

    UR <= "11101110011";
    UI <= "00011001010";
    WAIT FOR clk_period;

    UR <= "11101011101";
    UI <= "00010011010";
    WAIT FOR clk_period;

    UR <= "11101000010";
    UI <= "00001110110";
    WAIT FOR clk_period;

    UR <= "11100100010";
    UI <= "00001100100";
    WAIT FOR clk_period;

    UR <= "11011111110";
    UI <= "00001100101";
    WAIT FOR clk_period;

    UR <= "11011011100";
    UI <= "00001111001";
    WAIT FOR clk_period;

    UR <= "11011000000";
    UI <= "00010011001";
    WAIT FOR clk_period;

    UR <= "11010110001";
    UI <= "00010111110";
    WAIT FOR clk_period;

    UR <= "11010110100";
    UI <= "00011011110";
    WAIT FOR clk_period;

    UR <= "11011001101";
    UI <= "00011101110";
    WAIT FOR clk_period;

    UR <= "11100000000";
    UI <= "00011100111";
    WAIT FOR clk_period;

    UR <= "11101001011";
    UI <= "00011000011";
    WAIT FOR clk_period;

    UR <= "11110101010";
    UI <= "00010000011";
    WAIT FOR clk_period;

    UR <= "00000010111";
    UI <= "00000101001";
    WAIT FOR clk_period;

    UR <= "00010001001";
    UI <= "11111000000";
    WAIT FOR clk_period;

    UR <= "00011110110";
    UI <= "11101010010";
    WAIT FOR clk_period;

    UR <= "00101010100";
    UI <= "11011101110";
    WAIT FOR clk_period;

    UR <= "00110011010";
    UI <= "11010100000";
    WAIT FOR clk_period;

    UR <= "00111000010";
    UI <= "11001110100";
    WAIT FOR clk_period;

    UR <= "00111001010";
    UI <= "11001110001";
    WAIT FOR clk_period;

    UR <= "00110110001";
    UI <= "11010011011";
    WAIT FOR clk_period;

    UR <= "00101111011";
    UI <= "11011110000";
    WAIT FOR clk_period;

    UR <= "00100110000";
    UI <= "11101100110";
    WAIT FOR clk_period;

    UR <= "00011011000";
    UI <= "11111110010";
    WAIT FOR clk_period;

    UR <= "00001111110";
    UI <= "00010000111";
    WAIT FOR clk_period;

    UR <= "00000101010";
    UI <= "00100010101";
    WAIT FOR clk_period;

    UR <= "11111100101";
    UI <= "00110001110";
    WAIT FOR clk_period;

    UR <= "11110110110";
    UI <= "00111101001";
    WAIT FOR clk_period;

    UR <= "11110011111";
    UI <= "01000011110";
    WAIT FOR clk_period;

    UR <= "11110100010";
    UI <= "01000101110";
    WAIT FOR clk_period;

    UR <= "11110111100";
    UI <= "01000011011";
    WAIT FOR clk_period;

    UR <= "11111101010";
    UI <= "00111101101";
    WAIT FOR clk_period;

    UR <= "00000100111";
    UI <= "00110101111";
    WAIT FOR clk_period;

    UR <= "00001101011";
    UI <= "00101101010";
    WAIT FOR clk_period;

    UR <= "00010110001";
    UI <= "00100101010";
    WAIT FOR clk_period;

    UR <= "00011110100";
    UI <= "00011110111";
    WAIT FOR clk_period;

    UR <= "00100101111";
    UI <= "00011010101";
    WAIT FOR clk_period;

    UR <= "00101011101";
    UI <= "00011000110";
    WAIT FOR clk_period;

    UR <= "00101111101";
    UI <= "00011000110";
    WAIT FOR clk_period;

    UR <= "00110001101";
    UI <= "00011010001";
    WAIT FOR clk_period;

    UR <= "00110001100";
    UI <= "00011011111";
    WAIT FOR clk_period;

    UR <= "00101111100";
    UI <= "00011101001";
    WAIT FOR clk_period;

    UR <= "00101011110";
    UI <= "00011100111";
    WAIT FOR clk_period;

    UR <= "00100110101";
    UI <= "00011010110";
    WAIT FOR clk_period;

    UR <= "00100000100";
    UI <= "00010110100";
    WAIT FOR clk_period;

    UR <= "00011001111";
    UI <= "00010000011";
    WAIT FOR clk_period;

    UR <= "00010011100";
    UI <= "00001001010";
    WAIT FOR clk_period;

    UR <= "00001101111";
    UI <= "00000001101";
    WAIT FOR clk_period;

    UR <= "00001001110";
    UI <= "11111010111";
    WAIT FOR clk_period;

    UR <= "00000111101";
    UI <= "11110101111";
    WAIT FOR clk_period;

    UR <= "00000111110";
    UI <= "11110011100";
    WAIT FOR clk_period;

    UR <= "00001010100";
    UI <= "11110011111";
    WAIT FOR clk_period;

    UR <= "00001111101";
    UI <= "11110111010";
    WAIT FOR clk_period;

    UR <= "00010110110";
    UI <= "11111101000";
    WAIT FOR clk_period;

    UR <= "00011111001";
    UI <= "00000100010";
    WAIT FOR clk_period;

    UR <= "00100111111";
    UI <= "00001011110";
    WAIT FOR clk_period;

    UR <= "00101111111";
    UI <= "00010010001";
    WAIT FOR clk_period;

    UR <= "00110110010";
    UI <= "00010110001";
    WAIT FOR clk_period;

    UR <= "00111010000";
    UI <= "00010111000";
    WAIT FOR clk_period;

    UR <= "00111010011";
    UI <= "00010100000";
    WAIT FOR clk_period;

    UR <= "00110111010";
    UI <= "00001101010";
    WAIT FOR clk_period;

    UR <= "00110000110";
    UI <= "00000011010";
    WAIT FOR clk_period;

    UR <= "00100111010";
    UI <= "11110111001";
    WAIT FOR clk_period;

    UR <= "00011011110";
    UI <= "11101010100";
    WAIT FOR clk_period;

    UR <= "00001111010";
    UI <= "11011110110";
    WAIT FOR clk_period;

    UR <= "00000011000";
    UI <= "11010101101";
    WAIT FOR clk_period;

    UR <= "11111000001";
    UI <= "11010000010";
    WAIT FOR clk_period;

    UR <= "11101111101";
    UI <= "11001111101";
    WAIT FOR clk_period;

    UR <= "11101001111";
    UI <= "11010011101";
    WAIT FOR clk_period;

    UR <= "11100111011";
    UI <= "11011011110";
    WAIT FOR clk_period;

    UR <= "11100111101";
    UI <= "11100111000";
    WAIT FOR clk_period;

    UR <= "11101010010";
    UI <= "11110011110";
    WAIT FOR clk_period;

    UR <= "11101110001";
    UI <= "00000000001";
    WAIT FOR clk_period;

    UR <= "11110010101";
    UI <= "00001010001";
    WAIT FOR clk_period;

    UR <= "11110110101";
    UI <= "00010000100";
    WAIT FOR clk_period;

    UR <= "11111001100";
    UI <= "00010010000";
    WAIT FOR clk_period;

    UR <= "11111011000";
    UI <= "00001110011";
    WAIT FOR clk_period;

    UR <= "11111011000";
    UI <= "00000110001";
    WAIT FOR clk_period;

    UR <= "11111010000";
    UI <= "11111010011";
    WAIT FOR clk_period;

    UR <= "11111000011";
    UI <= "11101100111";
    WAIT FOR clk_period;

    UR <= "11110111010";
    UI <= "11011111110";
    WAIT FOR clk_period;

    UR <= "11110111011";
    UI <= "11010101000";
    WAIT FOR clk_period;

    UR <= "11111001011";
    UI <= "11001110100";
    WAIT FOR clk_period;

    UR <= "11111101101";
    UI <= "11001101100";
    WAIT FOR clk_period;

    UR <= "00000100010";
    UI <= "11010010011";
    WAIT FOR clk_period;

    UR <= "00001100111";
    UI <= "11011100111";
    WAIT FOR clk_period;

    UR <= "00010110101";
    UI <= "11101011110";
    WAIT FOR clk_period;

    UR <= "00100000100";
    UI <= "11111101010";
    WAIT FOR clk_period;

    UR <= "00101001011";
    UI <= "00001111010";
    WAIT FOR clk_period;

    UR <= "00110000010";
    UI <= "00011111100";
    WAIT FOR clk_period;

    UR <= "00110100000";
    UI <= "00101100000";
    WAIT FOR clk_period;

    UR <= "00110100010";
    UI <= "00110011010";
    WAIT FOR clk_period;

    UR <= "00110000111";
    UI <= "00110100101";
    WAIT FOR clk_period;

    UR <= "00101010100";
    UI <= "00110000010";
    WAIT FOR clk_period;

    UR <= "00100001110";
    UI <= "00100111001";
    WAIT FOR clk_period;

    UR <= "00011000001";
    UI <= "00011011000";
    WAIT FOR clk_period;

    UR <= "00001110110";
    UI <= "00001101101";
    WAIT FOR clk_period;

    UR <= "00000111010";
    UI <= "00000001011";
    WAIT FOR clk_period;

    UR <= "00000010100";
    UI <= "11110111110";
    WAIT FOR clk_period;

    UR <= "00000001011";
    UI <= "11110010010";
    WAIT FOR clk_period;

    UR <= "00000100001";
    UI <= "11110001010";
    WAIT FOR clk_period;

    UR <= "00001010010";
    UI <= "11110100101";
    WAIT FOR clk_period;

    UR <= "00010011010";
    UI <= "11111011001";
    WAIT FOR clk_period;

    UR <= "00011101101";
    UI <= "00000011100";
    WAIT FOR clk_period;

    UR <= "00101000000";
    UI <= "00001011100";
    WAIT FOR clk_period;

    UR <= "00110001001";
    UI <= "00010001100";
    WAIT FOR clk_period;

    UR <= "00110111101";
    UI <= "00010011111";
    WAIT FOR clk_period;

    UR <= "00111010110";
    UI <= "00010001101";
    WAIT FOR clk_period;

    UR <= "00111001110";
    UI <= "00001010101";
    WAIT FOR clk_period;

    UR <= "00110101000";
    UI <= "11111111011";
    WAIT FOR clk_period;

    UR <= "00101101000";
    UI <= "11110001001";
    WAIT FOR clk_period;

    UR <= "00100010101";
    UI <= "11100001110";
    WAIT FOR clk_period;

    UR <= "00010111001";
    UI <= "11010011000";
    WAIT FOR clk_period;

    UR <= "00001011111";
    UI <= "11000110111";
    WAIT FOR clk_period;

    UR <= "00000001111";
    UI <= "10111111001";
    WAIT FOR clk_period;

    UR <= "11111010000";
    UI <= "10111100100";
    WAIT FOR clk_period;

    UR <= "11110100111";
    UI <= "10111111010";
    WAIT FOR clk_period;

    UR <= "11110010100";
    UI <= "11000111000";
    WAIT FOR clk_period;

    UR <= "11110010100";
    UI <= "11010010011";
    WAIT FOR clk_period;

    UR <= "11110100010";
    UI <= "11011111111";
    WAIT FOR clk_period;

    UR <= "11110110111";
    UI <= "11101101101";
    WAIT FOR clk_period;

    UR <= "11111001100";
    UI <= "11111001101";
    WAIT FOR clk_period;

    UR <= "11111011100";
    UI <= "00000010110";
    WAIT FOR clk_period;

    UR <= "11111100001";
    UI <= "00000111110";
    WAIT FOR clk_period;

    UR <= "11111011011";
    UI <= "00001000100";
    WAIT FOR clk_period;

    UR <= "11111001010";
    UI <= "00000101010";
    WAIT FOR clk_period;

    UR <= "11110110001";
    UI <= "11111110111";
    WAIT FOR clk_period;

    UR <= "11110010101";
    UI <= "11110110111";
    WAIT FOR clk_period;

    UR <= "11101111010";
    UI <= "11101110100";
    WAIT FOR clk_period;

    UR <= "11101100111";
    UI <= "11100111010";
    WAIT FOR clk_period;

    UR <= "11101011101";
    UI <= "11100010100";
    WAIT FOR clk_period;

    UR <= "11101011111";
    UI <= "11100000110";
    WAIT FOR clk_period;

    UR <= "11101101100";
    UI <= "11100010100";
    WAIT FOR clk_period;

    UR <= "11110000001";
    UI <= "11100111100";
    WAIT FOR clk_period;

    UR <= "11110011001";
    UI <= "11101111001";
    WAIT FOR clk_period;

    UR <= "11110101110";
    UI <= "11111000011";
    WAIT FOR clk_period;

    UR <= "11110111100";
    UI <= "00000010011";
    WAIT FOR clk_period;

    UR <= "11110111101";
    UI <= "00001100000";
    WAIT FOR clk_period;

    UR <= "11110110000";
    UI <= "00010100010";
    WAIT FOR clk_period;

    UR <= "11110010011";
    UI <= "00011010101";
    WAIT FOR clk_period;

    UR <= "11101101010";
    UI <= "00011110100";
    WAIT FOR clk_period;

    UR <= "11100110111";
    UI <= "00100000000";
    WAIT FOR clk_period;

    UR <= "11100000000";
    UI <= "00011111001";
    WAIT FOR clk_period;

    UR <= "11011001011";
    UI <= "00011100100";
    WAIT FOR clk_period;

    UR <= "11010011110";
    UI <= "00011000011";
    WAIT FOR clk_period;

    UR <= "11001111110";
    UI <= "00010011010";
    WAIT FOR clk_period;

    UR <= "11001101111";
    UI <= "00001101111";
    WAIT FOR clk_period;

    UR <= "11001110011";
    UI <= "00001000011";
    WAIT FOR clk_period;

    UR <= "11010001010";
    UI <= "00000011011";
    WAIT FOR clk_period;

    UR <= "11010110010";
    UI <= "11111111000";
    WAIT FOR clk_period;

    UR <= "11011101000";
    UI <= "11111011101";
    WAIT FOR clk_period;

    UR <= "11100101000";
    UI <= "11111001011";
    WAIT FOR clk_period;

    UR <= "11101101111";
    UI <= "11111000011";
    WAIT FOR clk_period;

    UR <= "11110111001";
    UI <= "11111000110";
    WAIT FOR clk_period;

    UR <= "00000000000";
    UI <= "11111010100";
    WAIT FOR clk_period;

    UR <= "00001000001";
    UI <= "11111101100";
    WAIT FOR clk_period;

    UR <= "00001111010";
    UI <= "00000001101";
    WAIT FOR clk_period;

    UR <= "00010100111";
    UI <= "00000110010";
    WAIT FOR clk_period;

    UR <= "00011000110";
    UI <= "00001011000";
    WAIT FOR clk_period;

    UR <= "00011010101";
    UI <= "00001111001";
    WAIT FOR clk_period;

    UR <= "00011010011";
    UI <= "00010001111";
    WAIT FOR clk_period;

    UR <= "00011000000";
    UI <= "00010010110";
    WAIT FOR clk_period;

    UR <= "00010011101";
    UI <= "00010001010";
    WAIT FOR clk_period;

    UR <= "00001101101";
    UI <= "00001101001";
    WAIT FOR clk_period;

    UR <= "00000110100";
    UI <= "00000110011";
    WAIT FOR clk_period;

    UR <= "11111110111";
    UI <= "11111101100";
    WAIT FOR clk_period;

    UR <= "11110111101";
    UI <= "11110011100";
    WAIT FOR clk_period;

    UR <= "11110001110";
    UI <= "11101001010";
    WAIT FOR clk_period;

    UR <= "11101101111";
    UI <= "11011111111";
    WAIT FOR clk_period;

    UR <= "11101100101";
    UI <= "11011000111";
    WAIT FOR clk_period;

    UR <= "11101110100";
    UI <= "11010100111";
    WAIT FOR clk_period;

    UR <= "11110011100";
    UI <= "11010100110";
    WAIT FOR clk_period;

    UR <= "11111011011";
    UI <= "11011000100";
    WAIT FOR clk_period;

    UR <= "00000101010";
    UI <= "11011111110";
    WAIT FOR clk_period;

    UR <= "00010000010";
    UI <= "11101001111";
    WAIT FOR clk_period;

    UR <= "00011011001";
    UI <= "11110101010";
    WAIT FOR clk_period;

    UR <= "00100100110";
    UI <= "00000000101";
    WAIT FOR clk_period;

    UR <= "00101011110";
    UI <= "00001010010";
    WAIT FOR clk_period;

    UR <= "00101111100";
    UI <= "00010000111";
    WAIT FOR clk_period;

    UR <= "00101111011";
    UI <= "00010011011";
    WAIT FOR clk_period;

    UR <= "00101011010";
    UI <= "00010001011";
    WAIT FOR clk_period;

    UR <= "00100011100";
    UI <= "00001011000";
    WAIT FOR clk_period;

    UR <= "00011000110";
    UI <= "00000001000";
    WAIT FOR clk_period;

    UR <= "00001011111";
    UI <= "11110100101";
    WAIT FOR clk_period;

    UR <= "11111110010";
    UI <= "11100111100";
    WAIT FOR clk_period;

    UR <= "11110000110";
    UI <= "11011011010";
    WAIT FOR clk_period;

    UR <= "11100100100";
    UI <= "11010001110";
    WAIT FOR clk_period;

    UR <= "11011010011";
    UI <= "11001100000";
    WAIT FOR clk_period;

    UR <= "11010010111";
    UI <= "11001011000";
    WAIT FOR clk_period;

    UR <= "11001110011";
    UI <= "11001110110";
    WAIT FOR clk_period;

    UR <= "11001100111";
    UI <= "11010110110";
    WAIT FOR clk_period;

    UR <= "11001110011";
    UI <= "11100010000";
    WAIT FOR clk_period;

    UR <= "11010010011";
    UI <= "11101111010";
    WAIT FOR clk_period;

    UR <= "11011000110";
    UI <= "11111101001";
    WAIT FOR clk_period;

    UR <= "11100000111";
    UI <= "00001001111";
    WAIT FOR clk_period;

    UR <= "11101010010";
    UI <= "00010100101";
    WAIT FOR clk_period;

    UR <= "11110100011";
    UI <= "00011100011";
    WAIT FOR clk_period;

    UR <= "11111110101";
    UI <= "00100001001";
    WAIT FOR clk_period;

    UR <= "00001000010";
    UI <= "00100011000";
    WAIT FOR clk_period;

    UR <= "00010000101";
    UI <= "00100010101";
    WAIT FOR clk_period;

    UR <= "00010111001";
    UI <= "00100001000";
    WAIT FOR clk_period;

    UR <= "00011010111";
    UI <= "00011111001";
    WAIT FOR clk_period;

    UR <= "00011011101";
    UI <= "00011101101";
    WAIT FOR clk_period;

    UR <= "00011000111";
    UI <= "00011101001";
    WAIT FOR clk_period;

    UR <= "00010010111";
    UI <= "00011101111";
    WAIT FOR clk_period;

    UR <= "00001010000";
    UI <= "00011111100";
    WAIT FOR clk_period;

    UR <= "11111111001";
    UI <= "00100001100";
    WAIT FOR clk_period;

    UR <= "11110011011";
    UI <= "00100010111";
    WAIT FOR clk_period;

    UR <= "11101000000";
    UI <= "00100010101";
    WAIT FOR clk_period;

    UR <= "11011110011";
    UI <= "00100000001";
    WAIT FOR clk_period;

    UR <= "11010111011";
    UI <= "00011010110";
    WAIT FOR clk_period;

    UR <= "11010100000";
    UI <= "00010010010";
    WAIT FOR clk_period;

    UR <= "11010100001";
    UI <= "00000111010";
    WAIT FOR clk_period;

    UR <= "11010111100";
    UI <= "11111010100";
    WAIT FOR clk_period;

    UR <= "11011101000";
    UI <= "11101101010";
    WAIT FOR clk_period;

    UR <= "11100011011";
    UI <= "11100001000";
    WAIT FOR clk_period;

    UR <= "11101000110";
    UI <= "11010111010";
    WAIT FOR clk_period;

    UR <= "11101011101";
    UI <= "11010001010";
    WAIT FOR clk_period;

    UR <= "11101010110";
    UI <= "11010000000";
    WAIT FOR clk_period;

    UR <= "11100101011";
    UI <= "11010011110";
    WAIT FOR clk_period;

    UR <= "11011011101";
    UI <= "11011100011";
    WAIT FOR clk_period;

    UR <= "11001110100";
    UI <= "11101001000";
    WAIT FOR clk_period;

    UR <= "10111111100";
    UI <= "11111000010";
    WAIT FOR clk_period;

    UR <= "10110001000";
    UI <= "00001000110";
    WAIT FOR clk_period;

    UR <= "10100101011";
    UI <= "00011000100";
    WAIT FOR clk_period;

    UR <= "10011110111";
    UI <= "00100110000";
    WAIT FOR clk_period;

    UR <= "10011111011";
    UI <= "00110000001";
    WAIT FOR clk_period;

    UR <= "10100111110";
    UI <= "00110101101";
    WAIT FOR clk_period;

    UR <= "10111000001";
    UI <= "00110110101";
    WAIT FOR clk_period;

    UR <= "11001111010";
    UI <= "00110011000";
    WAIT FOR clk_period;

    UR <= "11101011001";
    UI <= "00101011111";
    WAIT FOR clk_period;

    UR <= "00001001000";
    UI <= "00100010001";
    WAIT FOR clk_period;

    UR <= "00100101100";
    UI <= "00010111011";
    WAIT FOR clk_period;

    UR <= "00111101110";
    UI <= "00001100110";
    WAIT FOR clk_period;

    UR <= "01001111001";
    UI <= "00000011110";
    WAIT FOR clk_period;

    UR <= "01011000000";
    UI <= "11111101001";
    WAIT FOR clk_period;

    UR <= "01010111101";
    UI <= "11111001110";
    WAIT FOR clk_period;

    UR <= "01001110100";
    UI <= "11111001100";
    WAIT FOR clk_period;

    UR <= "00111110011";
    UI <= "11111100100";
    WAIT FOR clk_period;

    UR <= "00101001011";
    UI <= "00000010000";
    WAIT FOR clk_period;

    UR <= "00010010011";
    UI <= "00001001010";
    WAIT FOR clk_period;

    UR <= "11111100011";
    UI <= "00010001010";
    WAIT FOR clk_period;

    UR <= "11101001111";
    UI <= "00011001011";
    WAIT FOR clk_period;

    UR <= "11011100110";
    UI <= "00100000101";
    WAIT FOR clk_period;

    UR <= "11010110010";
    UI <= "00100110011";
    WAIT FOR clk_period;

    UR <= "11010110100";
    UI <= "00101010010";
    WAIT FOR clk_period;

    UR <= "11011100101";
    UI <= "00101100000";
    WAIT FOR clk_period;

    UR <= "11100111101";
    UI <= "00101011110";
    WAIT FOR clk_period;

    UR <= "11110101011";
    UI <= "00101001110";
    WAIT FOR clk_period;

    UR <= "00000100001";
    UI <= "00100110001";
    WAIT FOR clk_period;

    UR <= "00010010001";
    UI <= "00100001100";
    WAIT FOR clk_period;

    UR <= "00011101110";
    UI <= "00011100010";
    WAIT FOR clk_period;

    UR <= "00100110010";
    UI <= "00010110111";
    WAIT FOR clk_period;

    UR <= "00101011000";
    UI <= "00010001110";
    WAIT FOR clk_period;

    UR <= "00101100010";
    UI <= "00001101000";
    WAIT FOR clk_period;

    UR <= "00101010001";
    UI <= "00001001010";
    WAIT FOR clk_period;

    UR <= "00100101101";
    UI <= "00000110011";
    WAIT FOR clk_period;

    UR <= "00011111100";
    UI <= "00000100100";
    WAIT FOR clk_period;

    UR <= "00011000100";
    UI <= "00000011110";
    WAIT FOR clk_period;

    UR <= "00010001010";
    UI <= "00000100001";
    WAIT FOR clk_period;

    UR <= "00001010011";
    UI <= "00000101100";
    WAIT FOR clk_period;

    UR <= "00000100100";
    UI <= "00000111111";
    WAIT FOR clk_period;

    UR <= "11111111110";
    UI <= "00001010110";
    WAIT FOR clk_period;

    UR <= "11111100011";
    UI <= "00001110010";
    WAIT FOR clk_period;

    UR <= "11111010111";
    UI <= "00010010001";
    WAIT FOR clk_period;

    UR <= "11111011001";
    UI <= "00010101111";
    WAIT FOR clk_period;

    UR <= "11111101011";
    UI <= "00011001101";
    WAIT FOR clk_period;

    UR <= "00000001101";
    UI <= "00011100111";
    WAIT FOR clk_period;

    UR <= "00000111100";
    UI <= "00011111101";
    WAIT FOR clk_period;

    UR <= "00001110110";
    UI <= "00100001101";
    WAIT FOR clk_period;

    UR <= "00010110101";
    UI <= "00100010110";
    WAIT FOR clk_period;

    UR <= "00011110010";
    UI <= "00100010111";
    WAIT FOR clk_period;

    UR <= "00100100101";
    UI <= "00100010010";
    WAIT FOR clk_period;

    UR <= "00101000111";
    UI <= "00100000101";
    WAIT FOR clk_period;

    UR <= "00101010010";
    UI <= "00011110100";
    WAIT FOR clk_period;

    UR <= "00101000010";
    UI <= "00011011111";
    WAIT FOR clk_period;

    UR <= "00100010101";
    UI <= "00011001001";
    WAIT FOR clk_period;

    UR <= "00011010001";
    UI <= "00010110100";
    WAIT FOR clk_period;

    UR <= "00001111011";
    UI <= "00010100011";
    WAIT FOR clk_period;

    UR <= "00000011111";
    UI <= "00010011000";
    WAIT FOR clk_period;

    UR <= "11111001001";
    UI <= "00010010110";
    WAIT FOR clk_period;

    UR <= "11110000101";
    UI <= "00010011110";
    WAIT FOR clk_period;

    UR <= "11101011101";
    UI <= "00010101111";
    WAIT FOR clk_period;

    UR <= "11101011010";
    UI <= "00011001000";
    WAIT FOR clk_period;

    UR <= "11101111100";
    UI <= "00011101000";
    WAIT FOR clk_period;

    UR <= "11111000001";
    UI <= "00100001011";
    WAIT FOR clk_period;

    UR <= "00000100000";
    UI <= "00100101110";
    WAIT FOR clk_period;

    UR <= "00010001011";
    UI <= "00101001011";
    WAIT FOR clk_period;

    UR <= "00011110101";
    UI <= "00101011110";
    WAIT FOR clk_period;

    UR <= "00101001100";
    UI <= "00101100100";
    WAIT FOR clk_period;

    UR <= "00110000011";
    UI <= "00101011011";
    WAIT FOR clk_period;

    UR <= "00110010001";
    UI <= "00101000001";
    WAIT FOR clk_period;

    UR <= "00101110001";
    UI <= "00100011000";
    WAIT FOR clk_period;

    UR <= "00100100110";
    UI <= "00011100010";
    WAIT FOR clk_period;

    UR <= "00010111000";
    UI <= "00010100100";
    WAIT FOR clk_period;

    UR <= "00000110100";
    UI <= "00001100100";
    WAIT FOR clk_period;

    UR <= "11110101010";
    UI <= "00000100110";
    WAIT FOR clk_period;

    UR <= "11100101100";
    UI <= "11111110001";
    WAIT FOR clk_period;

    UR <= "11011001010";
    UI <= "11111001001";
    WAIT FOR clk_period;

    UR <= "11010001110";
    UI <= "11110110001";
    WAIT FOR clk_period;

    UR <= "11010000010";
    UI <= "11110101010";
    WAIT FOR clk_period;

    UR <= "11010100101";
    UI <= "11110110001";
    WAIT FOR clk_period;

    UR <= "11011110011";
    UI <= "11111000100";
    WAIT FOR clk_period;

    UR <= "11101100010";
    UI <= "11111011101";
    WAIT FOR clk_period;

    UR <= "11111100110";
    UI <= "11111110101";
    WAIT FOR clk_period;

    UR <= "00001101111";
    UI <= "00000001000";
    WAIT FOR clk_period;

    UR <= "00011110001";
    UI <= "00000001111";
    WAIT FOR clk_period;

    UR <= "00101011110";
    UI <= "00000001000";
    WAIT FOR clk_period;

    UR <= "00110110000";
    UI <= "11111110000";
    WAIT FOR clk_period;

    UR <= "00111100011";
    UI <= "11111001001";
    WAIT FOR clk_period;

    UR <= "00111110110";
    UI <= "11110010111";
    WAIT FOR clk_period;

    UR <= "00111101110";
    UI <= "11101011110";
    WAIT FOR clk_period;

    UR <= "00111010001";
    UI <= "11100100111";
    WAIT FOR clk_period;

    UR <= "00110100111";
    UI <= "11011110111";
    WAIT FOR clk_period;

    UR <= "00101111000";
    UI <= "11011010101";
    WAIT FOR clk_period;

    UR <= "00101001001";
    UI <= "11011000111";
    WAIT FOR clk_period;

    UR <= "00100011110";
    UI <= "11011010000";
    WAIT FOR clk_period;

    UR <= "00011111000";
    UI <= "11011110001";
    WAIT FOR clk_period;

    UR <= "00011010101";
    UI <= "11100101000";
    WAIT FOR clk_period;

    UR <= "00010110011";
    UI <= "11101110001";
    WAIT FOR clk_period;

    UR <= "00010001110";
    UI <= "11111000110";
    WAIT FOR clk_period;

    UR <= "00001100010";
    UI <= "00000100000";
    WAIT FOR clk_period;

    UR <= "00000101110";
    UI <= "00001111010";
    WAIT FOR clk_period;

    UR <= "11111110001";
    UI <= "00011001011";
    WAIT FOR clk_period;

    UR <= "11110101110";
    UI <= "00100010000";
    WAIT FOR clk_period;

    UR <= "11101101010";
    UI <= "00101000100";
    WAIT FOR clk_period;

    UR <= "11100101011";
    UI <= "00101100110";
    WAIT FOR clk_period;

    UR <= "11011111001";
    UI <= "00101110111";
    WAIT FOR clk_period;

    UR <= "11011011011";
    UI <= "00101110111";
    WAIT FOR clk_period;

    UR <= "11011010110";
    UI <= "00101101011";
    WAIT FOR clk_period;

    UR <= "11011101110";
    UI <= "00101010100";
    WAIT FOR clk_period;

    UR <= "11100100001";
    UI <= "00100110111";
    WAIT FOR clk_period;

    UR <= "11101101101";
    UI <= "00100010101";
    WAIT FOR clk_period;

    UR <= "11111001011";
    UI <= "00011110001";
    WAIT FOR clk_period;

    UR <= "00000110001";
    UI <= "00011001100";
    WAIT FOR clk_period;

    UR <= "00010010100";
    UI <= "00010100110";
    WAIT FOR clk_period;

    UR <= "00011101001";
    UI <= "00001111111";
    WAIT FOR clk_period;

    UR <= "00100101000";
    UI <= "00001010111";
    WAIT FOR clk_period;

    UR <= "00101001001";
    UI <= "00000101110";
    WAIT FOR clk_period;

    UR <= "00101001001";
    UI <= "00000000100";
    WAIT FOR clk_period;

    UR <= "00100101001";
    UI <= "11111011011";
    WAIT FOR clk_period;

    UR <= "00011101101";
    UI <= "11110110111";
    WAIT FOR clk_period;

    UR <= "00010011110";
    UI <= "11110011001";
    WAIT FOR clk_period;

    UR <= "00001000111";
    UI <= "11110000101";
    WAIT FOR clk_period;

    UR <= "11111110011";
    UI <= "11101111111";
    WAIT FOR clk_period;

    UR <= "11110101110";
    UI <= "11110001001";
    WAIT FOR clk_period;

    UR <= "11101111111";
    UI <= "11110100100";
    WAIT FOR clk_period;

    UR <= "11101101110";
    UI <= "11111001111";
    WAIT FOR clk_period;

    UR <= "11101111011";
    UI <= "00000000111";
    WAIT FOR clk_period;

    UR <= "11110100101";
    UI <= "00001001000";
    WAIT FOR clk_period;

    UR <= "11111100101";
    UI <= "00010001100";
    WAIT FOR clk_period;

    UR <= "00000110010";
    UI <= "00011001010";
    WAIT FOR clk_period;

    UR <= "00010000000";
    UI <= "00011111101";
    WAIT FOR clk_period;

    UR <= "00011000110";
    UI <= "00100011100";
    WAIT FOR clk_period;

    UR <= "00011111000";
    UI <= "00100100101";
    WAIT FOR clk_period;

    UR <= "00100010000";
    UI <= "00100010101";
    WAIT FOR clk_period;

    UR <= "00100001010";
    UI <= "00011101100";
    WAIT FOR clk_period;

    UR <= "00011100101";
    UI <= "00010101110";
    WAIT FOR clk_period;

    UR <= "00010100101";
    UI <= "00001100010";
    WAIT FOR clk_period;

    UR <= "00001010001";
    UI <= "00000010000";
    WAIT FOR clk_period;

    UR <= "11111110001";
    UI <= "11111000010";
    WAIT FOR clk_period;

    UR <= "11110010000";
    UI <= "11110000000";
    WAIT FOR clk_period;

    UR <= "11100110110";
    UI <= "11101010001";
    WAIT FOR clk_period;

    UR <= "11011101100";
    UI <= "11100111011";
    WAIT FOR clk_period;

    UR <= "11010110110";
    UI <= "11101000000";
    WAIT FOR clk_period;

    UR <= "11010011000";
    UI <= "11101011101";
    WAIT FOR clk_period;

    UR <= "11010010001";
    UI <= "11110001111";
    WAIT FOR clk_period;

    UR <= "11010011111";
    UI <= "11111001011";
    WAIT FOR clk_period;

    UR <= "11010111110";
    UI <= "00000001011";
    WAIT FOR clk_period;

    UR <= "11011101000";
    UI <= "00001000100";
    WAIT FOR clk_period;

    UR <= "11100011000";
    UI <= "00001101101";
    WAIT FOR clk_period;

    UR <= "11101001010";
    UI <= "00010000001";
    WAIT FOR clk_period;

    UR <= "11101111001";
    UI <= "00001111100";
    WAIT FOR clk_period;

    UR <= "11110100100";
    UI <= "00001011111";
    WAIT FOR clk_period;

    UR <= "11111001010";
    UI <= "00000101110";
    WAIT FOR clk_period;

    UR <= "11111101010";
    UI <= "11111101111";
    WAIT FOR clk_period;

    UR <= "00000000110";
    UI <= "11110101100";
    WAIT FOR clk_period;

    UR <= "00000011111";
    UI <= "11101101100";
    WAIT FOR clk_period;

    UR <= "00000110110";
    UI <= "11100111000";
    WAIT FOR clk_period;

    UR <= "00001001010";
    UI <= "11100010101";
    WAIT FOR clk_period;

    UR <= "00001011110";
    UI <= "11100000111";
    WAIT FOR clk_period;

    UR <= "00001110000";
    UI <= "11100001100";
    WAIT FOR clk_period;

    UR <= "00010000000";
    UI <= "11100100001";
    WAIT FOR clk_period;

    UR <= "00010001110";
    UI <= "11101000000";
    WAIT FOR clk_period;

    UR <= "00010011010";
    UI <= "11101100001";
    WAIT FOR clk_period;

    UR <= "00010100011";
    UI <= "11101111101";
    WAIT FOR clk_period;

    UR <= "00010101011";
    UI <= "11110001101";
    WAIT FOR clk_period;

    UR <= "00010110011";
    UI <= "11110001110";
    WAIT FOR clk_period;

    UR <= "00010111010";
    UI <= "11101111110";
    WAIT FOR clk_period;

    UR <= "00011000011";
    UI <= "11101100001";
    WAIT FOR clk_period;

    UR <= "00011001101";
    UI <= "11100111011";
    WAIT FOR clk_period;

    UR <= "00011011000";
    UI <= "11100010110";
    WAIT FOR clk_period;

    UR <= "00011100011";
    UI <= "11011111010";
    WAIT FOR clk_period;

    UR <= "00011101100";
    UI <= "11011101111";
    WAIT FOR clk_period;

    UR <= "00011110011";
    UI <= "11011111100";
    WAIT FOR clk_period;

    UR <= "00011110101";
    UI <= "11100100101";
    WAIT FOR clk_period;

    UR <= "00011110010";
    UI <= "11101101001";
    WAIT FOR clk_period;

    UR <= "00011101001";
    UI <= "11111000101";
    WAIT FOR clk_period;

    UR <= "00011011011";
    UI <= "00000110001";
    WAIT FOR clk_period;

    UR <= "00011001001";
    UI <= "00010100100";
    WAIT FOR clk_period;

    UR <= "00010110110";
    UI <= "00100010010";
    WAIT FOR clk_period;

    UR <= "00010100101";
    UI <= "00101110000";
    WAIT FOR clk_period;

    UR <= "00010010111";
    UI <= "00110110110";
    WAIT FOR clk_period;

    UR <= "00010001111";
    UI <= "00111011110";
    WAIT FOR clk_period;

    UR <= "00010001101";
    UI <= "00111100011";
    WAIT FOR clk_period;

    UR <= "00010010011";
    UI <= "00111001000";
    WAIT FOR clk_period;

    UR <= "00010011101";
    UI <= "00110010010";
    WAIT FOR clk_period;

    UR <= "00010101001";
    UI <= "00101000111";
    WAIT FOR clk_period;

    UR <= "00010110101";
    UI <= "00011110001";
    WAIT FOR clk_period;

    UR <= "00010111100";
    UI <= "00010011010";
    WAIT FOR clk_period;

    UR <= "00010111011";
    UI <= "00001001011";
    WAIT FOR clk_period;

    UR <= "00010110000";
    UI <= "00000001001";
    WAIT FOR clk_period;

    UR <= "00010011010";
    UI <= "11111011011";
    WAIT FOR clk_period;

    UR <= "00001111000";
    UI <= "11111000001";
    WAIT FOR clk_period;

    UR <= "00001001110";
    UI <= "11110111010";
    WAIT FOR clk_period;

    UR <= "00000011101";
    UI <= "11111000011";
    WAIT FOR clk_period;

    UR <= "11111101001";
    UI <= "11111010111";
    WAIT FOR clk_period;

    UR <= "11110110111";
    UI <= "11111110001";
    WAIT FOR clk_period;

    UR <= "11110001001";
    UI <= "00000001011";
    WAIT FOR clk_period;

    UR <= "11101100010";
    UI <= "00000100001";
    WAIT FOR clk_period;

    UR <= "11101000011";
    UI <= "00000101111";
    WAIT FOR clk_period;

    UR <= "11100101101";
    UI <= "00000110110";
    WAIT FOR clk_period;

    UR <= "11100011111";
    UI <= "00000110100";
    WAIT FOR clk_period;

    UR <= "11100010111";
    UI <= "00000101011";
    WAIT FOR clk_period;

    UR <= "11100010011";
    UI <= "00000011100";
    WAIT FOR clk_period;

    UR <= "11100010001";
    UI <= "00000001011";
    WAIT FOR clk_period;

    UR <= "11100010000";
    UI <= "11111111001";
    WAIT FOR clk_period;

    UR <= "11100001111";
    UI <= "11111101000";
    WAIT FOR clk_period;

    UR <= "11100001111";
    UI <= "11111011010";
    WAIT FOR clk_period;

    UR <= "11100010001";
    UI <= "11111001111";
    WAIT FOR clk_period;

    UR <= "11100010111";
    UI <= "11111000111";
    WAIT FOR clk_period;

    UR <= "11100100101";
    UI <= "11111000010";
    WAIT FOR clk_period;

    UR <= "11100111011";
    UI <= "11111000001";
    WAIT FOR clk_period;

    UR <= "11101011100";
    UI <= "11111000010";
    WAIT FOR clk_period;

    UR <= "11110001000";
    UI <= "11111000111";
    WAIT FOR clk_period;

    UR <= "11110111110";
    UI <= "11111001111";
    WAIT FOR clk_period;

    UR <= "11111111101";
    UI <= "11111011010";
    WAIT FOR clk_period;

    UR <= "00001000010";
    UI <= "11111100111";
    WAIT FOR clk_period;

    UR <= "00010001000";
    UI <= "11111110111";
    WAIT FOR clk_period;

    UR <= "00011001011";
    UI <= "00000001000";
    WAIT FOR clk_period;

    UR <= "00100000110";
    UI <= "00000011001";
    WAIT FOR clk_period;

    UR <= "00100110100";
    UI <= "00000100111";
    WAIT FOR clk_period;

    UR <= "00101010011";
    UI <= "00000110001";
    WAIT FOR clk_period;

    UR <= "00101011111";
    UI <= "00000110101";
    WAIT FOR clk_period;

    UR <= "00101010111";
    UI <= "00000101111";
    WAIT FOR clk_period;

    UR <= "00100111101";
    UI <= "00000011111";
    WAIT FOR clk_period;

    UR <= "00100010001";
    UI <= "00000000100";
    WAIT FOR clk_period;

    UR <= "00011011000";
    UI <= "11111011111";
    WAIT FOR clk_period;

    UR <= "00010010100";
    UI <= "11110110000";
    WAIT FOR clk_period;

    UR <= "00001001011";
    UI <= "11101111001";
    WAIT FOR clk_period;

    UR <= "00000000010";
    UI <= "11100111111";
    WAIT FOR clk_period;

    UR <= "11110111101";
    UI <= "11100000101";
    WAIT FOR clk_period;

    UR <= "11101111111";
    UI <= "11011001110";
    WAIT FOR clk_period;

    UR <= "11101001101";
    UI <= "11010011111";
    WAIT FOR clk_period;

    UR <= "11100100111";
    UI <= "11001111010";
    WAIT FOR clk_period;

    UR <= "11100001110";
    UI <= "11001100100";
    WAIT FOR clk_period;

    UR <= "11100000010";
    UI <= "11001011101";
    WAIT FOR clk_period;

    UR <= "11100000000";
    UI <= "11001100111";
    WAIT FOR clk_period;

    UR <= "11100001000";
    UI <= "11010000010";
    WAIT FOR clk_period;

    UR <= "11100010110";
    UI <= "11010101101";
    WAIT FOR clk_period;

    UR <= "11100101010";
    UI <= "11011100101";
    WAIT FOR clk_period;

    UR <= "11101000000";
    UI <= "11100100111";
    WAIT FOR clk_period;

    UR <= "11101011000";
    UI <= "11101110000";
    WAIT FOR clk_period;

    UR <= "11101110011";
    UI <= "11110111010";
    WAIT FOR clk_period;

    UR <= "11110010000";
    UI <= "00000000000";
    WAIT FOR clk_period;

    UR <= "11110101111";
    UI <= "00000111110";
    WAIT FOR clk_period;

    UR <= "11111010001";
    UI <= "00001101110";
    WAIT FOR clk_period;

    UR <= "11111110101";
    UI <= "00010001101";
    WAIT FOR clk_period;

    UR <= "00000011010";
    UI <= "00010010111";
    WAIT FOR clk_period;

    UR <= "00000111111";
    UI <= "00010001100";
    WAIT FOR clk_period;

    UR <= "00001011110";
    UI <= "00001101011";
    WAIT FOR clk_period;

    UR <= "00001110110";
    UI <= "00000110110";
    WAIT FOR clk_period;

    UR <= "00001111111";
    UI <= "11111110010";
    WAIT FOR clk_period;

    UR <= "00001111000";
    UI <= "11110100010";
    WAIT FOR clk_period;

    UR <= "00001011101";
    UI <= "11101001101";
    WAIT FOR clk_period;

    UR <= "00000101101";
    UI <= "11011111010";
    WAIT FOR clk_period;

    UR <= "11111101010";
    UI <= "11010110000";
    WAIT FOR clk_period;

    UR <= "11110011000";
    UI <= "11001110011";
    WAIT FOR clk_period;

    UR <= "11100111101";
    UI <= "11001001010";
    WAIT FOR clk_period;

    UR <= "11011100010";
    UI <= "11000110111";
    WAIT FOR clk_period;

    UR <= "11010010000";
    UI <= "11000111100";
    WAIT FOR clk_period;

    UR <= "11001010000";
    UI <= "11001011001";
    WAIT FOR clk_period;

    UR <= "11000101000";
    UI <= "11010001100";
    WAIT FOR clk_period;

    UR <= "11000011111";
    UI <= "11011010010";
    WAIT FOR clk_period;

    UR <= "11000110110";
    UI <= "11100100101";
    WAIT FOR clk_period;

    UR <= "11001101010";
    UI <= "11110000001";
    WAIT FOR clk_period;

    UR <= "11010110110";
    UI <= "11111100000";
    WAIT FOR clk_period;

    UR <= "11100010010";
    UI <= "00000111100";
    WAIT FOR clk_period;

    UR <= "11101110011";
    UI <= "00010010000";
    WAIT FOR clk_period;

    UR <= "11111010000";
    UI <= "00011010110";
    WAIT FOR clk_period;

    UR <= "00000011111";
    UI <= "00100001100";
    WAIT FOR clk_period;

    UR <= "00001011011";
    UI <= "00100101101";
    WAIT FOR clk_period;

    UR <= "00001111111";
    UI <= "00100111000";
    WAIT FOR clk_period;

    UR <= "00010001101";
    UI <= "00100101011";
    WAIT FOR clk_period;

    UR <= "00010001010";
    UI <= "00100000111";
    WAIT FOR clk_period;

    UR <= "00001111011";
    UI <= "00011001110";
    WAIT FOR clk_period;

    UR <= "00001101010";
    UI <= "00010000011";
    WAIT FOR clk_period;

    UR <= "00001011101";
    UI <= "00000101011";
    WAIT FOR clk_period;

    UR <= "00001011101";
    UI <= "11111001100";
    WAIT FOR clk_period;

    UR <= "00001101100";
    UI <= "11101101101";
    WAIT FOR clk_period;

    UR <= "00010001010";
    UI <= "11100010101";
    WAIT FOR clk_period;

    UR <= "00010110100";
    UI <= "11011001011";
    WAIT FOR clk_period;

    UR <= "00011100001";
    UI <= "11010010101";
    WAIT FOR clk_period;

    UR <= "00100001010";
    UI <= "11001111001";
    WAIT FOR clk_period;

    UR <= "00100100100";
    UI <= "11001111000";
    WAIT FOR clk_period;

    UR <= "00100100101";
    UI <= "11010010011";
    WAIT FOR clk_period;

    UR <= "00100001001";
    UI <= "11011000111";
    WAIT FOR clk_period;

    UR <= "00011001011";
    UI <= "11100010001";
    WAIT FOR clk_period;

    UR <= "00001101111";
    UI <= "11101101001";
    WAIT FOR clk_period;

    UR <= "11111111011";
    UI <= "11111001001";
    WAIT FOR clk_period;

    UR <= "11101111000";
    UI <= "00000101000";
    WAIT FOR clk_period;

    UR <= "11011110101";
    UI <= "00001111110";
    WAIT FOR clk_period;

    UR <= "11001111101";
    UI <= "00011000100";
    WAIT FOR clk_period;

    UR <= "11000011111";
    UI <= "00011110110";
    WAIT FOR clk_period;

    UR <= "10111100100";
    UI <= "00100010000";
    WAIT FOR clk_period;

    UR <= "10111010011";
    UI <= "00100010001";
    WAIT FOR clk_period;

    UR <= "10111101100";
    UI <= "00011111001";
    WAIT FOR clk_period;

    UR <= "11000101100";
    UI <= "00011001100";
    WAIT FOR clk_period;

    UR <= "11010001100";
    UI <= "00010001110";
    WAIT FOR clk_period;

    UR <= "11011111111";
    UI <= "00001000010";
    WAIT FOR clk_period;

    UR <= "11101111010";
    UI <= "11111101110";
    WAIT FOR clk_period;

    UR <= "11111101110";
    UI <= "11110011000";
    WAIT FOR clk_period;

    UR <= "00001010000";
    UI <= "11101000101";
    WAIT FOR clk_period;

    UR <= "00010010110";
    UI <= "11011111011";
    WAIT FOR clk_period;

    UR <= "00010111010";
    UI <= "11010111110";
    WAIT FOR clk_period;

    UR <= "00010111001";
    UI <= "11010010100";
    WAIT FOR clk_period;

    UR <= "00010010110";
    UI <= "11010000000";
    WAIT FOR clk_period;

    UR <= "00001010100";
    UI <= "11010000101";
    WAIT FOR clk_period;

    UR <= "11111111100";
    UI <= "11010100101";
    WAIT FOR clk_period;

    UR <= "11110010101";
    UI <= "11011011111";
    WAIT FOR clk_period;

    UR <= "11100101010";
    UI <= "11100110010";
    WAIT FOR clk_period;

    UR <= "11011000010";
    UI <= "11110011000";
    WAIT FOR clk_period;

    UR <= "11001100101";
    UI <= "00000001010";
    WAIT FOR clk_period;

    UR <= "11000011010";
    UI <= "00001111110";
    WAIT FOR clk_period;

    UR <= "10111100100";
    UI <= "00011101011";
    WAIT FOR clk_period;

    UR <= "10111000110";
    UI <= "00101000101";
    WAIT FOR clk_period;

    UR <= "10111000001";
    UI <= "00110000010";
    WAIT FOR clk_period;

    UR <= "10111010011";
    UI <= "00110011011";
    WAIT FOR clk_period;

    UR <= "10111111011";
    UI <= "00110001011";
    WAIT FOR clk_period;

    UR <= "11000110011";
    UI <= "00101010001";
    WAIT FOR clk_period;

    UR <= "11001111001";
    UI <= "00011110011";
    WAIT FOR clk_period;

    UR <= "11011000111";
    UI <= "00001111001";
    WAIT FOR clk_period;

    UR <= "11100010111";
    UI <= "11111101111";
    WAIT FOR clk_period;

    UR <= "11101100011";
    UI <= "11101100101";
    WAIT FOR clk_period;

    UR <= "11110101000";
    UI <= "11011101010";
    WAIT FOR clk_period;

    UR <= "11111011110";
    UI <= "11010001101";
    WAIT FOR clk_period;

    UR <= "00000000011";
    UI <= "11001010111";
    WAIT FOR clk_period;

    UR <= "00000010011";
    UI <= "11001010001";
    WAIT FOR clk_period;

    UR <= "00000001101";
    UI <= "11001111010";
    WAIT FOR clk_period;

    UR <= "11111110010";
    UI <= "11011001111";
    WAIT FOR clk_period;

    UR <= "11111000011";
    UI <= "11101000110";
    WAIT FOR clk_period;

    UR <= "11110000101";
    UI <= "11111010011";
    WAIT FOR clk_period;

    UR <= "11100111100";
    UI <= "00001100100";
    WAIT FOR clk_period;

    UR <= "11011101110";
    UI <= "00011101100";
    WAIT FOR clk_period;

    UR <= "11010100010";
    UI <= "00101011101";
    WAIT FOR clk_period;

    UR <= "11001011101";
    UI <= "00110101011";
    WAIT FOR clk_period;

    UR <= "11000100100";
    UI <= "00111010010";
    WAIT FOR clk_period;

    UR <= "10111111101";
    UI <= "00111001111";
    WAIT FOR clk_period;

    UR <= "10111101000";
    UI <= "00110100111";
    WAIT FOR clk_period;

    UR <= "10111101000";
    UI <= "00101100010";
    WAIT FOR clk_period;

    UR <= "10111111010";
    UI <= "00100001000";
    WAIT FOR clk_period;

    UR <= "11000011111";
    UI <= "00010100110";
    WAIT FOR clk_period;

    UR <= "11001010001";
    UI <= "00001000111";
    WAIT FOR clk_period;

    UR <= "11010001101";
    UI <= "11111110101";
    WAIT FOR clk_period;

    UR <= "11011001110";
    UI <= "11110110101";
    WAIT FOR clk_period;

    UR <= "11100010000";
    UI <= "11110001101";
    WAIT FOR clk_period;

    UR <= "11101001110";
    UI <= "11101111101";
    WAIT FOR clk_period;

    UR <= "11110000101";
    UI <= "11110000100";
    WAIT FOR clk_period;

    UR <= "11110110011";
    UI <= "11110011110";
    WAIT FOR clk_period;

    UR <= "11111010100";
    UI <= "11111000101";
    WAIT FOR clk_period;

    UR <= "11111101001";
    UI <= "11111110011";
    WAIT FOR clk_period;

    UR <= "11111110010";
    UI <= "00000100011";
    WAIT FOR clk_period;

    UR <= "11111110000";
    UI <= "00001001110";
    WAIT FOR clk_period;

    UR <= "11111100110";
    UI <= "00001110001";
    WAIT FOR clk_period;

    UR <= "11111010110";
    UI <= "00010000110";
    WAIT FOR clk_period;

    UR <= "11111000100";
    UI <= "00010001011";
    WAIT FOR clk_period;

    UR <= "11110110100";
    UI <= "00001111111";
    WAIT FOR clk_period;

    UR <= "11110101000";
    UI <= "00001011111";
    WAIT FOR clk_period;

    UR <= "11110100010";
    UI <= "00000101110";
    WAIT FOR clk_period;

    UR <= "11110100101";
    UI <= "11111101101";
    WAIT FOR clk_period;

    UR <= "11110110000";
    UI <= "11110100000";
    WAIT FOR clk_period;

    UR <= "11111000100";
    UI <= "11101001101";
    WAIT FOR clk_period;

    UR <= "11111011110";
    UI <= "11011111010";
    WAIT FOR clk_period;

    UR <= "11111111100";
    UI <= "11010110001";
    WAIT FOR clk_period;

    UR <= "00000011011";
    UI <= "11001111000";
    WAIT FOR clk_period;

    UR <= "00000111000";
    UI <= "11001011000";
    WAIT FOR clk_period;

    UR <= "00001001110";
    UI <= "11001010110";
    WAIT FOR clk_period;

    UR <= "00001011101";
    UI <= "11001110110";
    WAIT FOR clk_period;

    UR <= "00001100001";
    UI <= "11010111000";
    WAIT FOR clk_period;

    UR <= "00001011011";
    UI <= "11100011001";
    WAIT FOR clk_period;

    UR <= "00001001010";
    UI <= "11110010000";
    WAIT FOR clk_period;

    UR <= "00000110010";
    UI <= "00000010110";
    WAIT FOR clk_period;

    UR <= "00000010011";
    UI <= "00010011100";
    WAIT FOR clk_period;

    UR <= "11111110010";
    UI <= "00100011000";
    WAIT FOR clk_period;

    UR <= "11111010001";
    UI <= "00101111101";
    WAIT FOR clk_period;

    UR <= "11110110101";
    UI <= "00111000011";
    WAIT FOR clk_period;

    UR <= "11110011111";
    UI <= "00111100100";
    WAIT FOR clk_period;

    UR <= "11110010011";
    UI <= "00111011111";
    WAIT FOR clk_period;

    UR <= "11110010001";
    UI <= "00110111000";
    WAIT FOR clk_period;

    UR <= "11110011001";
    UI <= "00101110100";
    WAIT FOR clk_period;

    UR <= "11110101100";
    UI <= "00100011111";
    WAIT FOR clk_period;

    UR <= "11111001001";
    UI <= "00011000010";
    WAIT FOR clk_period;

    UR <= "11111101100";
    UI <= "00001101001";
    WAIT FOR clk_period;

    UR <= "00000010101";
    UI <= "00000011110";
    WAIT FOR clk_period;

    UR <= "00001000001";
    UI <= "11111100110";
    WAIT FOR clk_period;

    UR <= "00001101110";
    UI <= "11111000101";
    WAIT FOR clk_period;

    UR <= "00010011000";
    UI <= "11110111010";
    WAIT FOR clk_period;

    UR <= "00010111111";
    UI <= "11111000001";
    WAIT FOR clk_period;

    UR <= "00011100000";
    UI <= "11111010100";
    WAIT FOR clk_period;

    UR <= "00011111001";
    UI <= "11111101100";
    WAIT FOR clk_period;

    UR <= "00100001001";
    UI <= "00000000011";
    WAIT FOR clk_period;

    UR <= "00100010001";
    UI <= "00000010010";
    WAIT FOR clk_period;

    UR <= "00100010000";
    UI <= "00000011000";
    WAIT FOR clk_period;

    UR <= "00100000111";
    UI <= "00000010100";
    WAIT FOR clk_period;

    UR <= "00011110111";
    UI <= "00000001000";
    WAIT FOR clk_period;

    UR <= "00011100001";
    UI <= "11111110111";
    WAIT FOR clk_period;

    UR <= "00011001000";
    UI <= "11111101000";
    WAIT FOR clk_period;

    UR <= "00010101101";
    UI <= "11111100000";
    WAIT FOR clk_period;

    UR <= "00010010011";
    UI <= "11111100011";
    WAIT FOR clk_period;

    UR <= "00001111001";
    UI <= "11111110100";
    WAIT FOR clk_period;

    UR <= "00001100001";
    UI <= "00000010101";
    WAIT FOR clk_period;

    UR <= "00001001011";
    UI <= "00001000010";
    WAIT FOR clk_period;

    UR <= "00000110111";
    UI <= "00001111010";
    WAIT FOR clk_period;

    UR <= "00000100010";
    UI <= "00010110111";
    WAIT FOR clk_period;

    UR <= "00000001100";
    UI <= "00011110011";
    WAIT FOR clk_period;

    UR <= "11111110011";
    UI <= "00100101011";
    WAIT FOR clk_period;

    UR <= "11111010110";
    UI <= "00101011000";
    WAIT FOR clk_period;

    UR <= "11110110101";
    UI <= "00101111001";
    WAIT FOR clk_period;

    UR <= "11110001111";
    UI <= "00110001101";
    WAIT FOR clk_period;

    UR <= "11101100110";
    UI <= "00110010011";
    WAIT FOR clk_period;

    UR <= "11100111011";
    UI <= "00110001110";
    WAIT FOR clk_period;

    UR <= "11100010000";
    UI <= "00110000001";
    WAIT FOR clk_period;

    UR <= "11011101000";
    UI <= "00101101101";
    WAIT FOR clk_period;

    UR <= "11011000101";
    UI <= "00101011000";
    WAIT FOR clk_period;

    UR <= "11010101011";
    UI <= "00101000011";
    WAIT FOR clk_period;

    UR <= "11010011100";
    UI <= "00100110000";
    WAIT FOR clk_period;

    UR <= "11010011000";
    UI <= "00100100000";
    WAIT FOR clk_period;

    UR <= "11010100010";
    UI <= "00100010100";
    WAIT FOR clk_period;

    UR <= "11010111010";
    UI <= "00100001010";
    WAIT FOR clk_period;

    UR <= "11011011110";
    UI <= "00100000011";
    WAIT FOR clk_period;

    UR <= "11100001111";
    UI <= "00011111101";
    WAIT FOR clk_period;

    UR <= "11101001001";
    UI <= "00011111000";
    WAIT FOR clk_period;

    UR <= "11110001101";
    UI <= "00011110010";
    WAIT FOR clk_period;

    UR <= "11111010101";
    UI <= "00011101101";
    WAIT FOR clk_period;

    UR <= "00000100001";
    UI <= "00011100111";
    WAIT FOR clk_period;

    UR <= "00001101100";
    UI <= "00011100001";
    WAIT FOR clk_period;

    UR <= "00010110100";
    UI <= "00011011100";
    WAIT FOR clk_period;

    UR <= "00011110100";
    UI <= "00011011000";
    WAIT FOR clk_period;

    UR <= "00100101010";
    UI <= "00011010110";
    WAIT FOR clk_period;

    UR <= "00101010010";
    UI <= "00011010110";
    WAIT FOR clk_period;

    UR <= "00101101001";
    UI <= "00011011000";
    WAIT FOR clk_period;

    UR <= "00101101111";
    UI <= "00011011011";
    WAIT FOR clk_period;

    UR <= "00101100011";
    UI <= "00011100000";
    WAIT FOR clk_period;

    UR <= "00101000111";
    UI <= "00011100100";
    WAIT FOR clk_period;

    UR <= "00100011100";
    UI <= "00011100111";
    WAIT FOR clk_period;

    UR <= "00011100101";
    UI <= "00011100111";
    WAIT FOR clk_period;

    UR <= "00010101001";
    UI <= "00011100010";
    WAIT FOR clk_period;

    UR <= "00001101010";
    UI <= "00011010111";
    WAIT FOR clk_period;

    UR <= "00000101110";
    UI <= "00011000101";
    WAIT FOR clk_period;

    UR <= "11111111000";
    UI <= "00010101011";
    WAIT FOR clk_period;

    UR <= "11111001010";
    UI <= "00010001010";
    WAIT FOR clk_period;

    UR <= "11110100101";
    UI <= "00001100100";
    WAIT FOR clk_period;

    UR <= "11110001001";
    UI <= "00000111100";
    WAIT FOR clk_period;

    UR <= "11101110011";
    UI <= "00000010101";
    WAIT FOR clk_period;

    UR <= "11101100001";
    UI <= "11111110100";
    WAIT FOR clk_period;

    UR <= "11101001111";
    UI <= "11111011101";
    WAIT FOR clk_period;

    UR <= "11100111100";
    UI <= "11111010101";
    WAIT FOR clk_period;

    UR <= "11100100101";
    UI <= "11111011101";
    WAIT FOR clk_period;

    UR <= "11100001011";
    UI <= "11111111000";
    WAIT FOR clk_period;

    UR <= "11011101111";
    UI <= "00000100100";
    WAIT FOR clk_period;

    UR <= "11011010100";
    UI <= "00001011101";
    WAIT FOR clk_period;

    UR <= "11010111111";
    UI <= "00010011110";
    WAIT FOR clk_period;

    UR <= "11010110011";
    UI <= "00011100001";
    WAIT FOR clk_period;

    UR <= "11010110100";
    UI <= "00100011111";
    WAIT FOR clk_period;

    UR <= "11011000110";
    UI <= "00101010001";
    WAIT FOR clk_period;

    UR <= "11011101000";
    UI <= "00101110011";
    WAIT FOR clk_period;

    UR <= "11100011010";
    UI <= "00110000010";
    WAIT FOR clk_period;

    UR <= "11101011000";
    UI <= "00101111111";
    WAIT FOR clk_period;

    UR <= "11110011110";
    UI <= "00101101110";
    WAIT FOR clk_period;

    UR <= "11111100100";
    UI <= "00101010011";
    WAIT FOR clk_period;

    UR <= "00000100110";
    UI <= "00100110110";
    WAIT FOR clk_period;

    UR <= "00001011101";
    UI <= "00100011111";
    WAIT FOR clk_period;

    UR <= "00010000011";
    UI <= "00100010100";
    WAIT FOR clk_period;

    UR <= "00010010111";
    UI <= "00100011000";
    WAIT FOR clk_period;

    UR <= "00010010111";
    UI <= "00100101101";
    WAIT FOR clk_period;

    UR <= "00010000100";
    UI <= "00101010000";
    WAIT FOR clk_period;

    UR <= "00001100000";
    UI <= "00101111010";
    WAIT FOR clk_period;

    UR <= "00000110001";
    UI <= "00110100011";
    WAIT FOR clk_period;

    UR <= "11111111010";
    UI <= "00111000010";
    WAIT FOR clk_period;

    UR <= "11110111111";
    UI <= "00111001101";
    WAIT FOR clk_period;

    UR <= "11110000110";
    UI <= "00110111101";
    WAIT FOR clk_period;

    UR <= "11101010001";
    UI <= "00110001111";
    WAIT FOR clk_period;

    UR <= "11100100011";
    UI <= "00101000101";
    WAIT FOR clk_period;

    UR <= "11011111111";
    UI <= "00011100101";
    WAIT FOR clk_period;

    UR <= "11011100110";
    UI <= "00001111001";
    WAIT FOR clk_period;

    UR <= "11011011010";
    UI <= "00000010000";
    WAIT FOR clk_period;

    UR <= "11011011100";
    UI <= "11110110110";
    WAIT FOR clk_period;

    UR <= "11011101101";
    UI <= "11101111100";
    WAIT FOR clk_period;

    UR <= "11100001101";
    UI <= "11101101001";
    WAIT FOR clk_period;

    UR <= "11100111100";
    UI <= "11110000101";
    WAIT FOR clk_period;

    UR <= "11101110111";
    UI <= "11111001110";
    WAIT FOR clk_period;

    UR <= "11110111011";
    UI <= "00000111111";
    WAIT FOR clk_period;

    UR <= "00000000100";
    UI <= "00011001010";
    WAIT FOR clk_period;

    UR <= "00001001010";
    UI <= "00101100000";
    WAIT FOR clk_period;

    UR <= "00010000110";
    UI <= "00111101110";
    WAIT FOR clk_period;

    UR <= "00010110010";
    UI <= "01001100011";
    WAIT FOR clk_period;

    UR <= "00011001001";
    UI <= "01010101111";
    WAIT FOR clk_period;

    UR <= "00011000101";
    UI <= "01011000111";
    WAIT FOR clk_period;

    UR <= "00010100111";
    UI <= "01010101001";
    WAIT FOR clk_period;

    UR <= "00001110001";
    UI <= "01001010101";
    WAIT FOR clk_period;

    UR <= "00000101010";
    UI <= "00111010101";
    WAIT FOR clk_period;

    UR <= "11111011100";
    UI <= "00100110110";
    WAIT FOR clk_period;

    UR <= "11110010001";
    UI <= "00010001000";
    WAIT FOR clk_period;

    UR <= "11101010100";
    UI <= "11111011101";
    WAIT FOR clk_period;

    UR <= "11100101111";
    UI <= "11101000101";
    WAIT FOR clk_period;

    UR <= "11100100111";
    UI <= "11011001100";
    WAIT FOR clk_period;

    UR <= "11100111111";
    UI <= "11001111011";
    WAIT FOR clk_period;

    UR <= "11101110010";
    UI <= "11001010101";
    WAIT FOR clk_period;

    UR <= "11110111000";
    UI <= "11001011000";
    WAIT FOR clk_period;

    UR <= "00000000110";
    UI <= "11001111101";
    WAIT FOR clk_period;

    UR <= "00001001110";
    UI <= "11010111100";
    WAIT FOR clk_period;

    UR <= "00010000000";
    UI <= "11100001001";
    WAIT FOR clk_period;

    UR <= "00010010011";
    UI <= "11101011010";
    WAIT FOR clk_period;

    UR <= "00001111111";
    UI <= "11110100110";
    WAIT FOR clk_period;

    UR <= "00001000011";
    UI <= "11111100111";
    WAIT FOR clk_period;

    UR <= "11111100100";
    UI <= "00000011001";
    WAIT FOR clk_period;

    UR <= "11101101110";
    UI <= "00000111100";
    WAIT FOR clk_period;

    UR <= "11011101111";
    UI <= "00001010001";
    WAIT FOR clk_period;

    UR <= "11001111010";
    UI <= "00001011101";
    WAIT FOR clk_period;

    UR <= "11000100000";
    UI <= "00001100001";
    WAIT FOR clk_period;

    UR <= "10111101110";
    UI <= "00001100100";
    WAIT FOR clk_period;

    UR <= "10111101110";
    UI <= "00001100101";
    WAIT FOR clk_period;

    UR <= "11000100000";
    UI <= "00001101000";
    WAIT FOR clk_period;

    UR <= "11001111111";
    UI <= "00001101011";
    WAIT FOR clk_period;

    UR <= "11011111111";
    UI <= "00001101101";
    WAIT FOR clk_period;

    UR <= "11110001110";
    UI <= "00001101011";
    WAIT FOR clk_period;

    UR <= "00000011000";
    UI <= "00001100100";
    WAIT FOR clk_period;

    UR <= "00010001010";
    UI <= "00001010110";
    WAIT FOR clk_period;

    UR <= "00011010011";
    UI <= "00001000000";
    WAIT FOR clk_period;

    UR <= "00011101001";
    UI <= "00000100100";
    WAIT FOR clk_period;

    UR <= "00011001001";
    UI <= "00000000100";
    WAIT FOR clk_period;

    UR <= "00001110110";
    UI <= "11111100011";
    WAIT FOR clk_period;

    UR <= "11111111011";
    UI <= "11111000101";
    WAIT FOR clk_period;

    UR <= "11101101000";
    UI <= "11110110000";
    WAIT FOR clk_period;

    UR <= "11011010000";
    UI <= "11110100111";
    WAIT FOR clk_period;

    UR <= "11001000110";
    UI <= "11110101101";
    WAIT FOR clk_period;

    UR <= "10111011001";
    UI <= "11111000010";
    WAIT FOR clk_period;

    UR <= "10110010110";
    UI <= "11111100110";
    WAIT FOR clk_period;

    UR <= "10110000011";
    UI <= "00000010111";
    WAIT FOR clk_period;

    UR <= "10110011110";
    UI <= "00001010000";
    WAIT FOR clk_period;

    UR <= "10111100010";
    UI <= "00010001110";
    WAIT FOR clk_period;

    UR <= "11001000011";
    UI <= "00011001011";
    WAIT FOR clk_period;

    UR <= "11010110101";
    UI <= "00100000011";
    WAIT FOR clk_period;

    UR <= "11100101000";
    UI <= "00100110000";
    WAIT FOR clk_period;

    UR <= "11110010001";
    UI <= "00101010001";
    WAIT FOR clk_period;

    UR <= "11111100110";
    UI <= "00101100011";
    WAIT FOR clk_period;

    UR <= "00000100000";
    UI <= "00101100110";
    WAIT FOR clk_period;

    UR <= "00000111111";
    UI <= "00101011001";
    WAIT FOR clk_period;

    UR <= "00001000011";
    UI <= "00101000000";
    WAIT FOR clk_period;

    UR <= "00000110011";
    UI <= "00100011011";
    WAIT FOR clk_period;

    UR <= "00000010110";
    UI <= "00011101101";
    WAIT FOR clk_period;

    UR <= "11111110010";
    UI <= "00010111010";
    WAIT FOR clk_period;

    UR <= "11111010000";
    UI <= "00010000100";
    WAIT FOR clk_period;

    UR <= "11110110101";
    UI <= "00001001101";
    WAIT FOR clk_period;

    UR <= "11110100100";
    UI <= "00000010111";
    WAIT FOR clk_period;

    UR <= "11110100001";
    UI <= "11111100101";
    WAIT FOR clk_period;

    UR <= "11110101010";
    UI <= "11110111000";
    WAIT FOR clk_period;

    UR <= "11110111111";
    UI <= "11110010001";
    WAIT FOR clk_period;

    UR <= "11111011101";
    UI <= "11101110001";
    WAIT FOR clk_period;

    UR <= "00000000010";
    UI <= "11101011001";
    WAIT FOR clk_period;

    UR <= "00000101100";
    UI <= "11101000111";
    WAIT FOR clk_period;

    UR <= "00001010111";
    UI <= "11100111100";
    WAIT FOR clk_period;

    UR <= "00010000010";
    UI <= "11100110101";
    WAIT FOR clk_period;

    UR <= "00010101001";
    UI <= "11100110000";
    WAIT FOR clk_period;

    UR <= "00011001011";
    UI <= "11100101100";
    WAIT FOR clk_period;

    UR <= "00011100100";
    UI <= "11100100101";
    WAIT FOR clk_period;

    UR <= "00011110010";
    UI <= "11100011001";
    WAIT FOR clk_period;

    UR <= "00011110011";
    UI <= "11100000110";
    WAIT FOR clk_period;

    UR <= "00011100100";
    UI <= "11011101101";
    WAIT FOR clk_period;

    UR <= "00011000101";
    UI <= "11011001101";
    WAIT FOR clk_period;

    UR <= "00010010110";
    UI <= "11010101000";
    WAIT FOR clk_period;

    UR <= "00001011001";
    UI <= "11010000001";
    WAIT FOR clk_period;

    UR <= "00000010011";
    UI <= "11001011100";
    WAIT FOR clk_period;

    UR <= "11111000111";
    UI <= "11000111111";
    WAIT FOR clk_period;

    UR <= "11101111101";
    UI <= "11000101110";
    WAIT FOR clk_period;

    UR <= "11100111010";
    UI <= "11000101110";
    WAIT FOR clk_period;

    UR <= "11100000011";
    UI <= "11001000011";
    WAIT FOR clk_period;

    UR <= "11011011110";
    UI <= "11001101101";
    WAIT FOR clk_period;

    UR <= "11011001100";
    UI <= "11010101111";
    WAIT FOR clk_period;

    UR <= "11011001110";
    UI <= "11100000100";
    WAIT FOR clk_period;

    UR <= "11011100001";
    UI <= "11101101011";
    WAIT FOR clk_period;

    UR <= "11100000010";
    UI <= "11111011100";
    WAIT FOR clk_period;

    UR <= "11100101010";
    UI <= "00001010011";
    WAIT FOR clk_period;

    UR <= "11101010101";
    UI <= "00011001000";
    WAIT FOR clk_period;

    UR <= "11101111011";
    UI <= "00100110100";
    WAIT FOR clk_period;

    UR <= "11110011001";
    UI <= "00110010010";
    WAIT FOR clk_period;

    UR <= "11110101100";
    UI <= "00111011101";
    WAIT FOR clk_period;

    UR <= "11110110010";
    UI <= "01000010010";
    WAIT FOR clk_period;

    UR <= "11110101101";
    UI <= "01000101111";
    WAIT FOR clk_period;

    UR <= "11110100000";
    UI <= "01000110110";
    WAIT FOR clk_period;

    UR <= "11110001110";
    UI <= "01000100111";
    WAIT FOR clk_period;

    UR <= "11101111101";
    UI <= "01000000110";
    WAIT FOR clk_period;

    UR <= "11101110010";
    UI <= "00111010101";
    WAIT FOR clk_period;

    UR <= "11101101110";
    UI <= "00110011000";
    WAIT FOR clk_period;

    UR <= "11101110100";
    UI <= "00101010010";
    WAIT FOR clk_period;

    UR <= "11110000100";
    UI <= "00100001000";
    WAIT FOR clk_period;

    UR <= "11110011100";
    UI <= "00010111100";
    WAIT FOR clk_period;

    UR <= "11110111000";
    UI <= "00001110001";
    WAIT FOR clk_period;

    UR <= "11111010101";
    UI <= "00000101001";
    WAIT FOR clk_period;

    UR <= "11111101110";
    UI <= "11111101001";
    WAIT FOR clk_period;

    UR <= "11111111110";
    UI <= "11110110010";
    WAIT FOR clk_period;

    UR <= "00000000010";
    UI <= "11110000101";
    WAIT FOR clk_period;

    UR <= "11111111001";
    UI <= "11101100110";
    WAIT FOR clk_period;

    UR <= "11111100001";
    UI <= "11101010100";
    WAIT FOR clk_period;

    UR <= "11110111110";
    UI <= "11101010001";
    WAIT FOR clk_period;

    UR <= "11110010001";
    UI <= "11101011100";
    WAIT FOR clk_period;

    UR <= "11101011110";
    UI <= "11101110011";
    WAIT FOR clk_period;

    UR <= "11100101011";
    UI <= "11110010100";
    WAIT FOR clk_period;

    UR <= "11011111011";
    UI <= "11110111110";
    WAIT FOR clk_period;

    UR <= "11011010010";
    UI <= "11111101101";
    WAIT FOR clk_period;

    UR <= "11010110100";
    UI <= "00000011110";
    WAIT FOR clk_period;

    UR <= "11010100010";
    UI <= "00001010000";
    WAIT FOR clk_period;

    UR <= "11010011101";
    UI <= "00010000001";
    WAIT FOR clk_period;

    UR <= "11010100011";
    UI <= "00010110000";
    WAIT FOR clk_period;

    UR <= "11010110010";
    UI <= "00011011101";
    WAIT FOR clk_period;

    UR <= "11011001000";
    UI <= "00100001010";
    WAIT FOR clk_period;

    UR <= "11011100010";
    UI <= "00100110101";
    WAIT FOR clk_period;

    UR <= "11011111110";
    UI <= "00101100001";
    WAIT FOR clk_period;

    UR <= "11100011010";
    UI <= "00110001100";
    WAIT FOR clk_period;

    UR <= "11100110101";
    UI <= "00110110101";
    WAIT FOR clk_period;

    UR <= "11101001111";
    UI <= "00111011010";
    WAIT FOR clk_period;

    UR <= "11101101001";
    UI <= "00111110111";
    WAIT FOR clk_period;

    UR <= "11110000101";
    UI <= "01000001001";
    WAIT FOR clk_period;

    UR <= "11110100010";
    UI <= "01000001101";
    WAIT FOR clk_period;

    UR <= "11111000011";
    UI <= "00111111110";
    WAIT FOR clk_period;

    UR <= "11111100110";
    UI <= "00111011100";
    WAIT FOR clk_period;

    UR <= "00000001011";
    UI <= "00110101000";
    WAIT FOR clk_period;

    UR <= "00000101111";
    UI <= "00101100011";
    WAIT FOR clk_period;

    UR <= "00001001111";
    UI <= "00100010010";
    WAIT FOR clk_period;

    UR <= "00001100110";
    UI <= "00010111100";
    WAIT FOR clk_period;

    UR <= "00001101111";
    UI <= "00001100110";
    WAIT FOR clk_period;

    UR <= "00001101000";
    UI <= "00000011001";
    WAIT FOR clk_period;

    UR <= "00001001110";
    UI <= "11111011001";
    WAIT FOR clk_period;

    UR <= "00000100010";
    UI <= "11110101100";
    WAIT FOR clk_period;

    UR <= "11111100101";
    UI <= "11110010010";
    WAIT FOR clk_period;

    UR <= "11110011111";
    UI <= "11110001101";
    WAIT FOR clk_period;

    UR <= "11101010101";
    UI <= "11110011000";
    WAIT FOR clk_period;

    UR <= "11100010010";
    UI <= "11110110000";
    WAIT FOR clk_period;

    UR <= "11011011110";
    UI <= "11111001111";
    WAIT FOR clk_period;

    UR <= "11011000010";
    UI <= "11111110000";
    WAIT FOR clk_period;

    UR <= "11011000101";
    UI <= "00000001110";
    WAIT FOR clk_period;

    UR <= "11011101001";
    UI <= "00000100110";
    WAIT FOR clk_period;

    UR <= "11100101110";
    UI <= "00000111000";
    WAIT FOR clk_period;

    UR <= "11110001110";
    UI <= "00001000100";
    WAIT FOR clk_period;

    UR <= "00000000010";
    UI <= "00001001110";
    WAIT FOR clk_period;

    UR <= "00001111101";
    UI <= "00001011001";
    WAIT FOR clk_period;

    UR <= "00011110011";
    UI <= "00001101010";
    WAIT FOR clk_period;

    UR <= "00101010111";
    UI <= "00010000011";
    WAIT FOR clk_period;

    UR <= "00110100001";
    UI <= "00010100110";
    WAIT FOR clk_period;

    UR <= "00111001000";
    UI <= "00011010011";
    WAIT FOR clk_period;

    UR <= "00111001100";
    UI <= "00100000111";
    WAIT FOR clk_period;

    UR <= "00110101110";
    UI <= "00100111100";
    WAIT FOR clk_period;

    UR <= "00101110111";
    UI <= "00101101101";
    WAIT FOR clk_period;

    UR <= "00100110000";
    UI <= "00110010011";
    WAIT FOR clk_period;

    UR <= "00011100101";
    UI <= "00110100111";
    WAIT FOR clk_period;

    UR <= "00010100100";
    UI <= "00110100101";
    WAIT FOR clk_period;

    UR <= "00001110111";
    UI <= "00110001000";
    WAIT FOR clk_period;

    UR <= "00001100011";
    UI <= "00101010001";
    WAIT FOR clk_period;

    UR <= "00001101100";
    UI <= "00100000000";
    WAIT FOR clk_period;

    UR <= "00010010000";
    UI <= "00010011011";
    WAIT FOR clk_period;

    UR <= "00011000110";
    UI <= "00000100110";
    WAIT FOR clk_period;

    UR <= "00100000101";
    UI <= "11110101000";
    WAIT FOR clk_period;

    UR <= "00101000001";
    UI <= "11100101001";
    WAIT FOR clk_period;

    UR <= "00101101110";
    UI <= "11010101111";
    WAIT FOR clk_period;

    UR <= "00110000010";
    UI <= "11001000000";
    WAIT FOR clk_period;

    UR <= "00101110111";
    UI <= "10111100001";
    WAIT FOR clk_period;

    UR <= "00101001010";
    UI <= "10110010110";
    WAIT FOR clk_period;

    UR <= "00011111110";
    UI <= "10101100000";
    WAIT FOR clk_period;

    UR <= "00010011011";
    UI <= "10101000010";
    WAIT FOR clk_period;

    UR <= "00000101010";
    UI <= "10100111100";
    WAIT FOR clk_period;

    UR <= "11110110111";
    UI <= "10101001100";
    WAIT FOR clk_period;

    UR <= "11101010000";
    UI <= "10101110010";
    WAIT FOR clk_period;

    UR <= "11011111110";
    UI <= "10110101011";
    WAIT FOR clk_period;

    UR <= "11011001011";
    UI <= "10111110010";
    WAIT FOR clk_period;

    UR <= "11010111001";
    UI <= "11001000001";
    WAIT FOR clk_period;

    UR <= "11011001010";
    UI <= "11010010011";
    WAIT FOR clk_period;

    UR <= "11011111010";
    UI <= "11011011110";
    WAIT FOR clk_period;

    UR <= "11101000000";
    UI <= "11100011100";
    WAIT FOR clk_period;

    UR <= "11110010101";
    UI <= "11101000101";
    WAIT FOR clk_period;

    UR <= "11111101110";
    UI <= "11101010100";
    WAIT FOR clk_period;

    UR <= "00001000001";
    UI <= "11101000101";
    WAIT FOR clk_period;

    UR <= "00010000111";
    UI <= "11100011001";
    WAIT FOR clk_period;

    UR <= "00010111000";
    UI <= "11011010100";
    WAIT FOR clk_period;

    UR <= "00011010001";
    UI <= "11001111110";
    WAIT FOR clk_period;

    UR <= "00011010001";
    UI <= "11000100011";
    WAIT FOR clk_period;

    UR <= "00010111000";
    UI <= "10111001111";
    WAIT FOR clk_period;

    UR <= "00010001001";
    UI <= "10110010001";
    WAIT FOR clk_period;

    UR <= "00001001001";
    UI <= "10101110100";
    WAIT FOR clk_period;

    UR <= "11111111011";
    UI <= "10110000001";
    WAIT FOR clk_period;

    UR <= "11110100101";
    UI <= "10110111100";
    WAIT FOR clk_period;

    UR <= "11101001101";
    UI <= "11000100101";
    WAIT FOR clk_period;

    UR <= "11011110101";
    UI <= "11010110110";
    WAIT FOR clk_period;

    UR <= "11010100101";
    UI <= "11101100000";
    WAIT FOR clk_period;

    UR <= "11001011110";
    UI <= "00000010110";
    WAIT FOR clk_period;

    UR <= "11000100110";
    UI <= "00011000101";
    WAIT FOR clk_period;

    UR <= "11000000000";
    UI <= "00101011100";
    WAIT FOR clk_period;

    UR <= "10111101110";
    UI <= "00111001011";
    WAIT FOR clk_period;

    UR <= "10111110001";
    UI <= "01000001000";
    WAIT FOR clk_period;

    UR <= "11000001011";
    UI <= "01000001110";
    WAIT FOR clk_period;

    UR <= "11000111010";
    UI <= "00111011101";
    WAIT FOR clk_period;

    UR <= "11001111101";
    UI <= "00101111101";
    WAIT FOR clk_period;

    UR <= "11011001111";
    UI <= "00011111010";
    WAIT FOR clk_period;

    UR <= "11100101101";
    UI <= "00001100011";
    WAIT FOR clk_period;

    UR <= "11110010000";
    UI <= "11111001000";
    WAIT FOR clk_period;

    UR <= "11111110010";
    UI <= "11100111010";
    WAIT FOR clk_period;

    UR <= "00001001101";
    UI <= "11011000101";
    WAIT FOR clk_period;

    UR <= "00010011011";
    UI <= "11001110101";
    WAIT FOR clk_period;

    UR <= "00011010111";
    UI <= "11001001101";
    WAIT FOR clk_period;

    UR <= "00011111110";
    UI <= "11001001110";
    WAIT FOR clk_period;

    UR <= "00100001111";
    UI <= "11001110100";
    WAIT FOR clk_period;

    UR <= "00100001000";
    UI <= "11010110111";
    WAIT FOR clk_period;

    UR <= "00011101100";
    UI <= "11100001111";
    WAIT FOR clk_period;

    UR <= "00010111100";
    UI <= "11101110010";
    WAIT FOR clk_period;

    UR <= "00001111101";
    UI <= "11111010101";
    WAIT FOR clk_period;

    UR <= "00000110011";
    UI <= "00000110010";
    WAIT FOR clk_period;

    UR <= "11111100011";
    UI <= "00010000001";
    WAIT FOR clk_period;

    UR <= "11110010010";
    UI <= "00011000000";
    WAIT FOR clk_period;

    UR <= "11101000101";
    UI <= "00011101011";
    WAIT FOR clk_period;

    UR <= "11100000001";
    UI <= "00100000011";
    WAIT FOR clk_period;

    UR <= "11011001001";
    UI <= "00100001001";
    WAIT FOR clk_period;

    UR <= "11010100000";
    UI <= "00011111101";
    WAIT FOR clk_period;

    UR <= "11010001001";
    UI <= "00011100010";
    WAIT FOR clk_period;

    UR <= "11010000101";
    UI <= "00010111010";
    WAIT FOR clk_period;

    UR <= "11010010100";
    UI <= "00010000111";
    WAIT FOR clk_period;

    UR <= "11010110100";
    UI <= "00001001100";
    WAIT FOR clk_period;

    UR <= "11011100100";
    UI <= "00000001010";
    WAIT FOR clk_period;

    UR <= "11100011111";
    UI <= "11111000110";
    WAIT FOR clk_period;

    UR <= "11101100010";
    UI <= "11110000011";
    WAIT FOR clk_period;

    UR <= "11110101000";
    UI <= "11101000101";
    WAIT FOR clk_period;

    UR <= "11111101110";
    UI <= "11100010001";
    WAIT FOR clk_period;

    UR <= "00000101111";
    UI <= "11011101001";
    WAIT FOR clk_period;

    UR <= "00001101001";
    UI <= "11011010000";
    WAIT FOR clk_period;

    UR <= "00010011000";
    UI <= "11011001001";
    WAIT FOR clk_period;

    UR <= "00010111100";
    UI <= "11011010011";
    WAIT FOR clk_period;

    UR <= "00011010011";
    UI <= "11011101110";
    WAIT FOR clk_period;

    UR <= "00011011111";
    UI <= "11100010111";
    WAIT FOR clk_period;

    UR <= "00011100000";
    UI <= "11101001001";
    WAIT FOR clk_period;

    UR <= "00011010111";
    UI <= "11110000010";
    WAIT FOR clk_period;

    UR <= "00011000101";
    UI <= "11110111101";
    WAIT FOR clk_period;

    UR <= "00010101010";
    UI <= "11111110101";
    WAIT FOR clk_period;

    UR <= "00010001001";
    UI <= "00000100111";
    WAIT FOR clk_period;

    UR <= "00001100000";
    UI <= "00001010010";
    WAIT FOR clk_period;

    UR <= "00000110000";
    UI <= "00001110100";
    WAIT FOR clk_period;

    UR <= "11111111100";
    UI <= "00010001100";
    WAIT FOR clk_period;

    UR <= "11111000011";
    UI <= "00010011100";
    WAIT FOR clk_period;

    UR <= "11110001001";
    UI <= "00010100100";
    WAIT FOR clk_period;

    UR <= "11101010000";
    UI <= "00010100110";
    WAIT FOR clk_period;

    UR <= "11100011011";
    UI <= "00010100011";
    WAIT FOR clk_period;

    UR <= "11011110000";
    UI <= "00010011100";
    WAIT FOR clk_period;

    UR <= "11011010001";
    UI <= "00010010010";
    WAIT FOR clk_period;

    UR <= "11011000001";
    UI <= "00010000110";
    WAIT FOR clk_period;

    UR <= "11011000101";
    UI <= "00001111001";
    WAIT FOR clk_period;

    UR <= "11011011101";
    UI <= "00001101100";
    WAIT FOR clk_period;

    UR <= "11100001010";
    UI <= "00001100000";
    WAIT FOR clk_period;

    UR <= "11101001001";
    UI <= "00001010110";
    WAIT FOR clk_period;

    UR <= "11110011001";
    UI <= "00001010010";
    WAIT FOR clk_period;

    UR <= "11111110101";
    UI <= "00001010101";
    WAIT FOR clk_period;

    UR <= "00001011001";
    UI <= "00001100000";
    WAIT FOR clk_period;

    UR <= "00011000001";
    UI <= "00001110100";
    WAIT FOR clk_period;

    UR <= "00100100111";
    UI <= "00010010011";
    WAIT FOR clk_period;

    UR <= "00110001001";
    UI <= "00010111011";
    WAIT FOR clk_period;

    UR <= "00111100010";
    UI <= "00011101010";
    WAIT FOR clk_period;

    UR <= "01000101111";
    UI <= "00100011110";
    WAIT FOR clk_period;

    UR <= "01001101111";
    UI <= "00101010010";
    WAIT FOR clk_period;

    UR <= "01010100001";
    UI <= "00110000011";
    WAIT FOR clk_period;

    UR <= "01011000011";
    UI <= "00110101100";
    WAIT FOR clk_period;

    UR <= "01011010101";
    UI <= "00111001000";
    WAIT FOR clk_period;

    UR <= "01011011000";
    UI <= "00111010101";
    WAIT FOR clk_period;

    UR <= "01011001101";
    UI <= "00111010001";
    WAIT FOR clk_period;

    UR <= "01010110110";
    UI <= "00110111001";
    WAIT FOR clk_period;

    UR <= "01010010100";
    UI <= "00110001110";
    WAIT FOR clk_period;

    UR <= "01001101011";
    UI <= "00101010000";
    WAIT FOR clk_period;

    UR <= "01000111111";
    UI <= "00100000001";
    WAIT FOR clk_period;

    UR <= "01000010011";
    UI <= "00010100100";
    WAIT FOR clk_period;

    UR <= "00111101011";
    UI <= "00000111100";
    WAIT FOR clk_period;

    UR <= "00111001011";
    UI <= "11111001100";
    WAIT FOR clk_period;

    UR <= "00110110100";
    UI <= "11101011010";
    WAIT FOR clk_period;

    UR <= "00110100111";
    UI <= "11011101001";
    WAIT FOR clk_period;

    UR <= "00110100100";
    UI <= "11001111110";
    WAIT FOR clk_period;

    UR <= "00110101000";
    UI <= "11000011110";
    WAIT FOR clk_period;

    UR <= "00110101101";
    UI <= "10111001110";
    WAIT FOR clk_period;

    UR <= "00110110000";
    UI <= "10110010011";
    WAIT FOR clk_period;

    UR <= "00110101001";
    UI <= "10101110000";
    WAIT FOR clk_period;

    UR <= "00110010110";
    UI <= "10101101000";
    WAIT FOR clk_period;

    UR <= "00101110001";
    UI <= "10101111101";
    WAIT FOR clk_period;

    UR <= "00100111010";
    UI <= "10110101101";
    WAIT FOR clk_period;

    UR <= "00011110001";
    UI <= "10111110111";
    WAIT FOR clk_period;

    UR <= "00010011001";
    UI <= "11001010110";
    WAIT FOR clk_period;

    UR <= "00000111001";
    UI <= "11011000011";
    WAIT FOR clk_period;

    UR <= "11111010110";
    UI <= "11100111001";
    WAIT FOR clk_period;

    UR <= "11101111010";
    UI <= "11110101110";
    WAIT FOR clk_period;

    UR <= "11100101010";
    UI <= "00000011100";
    WAIT FOR clk_period;

    UR <= "11011101110";
    UI <= "00001111101";
    WAIT FOR clk_period;

    UR <= "11011001001";
    UI <= "00011001011";
    WAIT FOR clk_period;

    UR <= "11010111101";
    UI <= "00100000101";
    WAIT FOR clk_period;

    UR <= "11011001000";
    UI <= "00100101011";
    WAIT FOR clk_period;

    UR <= "11011101001";
    UI <= "00101000000";
    WAIT FOR clk_period;

    UR <= "11100011001";
    UI <= "00101001000";
    WAIT FOR clk_period;

    UR <= "11101010011";
    UI <= "00101001010";
    WAIT FOR clk_period;

    UR <= "11110010000";
    UI <= "00101001100";
    WAIT FOR clk_period;

    UR <= "11111001011";
    UI <= "00101010101";
    WAIT FOR clk_period;

    UR <= "11111111110";
    UI <= "00101101001";
    WAIT FOR clk_period;

    UR <= "00000100111";
    UI <= "00110001100";
    WAIT FOR clk_period;

    UR <= "00001000100";
    UI <= "00110111100";
    WAIT FOR clk_period;

    UR <= "00001010011";
    UI <= "00111111001";
    WAIT FOR clk_period;

    UR <= "00001010101";
    UI <= "01000111111";
    WAIT FOR clk_period;

    UR <= "00001001100";
    UI <= "01010000110";
    WAIT FOR clk_period;

    UR <= "00000111000";
    UI <= "01011001001";
    WAIT FOR clk_period;

    UR <= "00000011100";
    UI <= "01100000001";
    WAIT FOR clk_period;

    UR <= "11111111011";
    UI <= "01100100111";
    WAIT FOR clk_period;

    UR <= "11111010110";
    UI <= "01100111010";
    WAIT FOR clk_period;

    UR <= "11110110001";
    UI <= "01100110110";
    WAIT FOR clk_period;

    UR <= "11110001111";
    UI <= "01100011100";
    WAIT FOR clk_period;

    UR <= "11101110010";
    UI <= "01011101110";
    WAIT FOR clk_period;

    UR <= "11101011111";
    UI <= "01010110010";
    WAIT FOR clk_period;

    UR <= "11101011000";
    UI <= "01001101101";
    WAIT FOR clk_period;

    UR <= "11101100000";
    UI <= "01000100011";
    WAIT FOR clk_period;

    UR <= "11101110110";
    UI <= "00111011011";
    WAIT FOR clk_period;

    UR <= "11110011011";
    UI <= "00110011000";
    WAIT FOR clk_period;

    UR <= "11111001011";
    UI <= "00101011101";
    WAIT FOR clk_period;

    UR <= "00000000010";
    UI <= "00100101010";
    WAIT FOR clk_period;

    UR <= "00000111001";
    UI <= "00100000000";
    WAIT FOR clk_period;

    UR <= "00001101000";
    UI <= "00011011110";
    WAIT FOR clk_period;

    UR <= "00010001010";
    UI <= "00011000001";
    WAIT FOR clk_period;

    UR <= "00010011000";
    UI <= "00010101000";
    WAIT FOR clk_period;

    UR <= "00010001111";
    UI <= "00010010010";
    WAIT FOR clk_period;

    UR <= "00001110000";
    UI <= "00010000000";
    WAIT FOR clk_period;

    UR <= "00000111101";
    UI <= "00001110011";
    WAIT FOR clk_period;

    UR <= "11111111100";
    UI <= "00001101101";
    WAIT FOR clk_period;

    UR <= "11110110111";
    UI <= "00001110010";
    WAIT FOR clk_period;

    UR <= "11101111001";
    UI <= "00010000011";
    WAIT FOR clk_period;

    UR <= "11101001001";
    UI <= "00010100100";
    WAIT FOR clk_period;

    UR <= "11100110011";
    UI <= "00011010100";
    WAIT FOR clk_period;

    UR <= "11100111001";
    UI <= "00100010001";
    WAIT FOR clk_period;

    UR <= "11101011111";
    UI <= "00101011001";
    WAIT FOR clk_period;

    UR <= "11110100000";
    UI <= "00110100101";
    WAIT FOR clk_period;

    UR <= "11111110111";
    UI <= "00111101111";
    WAIT FOR clk_period;

    UR <= "00001011000";
    UI <= "01000101110";
    WAIT FOR clk_period;

    UR <= "00010111000";
    UI <= "01001011011";
    WAIT FOR clk_period;

    UR <= "00100001010";
    UI <= "01001110000";
    WAIT FOR clk_period;

    UR <= "00101000110";
    UI <= "01001101000";
    WAIT FOR clk_period;

    UR <= "00101100011";
    UI <= "01001000100";
    WAIT FOR clk_period;

    UR <= "00101100000";
    UI <= "01000000101";
    WAIT FOR clk_period;

    UR <= "00100111110";
    UI <= "00110110010";
    WAIT FOR clk_period;

    UR <= "00100000011";
    UI <= "00101010011";
    WAIT FOR clk_period;

    UR <= "00010111001";
    UI <= "00011110000";
    WAIT FOR clk_period;

    UR <= "00001101010";
    UI <= "00010010110";
    WAIT FOR clk_period;

    UR <= "00000100010";
    UI <= "00001001101";
    WAIT FOR clk_period;

    UR <= "11111101010";
    UI <= "00000011101";
    WAIT FOR clk_period;

    UR <= "11111001000";
    UI <= "00000001010";
    WAIT FOR clk_period;

    UR <= "11110111111";
    UI <= "00000010110";
    WAIT FOR clk_period;

    UR <= "11111001101";
    UI <= "00000111100";
    WAIT FOR clk_period;

    UR <= "11111101100";
    UI <= "00001111000";
    WAIT FOR clk_period;

    UR <= "00000010011";
    UI <= "00011000001";
    WAIT FOR clk_period;

    UR <= "00000111010";
    UI <= "00100001110";
    WAIT FOR clk_period;

    UR <= "00001010110";
    UI <= "00101010011";
    WAIT FOR clk_period;

    UR <= "00001011110";
    UI <= "00110001010";
    WAIT FOR clk_period;

    UR <= "00001001111";
    UI <= "00110101011";
    WAIT FOR clk_period;

    UR <= "00000100101";
    UI <= "00110110010";
    WAIT FOR clk_period;

    UR <= "11111100100";
    UI <= "00110011110";
    WAIT FOR clk_period;

    UR <= "11110010001";
    UI <= "00101110010";
    WAIT FOR clk_period;

    UR <= "11100110100";
    UI <= "00100110000";
    WAIT FOR clk_period;

    UR <= "11011010111";
    UI <= "00011100000";
    WAIT FOR clk_period;

    UR <= "11010000011";
    UI <= "00010001000";
    WAIT FOR clk_period;

    UR <= "11001000011";
    UI <= "00000110000";
    WAIT FOR clk_period;

    UR <= "11000011101";
    UI <= "11111011101";
    WAIT FOR clk_period;

    UR <= "11000010101";
    UI <= "11110010110";
    WAIT FOR clk_period;

    UR <= "11000101100";
    UI <= "11101011111";
    WAIT FOR clk_period;

    UR <= "11001100000";
    UI <= "11100111011";
    WAIT FOR clk_period;

    UR <= "11010101011";
    UI <= "11100101101";
    WAIT FOR clk_period;

    UR <= "11100000111";
    UI <= "11100110101";
    WAIT FOR clk_period;

    UR <= "11101101100";
    UI <= "11101010011";
    WAIT FOR clk_period;

    UR <= "11111010010";
    UI <= "11110000101";
    WAIT FOR clk_period;

    UR <= "00000110001";
    UI <= "11111001001";
    WAIT FOR clk_period;

    UR <= "00010000100";
    UI <= "00000011011";
    WAIT FOR clk_period;

    UR <= "00011000100";
    UI <= "00001110111";
    WAIT FOR clk_period;

    UR <= "00011110001";
    UI <= "00011011000";
    WAIT FOR clk_period;

    UR <= "00100001001";
    UI <= "00100111000";
    WAIT FOR clk_period;

    UR <= "00100001110";
    UI <= "00110010000";
    WAIT FOR clk_period;

    UR <= "00100000010";
    UI <= "00111011011";
    WAIT FOR clk_period;

    UR <= "00011101000";
    UI <= "01000010011";
    WAIT FOR clk_period;

    UR <= "00011000100";
    UI <= "01000110100";
    WAIT FOR clk_period;

    UR <= "00010011010";
    UI <= "01000111101";
    WAIT FOR clk_period;

    UR <= "00001101101";
    UI <= "01000101110";
    WAIT FOR clk_period;

    UR <= "00001000000";
    UI <= "01000001000";
    WAIT FOR clk_period;

    UR <= "00000010011";
    UI <= "00111010001";
    WAIT FOR clk_period;

    UR <= "11111101010";
    UI <= "00110001110";
    WAIT FOR clk_period;

    UR <= "11111000100";
    UI <= "00101000111";
    WAIT FOR clk_period;

    UR <= "11110100001";
    UI <= "00100000010";
    WAIT FOR clk_period;

    UR <= "11110000100";
    UI <= "00011000100";
    WAIT FOR clk_period;

    UR <= "11101101100";
    UI <= "00010010011";
    WAIT FOR clk_period;

    UR <= "11101011101";
    UI <= "00001110001";
    WAIT FOR clk_period;

    UR <= "11101010111";
    UI <= "00001011100";
    WAIT FOR clk_period;

    UR <= "11101011110";
    UI <= "00001010010";
    WAIT FOR clk_period;

    UR <= "11101110011";
    UI <= "00001010000";
    WAIT FOR clk_period;

    UR <= "11110011001";
    UI <= "00001010001";
    WAIT FOR clk_period;

    UR <= "11111010000";
    UI <= "00001010001";
    WAIT FOR clk_period;

    UR <= "00000010110";
    UI <= "00001001101";
    WAIT FOR clk_period;

    UR <= "00001100111";
    UI <= "00001000011";
    WAIT FOR clk_period;

    UR <= "00010111110";
    UI <= "00000110011";
    WAIT FOR clk_period;

    UR <= "00100010011";
    UI <= "00000100001";
    WAIT FOR clk_period;

    UR <= "00101011110";
    UI <= "00000001111";
    WAIT FOR clk_period;

    UR <= "00110010110";
    UI <= "00000000010";
    WAIT FOR clk_period;

    UR <= "00110110100";
    UI <= "11111111111";
    WAIT FOR clk_period;

    UR <= "00110110011";
    UI <= "00000001000";
    WAIT FOR clk_period;

    UR <= "00110010011";
    UI <= "00000011111";
    WAIT FOR clk_period;

    UR <= "00101010110";
    UI <= "00001000011";
    WAIT FOR clk_period;

    UR <= "00100000100";
    UI <= "00001110001";
    WAIT FOR clk_period;

    UR <= "00010101000";
    UI <= "00010100100";
    WAIT FOR clk_period;

    UR <= "00001001110";
    UI <= "00011010101";
    WAIT FOR clk_period;

    UR <= "00000000110";
    UI <= "00011111101";
    WAIT FOR clk_period;

    UR <= "11111011100";
    UI <= "00100011000";
    WAIT FOR clk_period;

    UR <= "11111011000";
    UI <= "00100100001";
    WAIT FOR clk_period;

    UR <= "00000000000";
    UI <= "00100010101";
    WAIT FOR clk_period;

    UR <= "00001010011";
    UI <= "00011110110";
    WAIT FOR clk_period;

    UR <= "00011001000";
    UI <= "00011000110";
    WAIT FOR clk_period;

    UR <= "00101010001";
    UI <= "00010001100";
    WAIT FOR clk_period;

    UR <= "00111011111";
    UI <= "00001001101";
    WAIT FOR clk_period;

    UR <= "01001011101";
    UI <= "00000010010";
    WAIT FOR clk_period;

    UR <= "01010111000";
    UI <= "11111100000";
    WAIT FOR clk_period;

    UR <= "01011100011";
    UI <= "11110111101";
    WAIT FOR clk_period;

    UR <= "01011010010";
    UI <= "11110101101";
    WAIT FOR clk_period;

    UR <= "01010000101";
    UI <= "11110110010";
    WAIT FOR clk_period;

    UR <= "01000000000";
    UI <= "11111001001";
    WAIT FOR clk_period;

    UR <= "00101001111";
    UI <= "11111110010";
    WAIT FOR clk_period;

    UR <= "00010000101";
    UI <= "00000100111";
    WAIT FOR clk_period;

    UR <= "11110110110";
    UI <= "00001100100";
    WAIT FOR clk_period;

    UR <= "11011111000";
    UI <= "00010100010";
    WAIT FOR clk_period;

    UR <= "11001011110";
    UI <= "00011011110";
    WAIT FOR clk_period;

    UR <= "10111110101";
    UI <= "00100010010";
    WAIT FOR clk_period;

    UR <= "10111000110";
    UI <= "00100111100";
    WAIT FOR clk_period;

    UR <= "10111001111";
    UI <= "00101011010";
    WAIT FOR clk_period;

    UR <= "11000001001";
    UI <= "00101101001";
    WAIT FOR clk_period;

    UR <= "11001101001";
    UI <= "00101101011";
    WAIT FOR clk_period;

    UR <= "11011011101";
    UI <= "00101100001";
    WAIT FOR clk_period;

    UR <= "11101010100";
    UI <= "00101001100";
    WAIT FOR clk_period;

    UR <= "11110111111";
    UI <= "00100101110";
    WAIT FOR clk_period;

    UR <= "00000010010";
    UI <= "00100001011";
    WAIT FOR clk_period;

    UR <= "00001000101";
    UI <= "00011100110";
    WAIT FOR clk_period;

    UR <= "00001011000";
    UI <= "00011000011";
    WAIT FOR clk_period;

    UR <= "00001001110";
    UI <= "00010100011";
    WAIT FOR clk_period;

    UR <= "00000110010";
    UI <= "00010001011";
    WAIT FOR clk_period;

    UR <= "00000001101";
    UI <= "00001111100";
    WAIT FOR clk_period;

    UR <= "11111101101";
    UI <= "00001110111";
    WAIT FOR clk_period;

    UR <= "11111011010";
    UI <= "00001111100";
    WAIT FOR clk_period;

    UR <= "11111011101";
    UI <= "00010001010";
    WAIT FOR clk_period;

    UR <= "11111111000";
    UI <= "00010011101";
    WAIT FOR clk_period;

    UR <= "00000101100";
    UI <= "00010110100";
    WAIT FOR clk_period;

    UR <= "00001110010";
    UI <= "00011001000";
    WAIT FOR clk_period;

    UR <= "00011000011";
    UI <= "00011010110";
    WAIT FOR clk_period;

    UR <= "00100010110";
    UI <= "00011011001";
    WAIT FOR clk_period;

    UR <= "00101100001";
    UI <= "00011010000";
    WAIT FOR clk_period;

    UR <= "00110011101";
    UI <= "00010110110";
    WAIT FOR clk_period;

    UR <= "00111000010";
    UI <= "00010001101";
    WAIT FOR clk_period;

    UR <= "00111001111";
    UI <= "00001010110";
    WAIT FOR clk_period;

    UR <= "00111000010";
    UI <= "00000010011";
    WAIT FOR clk_period;

    UR <= "00110011110";
    UI <= "11111001000";
    WAIT FOR clk_period;

    UR <= "00101100111";
    UI <= "11101111100";
    WAIT FOR clk_period;

    UR <= "00100100011";
    UI <= "11100110010";
    WAIT FOR clk_period;

    UR <= "00011011000";
    UI <= "11011110000";
    WAIT FOR clk_period;

    UR <= "00010001011";
    UI <= "11010111011";
    WAIT FOR clk_period;

    UR <= "00001000001";
    UI <= "11010010110";
    WAIT FOR clk_period;

    UR <= "11111111111";
    UI <= "11010000101";
    WAIT FOR clk_period;

    UR <= "11111001000";
    UI <= "11010001001";
    WAIT FOR clk_period;

    UR <= "11110011111";
    UI <= "11010100011";
    WAIT FOR clk_period;

    UR <= "11110000110";
    UI <= "11011010010";
    WAIT FOR clk_period;

    UR <= "11101111111";
    UI <= "11100010110";
    WAIT FOR clk_period;

    UR <= "11110001011";
    UI <= "11101101011";
    WAIT FOR clk_period;

    UR <= "11110101011";
    UI <= "11111001110";
    WAIT FOR clk_period;

    UR <= "11111011110";
    UI <= "00000111000";
    WAIT FOR clk_period;

    UR <= "00000100001";
    UI <= "00010100101";
    WAIT FOR clk_period;

    UR <= "00001110010";
    UI <= "00100001100";
    WAIT FOR clk_period;

    UR <= "00011001010";
    UI <= "00101100110";
    WAIT FOR clk_period;

    UR <= "00100100010";
    UI <= "00110101001";
    WAIT FOR clk_period;

    UR <= "00101110010";
    UI <= "00111001111";
    WAIT FOR clk_period;

    UR <= "00110110010";
    UI <= "00111010001";
    WAIT FOR clk_period;

    UR <= "00111011011";
    UI <= "00110101101";
    WAIT FOR clk_period;

    UR <= "00111101000";
    UI <= "00101100011";
    WAIT FOR clk_period;

    UR <= "00111010110";
    UI <= "00011110111";
    WAIT FOR clk_period;

    UR <= "00110100110";
    UI <= "00001110001";
    WAIT FOR clk_period;

    UR <= "00101011100";
    UI <= "11111011101";
    WAIT FOR clk_period;

    UR <= "00011111111";
    UI <= "11101001000";
    WAIT FOR clk_period;

    UR <= "00010011000";
    UI <= "11011000001";
    WAIT FOR clk_period;

    UR <= "00000110010";
    UI <= "11001010110";
    WAIT FOR clk_period;

    UR <= "11111010110";
    UI <= "11000010010";
    WAIT FOR clk_period;

    UR <= "11110001110";
    UI <= "10111111100";
    WAIT FOR clk_period;

    UR <= "11101011101";
    UI <= "11000010110";
    WAIT FOR clk_period;

    UR <= "11101001000";
    UI <= "11001011100";
    WAIT FOR clk_period;

    UR <= "11101001011";
    UI <= "11011000100";
    WAIT FOR clk_period;

    UR <= "11101100100";
    UI <= "11101000000";
    WAIT FOR clk_period;

    UR <= "11110001010";
    UI <= "11111000000";
    WAIT FOR clk_period;

    UR <= "11110110101";
    UI <= "00000110011";
    WAIT FOR clk_period;

    UR <= "11111011110";
    UI <= "00010001010";
    WAIT FOR clk_period;

    UR <= "11111111101";
    UI <= "00010111011";
    WAIT FOR clk_period;

    UR <= "00000001111";
    UI <= "00011000000";
    WAIT FOR clk_period;

    UR <= "00000010001";
    UI <= "00010011001";
    WAIT FOR clk_period;

    UR <= "00000000110";
    UI <= "00001001111";
    WAIT FOR clk_period;

    UR <= "11111110000";
    UI <= "11111101101";
    WAIT FOR clk_period;

    UR <= "11111010110";
    UI <= "11110000011";
    WAIT FOR clk_period;

    UR <= "11110111110";
    UI <= "11100100000";
    WAIT FOR clk_period;

    UR <= "11110101111";
    UI <= "11011010101";
    WAIT FOR clk_period;

    UR <= "11110101011";
    UI <= "11010101011";
    WAIT FOR clk_period;

    UR <= "11110110110";
    UI <= "11010101010";
    WAIT FOR clk_period;

    UR <= "11111001110";
    UI <= "11011010010";
    WAIT FOR clk_period;

    UR <= "11111110010";
    UI <= "11100011100";
    WAIT FOR clk_period;

    UR <= "00000011100";
    UI <= "11101111110";
    WAIT FOR clk_period;

    UR <= "00001000111";
    UI <= "11111101010";
    WAIT FOR clk_period;

    UR <= "00001101111";
    UI <= "00001010001";
    WAIT FOR clk_period;

    UR <= "00010001110";
    UI <= "00010100101";
    WAIT FOR clk_period;

    UR <= "00010100010";
    UI <= "00011011100";
    WAIT FOR clk_period;

    UR <= "00010101100";
    UI <= "00011101111";
    WAIT FOR clk_period;

    UR <= "00010101101";
    UI <= "00011011101";
    WAIT FOR clk_period;

    UR <= "00010101010";
    UI <= "00010101100";
    WAIT FOR clk_period;

    UR <= "00010100111";
    UI <= "00001100011";
    WAIT FOR clk_period;

    UR <= "00010101001";
    UI <= "00000001101";
    WAIT FOR clk_period;

    UR <= "00010110100";
    UI <= "11110110101";
    WAIT FOR clk_period;

    UR <= "00011001100";
    UI <= "11101100111";
    WAIT FOR clk_period;

    UR <= "00011110001";
    UI <= "11100101010";
    WAIT FOR clk_period;

    UR <= "00100100000";
    UI <= "11100000011";
    WAIT FOR clk_period;

    UR <= "00101010110";
    UI <= "11011110000";
    WAIT FOR clk_period;

    UR <= "00110001100";
    UI <= "11011101111";
    WAIT FOR clk_period;

    UR <= "00110111011";
    UI <= "11011111001";
    WAIT FOR clk_period;

    UR <= "00111011111";
    UI <= "11100000110";
    WAIT FOR clk_period;

    UR <= "00111110000";
    UI <= "11100001101";
    WAIT FOR clk_period;

    UR <= "00111101101";
    UI <= "11100001001";
    WAIT FOR clk_period;

    UR <= "00111010011";
    UI <= "11011110110";
    WAIT FOR clk_period;

    UR <= "00110100110";
    UI <= "11011010011";
    WAIT FOR clk_period;

    UR <= "00101101010";
    UI <= "11010100101";
    WAIT FOR clk_period;

    UR <= "00100100100";
    UI <= "11001110001";
    WAIT FOR clk_period;

    UR <= "00011011110";
    UI <= "11000111111";
    WAIT FOR clk_period;

    UR <= "00010011110";
    UI <= "11000010111";
    WAIT FOR clk_period;

    UR <= "00001101011";
    UI <= "11000000001";
    WAIT FOR clk_period;

    UR <= "00001001010";
    UI <= "11000000010";
    WAIT FOR clk_period;

    UR <= "00000111111";
    UI <= "11000011101";
    WAIT FOR clk_period;

    UR <= "00001001001";
    UI <= "11001010001";
    WAIT FOR clk_period;

    UR <= "00001100110";
    UI <= "11010011010";
    WAIT FOR clk_period;

    UR <= "00010010011";
    UI <= "11011110010";
    WAIT FOR clk_period;

    UR <= "00011001001";
    UI <= "11101010000";
    WAIT FOR clk_period;

    UR <= "00100000010";
    UI <= "11110101011";
    WAIT FOR clk_period;

    UR <= "00100110110";
    UI <= "11111111100";
    WAIT FOR clk_period;

    UR <= "00101100000";
    UI <= "00000111100";
    WAIT FOR clk_period;

    UR <= "00101111011";
    UI <= "00001100111";
    WAIT FOR clk_period;

    UR <= "00110000100";
    UI <= "00001111011";
    WAIT FOR clk_period;

    UR <= "00101111000";
    UI <= "00001111001";
    WAIT FOR clk_period;

    UR <= "00101011010";
    UI <= "00001100101";
    WAIT FOR clk_period;

    UR <= "00100101010";
    UI <= "00001000011";
    WAIT FOR clk_period;

    UR <= "00011101101";
    UI <= "00000011010";
    WAIT FOR clk_period;

    UR <= "00010100111";
    UI <= "11111101110";
    WAIT FOR clk_period;

    UR <= "00001011110";
    UI <= "11111000101";
    WAIT FOR clk_period;

    UR <= "00000011000";
    UI <= "11110100010";
    WAIT FOR clk_period;

    UR <= "11111011001";
    UI <= "11110001000";
    WAIT FOR clk_period;

    UR <= "11110101000";
    UI <= "11101110110";
    WAIT FOR clk_period;

    UR <= "11110001000";
    UI <= "11101101101";
    WAIT FOR clk_period;

    UR <= "11101111011";
    UI <= "11101101011";
    WAIT FOR clk_period;

    UR <= "11110000011";
    UI <= "11101101011";
    WAIT FOR clk_period;

    UR <= "11110100001";
    UI <= "11101101101";
    WAIT FOR clk_period;

    UR <= "11111010001";
    UI <= "11101101110";
    WAIT FOR clk_period;

    UR <= "00000010001";
    UI <= "11101101100";
    WAIT FOR clk_period;

    UR <= "00001011100";
    UI <= "11101100110";
    WAIT FOR clk_period;

    UR <= "00010101101";
    UI <= "11101011110";
    WAIT FOR clk_period;

    UR <= "00011111100";
    UI <= "11101010011";
    WAIT FOR clk_period;

    UR <= "00101000011";
    UI <= "11101001001";
    WAIT FOR clk_period;

    UR <= "00101111100";
    UI <= "11101000010";
    WAIT FOR clk_period;

    UR <= "00110100001";
    UI <= "11101000000";
    WAIT FOR clk_period;

    UR <= "00110101111";
    UI <= "11101000100";
    WAIT FOR clk_period;

    UR <= "00110100100";
    UI <= "11101010001";
    WAIT FOR clk_period;

    UR <= "00110000000";
    UI <= "11101101000";
    WAIT FOR clk_period;

    UR <= "00101000110";
    UI <= "11110000111";
    WAIT FOR clk_period;

    UR <= "00011111011";
    UI <= "11110101101";
    WAIT FOR clk_period;

    UR <= "00010100100";
    UI <= "11111011000";
    WAIT FOR clk_period;

    UR <= "00001001010";
    UI <= "00000000100";
    WAIT FOR clk_period;

    UR <= "11111110100";
    UI <= "00000101111";
    WAIT FOR clk_period;

    UR <= "11110101010";
    UI <= "00001010110";
    WAIT FOR clk_period;

    UR <= "11101110010";
    UI <= "00001110100";
    WAIT FOR clk_period;

    UR <= "11101010010";
    UI <= "00010001010";
    WAIT FOR clk_period;

    UR <= "11101001100";
    UI <= "00010010110";
    WAIT FOR clk_period;

    UR <= "11101100011";
    UI <= "00010010111";
    WAIT FOR clk_period;

    UR <= "11110010100";
    UI <= "00010010001";
    WAIT FOR clk_period;

    UR <= "11111011101";
    UI <= "00010000100";
    WAIT FOR clk_period;

    UR <= "00000110111";
    UI <= "00001110100";
    WAIT FOR clk_period;

    UR <= "00010011101";
    UI <= "00001100011";
    WAIT FOR clk_period;

    UR <= "00100000111";
    UI <= "00001010100";
    WAIT FOR clk_period;

    UR <= "00101101100";
    UI <= "00001000110";
    WAIT FOR clk_period;

    UR <= "00111000111";
    UI <= "00000111100";
    WAIT FOR clk_period;

    UR <= "01000001111";
    UI <= "00000110011";
    WAIT FOR clk_period;

    UR <= "01001000000";
    UI <= "00000101011";
    WAIT FOR clk_period;

    UR <= "01001010100";
    UI <= "00000100000";
    WAIT FOR clk_period;

    UR <= "01001001011";
    UI <= "00000010001";
    WAIT FOR clk_period;

    UR <= "01000100011";
    UI <= "11111111011";
    WAIT FOR clk_period;

    UR <= "00111011101";
    UI <= "11111011100";
    WAIT FOR clk_period;

    UR <= "00101111110";
    UI <= "11110110101";
    WAIT FOR clk_period;

    UR <= "00100001010";
    UI <= "11110001000";
    WAIT FOR clk_period;

    UR <= "00010000111";
    UI <= "11101010110";
    WAIT FOR clk_period;

    UR <= "11111111100";
    UI <= "11100100011";
    WAIT FOR clk_period;

    UR <= "11101110010";
    UI <= "11011110011";
    WAIT FOR clk_period;

    UR <= "11011110000";
    UI <= "11011001010";
    WAIT FOR clk_period;

    UR <= "11001111101";
    UI <= "11010101010";
    WAIT FOR clk_period;

    UR <= "11000011111";
    UI <= "11010010101";
    WAIT FOR clk_period;

    UR <= "10111011010";
    UI <= "11010001010";
    WAIT FOR clk_period;

    UR <= "10110110010";
    UI <= "11010001000";
    WAIT FOR clk_period;

    UR <= "10110100101";
    UI <= "11010001011";
    WAIT FOR clk_period;

    UR <= "10110110011";
    UI <= "11010010000";
    WAIT FOR clk_period;

    UR <= "10111011001";
    UI <= "11010010001";
    WAIT FOR clk_period;

    UR <= "11000010001";
    UI <= "11010001100";
    WAIT FOR clk_period;

    UR <= "11001010110";
    UI <= "11001111110";
    WAIT FOR clk_period;

    UR <= "11010100001";
    UI <= "11001101000";
    WAIT FOR clk_period;

    UR <= "11011101111";
    UI <= "11001001011";
    WAIT FOR clk_period;

    UR <= "11100111000";
    UI <= "11000101010";
    WAIT FOR clk_period;

    UR <= "11101111010";
    UI <= "11000001011";
    WAIT FOR clk_period;

    UR <= "11110110010";
    UI <= "10111110011";
    WAIT FOR clk_period;

    UR <= "11111011110";
    UI <= "10111101001";
    WAIT FOR clk_period;

    UR <= "11111111111";
    UI <= "10111110010";
    WAIT FOR clk_period;

    UR <= "00000010100";
    UI <= "11000001111";
    WAIT FOR clk_period;

    UR <= "00000100000";
    UI <= "11001000010";
    WAIT FOR clk_period;

    UR <= "00000100100";
    UI <= "11010001001";
    WAIT FOR clk_period;

    UR <= "00000100001";
    UI <= "11011100000";
    WAIT FOR clk_period;

    UR <= "00000011011";
    UI <= "11101000010";
    WAIT FOR clk_period;

    UR <= "00000010010";
    UI <= "11110101000";
    WAIT FOR clk_period;

    UR <= "00000001000";
    UI <= "00000001100";
    WAIT FOR clk_period;

    UR <= "11111111101";
    UI <= "00001101000";
    WAIT FOR clk_period;

    UR <= "11111110100";
    UI <= "00010110110";
    WAIT FOR clk_period;

    UR <= "11111101101";
    UI <= "00011110011";
    WAIT FOR clk_period;

    UR <= "11111101001";
    UI <= "00100011110";
    WAIT FOR clk_period;

    UR <= "11111101000";
    UI <= "00100110111";
    WAIT FOR clk_period;

    UR <= "11111101010";
    UI <= "00100111101";
    WAIT FOR clk_period;

    UR <= "11111110000";
    UI <= "00100110101";
    WAIT FOR clk_period;

    UR <= "11111111001";
    UI <= "00100011111";
    WAIT FOR clk_period;

    UR <= "00000000011";
    UI <= "00011111111";
    WAIT FOR clk_period;

    UR <= "00000001110";
    UI <= "00011010111";
    WAIT FOR clk_period;

    UR <= "00000010110";
    UI <= "00010101011";
    WAIT FOR clk_period;

    UR <= "00000011011";
    UI <= "00001111101";
    WAIT FOR clk_period;

    UR <= "00000011001";
    UI <= "00001010010";
    WAIT FOR clk_period;

    UR <= "00000001110";
    UI <= "00000101100";
    WAIT FOR clk_period;

    UR <= "11111111010";
    UI <= "00000010000";
    WAIT FOR clk_period;

    UR <= "11111011011";
    UI <= "00000000000";
    WAIT FOR clk_period;

    UR <= "11110110010";
    UI <= "00000000000";
    WAIT FOR clk_period;

    UR <= "11110000000";
    UI <= "00000010001";
    WAIT FOR clk_period;

    UR <= "11101000111";
    UI <= "00000110010";
    WAIT FOR clk_period;

    UR <= "11100001001";
    UI <= "00001100000";
    WAIT FOR clk_period;

    UR <= "11011001001";
    UI <= "00010010101";
    WAIT FOR clk_period;

    UR <= "11010001010";
    UI <= "00011001010";
    WAIT FOR clk_period;

    UR <= "11001001111";
    UI <= "00011110101";
    WAIT FOR clk_period;

    UR <= "11000011011";
    UI <= "00100001100";
    WAIT FOR clk_period;

    UR <= "10111110001";
    UI <= "00100000110";
    WAIT FOR clk_period;

    UR <= "10111010010";
    UI <= "00011011100";
    WAIT FOR clk_period;

    UR <= "10111000001";
    UI <= "00010001100";
    WAIT FOR clk_period;

    UR <= "10110111111";
    UI <= "00000010110";
    WAIT FOR clk_period;

    UR <= "10111001101";
    UI <= "11110000010";
    WAIT FOR clk_period;

    UR <= "10111101100";
    UI <= "11011011100";
    WAIT FOR clk_period;

    UR <= "11000011011";
    UI <= "11000110010";
    WAIT FOR clk_period;

    UR <= "11001011010";
    UI <= "10110010110";
    WAIT FOR clk_period;

    UR <= "11010101000";
    UI <= "10100011000";
    WAIT FOR clk_period;

    UR <= "11100000010";
    UI <= "10011000110";
    WAIT FOR clk_period;

    UR <= "11101100101";
    UI <= "10010101010";
    WAIT FOR clk_period;

    UR <= "11111001100";
    UI <= "10011000100";
    WAIT FOR clk_period;

    UR <= "00000110100";
    UI <= "10100010010";
    WAIT FOR clk_period;

    UR <= "00010010101";
    UI <= "10110001000";
    WAIT FOR clk_period;

    UR <= "00011101100";
    UI <= "11000010101";
    WAIT FOR clk_period;

    UR <= "00100110010";
    UI <= "11010100111";
    WAIT FOR clk_period;

    UR <= "00101100101";
    UI <= "11100101010";
    WAIT FOR clk_period;

    UR <= "00110000001";
    UI <= "11110001101";
    WAIT FOR clk_period;

    UR <= "00110000111";
    UI <= "11111000010";
    WAIT FOR clk_period;

    UR <= "00101110111";
    UI <= "11111000110";
    WAIT FOR clk_period;

    UR <= "00101010011";
    UI <= "11110011010";
    WAIT FOR clk_period;

    UR <= "00100100000";
    UI <= "11101001000";
    WAIT FOR clk_period;

    UR <= "00011100010";
    UI <= "11011011111";
    WAIT FOR clk_period;

    UR <= "00010100000";
    UI <= "11001110001";
    WAIT FOR clk_period;

    UR <= "00001011101";
    UI <= "11000010011";
    WAIT FOR clk_period;

    UR <= "00000100000";
    UI <= "10111010101";
    WAIT FOR clk_period;

    UR <= "11111101100";
    UI <= "10111000011";
    WAIT FOR clk_period;

    UR <= "11111000011";
    UI <= "10111100001";
    WAIT FOR clk_period;

    UR <= "11110101001";
    UI <= "11000101110";
    WAIT FOR clk_period;

    UR <= "11110011100";
    UI <= "11010011111";
    WAIT FOR clk_period;

    UR <= "11110011110";
    UI <= "11100100101";
    WAIT FOR clk_period;

    UR <= "11110101100";
    UI <= "11110101111";
    WAIT FOR clk_period;

    UR <= "11111000101";
    UI <= "00000101000";
    WAIT FOR clk_period;

    UR <= "11111100110";
    UI <= "00010000001";
    WAIT FOR clk_period;

    UR <= "00000001011";
    UI <= "00010101110";
    WAIT FOR clk_period;

    UR <= "00000110001";
    UI <= "00010101100";
    WAIT FOR clk_period;

    UR <= "00001010011";
    UI <= "00001111101";
    WAIT FOR clk_period;

    UR <= "00001101101";
    UI <= "00000101010";
    WAIT FOR clk_period;

    UR <= "00001111011";
    UI <= "11111000010";
    WAIT FOR clk_period;

    UR <= "00001110111";
    UI <= "11101010101";
    WAIT FOR clk_period;

    UR <= "00001011111";
    UI <= "11011110110";
    WAIT FOR clk_period;

    UR <= "00000110001";
    UI <= "11010110001";
    WAIT FOR clk_period;

    UR <= "11111101101";
    UI <= "11010010010";
    WAIT FOR clk_period;

    UR <= "11110010110";
    UI <= "11010011011";
    WAIT FOR clk_period;

    UR <= "11100101111";
    UI <= "11011001010";
    WAIT FOR clk_period;

    UR <= "11010111111";
    UI <= "11100010111";
    WAIT FOR clk_period;

    UR <= "11001010000";
    UI <= "11101110011";
    WAIT FOR clk_period;

    UR <= "10111101000";
    UI <= "11111010000";
    WAIT FOR clk_period;

    UR <= "10110010011";
    UI <= "00000100000";
    WAIT FOR clk_period;

    UR <= "10101010110";
    UI <= "00001010101";
    WAIT FOR clk_period;

    UR <= "10100111000";
    UI <= "00001100111";
    WAIT FOR clk_period;

    UR <= "10100111010";
    UI <= "00001010100";
    WAIT FOR clk_period;

    UR <= "10101011100";
    UI <= "00000011110";
    WAIT FOR clk_period;

    UR <= "10110011010";
    UI <= "11111001100";
    WAIT FOR clk_period;

    UR <= "10111101011";
    UI <= "11101101010";
    WAIT FOR clk_period;

    UR <= "11001001000";
    UI <= "11100000100";
    WAIT FOR clk_period;

    UR <= "11010100110";
    UI <= "11010101001";
    WAIT FOR clk_period;

    UR <= "11011111011";
    UI <= "11001100010";
    WAIT FOR clk_period;

    UR <= "11101000000";
    UI <= "11000111001";
    WAIT FOR clk_period;

    UR <= "11101110001";
    UI <= "11000110010";
    WAIT FOR clk_period;

    UR <= "11110001001";
    UI <= "11001001011";
    WAIT FOR clk_period;

    UR <= "11110001100";
    UI <= "11010000001";
    WAIT FOR clk_period;

    UR <= "11101111100";
    UI <= "11011001100";
    WAIT FOR clk_period;

    UR <= "11101100000";
    UI <= "11100100011";
    WAIT FOR clk_period;

    UR <= "11100111100";
    UI <= "11101111110";
    WAIT FOR clk_period;

    UR <= "11100011001";
    UI <= "11111010010";
    WAIT FOR clk_period;

    UR <= "11011111010";
    UI <= "00000011001";
    WAIT FOR clk_period;

    UR <= "11011100011";
    UI <= "00001001101";
    WAIT FOR clk_period;

    UR <= "11011010100";
    UI <= "00001101011";
    WAIT FOR clk_period;

    UR <= "11011001101";
    UI <= "00001110100";
    WAIT FOR clk_period;

    UR <= "11011001001";
    UI <= "00001101001";
    WAIT FOR clk_period;

    UR <= "11011000110";
    UI <= "00001001101";
    WAIT FOR clk_period;

    UR <= "11010111111";
    UI <= "00000100100";
    WAIT FOR clk_period;

    UR <= "11010110011";
    UI <= "11111110000";
    WAIT FOR clk_period;

    UR <= "11010100000";
    UI <= "11110110111";
    WAIT FOR clk_period;

    UR <= "11010000111";
    UI <= "11101111010";
    WAIT FOR clk_period;

    UR <= "11001101010";
    UI <= "11100111110";
    WAIT FOR clk_period;

    UR <= "11001001111";
    UI <= "11100000011";
    WAIT FOR clk_period;

    UR <= "11000111001";
    UI <= "11011001101";
    WAIT FOR clk_period;

    UR <= "11000101110";
    UI <= "11010011101";
    WAIT FOR clk_period;

    UR <= "11000110010";
    UI <= "11001110110";
    WAIT FOR clk_period;

    UR <= "11001000110";
    UI <= "11001011000";
    WAIT FOR clk_period;

    UR <= "11001101010";
    UI <= "11001000111";
    WAIT FOR clk_period;

    UR <= "11010011100";
    UI <= "11001000010";
    WAIT FOR clk_period;

    UR <= "11011010111";
    UI <= "11001001100";
    WAIT FOR clk_period;

    UR <= "11100010101";
    UI <= "11001100011";
    WAIT FOR clk_period;

    UR <= "11101001111";
    UI <= "11010000111";
    WAIT FOR clk_period;

    UR <= "11101111110";
    UI <= "11010110101";
    WAIT FOR clk_period;

    UR <= "11110011110";
    UI <= "11011101011";
    WAIT FOR clk_period;

    UR <= "11110101011";
    UI <= "11100100100";
    WAIT FOR clk_period;

    UR <= "11110100010";
    UI <= "11101011101";
    WAIT FOR clk_period;

    UR <= "11110000100";
    UI <= "11110010000";
    WAIT FOR clk_period;

    UR <= "11101010110";
    UI <= "11110111001";
    WAIT FOR clk_period;

    UR <= "11100011010";
    UI <= "11111010100";
    WAIT FOR clk_period;

    UR <= "11011010111";
    UI <= "11111100000";
    WAIT FOR clk_period;

    UR <= "11010010100";
    UI <= "11111011001";
    WAIT FOR clk_period;

    UR <= "11001010111";
    UI <= "11111000001";
    WAIT FOR clk_period;

    UR <= "11000100110";
    UI <= "11110011001";
    WAIT FOR clk_period;

    UR <= "11000000110";
    UI <= "11101100011";
    WAIT FOR clk_period;

    UR <= "10111111011";
    UI <= "11100100011";
    WAIT FOR clk_period;

    UR <= "11000000110";
    UI <= "11011011101";
    WAIT FOR clk_period;

    UR <= "11000101000";
    UI <= "11010010110";
    WAIT FOR clk_period;

    UR <= "11001100001";
    UI <= "11001010101";
    WAIT FOR clk_period;

    UR <= "11010101100";
    UI <= "11000011101";
    WAIT FOR clk_period;

    UR <= "11100000111";
    UI <= "10111110011";
    WAIT FOR clk_period;

    UR <= "11101101011";
    UI <= "10111011100";
    WAIT FOR clk_period;

    UR <= "11111010010";
    UI <= "10111011000";
    WAIT FOR clk_period;

    UR <= "00000110110";
    UI <= "10111101001";
    WAIT FOR clk_period;

    UR <= "00010001111";
    UI <= "11000001111";
    WAIT FOR clk_period;

    UR <= "00011010110";
    UI <= "11001000111";
    WAIT FOR clk_period;

    UR <= "00100000110";
    UI <= "11010001101";
    WAIT FOR clk_period;

    UR <= "00100011001";
    UI <= "11011011111";
    WAIT FOR clk_period;

    UR <= "00100001110";
    UI <= "11100110101";
    WAIT FOR clk_period;

    UR <= "00011100100";
    UI <= "11110001100";
    WAIT FOR clk_period;

    UR <= "00010011110";
    UI <= "11111011101";
    WAIT FOR clk_period;

    UR <= "00001000000";
    UI <= "00000100100";
    WAIT FOR clk_period;

    UR <= "11111010010";
    UI <= "00001011111";
    WAIT FOR clk_period;

    UR <= "11101011100";
    UI <= "00010001010";
    WAIT FOR clk_period;

    UR <= "11011101000";
    UI <= "00010100101";
    WAIT FOR clk_period;

    UR <= "11001111111";
    UI <= "00010110001";
    WAIT FOR clk_period;

    UR <= "11000101010";
    UI <= "00010101111";
    WAIT FOR clk_period;

    UR <= "10111110000";
    UI <= "00010100010";
    WAIT FOR clk_period;

    UR <= "10111010111";
    UI <= "00010001110";
    WAIT FOR clk_period;

    UR <= "10111100000";
    UI <= "00001110011";
    WAIT FOR clk_period;

    UR <= "11000001010";
    UI <= "00001010110";
    WAIT FOR clk_period;

    UR <= "11001010100";
    UI <= "00000110110";
    WAIT FOR clk_period;

    UR <= "11010110111";
    UI <= "00000010101";
    WAIT FOR clk_period;

    UR <= "11100101100";
    UI <= "11111110011";
    WAIT FOR clk_period;

    UR <= "11110101001";
    UI <= "11111001110";
    WAIT FOR clk_period;

    UR <= "00000100110";
    UI <= "11110100101";
    WAIT FOR clk_period;

    UR <= "00010011001";
    UI <= "11101111000";
    WAIT FOR clk_period;

    UR <= "00011111010";
    UI <= "11101000110";
    WAIT FOR clk_period;

    UR <= "00101000011";
    UI <= "11100001111";
    WAIT FOR clk_period;

    UR <= "00101101101";
    UI <= "11011010100";
    WAIT FOR clk_period;

    UR <= "00101110111";
    UI <= "11010011001";
    WAIT FOR clk_period;

    UR <= "00101011111";
    UI <= "11001011110";
    WAIT FOR clk_period;

    UR <= "00100100111";
    UI <= "11000101001";
    WAIT FOR clk_period;

    UR <= "00011010100";
    UI <= "10111111011";
    WAIT FOR clk_period;

    UR <= "00001101100";
    UI <= "10111011000";
    WAIT FOR clk_period;

    UR <= "11111110110";
    UI <= "10111000001";
    WAIT FOR clk_period;

    UR <= "11101111011";
    UI <= "10110110111";
    WAIT FOR clk_period;

    UR <= "11100000100";
    UI <= "10110111000";
    WAIT FOR clk_period;

    UR <= "11010011010";
    UI <= "10111000011";
    WAIT FOR clk_period;

    UR <= "11001000100";
    UI <= "10111010111";
    WAIT FOR clk_period;

    UR <= "11000001000";
    UI <= "10111101111";
    WAIT FOR clk_period;

    UR <= "10111101011";
    UI <= "11000001010";
    WAIT FOR clk_period;

    UR <= "10111101101";
    UI <= "11000101000";
    WAIT FOR clk_period;

    UR <= "11000001111";
    UI <= "11001000110";
    WAIT FOR clk_period;

    UR <= "11001001101";
    UI <= "11001101001";
    WAIT FOR clk_period;

    UR <= "11010100001";
    UI <= "11010010000";
    WAIT FOR clk_period;

    UR <= "11100000101";
    UI <= "11011000001";
    WAIT FOR clk_period;

    UR <= "11101110001";
    UI <= "11011111110";
    WAIT FOR clk_period;

    UR <= "11111011110";
    UI <= "11101001010";
    WAIT FOR clk_period;

    UR <= "00001000101";
    UI <= "11110100110";
    WAIT FOR clk_period;

    UR <= "00010011111";
    UI <= "00000001111";
    WAIT FOR clk_period;

    UR <= "00011101000";
    UI <= "00010000010";
    WAIT FOR clk_period;

    UR <= "00100011100";
    UI <= "00011111001";
    WAIT FOR clk_period;

    UR <= "00100111001";
    UI <= "00101101001";
    WAIT FOR clk_period;

    UR <= "00101000000";
    UI <= "00111001000";
    WAIT FOR clk_period;

    UR <= "00100110010";
    UI <= "01000001101";
    WAIT FOR clk_period;

    UR <= "00100010001";
    UI <= "01000101111";
    WAIT FOR clk_period;

    UR <= "00011100010";
    UI <= "01000100110";
    WAIT FOR clk_period;

    UR <= "00010100111";
    UI <= "00111110010";
    WAIT FOR clk_period;

    UR <= "00001100111";
    UI <= "00110010100";
    WAIT FOR clk_period;

    UR <= "00000100110";
    UI <= "00100010100";
    WAIT FOR clk_period;

    UR <= "11111101000";
    UI <= "00001111101";
    WAIT FOR clk_period;

    UR <= "11110110010";
    UI <= "11111011101";
    WAIT FOR clk_period;

    UR <= "11110001000";
    UI <= "11101000101";
    WAIT FOR clk_period;

    UR <= "11101101100";
    UI <= "11011000011";
    WAIT FOR clk_period;

    UR <= "11101011111";
    UI <= "11001100110";
    WAIT FOR clk_period;

    UR <= "11101100010";
    UI <= "11000110101";
    WAIT FOR clk_period;

    UR <= "11101110011";
    UI <= "11000110101";
    WAIT FOR clk_period;

    UR <= "11110001110";
    UI <= "11001100010";
    WAIT FOR clk_period;

    UR <= "11110101111";
    UI <= "11010110111";
    WAIT FOR clk_period;

    UR <= "11111010001";
    UI <= "11100100110";
    WAIT FOR clk_period;

    UR <= "11111101111";
    UI <= "11110100001";
    WAIT FOR clk_period;

    UR <= "00000000101";
    UI <= "00000011001";
    WAIT FOR clk_period;

    UR <= "00000010000";
    UI <= "00001111111";
    WAIT FOR clk_period;

    UR <= "00000001101";
    UI <= "00011001000";
    WAIT FOR clk_period;

    UR <= "11111111111";
    UI <= "00011101110";
    WAIT FOR clk_period;

    UR <= "11111101000";
    UI <= "00011110000";
    WAIT FOR clk_period;

    UR <= "11111001100";
    UI <= "00011010010";
    WAIT FOR clk_period;

    UR <= "11110110011";
    UI <= "00010011100";
    WAIT FOR clk_period;

    UR <= "11110100011";
    UI <= "00001011001";
    WAIT FOR clk_period;

    UR <= "11110100001";
    UI <= "00000010100";
    WAIT FOR clk_period;

    UR <= "11110110001";
    UI <= "11111011001";
    WAIT FOR clk_period;

    UR <= "11111010110";
    UI <= "11110110000";
    WAIT FOR clk_period;

    UR <= "00000001110";
    UI <= "11110011110";
    WAIT FOR clk_period;

    UR <= "00001010101";
    UI <= "11110100011";
    WAIT FOR clk_period;

    UR <= "00010100101";
    UI <= "11110111100";
    WAIT FOR clk_period;

    UR <= "00011110100";
    UI <= "11111100001";
    WAIT FOR clk_period;

    UR <= "00100111100";
    UI <= "00000001001";
    WAIT FOR clk_period;

    UR <= "00101110001";
    UI <= "00000101100";
    WAIT FOR clk_period;

    UR <= "00110001110";
    UI <= "00001000001";
    WAIT FOR clk_period;

    UR <= "00110001110";
    UI <= "00001000011";
    WAIT FOR clk_period;

    UR <= "00101110001";
    UI <= "00000110001";
    WAIT FOR clk_period;

    UR <= "00100111000";
    UI <= "00000001100";
    WAIT FOR clk_period;

    UR <= "00011101000";
    UI <= "11111011001";
    WAIT FOR clk_period;

    UR <= "00010001010";
    UI <= "11110100001";
    WAIT FOR clk_period;

    UR <= "00000101000";
    UI <= "11101101100";
    WAIT FOR clk_period;

    UR <= "11111001010";
    UI <= "11101000011";
    WAIT FOR clk_period;

    UR <= "11101111010";
    UI <= "11100101100";
    WAIT FOR clk_period;

    UR <= "11101000000";
    UI <= "11100101100";
    WAIT FOR clk_period;

    UR <= "11100100000";
    UI <= "11101000100";
    WAIT FOR clk_period;

    UR <= "11100011100";
    UI <= "11101110010";
    WAIT FOR clk_period;

    UR <= "11100110100";
    UI <= "11110110001";
    WAIT FOR clk_period;

    UR <= "11101100110";
    UI <= "11111111011";
    WAIT FOR clk_period;

    UR <= "11110101011";
    UI <= "00001000111";
    WAIT FOR clk_period;

    UR <= "11111111111";
    UI <= "00010001111";
    WAIT FOR clk_period;

    UR <= "00001011010";
    UI <= "00011001100";
    WAIT FOR clk_period;

    UR <= "00010110111";
    UI <= "00011111010";
    WAIT FOR clk_period;

    UR <= "00100001111";
    UI <= "00100010110";
    WAIT FOR clk_period;

    UR <= "00101011101";
    UI <= "00100011111";
    WAIT FOR clk_period;

    UR <= "00110011101";
    UI <= "00100011001";
    WAIT FOR clk_period;

    UR <= "00111001101";
    UI <= "00100000101";
    WAIT FOR clk_period;

    UR <= "00111101011";
    UI <= "00011101000";
    WAIT FOR clk_period;

    UR <= "00111110110";
    UI <= "00011000100";
    WAIT FOR clk_period;

    UR <= "00111101111";
    UI <= "00010011100";
    WAIT FOR clk_period;

    UR <= "00111011000";
    UI <= "00001110100";
    WAIT FOR clk_period;

    UR <= "00110110010";
    UI <= "00001001100";
    WAIT FOR clk_period;

    UR <= "00110000010";
    UI <= "00000100111";
    WAIT FOR clk_period;

    UR <= "00101001100";
    UI <= "00000000110";
    WAIT FOR clk_period;

    UR <= "00100010011";
    UI <= "11111101000";
    WAIT FOR clk_period;

    UR <= "00011011101";
    UI <= "11111010000";
    WAIT FOR clk_period;

    UR <= "00010101110";
    UI <= "11110111110";
    WAIT FOR clk_period;

    UR <= "00010001010";
    UI <= "11110110100";
    WAIT FOR clk_period;

    UR <= "00001110011";
    UI <= "11110110010";
    WAIT FOR clk_period;

    UR <= "00001101001";
    UI <= "11110111001";
    WAIT FOR clk_period;

    UR <= "00001101100";
    UI <= "11111001010";
    WAIT FOR clk_period;

    UR <= "00001111000";
    UI <= "11111100010";
    WAIT FOR clk_period;

    UR <= "00010001001";
    UI <= "00000000001";
    WAIT FOR clk_period;

    UR <= "00010011001";
    UI <= "00000100010";
    WAIT FOR clk_period;

    UR <= "00010100011";
    UI <= "00001000100";
    WAIT FOR clk_period;

    UR <= "00010100010";
    UI <= "00001100011";
    WAIT FOR clk_period;

    UR <= "00010010010";
    UI <= "00001111100";
    WAIT FOR clk_period;

    UR <= "00001110001";
    UI <= "00010001101";
    WAIT FOR clk_period;

    UR <= "00001000001";
    UI <= "00010010110";
    WAIT FOR clk_period;

    UR <= "00000000011";
    UI <= "00010010110";
    WAIT FOR clk_period;

    UR <= "11110111110";
    UI <= "00010010000";
    WAIT FOR clk_period;

    UR <= "11101110111";
    UI <= "00010000101";
    WAIT FOR clk_period;

    UR <= "11100110101";
    UI <= "00001110111";
    WAIT FOR clk_period;

    UR <= "11011111110";
    UI <= "00001101010";
    WAIT FOR clk_period;

    UR <= "11011011000";
    UI <= "00001011111";
    WAIT FOR clk_period;

    UR <= "11011000101";
    UI <= "00001010110";
    WAIT FOR clk_period;

    UR <= "11011000110";
    UI <= "00001001111";
    WAIT FOR clk_period;

    UR <= "11011011000";
    UI <= "00001001010";
    WAIT FOR clk_period;

    UR <= "11011111000";
    UI <= "00001000101";
    WAIT FOR clk_period;

    UR <= "11100011110";
    UI <= "00000111110";
    WAIT FOR clk_period;

    UR <= "11101000101";
    UI <= "00000110100";
    WAIT FOR clk_period;

    UR <= "11101100110";
    UI <= "00000100101";
    WAIT FOR clk_period;

    UR <= "11101111100";
    UI <= "00000010011";
    WAIT FOR clk_period;

    UR <= "11110000100";
    UI <= "11111111111";
    WAIT FOR clk_period;

    UR <= "11101111101";
    UI <= "11111101011";
    WAIT FOR clk_period;

    UR <= "11101101000";
    UI <= "11111011001";
    WAIT FOR clk_period;

    UR <= "11101001011";
    UI <= "11111001101";
    WAIT FOR clk_period;

    UR <= "11100101011";
    UI <= "11111001010";
    WAIT FOR clk_period;

    UR <= "11100001110";
    UI <= "11111001111";
    WAIT FOR clk_period;

    UR <= "11011111010";
    UI <= "11111011110";
    WAIT FOR clk_period;

    UR <= "11011110100";
    UI <= "11111110101";
    WAIT FOR clk_period;

    UR <= "11011111110";
    UI <= "00000010010";
    WAIT FOR clk_period;

    UR <= "11100011001";
    UI <= "00000110001";
    WAIT FOR clk_period;

    UR <= "11101000010";
    UI <= "00001001111";
    WAIT FOR clk_period;

    UR <= "11101110110";
    UI <= "00001100111";
    WAIT FOR clk_period;

    UR <= "11110101110";
    UI <= "00001110111";
    WAIT FOR clk_period;

    UR <= "11111100101";
    UI <= "00001111101";
    WAIT FOR clk_period;

    UR <= "00000010100";
    UI <= "00001110110";
    WAIT FOR clk_period;

    UR <= "00000110111";
    UI <= "00001100010";
    WAIT FOR clk_period;

    UR <= "00001001010";
    UI <= "00001000100";
    WAIT FOR clk_period;

    UR <= "00001001110";
    UI <= "00000011011";
    WAIT FOR clk_period;

    UR <= "00001000100";
    UI <= "11111101011";
    WAIT FOR clk_period;

    UR <= "00000110000";
    UI <= "11110110110";
    WAIT FOR clk_period;

    UR <= "00000011000";
    UI <= "11101111111";
    WAIT FOR clk_period;

    UR <= "00000000001";
    UI <= "11101001001";
    WAIT FOR clk_period;

    UR <= "11111110000";
    UI <= "11100010110";
    WAIT FOR clk_period;

    UR <= "11111101001";
    UI <= "11011101011";
    WAIT FOR clk_period;

    UR <= "11111101110";
    UI <= "11011001001";
    WAIT FOR clk_period;

    UR <= "11111111101";
    UI <= "11010110101";
    WAIT FOR clk_period;

    UR <= "00000010100";
    UI <= "11010110001";
    WAIT FOR clk_period;

    UR <= "00000101110";
    UI <= "11011000001";
    WAIT FOR clk_period;

    UR <= "00001000110";
    UI <= "11011100110";
    WAIT FOR clk_period;

    UR <= "00001010110";
    UI <= "11100100001";
    WAIT FOR clk_period;

    UR <= "00001011010";
    UI <= "11101110000";
    WAIT FOR clk_period;

    UR <= "00001010000";
    UI <= "11111010000";
    WAIT FOR clk_period;

    UR <= "00000111001";
    UI <= "00000111100";
    WAIT FOR clk_period;

    UR <= "00000011000";
    UI <= "00010101100";
    WAIT FOR clk_period;

    UR <= "11111110010";
    UI <= "00100011000";
    WAIT FOR clk_period;

    UR <= "11111010000";
    UI <= "00101110101";
    WAIT FOR clk_period;

    UR <= "11110111000";
    UI <= "00110111100";
    WAIT FOR clk_period;

    UR <= "11110110010";
    UI <= "00111100100";
    WAIT FOR clk_period;

    UR <= "11111000001";
    UI <= "00111101010";
    WAIT FOR clk_period;

    UR <= "11111101000";
    UI <= "00111001100";
    WAIT FOR clk_period;

    UR <= "00000100011";
    UI <= "00110001100";
    WAIT FOR clk_period;

    UR <= "00001101110";
    UI <= "00100110001";
    WAIT FOR clk_period;

    UR <= "00011000000";
    UI <= "00011000011";
    WAIT FOR clk_period;

    UR <= "00100001101";
    UI <= "00001001110";
    WAIT FOR clk_period;

    UR <= "00101001011";
    UI <= "11111011101";
    WAIT FOR clk_period;

    UR <= "00101110001";
    UI <= "11101111100";
    WAIT FOR clk_period;

    UR <= "00101110111";
    UI <= "11100110011";
    WAIT FOR clk_period;

    UR <= "00101011011";
    UI <= "11100001001";
    WAIT FOR clk_period;

    UR <= "00100011101";
    UI <= "11100000000";
    WAIT FOR clk_period;

    UR <= "00011000101";
    UI <= "11100010101";
    WAIT FOR clk_period;

    UR <= "00001011101";
    UI <= "11101000101";
    WAIT FOR clk_period;

    UR <= "11111110000";
    UI <= "11110000111";
    WAIT FOR clk_period;

    UR <= "11110001011";
    UI <= "11111010000";
    WAIT FOR clk_period;

    UR <= "11100111011";
    UI <= "00000010110";
    WAIT FOR clk_period;

    UR <= "11100001010";
    UI <= "00001010001";
    WAIT FOR clk_period;

    UR <= "11011111100";
    UI <= "00001111001";
    WAIT FOR clk_period;

    UR <= "11100010011";
    UI <= "00010001001";
    WAIT FOR clk_period;

    UR <= "11101001100";
    UI <= "00010000001";
    WAIT FOR clk_period;

    UR <= "11110011101";
    UI <= "00001100010";
    WAIT FOR clk_period;

    UR <= "11111111100";
    UI <= "00000110001";
    WAIT FOR clk_period;

    UR <= "00001011101";
    UI <= "11111110110";
    WAIT FOR clk_period;

    UR <= "00010110100";
    UI <= "11110110111";
    WAIT FOR clk_period;

    UR <= "00011110111";
    UI <= "11101111101";
    WAIT FOR clk_period;

    UR <= "00100011111";
    UI <= "11101001111";
    WAIT FOR clk_period;

    UR <= "00100100111";
    UI <= "11100110011";
    WAIT FOR clk_period;

    UR <= "00100010001";
    UI <= "11100101101";
    WAIT FOR clk_period;

    UR <= "00011011111";
    UI <= "11100111101";
    WAIT FOR clk_period;

    UR <= "00010011001";
    UI <= "11101100100";
    WAIT FOR clk_period;

    UR <= "00001000110";
    UI <= "11110011111";
    WAIT FOR clk_period;

    UR <= "11111101111";
    UI <= "11111101001";
    WAIT FOR clk_period;

    UR <= "11110011100";
    UI <= "00000111101";
    WAIT FOR clk_period;

    UR <= "11101010101";
    UI <= "00010010100";
    WAIT FOR clk_period;

    UR <= "11100011111";
    UI <= "00011101000";
    WAIT FOR clk_period;

    UR <= "11011111110";
    UI <= "00100110011";
    WAIT FOR clk_period;

    UR <= "11011110011";
    UI <= "00101110000";
    WAIT FOR clk_period;

    UR <= "11100000000";
    UI <= "00110011000";
    WAIT FOR clk_period;

    UR <= "11100100011";
    UI <= "00110101010";
    WAIT FOR clk_period;

    UR <= "11101011001";
    UI <= "00110100011";
    WAIT FOR clk_period;

    UR <= "11110011111";
    UI <= "00110000001";
    WAIT FOR clk_period;

    UR <= "11111110001";
    UI <= "00101001000";
    WAIT FOR clk_period;

    UR <= "00001001001";
    UI <= "00011111000";
    WAIT FOR clk_period;

    UR <= "00010100010";
    UI <= "00010011000";
    WAIT FOR clk_period;

    UR <= "00011110101";
    UI <= "00000101101";
    WAIT FOR clk_period;

    UR <= "00100111011";
    UI <= "11110111111";
    WAIT FOR clk_period;

    UR <= "00101101110";
    UI <= "11101010100";
    WAIT FOR clk_period;

    UR <= "00110001000";
    UI <= "11011110101";
    WAIT FOR clk_period;

    UR <= "00110000101";
    UI <= "11010101001";
    WAIT FOR clk_period;

    UR <= "00101100110";
    UI <= "11001110101";
    WAIT FOR clk_period;

    UR <= "00100101011";
    UI <= "11001011101";
    WAIT FOR clk_period;

    UR <= "00011011010";
    UI <= "11001100010";
    WAIT FOR clk_period;

    UR <= "00001111100";
    UI <= "11010000011";
    WAIT FOR clk_period;

    UR <= "00000011010";
    UI <= "11010111100";
    WAIT FOR clk_period;

    UR <= "11111000000";
    UI <= "11100000111";
    WAIT FOR clk_period;

    UR <= "11101111000";
    UI <= "11101011100";
    WAIT FOR clk_period;

    UR <= "11101001101";
    UI <= "11110110101";
    WAIT FOR clk_period;

    UR <= "11101000100";
    UI <= "00000000111";
    WAIT FOR clk_period;

    UR <= "11101011101";
    UI <= "00001001100";
    WAIT FOR clk_period;

    UR <= "11110010101";
    UI <= "00001111110";
    WAIT FOR clk_period;

    UR <= "11111100101";
    UI <= "00010011001";
    WAIT FOR clk_period;

    UR <= "00001000010";
    UI <= "00010011100";
    WAIT FOR clk_period;

    UR <= "00010011101";
    UI <= "00010001001";
    WAIT FOR clk_period;

    UR <= "00011101011";
    UI <= "00001100001";
    WAIT FOR clk_period;

    UR <= "00100011110";
    UI <= "00000101011";
    WAIT FOR clk_period;

    UR <= "00100110001";
    UI <= "11111101101";
    WAIT FOR clk_period;

    UR <= "00100100000";
    UI <= "11110101100";
    WAIT FOR clk_period;

    UR <= "00011101101";
    UI <= "11101101111";
    WAIT FOR clk_period;

    UR <= "00010100000";
    UI <= "11100111010";
    WAIT FOR clk_period;

    UR <= "00001000101";
    UI <= "11100010010";
    WAIT FOR clk_period;

    UR <= "11111101001";
    UI <= "11011111001";
    WAIT FOR clk_period;

    UR <= "11110011010";
    UI <= "11011110000";
    WAIT FOR clk_period;

    UR <= "11101100101";
    UI <= "11011110110";
    WAIT FOR clk_period;

    UR <= "11101010001";
    UI <= "11100001011";
    WAIT FOR clk_period;

    UR <= "11101100010";
    UI <= "11100101110";
    WAIT FOR clk_period;

    UR <= "11110010110";
    UI <= "11101011011";
    WAIT FOR clk_period;

    UR <= "11111100101";
    UI <= "11110010010";
    WAIT FOR clk_period;

    UR <= "00001000011";
    UI <= "11111010001";
    WAIT FOR clk_period;

    UR <= "00010100011";
    UI <= "00000010110";
    WAIT FOR clk_period;

    UR <= "00011110101";
    UI <= "00001100000";
    WAIT FOR clk_period;

    UR <= "00100101011";
    UI <= "00010101100";
    WAIT FOR clk_period;

    UR <= "00100111100";
    UI <= "00011110111";
    WAIT FOR clk_period;

    UR <= "00100100011";
    UI <= "00100111111";
    WAIT FOR clk_period;

    UR <= "00011011101";
    UI <= "00101111110";
    WAIT FOR clk_period;

    UR <= "00001101111";
    UI <= "00110110000";
    WAIT FOR clk_period;

    UR <= "11111100011";
    UI <= "00111010000";
    WAIT FOR clk_period;

    UR <= "11101000011";
    UI <= "00111011011";
    WAIT FOR clk_period;

    UR <= "11010011101";
    UI <= "00111001101";
    WAIT FOR clk_period;

    UR <= "10111111110";
    UI <= "00110100110";
    WAIT FOR clk_period;

    UR <= "10101110010";
    UI <= "00101101000";
    WAIT FOR clk_period;

    UR <= "10100000010";
    UI <= "00100010110";
    WAIT FOR clk_period;

    UR <= "10010110101";
    UI <= "00010111000";
    WAIT FOR clk_period;

    UR <= "10010001101";
    UI <= "00001010111";
    WAIT FOR clk_period;

    UR <= "10010001010";
    UI <= "11111111100";
    WAIT FOR clk_period;

    UR <= "10010101011";
    UI <= "11110110011";
    WAIT FOR clk_period;

    UR <= "10011101100";
    UI <= "11110000100";
    WAIT FOR clk_period;

    UR <= "10101000110";
    UI <= "11101110101";
    WAIT FOR clk_period;

    UR <= "10110110110";
    UI <= "11110001000";
    WAIT FOR clk_period;

    UR <= "11000110101";
    UI <= "11110111101";
    WAIT FOR clk_period;

    UR <= "11010111111";
    UI <= "00000001100";
    WAIT FOR clk_period;

    UR <= "11101001110";
    UI <= "00001101101";
    WAIT FOR clk_period;

    UR <= "11111011111";
    UI <= "00011010011";
    WAIT FOR clk_period;

    UR <= "00001101100";
    UI <= "00100110010";
    WAIT FOR clk_period;

    UR <= "00011110001";
    UI <= "00101111100";
    WAIT FOR clk_period;

    UR <= "00101101010";
    UI <= "00110101000";
    WAIT FOR clk_period;

    UR <= "00111010010";
    UI <= "00110110001";
    WAIT FOR clk_period;

    UR <= "01000100110";
    UI <= "00110010100";
    WAIT FOR clk_period;

    UR <= "01001100011";
    UI <= "00101010110";
    WAIT FOR clk_period;

    UR <= "01010000110";
    UI <= "00100000001";
    WAIT FOR clk_period;

    UR <= "01010001111";
    UI <= "00010011111";
    WAIT FOR clk_period;

    UR <= "01010000001";
    UI <= "00001000001";
    WAIT FOR clk_period;

    UR <= "01001011101";
    UI <= "11111110011";
    WAIT FOR clk_period;

    UR <= "01000101000";
    UI <= "11111000011";
    WAIT FOR clk_period;

    UR <= "00111101001";
    UI <= "11110110111";
    WAIT FOR clk_period;

    UR <= "00110100100";
    UI <= "11111010011";
    WAIT FOR clk_period;

    UR <= "00101100001";
    UI <= "00000010101";
    WAIT FOR clk_period;

    UR <= "00100100101";
    UI <= "00001110101";
    WAIT FOR clk_period;

    UR <= "00011110011";
    UI <= "00011100110";
    WAIT FOR clk_period;

    UR <= "00011001111";
    UI <= "00101011011";
    WAIT FOR clk_period;

    UR <= "00010111010";
    UI <= "00111000100";
    WAIT FOR clk_period;

    UR <= "00010110010";
    UI <= "01000010100";
    WAIT FOR clk_period;

    UR <= "00010110101";
    UI <= "01001000001";
    WAIT FOR clk_period;

    UR <= "00011000001";
    UI <= "01001001000";
    WAIT FOR clk_period;

    UR <= "00011010000";
    UI <= "01000100111";
    WAIT FOR clk_period;

    UR <= "00011011110";
    UI <= "00111100110";
    WAIT FOR clk_period;

    UR <= "00011101001";
    UI <= "00110001101";
    WAIT FOR clk_period;

    UR <= "00011101011";
    UI <= "00100101010";
    WAIT FOR clk_period;

    UR <= "00011100011";
    UI <= "00011001001";
    WAIT FOR clk_period;

    UR <= "00011001111";
    UI <= "00001111000";
    WAIT FOR clk_period;

    UR <= "00010110000";
    UI <= "00001000000";
    WAIT FOR clk_period;

    UR <= "00010000110";
    UI <= "00000100100";
    WAIT FOR clk_period;

    UR <= "00001010100";
    UI <= "00000100111";
    WAIT FOR clk_period;

    UR <= "00000011010";
    UI <= "00001000010";
    WAIT FOR clk_period;

    UR <= "11111011101";
    UI <= "00001101110";
    WAIT FOR clk_period;

    UR <= "11110011111";
    UI <= "00010100000";
    WAIT FOR clk_period;

    UR <= "11101100011";
    UI <= "00011001101";
    WAIT FOR clk_period;

    UR <= "11100101100";
    UI <= "00011101010";
    WAIT FOR clk_period;

    UR <= "11011111100";
    UI <= "00011110000";
    WAIT FOR clk_period;

    UR <= "11011010100";
    UI <= "00011011011";
    WAIT FOR clk_period;

    UR <= "11010110111";
    UI <= "00010101011";
    WAIT FOR clk_period;

    UR <= "11010100110";
    UI <= "00001100101";
    WAIT FOR clk_period;

    UR <= "11010100000";
    UI <= "00000010001";
    WAIT FOR clk_period;

    UR <= "11010100101";
    UI <= "11110111001";
    WAIT FOR clk_period;

    UR <= "11010110100";
    UI <= "11101100110";
    WAIT FOR clk_period;

    UR <= "11011001011";
    UI <= "11100100100";
    WAIT FOR clk_period;

    UR <= "11011100111";
    UI <= "11011110111";
    WAIT FOR clk_period;

    UR <= "11100000110";
    UI <= "11011100110";
    WAIT FOR clk_period;

    UR <= "11100100100";
    UI <= "11011101110";
    WAIT FOR clk_period;

    UR <= "11100111110";
    UI <= "11100001110";
    WAIT FOR clk_period;

    UR <= "11101001111";
    UI <= "11100111111";
    WAIT FOR clk_period;

    UR <= "11101011000";
    UI <= "11101111001";
    WAIT FOR clk_period;

    UR <= "11101010100";
    UI <= "11110110010";
    WAIT FOR clk_period;

    UR <= "11101000110";
    UI <= "11111100101";
    WAIT FOR clk_period;

    UR <= "11100101110";
    UI <= "00000001011";
    WAIT FOR clk_period;

    UR <= "11100010001";
    UI <= "00000100001";
    WAIT FOR clk_period;

    UR <= "11011110001";
    UI <= "00000100111";
    WAIT FOR clk_period;

    UR <= "11011010110";
    UI <= "00000100000";
    WAIT FOR clk_period;

    UR <= "11011000100";
    UI <= "00000010010";
    WAIT FOR clk_period;

    UR <= "11011000011";
    UI <= "00000000010";
    WAIT FOR clk_period;

    UR <= "11011010101";
    UI <= "11111110101";
    WAIT FOR clk_period;

    UR <= "11011111111";
    UI <= "11111110001";
    WAIT FOR clk_period;

    UR <= "11101000000";
    UI <= "11111111001";
    WAIT FOR clk_period;

    UR <= "11110010111";
    UI <= "00000001100";
    WAIT FOR clk_period;

    UR <= "11111111110";
    UI <= "00000101000";
    WAIT FOR clk_period;

    UR <= "00001101110";
    UI <= "00001001001";
    WAIT FOR clk_period;

    UR <= "00011011111";
    UI <= "00001101000";
    WAIT FOR clk_period;

    UR <= "00101000111";
    UI <= "00010000000";
    WAIT FOR clk_period;

    UR <= "00110011101";
    UI <= "00010001010";
    WAIT FOR clk_period;

    UR <= "00111011010";
    UI <= "00010000100";
    WAIT FOR clk_period;

    UR <= "00111110110";
    UI <= "00001101100";
    WAIT FOR clk_period;

    UR <= "00111110001";
    UI <= "00001000100";
    WAIT FOR clk_period;

    UR <= "00111001010";
    UI <= "00000010010";
    WAIT FOR clk_period;

    UR <= "00110000110";
    UI <= "11111011011";
    WAIT FOR clk_period;

    UR <= "00100101100";
    UI <= "11110101000";
    WAIT FOR clk_period;

    UR <= "00011000100";
    UI <= "11110000011";
    WAIT FOR clk_period;

    UR <= "00001011000";
    UI <= "11101110001";
    WAIT FOR clk_period;

    UR <= "11111110000";
    UI <= "11101111000";
    WAIT FOR clk_period;

    UR <= "11110010101";
    UI <= "11110011000";
    WAIT FOR clk_period;

    UR <= "11101001101";
    UI <= "11111010001";
    WAIT FOR clk_period;

    UR <= "11100011001";
    UI <= "00000011101";
    WAIT FOR clk_period;

    UR <= "11011111100";
    UI <= "00001110011";
    WAIT FOR clk_period;

    UR <= "11011110010";
    UI <= "00011001010";
    WAIT FOR clk_period;

    UR <= "11011111000";
    UI <= "00100011000";
    WAIT FOR clk_period;

    UR <= "11100001001";
    UI <= "00101010010";
    WAIT FOR clk_period;

    UR <= "11100100001";
    UI <= "00101110001";
    WAIT FOR clk_period;

    UR <= "11100111011";
    UI <= "00101110010";
    WAIT FOR clk_period;

    UR <= "11101010101";
    UI <= "00101010011";
    WAIT FOR clk_period;

    UR <= "11101101110";
    UI <= "00100010111";
    WAIT FOR clk_period;

    UR <= "11110000110";
    UI <= "00011000101";
    WAIT FOR clk_period;

    UR <= "11110011110";
    UI <= "00001100100";
    WAIT FOR clk_period;

    UR <= "11110111000";
    UI <= "11111111111";
    WAIT FOR clk_period;

    UR <= "11111010111";
    UI <= "11110011111";
    WAIT FOR clk_period;

    UR <= "11111111011";
    UI <= "11101001100";
    WAIT FOR clk_period;

    UR <= "00000100111";
    UI <= "11100001100";
    WAIT FOR clk_period;

    UR <= "00001011001";
    UI <= "11011100100";
    WAIT FOR clk_period;

    UR <= "00010001111";
    UI <= "11011010100";
    WAIT FOR clk_period;

    UR <= "00011000110";
    UI <= "11011011011";
    WAIT FOR clk_period;

    UR <= "00011111010";
    UI <= "11011110100";
    WAIT FOR clk_period;

    UR <= "00100101001";
    UI <= "11100011010";
    WAIT FOR clk_period;

    UR <= "00101001111";
    UI <= "11101001000";
    WAIT FOR clk_period;

    UR <= "00101101000";
    UI <= "11101110111";
    WAIT FOR clk_period;

    UR <= "00101110101";
    UI <= "11110100010";
    WAIT FOR clk_period;

    UR <= "00101110011";
    UI <= "11111000111";
    WAIT FOR clk_period;

    UR <= "00101100101";
    UI <= "11111100010";
    WAIT FOR clk_period;

    UR <= "00101001100";
    UI <= "11111110011";
    WAIT FOR clk_period;

    UR <= "00100101001";
    UI <= "11111111010";
    WAIT FOR clk_period;

    UR <= "00011111111";
    UI <= "11111111001";
    WAIT FOR clk_period;

    UR <= "00011010001";
    UI <= "11111110010";
    WAIT FOR clk_period;

    UR <= "00010011111";
    UI <= "11111101000";
    WAIT FOR clk_period;

    UR <= "00001101110";
    UI <= "11111011101";
    WAIT FOR clk_period;

    UR <= "00000111110";
    UI <= "11111010100";
    WAIT FOR clk_period;

    UR <= "00000010001";
    UI <= "11111010000";
    WAIT FOR clk_period;

    UR <= "11111101011";
    UI <= "11111010011";
    WAIT FOR clk_period;

    UR <= "11111001101";
    UI <= "11111100000";
    WAIT FOR clk_period;

    UR <= "11110111001";
    UI <= "11111110111";
    WAIT FOR clk_period;

    UR <= "11110110010";
    UI <= "00000011001";
    WAIT FOR clk_period;

    UR <= "11110111001";
    UI <= "00001000111";
    WAIT FOR clk_period;

    UR <= "11111001101";
    UI <= "00010000000";
    WAIT FOR clk_period;

    UR <= "11111101101";
    UI <= "00010111111";
    WAIT FOR clk_period;

    UR <= "00000010111";
    UI <= "00100000011";
    WAIT FOR clk_period;

    UR <= "00001000110";
    UI <= "00101000101";
    WAIT FOR clk_period;

    UR <= "00001110100";
    UI <= "00110000000";
    WAIT FOR clk_period;

    UR <= "00010011001";
    UI <= "00110101111";
    WAIT FOR clk_period;

    UR <= "00010110010";
    UI <= "00111001100";
    WAIT FOR clk_period;

    UR <= "00010110111";
    UI <= "00111010011";
    WAIT FOR clk_period;

    UR <= "00010100101";
    UI <= "00111000010";
    WAIT FOR clk_period;

    UR <= "00001111101";
    UI <= "00110011010";
    WAIT FOR clk_period;

    UR <= "00001000000";
    UI <= "00101011100";
    WAIT FOR clk_period;

    UR <= "11111110011";
    UI <= "00100001111";
    WAIT FOR clk_period;

    UR <= "11110011110";
    UI <= "00010111001";
    WAIT FOR clk_period;

    UR <= "11101001010";
    UI <= "00001100011";
    WAIT FOR clk_period;

    UR <= "11100000001";
    UI <= "00000010100";
    WAIT FOR clk_period;

    UR <= "11011001011";
    UI <= "11111010110";
    WAIT FOR clk_period;

    UR <= "11010101110";
    UI <= "11110101100";
    WAIT FOR clk_period;

    UR <= "11010101111";
    UI <= "11110011010";
    WAIT FOR clk_period;

    UR <= "11011001011";
    UI <= "11110011111";
    WAIT FOR clk_period;

    UR <= "11100000001";
    UI <= "11110111010";
    WAIT FOR clk_period;

    UR <= "11101001001";
    UI <= "11111100010";
    WAIT FOR clk_period;

    UR <= "11110011001";
    UI <= "00000010010";
    WAIT FOR clk_period;

    UR <= "11111101010";
    UI <= "00001000001";
    WAIT FOR clk_period;

    UR <= "00000110001";
    UI <= "00001100111";
    WAIT FOR clk_period;

    UR <= "00001100111";
    UI <= "00001111110";
    WAIT FOR clk_period;

    UR <= "00010001000";
    UI <= "00010000001";
    WAIT FOR clk_period;

    UR <= "00010010100";
    UI <= "00001110001";
    WAIT FOR clk_period;

    UR <= "00010001110";
    UI <= "00001001101";
    WAIT FOR clk_period;

    UR <= "00001111001";
    UI <= "00000011011";
    WAIT FOR clk_period;

    UR <= "00001011111";
    UI <= "11111100001";
    WAIT FOR clk_period;

    UR <= "00001000110";
    UI <= "11110100101";
    WAIT FOR clk_period;

    UR <= "00000110110";
    UI <= "11101101110";
    WAIT FOR clk_period;

    UR <= "00000110101";
    UI <= "11101000010";
    WAIT FOR clk_period;

    UR <= "00001000011";
    UI <= "11100100101";
    WAIT FOR clk_period;

    UR <= "00001100010";
    UI <= "11100011000";
    WAIT FOR clk_period;

    UR <= "00010001011";
    UI <= "11100011100";
    WAIT FOR clk_period;

    UR <= "00010111010";
    UI <= "11100101110";
    WAIT FOR clk_period;

    UR <= "00011100111";
    UI <= "11101001011";
    WAIT FOR clk_period;

    UR <= "00100001010";
    UI <= "11101101110";
    WAIT FOR clk_period;

    UR <= "00100011101";
    UI <= "11110010011";
    WAIT FOR clk_period;

    UR <= "00100011100";
    UI <= "11110110110";
    WAIT FOR clk_period;

    UR <= "00100000111";
    UI <= "11111010101";
    WAIT FOR clk_period;

    UR <= "00011100001";
    UI <= "11111101110";
    WAIT FOR clk_period;

    UR <= "00010101110";
    UI <= "00000000011";
    WAIT FOR clk_period;

    UR <= "00001111001";
    UI <= "00000010011";
    WAIT FOR clk_period;

    UR <= "00001001000";
    UI <= "00000100010";
    WAIT FOR clk_period;

    UR <= "00000100100";
    UI <= "00000110001";
    WAIT FOR clk_period;

    UR <= "00000010100";
    UI <= "00001000000";
    WAIT FOR clk_period;

    UR <= "00000011100";
    UI <= "00001010010";
    WAIT FOR clk_period;

    UR <= "00000111011";
    UI <= "00001100100";
    WAIT FOR clk_period;

    UR <= "00001101100";
    UI <= "00001110110";
    WAIT FOR clk_period;

    UR <= "00010101011";
    UI <= "00010000110";
    WAIT FOR clk_period;

    UR <= "00011101100";
    UI <= "00010010001";
    WAIT FOR clk_period;

    UR <= "00100100110";
    UI <= "00010010011";
    WAIT FOR clk_period;

    UR <= "00101001111";
    UI <= "00010001100";
    WAIT FOR clk_period;

    UR <= "00101100000";
    UI <= "00001111010";
    WAIT FOR clk_period;

    UR <= "00101010101";
    UI <= "00001011110";
    WAIT FOR clk_period;

    UR <= "00100101110";
    UI <= "00000111001";
    WAIT FOR clk_period;

    UR <= "00011101111";
    UI <= "00000001110";
    WAIT FOR clk_period;

    UR <= "00010011111";
    UI <= "11111100001";
    WAIT FOR clk_period;

    UR <= "00001001000";
    UI <= "11110110110";
    WAIT FOR clk_period;

    UR <= "11111110110";
    UI <= "11110010001";
    WAIT FOR clk_period;

    UR <= "11110110100";
    UI <= "11101110101";
    WAIT FOR clk_period;

    UR <= "11110001011";
    UI <= "11101100110";
    WAIT FOR clk_period;

    UR <= "11101111111";
    UI <= "11101100100";
    WAIT FOR clk_period;

    UR <= "11110010010";
    UI <= "11101101110";
    WAIT FOR clk_period;

    UR <= "11111000001";
    UI <= "11110000100";
    WAIT FOR clk_period;

    UR <= "00000000101";
    UI <= "11110100010";
    WAIT FOR clk_period;

    UR <= "00001010101";
    UI <= "11111000110";
    WAIT FOR clk_period;

    UR <= "00010100101";
    UI <= "11111101110";
    WAIT FOR clk_period;

    UR <= "00011101000";
    UI <= "00000010101";
    WAIT FOR clk_period;

    UR <= "00100010111";
    UI <= "00000111001";
    WAIT FOR clk_period;

    UR <= "00100101001";
    UI <= "00001011001";
    WAIT FOR clk_period;

    UR <= "00100011100";
    UI <= "00001110011";
    WAIT FOR clk_period;

    UR <= "00011110010";
    UI <= "00010001001";
    WAIT FOR clk_period;

    UR <= "00010110000";
    UI <= "00010011010";
    WAIT FOR clk_period;

    UR <= "00001011111";
    UI <= "00010100110";
    WAIT FOR clk_period;

    UR <= "00000001010";
    UI <= "00010101111";
    WAIT FOR clk_period;

    UR <= "11110111101";
    UI <= "00010110101";
    WAIT FOR clk_period;

    UR <= "11110000001";
    UI <= "00010111010";
    WAIT FOR clk_period;

    UR <= "11101011110";
    UI <= "00010111100";
    WAIT FOR clk_period;

    UR <= "11101011001";
    UI <= "00010111101";
    WAIT FOR clk_period;

    UR <= "11101110010";
    UI <= "00010111101";
    WAIT FOR clk_period;

    UR <= "11110100111";
    UI <= "00010111011";
    WAIT FOR clk_period;

    UR <= "11111110001";
    UI <= "00010111000";
    WAIT FOR clk_period;

    UR <= "00001000111";
    UI <= "00010110101";
    WAIT FOR clk_period;

    UR <= "00010100000";
    UI <= "00010110010";
    WAIT FOR clk_period;

    UR <= "00011110100";
    UI <= "00010110001";
    WAIT FOR clk_period;

    UR <= "00100111010";
    UI <= "00010110001";
    WAIT FOR clk_period;

    UR <= "00101101101";
    UI <= "00010110100";
    WAIT FOR clk_period;

    UR <= "00110001010";
    UI <= "00010111001";
    WAIT FOR clk_period;

    UR <= "00110010001";
    UI <= "00010111111";
    WAIT FOR clk_period;

    UR <= "00110000101";
    UI <= "00011000100";
    WAIT FOR clk_period;

    UR <= "00101101001";
    UI <= "00011000111";
    WAIT FOR clk_period;

    UR <= "00101000010";
    UI <= "00011000100";
    WAIT FOR clk_period;

    UR <= "00100010100";
    UI <= "00010111001";
    WAIT FOR clk_period;

    UR <= "00011100100";
    UI <= "00010100110";
    WAIT FOR clk_period;

    UR <= "00010110100";
    UI <= "00010001000";
    WAIT FOR clk_period;

    UR <= "00010000101";
    UI <= "00001100010";
    WAIT FOR clk_period;

    UR <= "00001010111";
    UI <= "00000110011";
    WAIT FOR clk_period;

    UR <= "00000101011";
    UI <= "00000000001";
    WAIT FOR clk_period;

    UR <= "00000000000";
    UI <= "11111001110";
    WAIT FOR clk_period;

    UR <= "11111010101";
    UI <= "11110011110";
    WAIT FOR clk_period;

    UR <= "11110101100";
    UI <= "11101110110";
    WAIT FOR clk_period;

    UR <= "11110000101";
    UI <= "11101010111";
    WAIT FOR clk_period;

    UR <= "11101100010";
    UI <= "11101000010";
    WAIT FOR clk_period;

    UR <= "11101001000";
    UI <= "11100110101";
    WAIT FOR clk_period;

    UR <= "11100111010";
    UI <= "11100101111";
    WAIT FOR clk_period;

    UR <= "11100111011";
    UI <= "11100101010";
    WAIT FOR clk_period;

    UR <= "11101001101";
    UI <= "11100100010";
    WAIT FOR clk_period;

    UR <= "11101110010";
    UI <= "11100010011";
    WAIT FOR clk_period;

    UR <= "11110101000";
    UI <= "11011111000";
    WAIT FOR clk_period;

    UR <= "11111101100";
    UI <= "11011010001";
    WAIT FOR clk_period;

    UR <= "00000111010";
    UI <= "11010100001";
    WAIT FOR clk_period;

    UR <= "00010001101";
    UI <= "11001101011";
    WAIT FOR clk_period;

    UR <= "00011011101";
    UI <= "11000110110";
    WAIT FOR clk_period;

    UR <= "00100100101";
    UI <= "11000001101";
    WAIT FOR clk_period;

    UR <= "00101011110";
    UI <= "10111111000";
    WAIT FOR clk_period;

    UR <= "00110000100";
    UI <= "10111111111";
    WAIT FOR clk_period;

    UR <= "00110010100";
    UI <= "11000101001";
    WAIT FOR clk_period;

    UR <= "00110001100";
    UI <= "11001110111";
    WAIT FOR clk_period;

    UR <= "00101101101";
    UI <= "11011101000";
    WAIT FOR clk_period;

    UR <= "00100111010";
    UI <= "11101110101";
    WAIT FOR clk_period;

    UR <= "00011110110";
    UI <= "00000010011";
    WAIT FOR clk_period;

    UR <= "00010100110";
    UI <= "00010110100";
    WAIT FOR clk_period;

    UR <= "00001010000";
    UI <= "00101001001";
    WAIT FOR clk_period;

    UR <= "11111111001";
    UI <= "00111000011";
    WAIT FOR clk_period;

    UR <= "11110101000";
    UI <= "01000010111";
    WAIT FOR clk_period;

    UR <= "11101011111";
    UI <= "01000111100";
    WAIT FOR clk_period;

    UR <= "11100100101";
    UI <= "01000101111";
    WAIT FOR clk_period;

    UR <= "11011111011";
    UI <= "00111110100";
    WAIT FOR clk_period;

    UR <= "11011100101";
    UI <= "00110010010";
    WAIT FOR clk_period;

    UR <= "11011100010";
    UI <= "00100010101";
    WAIT FOR clk_period;

    UR <= "11011110010";
    UI <= "00010001100";
    WAIT FOR clk_period;

    UR <= "11100010101";
    UI <= "00000000100";
    WAIT FOR clk_period;

    UR <= "11101000110";
    UI <= "11110001011";
    WAIT FOR clk_period;

    UR <= "11110000010";
    UI <= "11100101011";
    WAIT FOR clk_period;

    UR <= "11111000101";
    UI <= "11011101010";
    WAIT FOR clk_period;

    UR <= "00000001001";
    UI <= "11011001001";
    WAIT FOR clk_period;

    UR <= "00001001001";
    UI <= "11011000100";
    WAIT FOR clk_period;

    UR <= "00010000000";
    UI <= "11011010100";
    WAIT FOR clk_period;

    UR <= "00010101010";
    UI <= "11011110001";
    WAIT FOR clk_period;

    UR <= "00011000010";
    UI <= "11100010000";
    WAIT FOR clk_period;

    UR <= "00011001001";
    UI <= "11100101001";
    WAIT FOR clk_period;

    UR <= "00010111100";
    UI <= "11100110101";
    WAIT FOR clk_period;

    UR <= "00010011110";
    UI <= "11100110010";
    WAIT FOR clk_period;

    UR <= "00001110001";
    UI <= "11100100001";
    WAIT FOR clk_period;

    UR <= "00000111010";
    UI <= "11100000110";
    WAIT FOR clk_period;

    UR <= "11111111101";
    UI <= "11011100111";
    WAIT FOR clk_period;

    UR <= "11110111110";
    UI <= "11011001101";
    WAIT FOR clk_period;

    UR <= "11110000100";
    UI <= "11010111111";
    WAIT FOR clk_period;

    UR <= "11101010010";
    UI <= "11011000101";
    WAIT FOR clk_period;

    UR <= "11100101011";
    UI <= "11011100010";
    WAIT FOR clk_period;

    UR <= "11100010010";
    UI <= "11100010111";
    WAIT FOR clk_period;

    UR <= "11100001000";
    UI <= "11101100010";
    WAIT FOR clk_period;

    UR <= "11100001101";
    UI <= "11110111101";
    WAIT FOR clk_period;

    UR <= "11100011111";
    UI <= "00000100001";
    WAIT FOR clk_period;

    UR <= "11100111110";
    UI <= "00010000101";
    WAIT FOR clk_period;

    UR <= "11101100110";
    UI <= "00011100001";
    WAIT FOR clk_period;

    UR <= "11110010101";
    UI <= "00100101011";
    WAIT FOR clk_period;

    UR <= "11111000111";
    UI <= "00101011101";
    WAIT FOR clk_period;

    UR <= "11111111000";
    UI <= "00101110101";
    WAIT FOR clk_period;

    UR <= "00000100110";
    UI <= "00101110000";
    WAIT FOR clk_period;

    UR <= "00001001101";
    UI <= "00101001111";
    WAIT FOR clk_period;

    UR <= "00001101010";
    UI <= "00100010111";
    WAIT FOR clk_period;

    UR <= "00001111010";
    UI <= "00011001101";
    WAIT FOR clk_period;

    UR <= "00001111101";
    UI <= "00001110101";
    WAIT FOR clk_period;

    UR <= "00001110000";
    UI <= "00000011000";
    WAIT FOR clk_period;

    UR <= "00001010110";
    UI <= "11110111011";
    WAIT FOR clk_period;

    UR <= "00000101111";
    UI <= "11101100011";
    WAIT FOR clk_period;

    UR <= "00000000000";
    UI <= "11100010101";
    WAIT FOR clk_period;

    UR <= "11111001100";
    UI <= "11011010100";
    WAIT FOR clk_period;

    UR <= "11110011001";
    UI <= "11010100100";
    WAIT FOR clk_period;

    UR <= "11101101100";
    UI <= "11010000101";
    WAIT FOR clk_period;

    UR <= "11101001011";
    UI <= "11001111000";
    WAIT FOR clk_period;

    UR <= "11100111000";
    UI <= "11001111011";
    WAIT FOR clk_period;

    UR <= "11100111000";
    UI <= "11010001110";
    WAIT FOR clk_period;

    UR <= "11101001010";
    UI <= "11010101111";
    WAIT FOR clk_period;

    UR <= "11101101110";
    UI <= "11011011010";
    WAIT FOR clk_period;

    UR <= "11110100000";
    UI <= "11100001100";
    WAIT FOR clk_period;

    UR <= "11111011101";
    UI <= "11101000001";
    WAIT FOR clk_period;

    UR <= "00000011110";
    UI <= "11101110110";
    WAIT FOR clk_period;

    UR <= "00001011110";
    UI <= "11110100110";
    WAIT FOR clk_period;

    UR <= "00010011001";
    UI <= "11111001101";
    WAIT FOR clk_period;

    UR <= "00011001010";
    UI <= "11111100111";
    WAIT FOR clk_period;

    UR <= "00011101111";
    UI <= "11111110011";
    WAIT FOR clk_period;

    UR <= "00100001000";
    UI <= "11111101110";
    WAIT FOR clk_period;

    UR <= "00100010101";
    UI <= "11111011001";
    WAIT FOR clk_period;

    UR <= "00100011000";
    UI <= "11110110011";
    WAIT FOR clk_period;

    UR <= "00100010101";
    UI <= "11101111111";
    WAIT FOR clk_period;

    UR <= "00100001111";
    UI <= "11101000000";
    WAIT FOR clk_period;

    UR <= "00100000111";
    UI <= "11011111100";
    WAIT FOR clk_period;

    UR <= "00011111111";
    UI <= "11010110111";
    WAIT FOR clk_period;

    UR <= "00011111000";
    UI <= "11001110111";
    WAIT FOR clk_period;

    UR <= "00011110000";
    UI <= "11001000010";
    WAIT FOR clk_period;

    UR <= "00011100110";
    UI <= "11000011111";
    WAIT FOR clk_period;

    UR <= "00011010110";
    UI <= "11000010010";
    WAIT FOR clk_period;

    UR <= "00010111111";
    UI <= "11000011110";
    WAIT FOR clk_period;

    UR <= "00010011111";
    UI <= "11001000101";
    WAIT FOR clk_period;

    UR <= "00001110100";
    UI <= "11010000111";
    WAIT FOR clk_period;

    UR <= "00001000000";
    UI <= "11011100010";
    WAIT FOR clk_period;

    UR <= "00000000100";
    UI <= "11101010000";
    WAIT FOR clk_period;

    UR <= "11111000100";
    UI <= "11111001010";
    WAIT FOR clk_period;

    UR <= "11110000001";
    UI <= "00001000111";
    WAIT FOR clk_period;

    UR <= "11101000010";
    UI <= "00010111100";
    WAIT FOR clk_period;

    UR <= "11100001001";
    UI <= "00100100001";
    WAIT FOR clk_period;

    UR <= "11011011001";
    UI <= "00101101011";
    WAIT FOR clk_period;

    UR <= "11010110100";
    UI <= "00110010100";
    WAIT FOR clk_period;

    UR <= "11010011101";
    UI <= "00110010111";
    WAIT FOR clk_period;

    UR <= "11010010011";
    UI <= "00101110011";
    WAIT FOR clk_period;

    UR <= "11010010111";
    UI <= "00100101011";
    WAIT FOR clk_period;

    UR <= "11010101001";
    UI <= "00011000011";
    WAIT FOR clk_period;

    UR <= "11011001000";
    UI <= "00001000111";
    WAIT FOR clk_period;

    UR <= "11011110101";
    UI <= "11111000000";
    WAIT FOR clk_period;

    UR <= "11100101110";
    UI <= "11100111011";
    WAIT FOR clk_period;

    UR <= "11101110011";
    UI <= "11011000011";
    WAIT FOR clk_period;

    UR <= "11111000010";
    UI <= "11001100010";
    WAIT FOR clk_period;

    UR <= "00000010111";
    UI <= "11000011111";
    WAIT FOR clk_period;

    UR <= "00001101101";
    UI <= "10111111110";
    WAIT FOR clk_period;

    UR <= "00010111110";
    UI <= "10111111110";
    WAIT FOR clk_period;

    UR <= "00100000011";
    UI <= "11000011101";
    WAIT FOR clk_period;

    UR <= "00100110101";
    UI <= "11001010011";
    WAIT FOR clk_period;

    UR <= "00101001011";
    UI <= "11010011011";
    WAIT FOR clk_period;

    UR <= "00101000010";
    UI <= "11011101010";
    WAIT FOR clk_period;

    UR <= "00100010111";
    UI <= "11100111010";
    WAIT FOR clk_period;

    UR <= "00011001100";
    UI <= "11110000100";
    WAIT FOR clk_period;

    UR <= "00001101000";
    UI <= "11111000011";
    WAIT FOR clk_period;

    UR <= "11111110110";
    UI <= "11111110111";
    WAIT FOR clk_period;

    UR <= "11110000010";
    UI <= "00000100000";
    WAIT FOR clk_period;

    UR <= "11100011100";
    UI <= "00001000000";
    WAIT FOR clk_period;

    UR <= "11011010100";
    UI <= "00001011010";
    WAIT FOR clk_period;

    UR <= "11010110110";
    UI <= "00001110001";
    WAIT FOR clk_period;

    UR <= "11011001001";
    UI <= "00010001000";
    WAIT FOR clk_period;

    UR <= "11100001110";
    UI <= "00010100000";
    WAIT FOR clk_period;

    UR <= "11110000001";
    UI <= "00010110111";
    WAIT FOR clk_period;

    UR <= "00000010100";
    UI <= "00011001100";
    WAIT FOR clk_period;

    UR <= "00010110110";
    UI <= "00011011100";
    WAIT FOR clk_period;

    UR <= "00101010010";
    UI <= "00011100001";
    WAIT FOR clk_period;

    UR <= "00111010100";
    UI <= "00011011010";
    WAIT FOR clk_period;

    UR <= "01000101001";
    UI <= "00011000100";
    WAIT FOR clk_period;

    UR <= "01001000110";
    UI <= "00010011111";
    WAIT FOR clk_period;

    UR <= "01000100110";
    UI <= "00001101101";
    WAIT FOR clk_period;

    UR <= "00111001111";
    UI <= "00000110010";
    WAIT FOR clk_period;

    UR <= "00101001101";
    UI <= "11111110011";
    WAIT FOR clk_period;

    UR <= "00010110100";
    UI <= "11110111000";
    WAIT FOR clk_period;

    UR <= "00000011100";
    UI <= "11110001000";
    WAIT FOR clk_period;

    UR <= "11110011101";
    UI <= "11101100111";
    WAIT FOR clk_period;

    UR <= "11101001011";
    UI <= "11101011100";
    WAIT FOR clk_period;

    UR <= "11100110100";
    UI <= "11101100111";
    WAIT FOR clk_period;

    UR <= "11101011100";
    UI <= "11110001000";
    WAIT FOR clk_period;

    UR <= "11110111101";
    UI <= "11110111101";
    WAIT FOR clk_period;

    UR <= "00001001000";
    UI <= "11111111111";
    WAIT FOR clk_period;

    UR <= "00011100110";
    UI <= "00001001010";
    WAIT FOR clk_period;

    UR <= "00101111010";
    UI <= "00010010110";
    WAIT FOR clk_period;

    UR <= "00111101011";
    UI <= "00011011101";
    WAIT FOR clk_period;

    UR <= "01000100010";
    UI <= "00100011100";
    WAIT FOR clk_period;

    UR <= "01000001111";
    UI <= "00101001101";
    WAIT FOR clk_period;

    UR <= "00110101111";
    UI <= "00101110001";
    WAIT FOR clk_period;

    UR <= "00100001001";
    UI <= "00110001000";
    WAIT FOR clk_period;

    UR <= "00000101111";
    UI <= "00110010100";
    WAIT FOR clk_period;

    UR <= "11100111100";
    UI <= "00110010111";
    WAIT FOR clk_period;

    UR <= "11001001100";
    UI <= "00110010101";
    WAIT FOR clk_period;

    UR <= "10110000000";
    UI <= "00110001111";
    WAIT FOR clk_period;

    UR <= "10011110001";
    UI <= "00110001010";
    WAIT FOR clk_period;

    UR <= "10010110000";
    UI <= "00110000101";
    WAIT FOR clk_period;

    UR <= "10011000110";
    UI <= "00110000010";
    WAIT FOR clk_period;

    UR <= "10100101101";
    UI <= "00110000001";
    WAIT FOR clk_period;

    UR <= "10111010110";
    UI <= "00110000001";
    WAIT FOR clk_period;

    UR <= "11010101010";
    UI <= "00110000010";
    WAIT FOR clk_period;

    UR <= "11110001100";
    UI <= "00110000100";
    WAIT FOR clk_period;

    UR <= "00001011111";
    UI <= "00110000111";
    WAIT FOR clk_period;

    UR <= "00100001011";
    UI <= "00110001010";
    WAIT FOR clk_period;

    UR <= "00101111111";
    UI <= "00110001101";
    WAIT FOR clk_period;

    UR <= "00110110000";
    UI <= "00110010000";
    WAIT FOR clk_period;

    UR <= "00110100010";
    UI <= "00110010011";
    WAIT FOR clk_period;

    UR <= "00101011110";
    UI <= "00110010011";
    WAIT FOR clk_period;

    UR <= "00011110111";
    UI <= "00110001111";
    WAIT FOR clk_period;

    UR <= "00010000010";
    UI <= "00110000100";
    WAIT FOR clk_period;

    UR <= "00000010100";
    UI <= "00101101110";
    WAIT FOR clk_period;

    UR <= "11111000001";
    UI <= "00101001101";
    WAIT FOR clk_period;

    UR <= "11110010011";
    UI <= "00100011110";
    WAIT FOR clk_period;

    UR <= "11110010010";
    UI <= "00011100100";
    WAIT FOR clk_period;

    UR <= "11110111001";
    UI <= "00010011110";
    WAIT FOR clk_period;

    UR <= "00000000001";
    UI <= "00001010011";
    WAIT FOR clk_period;

    UR <= "00001011010";
    UI <= "00000000110";
    WAIT FOR clk_period;

    UR <= "00010110111";
    UI <= "11110111111";
    WAIT FOR clk_period;

    UR <= "00100000110";
    UI <= "11110000011";
    WAIT FOR clk_period;

    UR <= "00100111011";
    UI <= "11101010111";
    WAIT FOR clk_period;

    UR <= "00101010000";
    UI <= "11100111111";
    WAIT FOR clk_period;

    UR <= "00101000001";
    UI <= "11100111010";
    WAIT FOR clk_period;

    UR <= "00100010001";
    UI <= "11101000110";
    WAIT FOR clk_period;

    UR <= "00011001001";
    UI <= "11101011110";
    WAIT FOR clk_period;

    UR <= "00001110100";
    UI <= "11101111100";
    WAIT FOR clk_period;

    UR <= "00000011011";
    UI <= "11110010110";
    WAIT FOR clk_period;

    UR <= "11111001011";
    UI <= "11110100110";
    WAIT FOR clk_period;

    UR <= "11110001011";
    UI <= "11110100110";
    WAIT FOR clk_period;

    UR <= "11101100011";
    UI <= "11110010010";
    WAIT FOR clk_period;

    UR <= "11101010010";
    UI <= "11101101101";
    WAIT FOR clk_period;

    UR <= "11101011011";
    UI <= "11100111001";
    WAIT FOR clk_period;

    UR <= "11101111000";
    UI <= "11011111111";
    WAIT FOR clk_period;

    UR <= "11110100111";
    UI <= "11011001001";
    WAIT FOR clk_period;

    UR <= "11111100010";
    UI <= "11010100010";
    WAIT FOR clk_period;

    UR <= "00000100100";
    UI <= "11010010011";
    WAIT FOR clk_period;

    UR <= "00001101010";
    UI <= "11010100101";
    WAIT FOR clk_period;

    UR <= "00010101111";
    UI <= "11011011011";
    WAIT FOR clk_period;

    UR <= "00011101111";
    UI <= "11100110101";
    WAIT FOR clk_period;

    UR <= "00100101000";
    UI <= "11110101101";
    WAIT FOR clk_period;

    UR <= "00101010110";
    UI <= "00000111010";
    WAIT FOR clk_period;

    UR <= "00101110100";
    UI <= "00011001111";
    WAIT FOR clk_period;

    UR <= "00101111111";
    UI <= "00101011110";
    WAIT FOR clk_period;

    UR <= "00101110100";
    UI <= "00111011001";
    WAIT FOR clk_period;

    UR <= "00101010000";
    UI <= "01000110110";
    WAIT FOR clk_period;

    UR <= "00100010100";
    UI <= "01001101101";
    WAIT FOR clk_period;

    UR <= "00011000010";
    UI <= "01001111011";
    WAIT FOR clk_period;

    UR <= "00001011111";
    UI <= "01001100011";
    WAIT FOR clk_period;

    UR <= "11111110101";
    UI <= "01000101010";
    WAIT FOR clk_period;

    UR <= "11110001101";
    UI <= "00111011001";
    WAIT FOR clk_period;

    UR <= "11100110011";
    UI <= "00101111110";
    WAIT FOR clk_period;

    UR <= "11011110000";
    UI <= "00100100011";
    WAIT FOR clk_period;

    UR <= "11011001110";
    UI <= "00011010010";
    WAIT FOR clk_period;

    UR <= "11011010001";
    UI <= "00010010100";
    WAIT FOR clk_period;

    UR <= "11011110111";
    UI <= "00001101100";
    WAIT FOR clk_period;

    UR <= "11100111101";
    UI <= "00001011100";
    WAIT FOR clk_period;

    UR <= "11110011000";
    UI <= "00001100000";
    WAIT FOR clk_period;

    UR <= "11111111010";
    UI <= "00001110100";
    WAIT FOR clk_period;

    UR <= "00001010111";
    UI <= "00010001111";
    WAIT FOR clk_period;

    UR <= "00010011110";
    UI <= "00010101011";
    WAIT FOR clk_period;

    UR <= "00011000111";
    UI <= "00011000001";
    WAIT FOR clk_period;

    UR <= "00011001001";
    UI <= "00011001100";
    WAIT FOR clk_period;

    UR <= "00010100100";
    UI <= "00011001000";
    WAIT FOR clk_period;

    UR <= "00001011100";
    UI <= "00010110100";
    WAIT FOR clk_period;

    UR <= "11111111100";
    UI <= "00010010000";
    WAIT FOR clk_period;

    UR <= "11110010010";
    UI <= "00001100000";
    WAIT FOR clk_period;

    UR <= "11100101101";
    UI <= "00000100101";
    WAIT FOR clk_period;

    UR <= "11011011101";
    UI <= "11111100011";
    WAIT FOR clk_period;

    UR <= "11010101111";
    UI <= "11110011111";
    WAIT FOR clk_period;

    UR <= "11010101101";
    UI <= "11101011011";
    WAIT FOR clk_period;

    UR <= "11011011000";
    UI <= "11100011101";
    WAIT FOR clk_period;

    UR <= "11100101110";
    UI <= "11011100110";
    WAIT FOR clk_period;

    UR <= "11110101000";
    UI <= "11010111010";
    WAIT FOR clk_period;

    UR <= "00000111010";
    UI <= "11010011101";
    WAIT FOR clk_period;

    UR <= "00011010110";
    UI <= "11010001111";
    WAIT FOR clk_period;

    UR <= "00101101100";
    UI <= "11010010011";
    WAIT FOR clk_period;

    UR <= "00111101110";
    UI <= "11010101001";
    WAIT FOR clk_period;

    UR <= "01001010100";
    UI <= "11011010001";
    WAIT FOR clk_period;

    UR <= "01010010100";
    UI <= "11100001000";
    WAIT FOR clk_period;

    UR <= "01010101100";
    UI <= "11101001001";
    WAIT FOR clk_period;

    UR <= "01010011110";
    UI <= "11110001111";
    WAIT FOR clk_period;

    UR <= "01001101101";
    UI <= "11111010010";
    WAIT FOR clk_period;

    UR <= "01000100001";
    UI <= "00000001011";
    WAIT FOR clk_period;

    UR <= "00111000000";
    UI <= "00000110010";
    WAIT FOR clk_period;

    UR <= "00101010101";
    UI <= "00001000001";
    WAIT FOR clk_period;

    UR <= "00011100101";
    UI <= "00000110100";
    WAIT FOR clk_period;

    UR <= "00001111001";
    UI <= "00000001101";
    WAIT FOR clk_period;

    UR <= "00000010101";
    UI <= "11111001101";
    WAIT FOR clk_period;

    UR <= "11110111101";
    UI <= "11101111100";
    WAIT FOR clk_period;

    UR <= "11101110110";
    UI <= "11100100010";
    WAIT FOR clk_period;

    UR <= "11100111111";
    UI <= "11011001011";
    WAIT FOR clk_period;

    UR <= "11100011011";
    UI <= "11010000000";
    WAIT FOR clk_period;

    UR <= "11100001001";
    UI <= "11001001101";
    WAIT FOR clk_period;

    UR <= "11100000111";
    UI <= "11000110111";
    WAIT FOR clk_period;

    UR <= "11100010100";
    UI <= "11001000011";
    WAIT FOR clk_period;

    UR <= "11100101100";
    UI <= "11001110000";
    WAIT FOR clk_period;

    UR <= "11101001011";
    UI <= "11010111010";
    WAIT FOR clk_period;

    UR <= "11101101011";
    UI <= "11100011001";
    WAIT FOR clk_period;

    UR <= "11110000111";
    UI <= "11110000100";
    WAIT FOR clk_period;

    UR <= "11110011100";
    UI <= "11111110000";
    WAIT FOR clk_period;

    UR <= "11110100100";
    UI <= "00001010101";
    WAIT FOR clk_period;

    UR <= "11110011111";
    UI <= "00010101001";
    WAIT FOR clk_period;

    UR <= "11110001101";
    UI <= "00011101000";
    WAIT FOR clk_period;

    UR <= "11101110001";
    UI <= "00100010000";
    WAIT FOR clk_period;

    UR <= "11101010000";
    UI <= "00100100100";
    WAIT FOR clk_period;

    UR <= "11100110010";
    UI <= "00100100111";
    WAIT FOR clk_period;

    UR <= "11100011110";
    UI <= "00100011110";
    WAIT FOR clk_period;

    UR <= "11100011011";
    UI <= "00100010000";
    WAIT FOR clk_period;

    UR <= "11100110001";
    UI <= "00100000011";
    WAIT FOR clk_period;

    UR <= "11101100010";
    UI <= "00011111011";
    WAIT FOR clk_period;

    UR <= "11110101111";
    UI <= "00011111010";
    WAIT FOR clk_period;

    UR <= "00000010100";
    UI <= "00011111111";
    WAIT FOR clk_period;

    UR <= "00010001011";
    UI <= "00100001001";
    WAIT FOR clk_period;

    UR <= "00100001011";
    UI <= "00100010011";
    WAIT FOR clk_period;

    UR <= "00110001001";
    UI <= "00100011001";
    WAIT FOR clk_period;

    UR <= "00111111001";
    UI <= "00100010111";
    WAIT FOR clk_period;

    UR <= "01001010011";
    UI <= "00100001001";
    WAIT FOR clk_period;

    UR <= "01010001110";
    UI <= "00011101100";
    WAIT FOR clk_period;

    UR <= "01010100111";
    UI <= "00011000010";
    WAIT FOR clk_period;

    UR <= "01010011011";
    UI <= "00010001010";
    WAIT FOR clk_period;

    UR <= "01001110000";
    UI <= "00001001010";
    WAIT FOR clk_period;

    UR <= "01000101010";
    UI <= "00000000100";
    WAIT FOR clk_period;

    UR <= "00111010010";
    UI <= "11110111101";
    WAIT FOR clk_period;

    UR <= "00101110010";
    UI <= "11101111010";
    WAIT FOR clk_period;

    UR <= "00100010100";
    UI <= "11101000000";
    WAIT FOR clk_period;

    UR <= "00011000001";
    UI <= "11100010001";
    WAIT FOR clk_period;

    UR <= "00001111111";
    UI <= "11011110000";
    WAIT FOR clk_period;

    UR <= "00001010011";
    UI <= "11011011110";
    WAIT FOR clk_period;

    UR <= "00000111111";
    UI <= "11011011100";
    WAIT FOR clk_period;

    UR <= "00001000011";
    UI <= "11011101010";
    WAIT FOR clk_period;

    UR <= "00001011100";
    UI <= "11100000110";
    WAIT FOR clk_period;

    UR <= "00010000111";
    UI <= "11100101111";
    WAIT FOR clk_period;

    UR <= "00010111110";
    UI <= "11101100010";
    WAIT FOR clk_period;

    UR <= "00011111101";
    UI <= "11110011110";
    WAIT FOR clk_period;

    UR <= "00100111110";
    UI <= "11111011110";
    WAIT FOR clk_period;

    UR <= "00101111100";
    UI <= "00000011111";
    WAIT FOR clk_period;

    UR <= "00110110011";
    UI <= "00001011110";
    WAIT FOR clk_period;

    UR <= "00111011110";
    UI <= "00010010110";
    WAIT FOR clk_period;

    UR <= "00111111011";
    UI <= "00011000011";
    WAIT FOR clk_period;

    UR <= "01000001000";
    UI <= "00011100011";
    WAIT FOR clk_period;

    UR <= "01000000010";
    UI <= "00011110100";
    WAIT FOR clk_period;

    UR <= "00111101010";
    UI <= "00011110100";
    WAIT FOR clk_period;

    UR <= "00111000001";
    UI <= "00011100101";
    WAIT FOR clk_period;

    UR <= "00110001001";
    UI <= "00011001001";
    WAIT FOR clk_period;

    UR <= "00101000100";
    UI <= "00010100011";
    WAIT FOR clk_period;

    UR <= "00011110111";
    UI <= "00001111001";
    WAIT FOR clk_period;

    UR <= "00010100111";
    UI <= "00001001110";
    WAIT FOR clk_period;

    UR <= "00001011001";
    UI <= "00000101001";
    WAIT FOR clk_period;

    UR <= "00000010010";
    UI <= "00000001101";
    WAIT FOR clk_period;

    UR <= "11111010110";
    UI <= "11111111110";
    WAIT FOR clk_period;

    UR <= "11110101001";
    UI <= "11111111111";
    WAIT FOR clk_period;

    UR <= "11110001100";
    UI <= "00000010000";
    WAIT FOR clk_period;

    UR <= "11110000000";
    UI <= "00000110001";
    WAIT FOR clk_period;

    UR <= "11110000101";
    UI <= "00001011111";
    WAIT FOR clk_period;

    UR <= "11110010111";
    UI <= "00010011000";
    WAIT FOR clk_period;

    UR <= "11110110101";
    UI <= "00011011001";
    WAIT FOR clk_period;

    UR <= "11111011001";
    UI <= "00100011101";
    WAIT FOR clk_period;

    UR <= "00000000010";
    UI <= "00101100001";
    WAIT FOR clk_period;

    UR <= "00000101010";
    UI <= "00110100001";
    WAIT FOR clk_period;

    UR <= "00001010000";
    UI <= "00111011001";
    WAIT FOR clk_period;

    UR <= "00001110001";
    UI <= "01000000110";
    WAIT FOR clk_period;

    UR <= "00010001101";
    UI <= "01000100101";
    WAIT FOR clk_period;

    UR <= "00010100011";
    UI <= "01000110100";
    WAIT FOR clk_period;

    UR <= "00010110010";
    UI <= "01000110010";
    WAIT FOR clk_period;

    UR <= "00010111101";
    UI <= "01000011101";
    WAIT FOR clk_period;

    UR <= "00011000010";
    UI <= "00111111000";
    WAIT FOR clk_period;

    UR <= "00011000100";
    UI <= "00111000011";
    WAIT FOR clk_period;

    UR <= "00011000100";
    UI <= "00110000011";
    WAIT FOR clk_period;

    UR <= "00011000001";
    UI <= "00100111100";
    WAIT FOR clk_period;

    UR <= "00010111110";
    UI <= "00011110101";
    WAIT FOR clk_period;

    UR <= "00010111010";
    UI <= "00010110100";
    WAIT FOR clk_period;

    UR <= "00010111000";
    UI <= "00001111101";
    WAIT FOR clk_period;

    UR <= "00010110111";
    UI <= "00001010110";
    WAIT FOR clk_period;

    UR <= "00010110111";
    UI <= "00001000001";
    WAIT FOR clk_period;

    UR <= "00010111001";
    UI <= "00000111101";
    WAIT FOR clk_period;

    UR <= "00010111010";
    UI <= "00001001001";
    WAIT FOR clk_period;

    UR <= "00010111010";
    UI <= "00001011111";
    WAIT FOR clk_period;

    UR <= "00010110110";
    UI <= "00001110111";
    WAIT FOR clk_period;

    UR <= "00010101011";
    UI <= "00010001010";
    WAIT FOR clk_period;

    UR <= "00010010111";
    UI <= "00010010001";
    WAIT FOR clk_period;

    UR <= "00001111001";
    UI <= "00010000100";
    WAIT FOR clk_period;

    UR <= "00001010001";
    UI <= "00001100010";
    WAIT FOR clk_period;

    UR <= "00000100000";
    UI <= "00000101000";
    WAIT FOR clk_period;

    UR <= "11111101010";
    UI <= "11111011100";
    WAIT FOR clk_period;

    UR <= "11110110101";
    UI <= "11110000100";
    WAIT FOR clk_period;

    UR <= "11110000111";
    UI <= "11100101010";
    WAIT FOR clk_period;

    UR <= "11101100111";
    UI <= "11011011001";
    WAIT FOR clk_period;

    UR <= "11101011101";
    UI <= "11010011100";
    WAIT FOR clk_period;

    UR <= "11101101110";
    UI <= "11001111110";
    WAIT FOR clk_period;

    UR <= "11110011100";
    UI <= "11010000011";
    WAIT FOR clk_period;

    UR <= "11111101000";
    UI <= "11010110000";
    WAIT FOR clk_period;

    UR <= "00001001011";
    UI <= "11100000001";
    WAIT FOR clk_period;

    UR <= "00011000000";
    UI <= "11101110001";
    WAIT FOR clk_period;

    UR <= "00100111001";
    UI <= "11111110111";
    WAIT FOR clk_period;

    UR <= "00110101011";
    UI <= "00010000110";
    WAIT FOR clk_period;

    UR <= "01000001001";
    UI <= "00100010100";
    WAIT FOR clk_period;

    UR <= "01001000110";
    UI <= "00110010100";
    WAIT FOR clk_period;

    UR <= "01001011100";
    UI <= "00111111110";
    WAIT FOR clk_period;

    UR <= "01001000110";
    UI <= "01001001100";
    WAIT FOR clk_period;

    UR <= "01000000111";
    UI <= "01001111100";
    WAIT FOR clk_period;

    UR <= "00110100101";
    UI <= "01010010000";
    WAIT FOR clk_period;

    UR <= "00100101100";
    UI <= "01010001100";
    WAIT FOR clk_period;

    UR <= "00010101001";
    UI <= "01001110101";
    WAIT FOR clk_period;

    UR <= "00000101011";
    UI <= "01001010100";
    WAIT FOR clk_period;

    UR <= "11111000001";
    UI <= "01000101111";
    WAIT FOR clk_period;

    UR <= "11101110101";
    UI <= "01000001010";
    WAIT FOR clk_period;

    UR <= "11101001100";
    UI <= "00111101010";
    WAIT FOR clk_period;

    UR <= "11101001001";
    UI <= "00111010000";
    WAIT FOR clk_period;

    UR <= "11101100110";
    UI <= "00110111100";
    WAIT FOR clk_period;

    UR <= "11110011001";
    UI <= "00110101011";
    WAIT FOR clk_period;

    UR <= "11111011000";
    UI <= "00110011100";
    WAIT FOR clk_period;

    UR <= "00000010101";
    UI <= "00110001011";
    WAIT FOR clk_period;

    UR <= "00001000100";
    UI <= "00101110110";
    WAIT FOR clk_period;

    UR <= "00001011101";
    UI <= "00101011100";
    WAIT FOR clk_period;

    UR <= "00001011100";
    UI <= "00100111100";
    WAIT FOR clk_period;

    UR <= "00001000001";
    UI <= "00100010101";
    WAIT FOR clk_period;

    UR <= "00000010011";
    UI <= "00011101010";
    WAIT FOR clk_period;

    UR <= "11111011010";
    UI <= "00010111010";
    WAIT FOR clk_period;

    UR <= "11110100100";
    UI <= "00010001000";
    WAIT FOR clk_period;

    UR <= "11101111100";
    UI <= "00001010101";
    WAIT FOR clk_period;

    UR <= "11101101011";
    UI <= "00000100000";
    WAIT FOR clk_period;

    UR <= "11101111001";
    UI <= "11111101100";
    WAIT FOR clk_period;

    UR <= "11110100101";
    UI <= "11110111001";
    WAIT FOR clk_period;

    UR <= "11111101101";
    UI <= "11110001000";
    WAIT FOR clk_period;

    UR <= "00001000110";
    UI <= "11101011100";
    WAIT FOR clk_period;

    UR <= "00010100110";
    UI <= "11100111000";
    WAIT FOR clk_period;

    UR <= "00011111110";
    UI <= "11100011110";
    WAIT FOR clk_period;

    UR <= "00101000010";
    UI <= "11100010010";
    WAIT FOR clk_period;

    UR <= "00101100111";
    UI <= "11100010110";
    WAIT FOR clk_period;

    UR <= "00101100111";
    UI <= "11100101101";
    WAIT FOR clk_period;

    UR <= "00101000000";
    UI <= "11101010110";
    WAIT FOR clk_period;

    UR <= "00011111000";
    UI <= "11110010000";
    WAIT FOR clk_period;

    UR <= "00010011000";
    UI <= "11111010111";
    WAIT FOR clk_period;

    UR <= "00000101100";
    UI <= "00000100111";
    WAIT FOR clk_period;

    UR <= "11111000001";
    UI <= "00001111010";
    WAIT FOR clk_period;

    UR <= "11101100101";
    UI <= "00011001000";
    WAIT FOR clk_period;

    UR <= "11100100010";
    UI <= "00100001011";
    WAIT FOR clk_period;

    UR <= "11011111111";
    UI <= "00100111110";
    WAIT FOR clk_period;

    UR <= "11011111110";
    UI <= "00101011111";
    WAIT FOR clk_period;

    UR <= "11100011011";
    UI <= "00101101101";
    WAIT FOR clk_period;

    UR <= "11101010000";
    UI <= "00101101001";
    WAIT FOR clk_period;

    UR <= "11110010011";
    UI <= "00101011000";
    WAIT FOR clk_period;

    UR <= "11111011001";
    UI <= "00100111110";
    WAIT FOR clk_period;

    UR <= "00000011000";
    UI <= "00100100001";
    WAIT FOR clk_period;

    UR <= "00001000111";
    UI <= "00100000101";
    WAIT FOR clk_period;

    UR <= "00001100010";
    UI <= "00011110000";
    WAIT FOR clk_period;

    UR <= "00001100111";
    UI <= "00011100001";
    WAIT FOR clk_period;

    UR <= "00001011000";
    UI <= "00011011010";
    WAIT FOR clk_period;

    UR <= "00000111010";
    UI <= "00011011000";
    WAIT FOR clk_period;

    UR <= "00000010100";
    UI <= "00011010111";
    WAIT FOR clk_period;

    UR <= "11111101101";
    UI <= "00011010011";
    WAIT FOR clk_period;

    UR <= "11111001101";
    UI <= "00011001001";
    WAIT FOR clk_period;

    UR <= "11110111000";
    UI <= "00010110111";
    WAIT FOR clk_period;

    UR <= "11110110010";
    UI <= "00010011010";
    WAIT FOR clk_period;

    UR <= "11110111011";
    UI <= "00001110101";
    WAIT FOR clk_period;

    UR <= "11111010011";
    UI <= "00001001011";
    WAIT FOR clk_period;

    UR <= "11111110101";
    UI <= "00000100001";
    WAIT FOR clk_period;

    UR <= "00000011110";
    UI <= "11111111101";
    WAIT FOR clk_period;

    UR <= "00001001010";
    UI <= "11111100101";
    WAIT FOR clk_period;

    UR <= "00001110011";
    UI <= "11111011101";
    WAIT FOR clk_period;

    UR <= "00010010110";
    UI <= "11111101010";
    WAIT FOR clk_period;

    UR <= "00010110001";
    UI <= "00000001011";
    WAIT FOR clk_period;

    UR <= "00011000001";
    UI <= "00001000000";
    WAIT FOR clk_period;

    UR <= "00011000101";
    UI <= "00010000110";
    WAIT FOR clk_period;

    UR <= "00010111101";
    UI <= "00011010111";
    WAIT FOR clk_period;

    UR <= "00010101001";
    UI <= "00100101110";
    WAIT FOR clk_period;

    UR <= "00010001001";
    UI <= "00110000011";
    WAIT FOR clk_period;

    UR <= "00001100000";
    UI <= "00111010001";
    WAIT FOR clk_period;

    UR <= "00000101110";
    UI <= "01000010010";
    WAIT FOR clk_period;

    UR <= "11111111000";
    UI <= "01001000100";
    WAIT FOR clk_period;

    UR <= "11111000011";
    UI <= "01001100010";
    WAIT FOR clk_period;

    UR <= "11110010010";
    UI <= "01001101101";
    WAIT FOR clk_period;

    UR <= "11101101110";
    UI <= "01001100100";
    WAIT FOR clk_period;

    UR <= "11101011100";
    UI <= "01001001000";
    WAIT FOR clk_period;

    UR <= "11101100011";
    UI <= "01000011011";
    WAIT FOR clk_period;

    UR <= "11110001000";
    UI <= "00111100000";
    WAIT FOR clk_period;

    UR <= "11111001011";
    UI <= "00110011000";
    WAIT FOR clk_period;

    UR <= "00000101100";
    UI <= "00101001000";
    WAIT FOR clk_period;

    UR <= "00010100101";
    UI <= "00011110010";
    WAIT FOR clk_period;

    UR <= "00100101110";
    UI <= "00010011101";
    WAIT FOR clk_period;

    UR <= "00110111100";
    UI <= "00001001100";
    WAIT FOR clk_period;

    UR <= "01000111111";
    UI <= "00000000100";
    WAIT FOR clk_period;

    UR <= "01010101011";
    UI <= "11111001011";
    WAIT FOR clk_period;

    UR <= "01011110011";
    UI <= "11110100110";
    WAIT FOR clk_period;

    UR <= "01100001100";
    UI <= "11110010101";
    WAIT FOR clk_period;

    UR <= "01011110010";
    UI <= "11110011100";
    WAIT FOR clk_period;

    UR <= "01010100100";
    UI <= "11110110111";
    WAIT FOR clk_period;

    UR <= "01000100111";
    UI <= "11111100100";
    WAIT FOR clk_period;

    UR <= "00110000110";
    UI <= "00000011110";
    WAIT FOR clk_period;

    UR <= "00011001110";
    UI <= "00001011100";
    WAIT FOR clk_period;

    UR <= "00000001111";
    UI <= "00010010110";
    WAIT FOR clk_period;

    UR <= "11101011010";
    UI <= "00011000110";
    WAIT FOR clk_period;

    UR <= "11010111100";
    UI <= "00011100110";
    WAIT FOR clk_period;

    UR <= "11001000011";
    UI <= "00011110000";
    WAIT FOR clk_period;

    UR <= "10111110100";
    UI <= "00011100101";
    WAIT FOR clk_period;

    UR <= "10111010001";
    UI <= "00011000110";
    WAIT FOR clk_period;

    UR <= "10111011000";
    UI <= "00010011000";
    WAIT FOR clk_period;

    UR <= "11000000011";
    UI <= "00001100011";
    WAIT FOR clk_period;

    UR <= "11001001000";
    UI <= "00000101110";
    WAIT FOR clk_period;

    UR <= "11010011100";
    UI <= "00000000001";
    WAIT FOR clk_period;

    UR <= "11011110101";
    UI <= "11111100001";
    WAIT FOR clk_period;

    UR <= "11101001001";
    UI <= "11111010100";
    WAIT FOR clk_period;

    UR <= "11110010011";
    UI <= "11111011010";
    WAIT FOR clk_period;

    UR <= "11111001011";
    UI <= "11111101111";
    WAIT FOR clk_period;

    UR <= "11111110010";
    UI <= "00000010000";
    WAIT FOR clk_period;

    UR <= "00000000111";
    UI <= "00000110100";
    WAIT FOR clk_period;

    UR <= "00000001100";
    UI <= "00001010011";
    WAIT FOR clk_period;

    UR <= "00000000101";
    UI <= "00001100101";
    WAIT FOR clk_period;

    UR <= "11111110101";
    UI <= "00001100101";
    WAIT FOR clk_period;

    UR <= "11111011111";
    UI <= "00001001111";
    WAIT FOR clk_period;

    UR <= "11111000111";
    UI <= "00000100001";
    WAIT FOR clk_period;

    UR <= "11110110000";
    UI <= "11111011111";
    WAIT FOR clk_period;

    UR <= "11110011110";
    UI <= "11110001111";
    WAIT FOR clk_period;

    UR <= "11110010001";
    UI <= "11100111000";
    WAIT FOR clk_period;

    UR <= "11110001101";
    UI <= "11011100100";
    WAIT FOR clk_period;

    UR <= "11110010011";
    UI <= "11010011011";
    WAIT FOR clk_period;

    UR <= "11110100101";
    UI <= "11001100101";
    WAIT FOR clk_period;

    UR <= "11111000011";
    UI <= "11001001000";
    WAIT FOR clk_period;

    UR <= "11111101011";
    UI <= "11001000111";
    WAIT FOR clk_period;

    UR <= "00000011011";
    UI <= "11001100011";
    WAIT FOR clk_period;

    UR <= "00001010000";
    UI <= "11010011010";
    WAIT FOR clk_period;

    UR <= "00010000010";
    UI <= "11011100110";
    WAIT FOR clk_period;

    UR <= "00010101101";
    UI <= "11101000011";
    WAIT FOR clk_period;

    UR <= "00011001001";
    UI <= "11110101010";
    WAIT FOR clk_period;

    UR <= "00011010010";
    UI <= "00000010011";
    WAIT FOR clk_period;

    UR <= "00011000101";
    UI <= "00001111000";
    WAIT FOR clk_period;

    UR <= "00010100000";
    UI <= "00011010100";
    WAIT FOR clk_period;

    UR <= "00001100110";
    UI <= "00100100001";
    WAIT FOR clk_period;

    UR <= "00000011110";
    UI <= "00101011011";
    WAIT FOR clk_period;

    UR <= "11111010000";
    UI <= "00101111111";
    WAIT FOR clk_period;

    UR <= "11110000111";
    UI <= "00110001011";
    WAIT FOR clk_period;

    UR <= "11101001110";
    UI <= "00110000000";
    WAIT FOR clk_period;

    UR <= "11100101101";
    UI <= "00101011101";
    WAIT FOR clk_period;

    UR <= "11100101010";
    UI <= "00100100100";
    WAIT FOR clk_period;

    UR <= "11101001001";
    UI <= "00011011011";
    WAIT FOR clk_period;

    UR <= "11110000101";
    UI <= "00010000101";
    WAIT FOR clk_period;

    UR <= "11111011010";
    UI <= "00000101010";
    WAIT FOR clk_period;

    UR <= "00000111010";
    UI <= "11111010010";
    WAIT FOR clk_period;

    UR <= "00010011010";
    UI <= "11110000011";
    WAIT FOR clk_period;

    UR <= "00011101100";
    UI <= "11101000111";
    WAIT FOR clk_period;

    UR <= "00100100100";
    UI <= "11100100010";
    WAIT FOR clk_period;

    UR <= "00100111010";
    UI <= "11100011000";
    WAIT FOR clk_period;

    UR <= "00100101001";
    UI <= "11100101011";
    WAIT FOR clk_period;

    UR <= "00011110011";
    UI <= "11101010110";
    WAIT FOR clk_period;

    UR <= "00010100001";
    UI <= "11110010110";
    WAIT FOR clk_period;

    UR <= "00000111011";
    UI <= "11111100001";
    WAIT FOR clk_period;

    UR <= "11111010000";
    UI <= "00000101101";
    WAIT FOR clk_period;

    UR <= "11101101110";
    UI <= "00001110000";
    WAIT FOR clk_period;

    UR <= "11100100001";
    UI <= "00010100000";
    WAIT FOR clk_period;

    UR <= "11011110010";
    UI <= "00010110111";
    WAIT FOR clk_period;

    UR <= "11011100011";
    UI <= "00010110010";
    WAIT FOR clk_period;

    UR <= "11011110101";
    UI <= "00010010000";
    WAIT FOR clk_period;

    UR <= "11100011111";
    UI <= "00001010111";
    WAIT FOR clk_period;

    UR <= "11101010111";
    UI <= "00000001111";
    WAIT FOR clk_period;

    UR <= "11110010010";
    UI <= "11111000010";
    WAIT FOR clk_period;

    UR <= "11111000001";
    UI <= "11101111101";
    WAIT FOR clk_period;

    UR <= "11111011011";
    UI <= "11101001000";
    WAIT FOR clk_period;

    UR <= "11111010111";
    UI <= "11100101100";
    WAIT FOR clk_period;

    UR <= "11110110011";
    UI <= "11100101110";
    WAIT FOR clk_period;

    UR <= "11101110010";
    UI <= "11101001101";
    WAIT FOR clk_period;

    UR <= "11100011010";
    UI <= "11110000100";
    WAIT FOR clk_period;

    UR <= "11010110110";
    UI <= "11111001010";
    WAIT FOR clk_period;

    UR <= "11001010011";
    UI <= "00000010101";
    WAIT FOR clk_period;

    UR <= "10111111100";
    UI <= "00001011001";
    WAIT FOR clk_period;

    UR <= "10110111101";
    UI <= "00010001001";
    WAIT FOR clk_period;

    UR <= "10110011110";
    UI <= "00010011110";
    WAIT FOR clk_period;

    UR <= "10110100010";
    UI <= "00010010011";
    WAIT FOR clk_period;

    UR <= "10111001000";
    UI <= "00001100111";
    WAIT FOR clk_period;

    UR <= "11000001100";
    UI <= "00000011110";
    WAIT FOR clk_period;

    UR <= "11001100111";
    UI <= "11111000001";
    WAIT FOR clk_period;

    UR <= "11011001111";
    UI <= "11101011011";
    WAIT FOR clk_period;

    UR <= "11100111011";
    UI <= "11011110111";
    WAIT FOR clk_period;

    UR <= "11110100010";
    UI <= "11010100000";
    WAIT FOR clk_period;

    UR <= "11111111110";
    UI <= "11001011110";
    WAIT FOR clk_period;

    UR <= "00001001100";
    UI <= "11000110111";
    WAIT FOR clk_period;

    UR <= "00010001001";
    UI <= "11000101010";
    WAIT FOR clk_period;

    UR <= "00010111000";
    UI <= "11000110110";
    WAIT FOR clk_period;

    UR <= "00011011011";
    UI <= "11001010011";
    WAIT FOR clk_period;

    UR <= "00011111000";
    UI <= "11001111010";
    WAIT FOR clk_period;

    UR <= "00100010010";
    UI <= "11010100001";
    WAIT FOR clk_period;

    UR <= "00100101101";
    UI <= "11011000001";
    WAIT FOR clk_period;

    UR <= "00101001011";
    UI <= "11011010110";
    WAIT FOR clk_period;

    UR <= "00101101100";
    UI <= "11011011101";
    WAIT FOR clk_period;

    UR <= "00110010000";
    UI <= "11011011000";
    WAIT FOR clk_period;

    UR <= "00110110011";
    UI <= "11011001101";
    WAIT FOR clk_period;

    UR <= "00111010100";
    UI <= "11011000010";
    WAIT FOR clk_period;

    UR <= "00111101110";
    UI <= "11011000000";
    WAIT FOR clk_period;

    UR <= "00111111110";
    UI <= "11011001101";
    WAIT FOR clk_period;

    UR <= "01000000011";
    UI <= "11011101110";
    WAIT FOR clk_period;

    UR <= "00111111001";
    UI <= "11100100101";
    WAIT FOR clk_period;

    UR <= "00111100011";
    UI <= "11101101111";
    WAIT FOR clk_period;

    UR <= "00111000000";
    UI <= "11111000101";
    WAIT FOR clk_period;

    UR <= "00110010100";
    UI <= "00000011110";
    WAIT FOR clk_period;

    UR <= "00101100001";
    UI <= "00001101110";
    WAIT FOR clk_period;

    UR <= "00100101011";
    UI <= "00010101010";
    WAIT FOR clk_period;

    UR <= "00011110101";
    UI <= "00011001000";
    WAIT FOR clk_period;

    UR <= "00011000011";
    UI <= "00011000000";
    WAIT FOR clk_period;

    UR <= "00010010111";
    UI <= "00010010000";
    WAIT FOR clk_period;

    UR <= "00001110010";
    UI <= "00000111010";
    WAIT FOR clk_period;

    UR <= "00001010110";
    UI <= "11111000101";
    WAIT FOR clk_period;

    UR <= "00001000100";
    UI <= "11100111101";
    WAIT FOR clk_period;

    UR <= "00000111011";
    UI <= "11010110000";
    WAIT FOR clk_period;

    UR <= "00000111001";
    UI <= "11000101101";
    WAIT FOR clk_period;

    UR <= "00000111111";
    UI <= "10111000010";
    WAIT FOR clk_period;

    UR <= "00001001001";
    UI <= "10101111011";
    WAIT FOR clk_period;

    UR <= "00001010111";
    UI <= "10101011111";
    WAIT FOR clk_period;

    UR <= "00001100111";
    UI <= "10101110001";
    WAIT FOR clk_period;

    UR <= "00001111000";
    UI <= "10110101110";
    WAIT FOR clk_period;

    UR <= "00010001010";
    UI <= "11000001111";
    WAIT FOR clk_period;

    UR <= "00010011011";
    UI <= "11010001010";
    WAIT FOR clk_period;

    UR <= "00010101100";
    UI <= "11100010001";
    WAIT FOR clk_period;

    UR <= "00010111011";
    UI <= "11110010111";
    WAIT FOR clk_period;

    UR <= "00011001001";
    UI <= "00000010000";
    WAIT FOR clk_period;

    UR <= "00011010101";
    UI <= "00001110011";
    WAIT FOR clk_period;

    UR <= "00011011100";
    UI <= "00010111001";
    WAIT FOR clk_period;

    UR <= "00011011110";
    UI <= "00011100000";
    WAIT FOR clk_period;

    UR <= "00011010111";
    UI <= "00011101010";
    WAIT FOR clk_period;

    UR <= "00011000101";
    UI <= "00011011011";
    WAIT FOR clk_period;

    UR <= "00010100101";
    UI <= "00010111100";
    WAIT FOR clk_period;

    UR <= "00001110101";
    UI <= "00010010010";
    WAIT FOR clk_period;

    UR <= "00000110110";
    UI <= "00001100111";
    WAIT FOR clk_period;

    UR <= "11111100110";
    UI <= "00001000000";
    WAIT FOR clk_period;

    UR <= "11110001011";
    UI <= "00000100010";
    WAIT FOR clk_period;

    UR <= "11100101001";
    UI <= "00000001111";
    WAIT FOR clk_period;

    UR <= "11011000110";
    UI <= "00000000110";
    WAIT FOR clk_period;

    UR <= "11001101100";
    UI <= "00000000100";
    WAIT FOR clk_period;

    UR <= "11000100010";
    UI <= "00000000100";
    WAIT FOR clk_period;

    UR <= "10111110000";
    UI <= "00000000011";
    WAIT FOR clk_period;

    UR <= "10111011110";
    UI <= "11111111011";
    WAIT FOR clk_period;

    UR <= "10111101101";
    UI <= "11111101010";
    WAIT FOR clk_period;

    UR <= "11000011111";
    UI <= "11111001101";
    WAIT FOR clk_period;

    UR <= "11001101111";
    UI <= "11110100101";
    WAIT FOR clk_period;

    UR <= "11011010110";
    UI <= "11101110101";
    WAIT FOR clk_period;

    UR <= "11101001010";
    UI <= "11100111111";
    WAIT FOR clk_period;

    UR <= "11111000000";
    UI <= "11100001001";
    WAIT FOR clk_period;

    UR <= "00000101011";
    UI <= "11011011001";
    WAIT FOR clk_period;

    UR <= "00010000001";
    UI <= "11010110010";
    WAIT FOR clk_period;

    UR <= "00010111000";
    UI <= "11010011010";
    WAIT FOR clk_period;

    UR <= "00011001101";
    UI <= "11010010010";
    WAIT FOR clk_period;

    UR <= "00011000000";
    UI <= "11010011011";
    WAIT FOR clk_period;

    UR <= "00010010101";
    UI <= "11010110101";
    WAIT FOR clk_period;

    UR <= "00001010011";
    UI <= "11011011110";
    WAIT FOR clk_period;

    UR <= "00000000110";
    UI <= "11100010011";
    WAIT FOR clk_period;

    UR <= "11110110111";
    UI <= "11101010000";
    WAIT FOR clk_period;

    UR <= "11101110010";
    UI <= "11110010010";
    WAIT FOR clk_period;

    UR <= "11100111111";
    UI <= "11111010110";
    WAIT FOR clk_period;

    UR <= "11100100011";
    UI <= "00000011001";
    WAIT FOR clk_period;

    UR <= "11100011101";
    UI <= "00001011010";
    WAIT FOR clk_period;

    UR <= "11100101011";
    UI <= "00010011000";
    WAIT FOR clk_period;

    UR <= "11101000101";
    UI <= "00011010010";
    WAIT FOR clk_period;

    UR <= "11101100011";
    UI <= "00100000111";
    WAIT FOR clk_period;

    UR <= "11101111011";
    UI <= "00100110111";
    WAIT FOR clk_period;

    UR <= "11110000100";
    UI <= "00101100010";
    WAIT FOR clk_period;

    UR <= "11101111001";
    UI <= "00110000110";
    WAIT FOR clk_period;

    UR <= "11101011001";
    UI <= "00110100000";
    WAIT FOR clk_period;

    UR <= "11100100101";
    UI <= "00110110000";
    WAIT FOR clk_period;

    UR <= "11011100011";
    UI <= "00110110010";
    WAIT FOR clk_period;

    UR <= "11010011110";
    UI <= "00110100101";
    WAIT FOR clk_period;

    UR <= "11001011111";
    UI <= "00110001000";
    WAIT FOR clk_period;

    UR <= "11000110010";
    UI <= "00101011010";
    WAIT FOR clk_period;

    UR <= "11000011110";
    UI <= "00100011111";
    WAIT FOR clk_period;

    UR <= "11000101000";
    UI <= "00011011001";
    WAIT FOR clk_period;

    UR <= "11001010001";
    UI <= "00010001100";
    WAIT FOR clk_period;

    UR <= "11010010101";
    UI <= "00000111110";
    WAIT FOR clk_period;

    UR <= "11011101011";
    UI <= "11111110110";
    WAIT FOR clk_period;

    UR <= "11101000111";
    UI <= "11110111001";
    WAIT FOR clk_period;

    UR <= "11110011100";
    UI <= "11110001100";
    WAIT FOR clk_period;

    UR <= "11111011111";
    UI <= "11101110011";
    WAIT FOR clk_period;

    UR <= "00000000100";
    UI <= "11101101110";
    WAIT FOR clk_period;

    UR <= "00000001000";
    UI <= "11101111101";
    WAIT FOR clk_period;

    UR <= "11111101000";
    UI <= "11110011110";
    WAIT FOR clk_period;

    UR <= "11110101011";
    UI <= "11111001011";
    WAIT FOR clk_period;

    UR <= "11101011010";
    UI <= "11111111110";
    WAIT FOR clk_period;

    UR <= "11100000001";
    UI <= "00000110001";
    WAIT FOR clk_period;

    UR <= "11010110001";
    UI <= "00001011100";
    WAIT FOR clk_period;

    UR <= "11001110110";
    UI <= "00001111010";
    WAIT FOR clk_period;

    UR <= "11001011101";
    UI <= "00010000110";
    WAIT FOR clk_period;

    UR <= "11001101100";
    UI <= "00001111101";
    WAIT FOR clk_period;

    UR <= "11010100110";
    UI <= "00001011101";
    WAIT FOR clk_period;

    UR <= "11100000110";
    UI <= "00000101001";
    WAIT FOR clk_period;

    UR <= "11110000011";
    UI <= "11111100100";
    WAIT FOR clk_period;

    UR <= "00000010000";
    UI <= "11110010000";
    WAIT FOR clk_period;

    UR <= "00010011101";
    UI <= "11100110100";
    WAIT FOR clk_period;

    UR <= "00100011010";
    UI <= "11011010110";
    WAIT FOR clk_period;

    UR <= "00101111001";
    UI <= "11001111100";
    WAIT FOR clk_period;

    UR <= "00110110000";
    UI <= "11000101100";
    WAIT FOR clk_period;

    UR <= "00110111011";
    UI <= "10111101010";
    WAIT FOR clk_period;

    UR <= "00110011011";
    UI <= "10110111011";
    WAIT FOR clk_period;

    UR <= "00101010101";
    UI <= "10110100010";
    WAIT FOR clk_period;

    UR <= "00011110101";
    UI <= "10110100010";
    WAIT FOR clk_period;

    UR <= "00010001000";
    UI <= "10110111010";
    WAIT FOR clk_period;

    UR <= "00000011100";
    UI <= "10111101001";
    WAIT FOR clk_period;

    UR <= "11110111101";
    UI <= "11000101110";
    WAIT FOR clk_period;

    UR <= "11101110111";
    UI <= "11010000100";
    WAIT FOR clk_period;

    UR <= "11101001110";
    UI <= "11011100101";
    WAIT FOR clk_period;

    UR <= "11101000011";
    UI <= "11101001011";
    WAIT FOR clk_period;

    UR <= "11101010011";
    UI <= "11110110000";
    WAIT FOR clk_period;

    UR <= "11101110110";
    UI <= "00000001010";
    WAIT FOR clk_period;

    UR <= "11110100011";
    UI <= "00001010100";
    WAIT FOR clk_period;

    UR <= "11111001110";
    UI <= "00010000111";
    WAIT FOR clk_period;

    UR <= "11111101110";
    UI <= "00010100000";
    WAIT FOR clk_period;

    UR <= "11111111110";
    UI <= "00010011101";
    WAIT FOR clk_period;

    UR <= "11111111001";
    UI <= "00010000000";
    WAIT FOR clk_period;

    UR <= "11111100010";
    UI <= "00001001100";
    WAIT FOR clk_period;

    UR <= "11110111110";
    UI <= "00000000111";
    WAIT FOR clk_period;

    UR <= "11110010101";
    UI <= "11110111011";
    WAIT FOR clk_period;

    UR <= "11101110010";
    UI <= "11101101111";
    WAIT FOR clk_period;

    UR <= "11101011110";
    UI <= "11100101101";
    WAIT FOR clk_period;

    UR <= "11101100001";
    UI <= "11011111101";
    WAIT FOR clk_period;

    UR <= "11110000001";
    UI <= "11011100100";
    WAIT FOR clk_period;

    UR <= "11110111101";
    UI <= "11011100101";
    WAIT FOR clk_period;

    UR <= "00000010010";
    UI <= "11011111111";
    WAIT FOR clk_period;

    UR <= "00001110110";
    UI <= "11100101111";
    WAIT FOR clk_period;

    UR <= "00011011111";
    UI <= "11101101110";
    WAIT FOR clk_period;

    UR <= "00101000000";
    UI <= "11110110011";
    WAIT FOR clk_period;

    UR <= "00110001100";
    UI <= "11111111000";
    WAIT FOR clk_period;

    UR <= "00110111010";
    UI <= "00000110011";
    WAIT FOR clk_period;

    UR <= "00111000100";
    UI <= "00001011111";
    WAIT FOR clk_period;

    UR <= "00110100111";
    UI <= "00001111000";
    WAIT FOR clk_period;

    UR <= "00101101001";
    UI <= "00001111100";
    WAIT FOR clk_period;

    UR <= "00100010001";
    UI <= "00001101110";
    WAIT FOR clk_period;

    UR <= "00010101010";
    UI <= "00001010010";
    WAIT FOR clk_period;

    UR <= "00001000011";
    UI <= "00000101111";
    WAIT FOR clk_period;

    UR <= "11111101000";
    UI <= "00000001100";
    WAIT FOR clk_period;

    UR <= "11110100110";
    UI <= "11111101111";
    WAIT FOR clk_period;

    UR <= "11110000011";
    UI <= "11111011101";
    WAIT FOR clk_period;

    UR <= "11110000010";
    UI <= "11111011011";
    WAIT FOR clk_period;

    UR <= "11110100011";
    UI <= "11111101001";
    WAIT FOR clk_period;

    UR <= "11111011110";
    UI <= "00000000110";
    WAIT FOR clk_period;

    UR <= "00000101011";
    UI <= "00000101110";
    WAIT FOR clk_period;

    UR <= "00001111110";
    UI <= "00001011101";
    WAIT FOR clk_period;

    UR <= "00011001011";
    UI <= "00010001100";
    WAIT FOR clk_period;

    UR <= "00100001001";
    UI <= "00010111000";
    WAIT FOR clk_period;

    UR <= "00100110001";
    UI <= "00011011010";
    WAIT FOR clk_period;

    UR <= "00101000000";
    UI <= "00011110001";
    WAIT FOR clk_period;

    UR <= "00100111000";
    UI <= "00011111011";
    WAIT FOR clk_period;

    UR <= "00100011110";
    UI <= "00011111001";
    WAIT FOR clk_period;

    UR <= "00011111000";
    UI <= "00011101011";
    WAIT FOR clk_period;

    UR <= "00011010000";
    UI <= "00011010110";
    WAIT FOR clk_period;

    UR <= "00010101111";
    UI <= "00010111011";
    WAIT FOR clk_period;

    UR <= "00010011010";
    UI <= "00010011101";
    WAIT FOR clk_period;

    UR <= "00010010111";
    UI <= "00001111111";
    WAIT FOR clk_period;

    UR <= "00010100101";
    UI <= "00001100001";
    WAIT FOR clk_period;

    UR <= "00011000001";
    UI <= "00001000101";
    WAIT FOR clk_period;

    UR <= "00011100111";
    UI <= "00000101001";
    WAIT FOR clk_period;

    UR <= "00100001111";
    UI <= "00000001110";
    WAIT FOR clk_period;

    UR <= "00100110001";
    UI <= "11111110011";
    WAIT FOR clk_period;

    UR <= "00101000101";
    UI <= "11111011000";
    WAIT FOR clk_period;

    UR <= "00101000111";
    UI <= "11110111100";
    WAIT FOR clk_period;

    UR <= "00100110011";
    UI <= "11110100000";
    WAIT FOR clk_period;

    UR <= "00100001011";
    UI <= "11110000111";
    WAIT FOR clk_period;

    UR <= "00011010000";
    UI <= "11101110001";
    WAIT FOR clk_period;

    UR <= "00010001010";
    UI <= "11101100001";
    WAIT FOR clk_period;

    UR <= "00001000000";
    UI <= "11101011001";
    WAIT FOR clk_period;

    UR <= "11111111001";
    UI <= "11101011001";
    WAIT FOR clk_period;

    UR <= "11110111100";
    UI <= "11101100100";
    WAIT FOR clk_period;

    UR <= "11110001111";
    UI <= "11101111000";
    WAIT FOR clk_period;

    UR <= "11101110111";
    UI <= "11110010100";
    WAIT FOR clk_period;

    UR <= "11101110101";
    UI <= "11110111001";
    WAIT FOR clk_period;

    UR <= "11110001001";
    UI <= "11111100010";
    WAIT FOR clk_period;

    UR <= "11110101111";
    UI <= "00000010000";
    WAIT FOR clk_period;

    UR <= "11111100101";
    UI <= "00000111111";
    WAIT FOR clk_period;

    UR <= "00000100101";
    UI <= "00001101101";
    WAIT FOR clk_period;

    UR <= "00001101001";
    UI <= "00010011010";
    WAIT FOR clk_period;

    UR <= "00010101110";
    UI <= "00011000100";
    WAIT FOR clk_period;

    UR <= "00011101101";
    UI <= "00011101001";
    WAIT FOR clk_period;

    UR <= "00100100100";
    UI <= "00100000111";
    WAIT FOR clk_period;

    UR <= "00101001111";
    UI <= "00100011110";
    WAIT FOR clk_period;

    UR <= "00101101011";
    UI <= "00100101011";
    WAIT FOR clk_period;

    UR <= "00101110110";
    UI <= "00100101110";
    WAIT FOR clk_period;

    UR <= "00101110000";
    UI <= "00100100011";
    WAIT FOR clk_period;

    UR <= "00101011000";
    UI <= "00100001010";
    WAIT FOR clk_period;

    UR <= "00100110000";
    UI <= "00011100011";
    WAIT FOR clk_period;

    UR <= "00011111001";
    UI <= "00010101110";
    WAIT FOR clk_period;

    UR <= "00010110111";
    UI <= "00001101101";
    WAIT FOR clk_period;

    UR <= "00001101111";
    UI <= "00000100011";
    WAIT FOR clk_period;

    UR <= "00000100110";
    UI <= "11111010101";
    WAIT FOR clk_period;

    UR <= "11111100010";
    UI <= "11110000111";
    WAIT FOR clk_period;

    UR <= "11110101001";
    UI <= "11101000000";
    WAIT FOR clk_period;

    UR <= "11101111111";
    UI <= "11100000110";
    WAIT FOR clk_period;

    UR <= "11101101001";
    UI <= "11011011101";
    WAIT FOR clk_period;

    UR <= "11101101000";
    UI <= "11011001001";
    WAIT FOR clk_period;

    UR <= "11101111011";
    UI <= "11011001101";
    WAIT FOR clk_period;

    UR <= "11110011111";
    UI <= "11011101000";
    WAIT FOR clk_period;

    UR <= "11111001111";
    UI <= "11100011000";
    WAIT FOR clk_period;

    UR <= "00000000011";
    UI <= "11101011001";
    WAIT FOR clk_period;

    UR <= "00000110101";
    UI <= "11110100110";
    WAIT FOR clk_period;

    UR <= "00001011110";
    UI <= "11111111010";
    WAIT FOR clk_period;

    UR <= "00001110111";
    UI <= "00001001101";
    WAIT FOR clk_period;

    UR <= "00001111100";
    UI <= "00010011100";
    WAIT FOR clk_period;

    UR <= "00001101110";
    UI <= "00011100001";
    WAIT FOR clk_period;

    UR <= "00001001100";
    UI <= "00100011010";
    WAIT FOR clk_period;

    UR <= "00000011011";
    UI <= "00101000110";
    WAIT FOR clk_period;

    UR <= "11111100001";
    UI <= "00101100110";
    WAIT FOR clk_period;

    UR <= "11110100110";
    UI <= "00101111100";
    WAIT FOR clk_period;

    UR <= "11101101111";
    UI <= "00110001001";
    WAIT FOR clk_period;

    UR <= "11101000101";
    UI <= "00110010001";
    WAIT FOR clk_period;

    UR <= "11100101011";
    UI <= "00110010101";
    WAIT FOR clk_period;

    UR <= "11100100100";
    UI <= "00110010111";
    WAIT FOR clk_period;

    UR <= "11100110000";
    UI <= "00110010101";
    WAIT FOR clk_period;

    UR <= "11101001101";
    UI <= "00110001111";
    WAIT FOR clk_period;

    UR <= "11101110111";
    UI <= "00110000011";
    WAIT FOR clk_period;

    UR <= "11110101001";
    UI <= "00101101101";
    WAIT FOR clk_period;

    UR <= "11111011011";
    UI <= "00101001011";
    WAIT FOR clk_period;

    UR <= "00000001010";
    UI <= "00100011101";
    WAIT FOR clk_period;

    UR <= "00000101111";
    UI <= "00011100010";
    WAIT FOR clk_period;

    UR <= "00001001000";
    UI <= "00010011101";
    WAIT FOR clk_period;

    UR <= "00001010011";
    UI <= "00001010010";
    WAIT FOR clk_period;

    UR <= "00001001111";
    UI <= "00000000110";
    WAIT FOR clk_period;

    UR <= "00000111101";
    UI <= "11111000001";
    WAIT FOR clk_period;

    UR <= "00000100000";
    UI <= "11110001011";
    WAIT FOR clk_period;

    UR <= "11111111100";
    UI <= "11101101010";
    WAIT FOR clk_period;

    UR <= "11111010100";
    UI <= "11101100011";
    WAIT FOR clk_period;

    UR <= "11110101011";
    UI <= "11101111000";
    WAIT FOR clk_period;

    UR <= "11110000111";
    UI <= "11110101000";
    WAIT FOR clk_period;

    UR <= "11101101001";
    UI <= "11111101110";
    WAIT FOR clk_period;

    UR <= "11101010101";
    UI <= "00001000011";
    WAIT FOR clk_period;

    UR <= "11101001110";
    UI <= "00010011100";
    WAIT FOR clk_period;

    UR <= "11101010011";
    UI <= "00011101111";
    WAIT FOR clk_period;

    UR <= "11101100110";
    UI <= "00100110000";
    WAIT FOR clk_period;

    UR <= "11110000101";
    UI <= "00101010110";
    WAIT FOR clk_period;

    UR <= "11110101111";
    UI <= "00101011010";
    WAIT FOR clk_period;

    UR <= "11111100000";
    UI <= "00100111011";
    WAIT FOR clk_period;

    UR <= "00000010110";
    UI <= "00011111010";
    WAIT FOR clk_period;

    UR <= "00001001011";
    UI <= "00010011110";
    WAIT FOR clk_period;

    UR <= "00001111010";
    UI <= "00000101111";
    WAIT FOR clk_period;

    UR <= "00010011111";
    UI <= "11110111011";
    WAIT FOR clk_period;

    UR <= "00010110111";
    UI <= "11101001100";
    WAIT FOR clk_period;

    UR <= "00010111101";
    UI <= "11011101110";
    WAIT FOR clk_period;

    UR <= "00010110001";
    UI <= "11010101010";
    WAIT FOR clk_period;

    UR <= "00010010011";
    UI <= "11010000010";
    WAIT FOR clk_period;

    UR <= "00001100101";
    UI <= "11001111000";
    WAIT FOR clk_period;

    UR <= "00000101100";
    UI <= "11010001000";
    WAIT FOR clk_period;

    UR <= "11111101011";
    UI <= "11010101001";
    WAIT FOR clk_period;

    UR <= "11110101001";
    UI <= "11011010001";
    WAIT FOR clk_period;

    UR <= "11101101100";
    UI <= "11011110111";
    WAIT FOR clk_period;

    UR <= "11100111010";
    UI <= "11100010010";
    WAIT FOR clk_period;

    UR <= "11100011000";
    UI <= "11100011010";
    WAIT FOR clk_period;

    UR <= "11100001000";
    UI <= "11100010000";
    WAIT FOR clk_period;

    UR <= "11100001101";
    UI <= "11011110011";
    WAIT FOR clk_period;

    UR <= "11100100100";
    UI <= "11011001100";
    WAIT FOR clk_period;

    UR <= "11101001110";
    UI <= "11010100010";
    WAIT FOR clk_period;

    UR <= "11110000110";
    UI <= "11010000010";
    WAIT FOR clk_period;

    UR <= "11111000111";
    UI <= "11001110110";
    WAIT FOR clk_period;

    UR <= "00000001110";
    UI <= "11010000111";
    WAIT FOR clk_period;

    UR <= "00001010100";
    UI <= "11010111010";
    WAIT FOR clk_period;

    UR <= "00010010110";
    UI <= "11100001110";
    WAIT FOR clk_period;

    UR <= "00011001110";
    UI <= "11110000001";
    WAIT FOR clk_period;

    UR <= "00011111100";
    UI <= "00000000111";
    WAIT FOR clk_period;

    UR <= "00100011011";
    UI <= "00010010110";
    WAIT FOR clk_period;

    UR <= "00100101011";
    UI <= "00100011110";
    WAIT FOR clk_period;

    UR <= "00100101101";
    UI <= "00110010011";
    WAIT FOR clk_period;

    UR <= "00100100010";
    UI <= "00111101001";
    WAIT FOR clk_period;

    UR <= "00100001011";
    UI <= "01000011000";
    WAIT FOR clk_period;

    UR <= "00011101011";
    UI <= "01000011110";
    WAIT FOR clk_period;

    UR <= "00011000110";
    UI <= "00111111110";
    WAIT FOR clk_period;

    UR <= "00010011111";
    UI <= "00111000000";
    WAIT FOR clk_period;

    UR <= "00001111010";
    UI <= "00101101101";
    WAIT FOR clk_period;

    UR <= "00001011010";
    UI <= "00100010011";
    WAIT FOR clk_period;

    UR <= "00001000011";
    UI <= "00010111111";
    WAIT FOR clk_period;

    UR <= "00000110101";
    UI <= "00001111100";
    WAIT FOR clk_period;

    UR <= "00000110011";
    UI <= "00001010001";
    WAIT FOR clk_period;

    UR <= "00000111010";
    UI <= "00001000011";
    WAIT FOR clk_period;

    UR <= "00001001010";
    UI <= "00001010010";
    WAIT FOR clk_period;

    UR <= "00001011110";
    UI <= "00001111000";
    WAIT FOR clk_period;

    UR <= "00001110100";
    UI <= "00010101110";
    WAIT FOR clk_period;

    UR <= "00010000111";
    UI <= "00011101011";
    WAIT FOR clk_period;

    UR <= "00010010100";
    UI <= "00100100110";
    WAIT FOR clk_period;

    UR <= "00010010111";
    UI <= "00101011000";
    WAIT FOR clk_period;

    UR <= "00010001111";
    UI <= "00101111011";
    WAIT FOR clk_period;

    UR <= "00001111011";
    UI <= "00110001100";
    WAIT FOR clk_period;

    UR <= "00001011110";
    UI <= "00110001101";
    WAIT FOR clk_period;

    UR <= "00000111011";
    UI <= "00110000000";
    WAIT FOR clk_period;

    UR <= "00000010110";
    UI <= "00101101011";
    WAIT FOR clk_period;

    UR <= "11111110100";
    UI <= "00101010100";
    WAIT FOR clk_period;

    UR <= "11111011011";
    UI <= "00101000000";
    WAIT FOR clk_period;

    UR <= "11111010000";
    UI <= "00100110011";
    WAIT FOR clk_period;

    UR <= "11111010100";
    UI <= "00100101111";
    WAIT FOR clk_period;

    UR <= "11111101010";
    UI <= "00100110110";
    WAIT FOR clk_period;

    UR <= "00000010000";
    UI <= "00101000011";
    WAIT FOR clk_period;

    UR <= "00001000101";
    UI <= "00101010101";
    WAIT FOR clk_period;

    UR <= "00010000101";
    UI <= "00101100111";
    WAIT FOR clk_period;

    UR <= "00011001000";
    UI <= "00101110010";
    WAIT FOR clk_period;

    UR <= "00100001011";
    UI <= "00101110101";
    WAIT FOR clk_period;

    UR <= "00101000110";
    UI <= "00101101010";
    WAIT FOR clk_period;

    UR <= "00101110100";
    UI <= "00101010001";
    WAIT FOR clk_period;

    UR <= "00110010001";
    UI <= "00100101000";
    WAIT FOR clk_period;

    UR <= "00110011001";
    UI <= "00011110010";
    WAIT FOR clk_period;

    UR <= "00110001101";
    UI <= "00010101111";
    WAIT FOR clk_period;

    UR <= "00101101011";
    UI <= "00001100100";
    WAIT FOR clk_period;

    UR <= "00100110110";
    UI <= "00000010011";
    WAIT FOR clk_period;

    UR <= "00011110001";
    UI <= "11111000000";
    WAIT FOR clk_period;

    UR <= "00010100000";
    UI <= "11101110000";
    WAIT FOR clk_period;

    UR <= "00001001000";
    UI <= "11100100101";
    WAIT FOR clk_period;

    UR <= "11111101110";
    UI <= "11011100011";
    WAIT FOR clk_period;

    UR <= "11110010111";
    UI <= "11010101110";
    WAIT FOR clk_period;

    UR <= "11101001001";
    UI <= "11010001010";
    WAIT FOR clk_period;

    UR <= "11100000111";
    UI <= "11001111001";
    WAIT FOR clk_period;

    UR <= "11011010110";
    UI <= "11001111101";
    WAIT FOR clk_period;

    UR <= "11010111000";
    UI <= "11010011000";
    WAIT FOR clk_period;

    UR <= "11010101111";
    UI <= "11011001001";
    WAIT FOR clk_period;

    UR <= "11010111001";
    UI <= "11100001111";
    WAIT FOR clk_period;

    UR <= "11011010110";
    UI <= "11101100101";
    WAIT FOR clk_period;

    UR <= "11100000001";
    UI <= "11111000101";
    WAIT FOR clk_period;

    UR <= "11100110101";
    UI <= "00000100111";
    WAIT FOR clk_period;

    UR <= "11101101110";
    UI <= "00010000011";
    WAIT FOR clk_period;

    UR <= "11110100100";
    UI <= "00011010001";
    WAIT FOR clk_period;

    UR <= "11111010000";
    UI <= "00100001001";
    WAIT FOR clk_period;

    UR <= "11111101110";
    UI <= "00100100100";
    WAIT FOR clk_period;

    UR <= "11111111010";
    UI <= "00100100000";
    WAIT FOR clk_period;

    UR <= "11111110001";
    UI <= "00011111101";
    WAIT FOR clk_period;

    UR <= "11111010100";
    UI <= "00010111110";
    WAIT FOR clk_period;

    UR <= "11110100101";
    UI <= "00001101010";
    WAIT FOR clk_period;

    UR <= "11101101001";
    UI <= "00000001001";
    WAIT FOR clk_period;

    UR <= "11100100101";
    UI <= "11110100111";
    WAIT FOR clk_period;

    UR <= "11011100010";
    UI <= "11101001110";
    WAIT FOR clk_period;

    UR <= "11010100110";
    UI <= "11100001000";
    WAIT FOR clk_period;

    UR <= "11001110110";
    UI <= "11011011101";
    WAIT FOR clk_period;

    UR <= "11001011001";
    UI <= "11011010001";
    WAIT FOR clk_period;

    UR <= "11001010001";
    UI <= "11011100111";
    WAIT FOR clk_period;

    UR <= "11001011111";
    UI <= "11100011100";
    WAIT FOR clk_period;

    UR <= "11010000001";
    UI <= "11101101010";
    WAIT FOR clk_period;

    UR <= "11010110110";
    UI <= "11111001100";
    WAIT FOR clk_period;

    UR <= "11011111001";
    UI <= "00000111000";
    WAIT FOR clk_period;

    UR <= "11101000100";
    UI <= "00010100101";
    WAIT FOR clk_period;

    UR <= "11110010011";
    UI <= "00100001100";
    WAIT FOR clk_period;

    UR <= "11111100000";
    UI <= "00101100101";
    WAIT FOR clk_period;

    UR <= "00000101000";
    UI <= "00110101101";
    WAIT FOR clk_period;

    UR <= "00001100111";
    UI <= "00111100001";
    WAIT FOR clk_period;

    UR <= "00010011010";
    UI <= "01000000001";
    WAIT FOR clk_period;

    UR <= "00011000001";
    UI <= "01000010000";
    WAIT FOR clk_period;

    UR <= "00011011011";
    UI <= "01000010000";
    WAIT FOR clk_period;

    UR <= "00011101000";
    UI <= "01000000100";
    WAIT FOR clk_period;

    UR <= "00011101001";
    UI <= "00111110000";
    WAIT FOR clk_period;

    UR <= "00011011111";
    UI <= "00111011000";
    WAIT FOR clk_period;

    UR <= "00011001011";
    UI <= "00110111011";
    WAIT FOR clk_period;

    UR <= "00010101111";
    UI <= "00110011101";
    WAIT FOR clk_period;

    UR <= "00010001100";
    UI <= "00101111101";
    WAIT FOR clk_period;

    UR <= "00001100101";
    UI <= "00101011011";
    WAIT FOR clk_period;

    UR <= "00000111011";
    UI <= "00100110111";
    WAIT FOR clk_period;

    UR <= "00000010000";
    UI <= "00100010000";
    WAIT FOR clk_period;

    UR <= "11111101000";
    UI <= "00011100111";
    WAIT FOR clk_period;

    UR <= "11111000011";
    UI <= "00010111101";
    WAIT FOR clk_period;

    UR <= "11110100010";
    UI <= "00010010100";
    WAIT FOR clk_period;

    UR <= "11110001000";
    UI <= "00001101101";
    WAIT FOR clk_period;

    UR <= "11101110100";
    UI <= "00001001010";
    WAIT FOR clk_period;

    UR <= "11101100101";
    UI <= "00000101110";
    WAIT FOR clk_period;

    UR <= "11101011010";
    UI <= "00000011010";
    WAIT FOR clk_period;

    UR <= "11101010010";
    UI <= "00000001111";
    WAIT FOR clk_period;

    UR <= "11101001010";
    UI <= "00000001101";
    WAIT FOR clk_period;

    UR <= "11101000010";
    UI <= "00000010010";
    WAIT FOR clk_period;

    UR <= "11100111001";
    UI <= "00000011101";
    WAIT FOR clk_period;

    UR <= "11100101101";
    UI <= "00000101011";
    WAIT FOR clk_period;

    UR <= "11100100001";
    UI <= "00000111010";
    WAIT FOR clk_period;

    UR <= "11100010011";
    UI <= "00001001000";
    WAIT FOR clk_period;

    UR <= "11100001000";
    UI <= "00001010011";
    WAIT FOR clk_period;

    UR <= "11011111111";
    UI <= "00001011001";
    WAIT FOR clk_period;

    UR <= "11011111101";
    UI <= "00001011010";
    WAIT FOR clk_period;

    UR <= "11100000000";
    UI <= "00001011000";
    WAIT FOR clk_period;

    UR <= "11100001100";
    UI <= "00001010100";
    WAIT FOR clk_period;

    UR <= "11100011111";
    UI <= "00001010000";
    WAIT FOR clk_period;

    UR <= "11100111000";
    UI <= "00001001110";
    WAIT FOR clk_period;

    UR <= "11101010111";
    UI <= "00001010001";
    WAIT FOR clk_period;

    UR <= "11101111000";
    UI <= "00001011011";
    WAIT FOR clk_period;

    UR <= "11110011010";
    UI <= "00001101101";
    WAIT FOR clk_period;

    UR <= "11110111011";
    UI <= "00010000101";
    WAIT FOR clk_period;

    UR <= "11111011000";
    UI <= "00010100100";
    WAIT FOR clk_period;

    UR <= "11111110000";
    UI <= "00011000110";
    WAIT FOR clk_period;

    UR <= "00000000010";
    UI <= "00011101001";
    WAIT FOR clk_period;

    UR <= "00000001110";
    UI <= "00100000111";
    WAIT FOR clk_period;

    UR <= "00000010011";
    UI <= "00100011111";
    WAIT FOR clk_period;

    UR <= "00000010011";
    UI <= "00100101100";
    WAIT FOR clk_period;

    UR <= "00000001110";
    UI <= "00100101101";
    WAIT FOR clk_period;

    UR <= "00000000100";
    UI <= "00100100000";
    WAIT FOR clk_period;

    UR <= "11111110110";
    UI <= "00100000101";
    WAIT FOR clk_period;

    UR <= "11111100101";
    UI <= "00011100000";
    WAIT FOR clk_period;

    UR <= "11111010011";
    UI <= "00010110010";
    WAIT FOR clk_period;

    UR <= "11110111111";
    UI <= "00010000000";
    WAIT FOR clk_period;

    UR <= "11110101100";
    UI <= "00001010000";
    WAIT FOR clk_period;

    UR <= "11110011011";
    UI <= "00000100100";
    WAIT FOR clk_period;

    UR <= "11110001111";
    UI <= "00000000001";
    WAIT FOR clk_period;

    UR <= "11110001001";
    UI <= "11111101011";
    WAIT FOR clk_period;

    UR <= "11110001011";
    UI <= "11111100010";
    WAIT FOR clk_period;

    UR <= "11110010111";
    UI <= "11111100111";
    WAIT FOR clk_period;

    UR <= "11110101110";
    UI <= "11111111000";
    WAIT FOR clk_period;

    UR <= "11111001110";
    UI <= "00000010010";
    WAIT FOR clk_period;

    UR <= "11111111000";
    UI <= "00000110000";
    WAIT FOR clk_period;

    UR <= "00000101000";
    UI <= "00001010000";
    WAIT FOR clk_period;

    UR <= "00001011101";
    UI <= "00001101011";
    WAIT FOR clk_period;

    UR <= "00010010001";
    UI <= "00001111111";
    WAIT FOR clk_period;

    UR <= "00011000010";
    UI <= "00010001000";
    WAIT FOR clk_period;

    UR <= "00011101011";
    UI <= "00010000100";
    WAIT FOR clk_period;

    UR <= "00100001011";
    UI <= "00001110010";
    WAIT FOR clk_period;

    UR <= "00100100000";
    UI <= "00001010100";
    WAIT FOR clk_period;

    UR <= "00100100111";
    UI <= "00000101010";
    WAIT FOR clk_period;

    UR <= "00100100010";
    UI <= "11111110111";
    WAIT FOR clk_period;

    UR <= "00100010001";
    UI <= "11110111110";
    WAIT FOR clk_period;

    UR <= "00011110101";
    UI <= "11110000011";
    WAIT FOR clk_period;

    UR <= "00011001110";
    UI <= "11101001000";
    WAIT FOR clk_period;

    UR <= "00010100000";
    UI <= "11100010000";
    WAIT FOR clk_period;

    UR <= "00001101010";
    UI <= "11011011111";
    WAIT FOR clk_period;

    UR <= "00000101101";
    UI <= "11010110110";
    WAIT FOR clk_period;

    UR <= "11111101100";
    UI <= "11010010110";
    WAIT FOR clk_period;

    UR <= "11110100111";
    UI <= "11010000010";
    WAIT FOR clk_period;

    UR <= "11101100001";
    UI <= "11001111010";
    WAIT FOR clk_period;

    UR <= "11100011011";
    UI <= "11001111111";
    WAIT FOR clk_period;

    UR <= "11011011010";
    UI <= "11010010000";
    WAIT FOR clk_period;

    UR <= "11010100010";
    UI <= "11010101110";
    WAIT FOR clk_period;

    UR <= "11001110111";
    UI <= "11011011000";
    WAIT FOR clk_period;

    UR <= "11001011111";
    UI <= "11100001011";
    WAIT FOR clk_period;

    UR <= "11001011101";
    UI <= "11101000101";
    WAIT FOR clk_period;

    UR <= "11001110101";
    UI <= "11110000101";
    WAIT FOR clk_period;

    UR <= "11010100110";
    UI <= "11111000110";
    WAIT FOR clk_period;

    UR <= "11011110001";
    UI <= "00000000110";
    WAIT FOR clk_period;

    UR <= "11101010001";
    UI <= "00001000000";
    WAIT FOR clk_period;

    UR <= "11111000000";
    UI <= "00001110010";
    WAIT FOR clk_period;

    UR <= "00000110110";
    UI <= "00010011001";
    WAIT FOR clk_period;

    UR <= "00010101011";
    UI <= "00010110100";
    WAIT FOR clk_period;

    UR <= "00100010100";
    UI <= "00011000001";
    WAIT FOR clk_period;

    UR <= "00101101010";
    UI <= "00011000001";
    WAIT FOR clk_period;

    UR <= "00110100111";
    UI <= "00010110100";
    WAIT FOR clk_period;

    UR <= "00111000101";
    UI <= "00010011101";
    WAIT FOR clk_period;

    UR <= "00111000100";
    UI <= "00001111110";
    WAIT FOR clk_period;

    UR <= "00110100110";
    UI <= "00001011000";
    WAIT FOR clk_period;

    UR <= "00101101110";
    UI <= "00000101111";
    WAIT FOR clk_period;

    UR <= "00100100011";
    UI <= "00000000100";
    WAIT FOR clk_period;

    UR <= "00011001101";
    UI <= "11111011001";
    WAIT FOR clk_period;

    UR <= "00001110011";
    UI <= "11110110000";
    WAIT FOR clk_period;

    UR <= "00000011011";
    UI <= "11110001010";
    WAIT FOR clk_period;

    UR <= "11111001101";
    UI <= "11101101001";
    WAIT FOR clk_period;

    UR <= "11110001010";
    UI <= "11101001100";
    WAIT FOR clk_period;

    UR <= "11101010110";
    UI <= "11100110111";
    WAIT FOR clk_period;

    UR <= "11100101111";
    UI <= "11100101010";
    WAIT FOR clk_period;

    UR <= "11100010110";
    UI <= "11100100110";
    WAIT FOR clk_period;

    UR <= "11100000110";
    UI <= "11100101101";
    WAIT FOR clk_period;

    UR <= "11011111101";
    UI <= "11101000001";
    WAIT FOR clk_period;

    UR <= "11011111000";
    UI <= "11101100001";
    WAIT FOR clk_period;

    UR <= "11011110101";
    UI <= "11110001110";
    WAIT FOR clk_period;

    UR <= "11011110010";
    UI <= "11111000110";
    WAIT FOR clk_period;

    UR <= "11011101111";
    UI <= "00000000110";
    WAIT FOR clk_period;

    UR <= "11011101010";
    UI <= "00001001010";
    WAIT FOR clk_period;

    UR <= "11011100110";
    UI <= "00010001110";
    WAIT FOR clk_period;

    UR <= "11011100011";
    UI <= "00011001101";
    WAIT FOR clk_period;

    UR <= "11011100001";
    UI <= "00100000010";
    WAIT FOR clk_period;

    UR <= "11011100011";
    UI <= "00100101010";
    WAIT FOR clk_period;

    UR <= "11011101010";
    UI <= "00101000011";
    WAIT FOR clk_period;

    UR <= "11011110101";
    UI <= "00101001011";
    WAIT FOR clk_period;

    UR <= "11100000101";
    UI <= "00101000101";
    WAIT FOR clk_period;

    UR <= "11100011011";
    UI <= "00100110011";
    WAIT FOR clk_period;

    UR <= "11100110110";
    UI <= "00100011001";
    WAIT FOR clk_period;

    UR <= "11101010101";
    UI <= "00011111110";
    WAIT FOR clk_period;

    UR <= "11101111001";
    UI <= "00011100110";
    WAIT FOR clk_period;

    UR <= "11110100000";
    UI <= "00011010101";
    WAIT FOR clk_period;

    UR <= "11111001000";
    UI <= "00011001110";
    WAIT FOR clk_period;

    UR <= "11111101111";
    UI <= "00011010001";
    WAIT FOR clk_period;

    UR <= "00000010100";
    UI <= "00011011110";
    WAIT FOR clk_period;

    UR <= "00000110100";
    UI <= "00011101111";
    WAIT FOR clk_period;

    UR <= "00001001100";
    UI <= "00100000000";
    WAIT FOR clk_period;

    UR <= "00001011010";
    UI <= "00100001001";
    WAIT FOR clk_period;

    UR <= "00001011100";
    UI <= "00100000101";
    WAIT FOR clk_period;

    UR <= "00001010010";
    UI <= "00011110000";
    WAIT FOR clk_period;

    UR <= "00000111100";
    UI <= "00011000110";
    WAIT FOR clk_period;

    UR <= "00000011100";
    UI <= "00010000111";
    WAIT FOR clk_period;

    UR <= "11111110101";
    UI <= "00000111000";
    WAIT FOR clk_period;

    UR <= "11111001011";
    UI <= "11111011110";
    WAIT FOR clk_period;

    UR <= "11110100010";
    UI <= "11110000001";
    WAIT FOR clk_period;

    UR <= "11101111111";
    UI <= "11100101100";
    WAIT FOR clk_period;

    UR <= "11101100110";
    UI <= "11011101000";
    WAIT FOR clk_period;

    UR <= "11101011001";
    UI <= "11010111101";
    WAIT FOR clk_period;

    UR <= "11101011011";
    UI <= "11010110000";
    WAIT FOR clk_period;

    UR <= "11101101011";
    UI <= "11011000100";
    WAIT FOR clk_period;

    UR <= "11110001000";
    UI <= "11011110101";
    WAIT FOR clk_period;

    UR <= "11110101111";
    UI <= "11100111111";
    WAIT FOR clk_period;

    UR <= "11111011100";
    UI <= "11110011001";
    WAIT FOR clk_period;

    UR <= "00000001010";
    UI <= "11111111000";
    WAIT FOR clk_period;

    UR <= "00000110100";
    UI <= "00001010001";
    WAIT FOR clk_period;

    UR <= "00001010110";
    UI <= "00010011010";
    WAIT FOR clk_period;

    UR <= "00001101100";
    UI <= "00011001100";
    WAIT FOR clk_period;

    UR <= "00001110101";
    UI <= "00011100011";
    WAIT FOR clk_period;

    UR <= "00001101111";
    UI <= "00011100000";
    WAIT FOR clk_period;

    UR <= "00001011001";
    UI <= "00011000101";
    WAIT FOR clk_period;

    UR <= "00000110111";
    UI <= "00010011010";
    WAIT FOR clk_period;

    UR <= "00000001001";
    UI <= "00001101000";
    WAIT FOR clk_period;

    UR <= "11111010100";
    UI <= "00000111010";
    WAIT FOR clk_period;

    UR <= "11110011001";
    UI <= "00000010111";
    WAIT FOR clk_period;

    UR <= "11101011101";
    UI <= "00000000110";
    WAIT FOR clk_period;

    UR <= "11100100011";
    UI <= "00000001001";
    WAIT FOR clk_period;

    UR <= "11011101111";
    UI <= "00000100001";
    WAIT FOR clk_period;

    UR <= "11011000011";
    UI <= "00001001000";
    WAIT FOR clk_period;

    UR <= "11010100010";
    UI <= "00001110111";
    WAIT FOR clk_period;

    UR <= "11010001101";
    UI <= "00010100101";
    WAIT FOR clk_period;

    UR <= "11010000111";
    UI <= "00011001001";
    WAIT FOR clk_period;

    UR <= "11010001111";
    UI <= "00011011100";
    WAIT FOR clk_period;

    UR <= "11010100101";
    UI <= "00011011001";
    WAIT FOR clk_period;

    UR <= "11011000111";
    UI <= "00010111111";
    WAIT FOR clk_period;

    UR <= "11011110010";
    UI <= "00010010001";
    WAIT FOR clk_period;

    UR <= "11100100011";
    UI <= "00001010110";
    WAIT FOR clk_period;

    UR <= "11101010110";
    UI <= "00000010110";
    WAIT FOR clk_period;

    UR <= "11110000111";
    UI <= "11111011101";
    WAIT FOR clk_period;

    UR <= "11110110010";
    UI <= "11110110011";
    WAIT FOR clk_period;

    UR <= "11111010100";
    UI <= "11110100010";
    WAIT FOR clk_period;

    UR <= "11111101100";
    UI <= "11110101101";
    WAIT FOR clk_period;

    UR <= "11111111010";
    UI <= "11111010100";
    WAIT FOR clk_period;

    UR <= "11111111110";
    UI <= "00000010101";
    WAIT FOR clk_period;

    UR <= "11111111100";
    UI <= "00001100111";
    WAIT FOR clk_period;

    UR <= "11111110111";
    UI <= "00011000001";
    WAIT FOR clk_period;

    UR <= "11111110011";
    UI <= "00100010110";
    WAIT FOR clk_period;

    UR <= "11111110100";
    UI <= "00101011101";
    WAIT FOR clk_period;

    UR <= "11111111101";
    UI <= "00110001010";
    WAIT FOR clk_period;

    UR <= "00000010000";
    UI <= "00110011001";
    WAIT FOR clk_period;

    UR <= "00000101100";
    UI <= "00110001000";
    WAIT FOR clk_period;

    UR <= "00001001110";
    UI <= "00101011001";
    WAIT FOR clk_period;

    UR <= "00001110100";
    UI <= "00100010001";
    WAIT FOR clk_period;

    UR <= "00010011001";
    UI <= "00010111001";
    WAIT FOR clk_period;

    UR <= "00010110110";
    UI <= "00001011011";
    WAIT FOR clk_period;

    UR <= "00011000111";
    UI <= "00000000001";
    WAIT FOR clk_period;

    UR <= "00011001001";
    UI <= "11110110011";
    WAIT FOR clk_period;

    UR <= "00010111001";
    UI <= "11101111000";
    WAIT FOR clk_period;

    UR <= "00010011000";
    UI <= "11101010001";
    WAIT FOR clk_period;

    UR <= "00001100111";
    UI <= "11101000000";
    WAIT FOR clk_period;

    UR <= "00000101010";
    UI <= "11101000001";
    WAIT FOR clk_period;

    UR <= "11111100111";
    UI <= "11101010000";
    WAIT FOR clk_period;

    UR <= "11110100100";
    UI <= "11101101000";
    WAIT FOR clk_period;

    UR <= "11101101000";
    UI <= "11110000010";
    WAIT FOR clk_period;

    UR <= "11100110111";
    UI <= "11110011100";
    WAIT FOR clk_period;

    UR <= "11100010111";
    UI <= "11110110001";
    WAIT FOR clk_period;

    UR <= "11100001011";
    UI <= "11111000001";
    WAIT FOR clk_period;

    UR <= "11100010011";
    UI <= "11111001101";
    WAIT FOR clk_period;

    UR <= "11100101111";
    UI <= "11111010111";
    WAIT FOR clk_period;

    UR <= "11101011110";
    UI <= "11111100010";
    WAIT FOR clk_period;

    UR <= "11110011010";
    UI <= "11111110001";
    WAIT FOR clk_period;

    UR <= "11111100001";
    UI <= "00000000111";
    WAIT FOR clk_period;

    UR <= "00000101101";
    UI <= "00000100101";
    WAIT FOR clk_period;

    UR <= "00001111001";
    UI <= "00001001011";
    WAIT FOR clk_period;

    UR <= "00010111111";
    UI <= "00001111001";
    WAIT FOR clk_period;

    UR <= "00011111001";
    UI <= "00010101101";
    WAIT FOR clk_period;

    UR <= "00100100011";
    UI <= "00011100101";
    WAIT FOR clk_period;

    UR <= "00100111000";
    UI <= "00100011101";
    WAIT FOR clk_period;

    UR <= "00100110100";
    UI <= "00101010100";
    WAIT FOR clk_period;

    UR <= "00100010111";
    UI <= "00110000101";
    WAIT FOR clk_period;

    UR <= "00011011111";
    UI <= "00110110000";
    WAIT FOR clk_period;

    UR <= "00010001110";
    UI <= "00111010010";
    WAIT FOR clk_period;

    UR <= "00000101001";
    UI <= "00111101000";
    WAIT FOR clk_period;

    UR <= "11110110111";
    UI <= "00111110001";
    WAIT FOR clk_period;

    UR <= "11101000000";
    UI <= "00111101001";
    WAIT FOR clk_period;

    UR <= "11011010000";
    UI <= "00111001111";
    WAIT FOR clk_period;

    UR <= "11001110000";
    UI <= "00110100000";
    WAIT FOR clk_period;

    UR <= "11000101101";
    UI <= "00101011100";
    WAIT FOR clk_period;

    UR <= "11000001101";
    UI <= "00100000010";
    WAIT FOR clk_period;

    UR <= "11000010111";
    UI <= "00010010101";
    WAIT FOR clk_period;

    UR <= "11001001100";
    UI <= "00000011001";
    WAIT FOR clk_period;

    UR <= "11010101011";
    UI <= "11110010101";
    WAIT FOR clk_period;

    UR <= "11100101011";
    UI <= "11100010001";
    WAIT FOR clk_period;


      report "Fim da simulacao" severity note;
      finish;
   end process;
   
END;
