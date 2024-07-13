library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
library work;
use work.Math_Package.all;

entity test_power is 
    generic(
        n_bits_overflow :INTEGER := 10;
        n_signals_used : INTEGER := 2;
        n_polygnos_degree : INTEGER := 2);
    port(
        reset : in std_logic;
        clk : in std_logic;
        U : in signed(n_bits_resolution downto 0);
	U_out_int : out integer;
        U_out : out signed(n_bits_resolution downto 0));
end test_power;

architecture hardware of test_power is
   signal complex_signal_in : complex_number;  
   signal u_int : limited_integer;
  begin
    u_int <= to_integer(U);
    calcul_process: process(clk, reset)
variable int_out : integer := 0; 
    begin
      if reset = '1' then
        U_out <= (others => '0'); 
      elsif rising_edge(clk) then
	int_out := pow(u_int);
	U_out_int <= int_out;
        U_out <= to_signed(u_int, n_bits_resolution + 1);
      end if;
    end process;
end hardware;
