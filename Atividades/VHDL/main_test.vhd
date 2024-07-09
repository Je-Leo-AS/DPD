library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
library work;
use work.Math_Package.all;

entity test_power is 
    generic(
        n_bits_resolution : INTEGER := 10 + 1;
        n_bits_overflow :INTEGER := 10;
        n_signals_used : INTEGER := 2;
        n_polygnos_degree : INTEGER := 2);
    port(
        reset : in std_logic;
        clk : in std_logic;
        U : in std_logic_vector(n_bits_resolution downto 0);
        U_out : out std_logic_vector(n_bits_resolution downto 0));
end test_power;

architecture hardware of test_power is
    signal u_unsigned : unsigned(n_bits_resolution downto 0) := (others => '0');

  begin
    u_unsigned <= unsigned(U);
    calcul_process: process(clk, reset)
    begin
      if reset = '1' then
        U_out <= (others => '0'); 
      elsif rising_edge(clk) then
         U_out <= std_logic_vector(pow(std_logic_vector(u_unsigned)));
      end if;
    end process;
end hardware;
