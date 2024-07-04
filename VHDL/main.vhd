library IEEE;
use IEEE.std_logic_1164.all;
library packge;
use packge.all;
-- TODO tera uma entrada exclusiva para sinal?

entity DPD is 
    generic(
        n_bits_resolution :INTEGER := 10 + 1;
        n_bits_overflow :INTEGER := 10;
        n_signals_used : INTEGER := 2;
        n_polygnos_degree : INTEGER := 2;
    );
    port(
        reset : in std_logic;
        clk : in std_logic;
        UR : in std_logic_vector(n_bits_resolution downto 0);
        IR : in std_logic_vector(n_bits_resolution downto 0);
        UR_out : out std_logic_vector(n_bits_resolution downto 0);
        IR_out : out std_logic_vector(n_bits_resolution downto 0) );
end DPD;

architecture hardware of DPD is
    type Array_signals is array (0 to n_signals_used) of std_logic_vector(n_bits_resolution downto 0);
    type Array_coeficients is array (0 to n_signals_used * n_polygnos_degree) of std_logic_vector(n_bits_resolution downto 0);
    type Array_multiplication is array (0 to n_signals_used * n_polygnos_degree) of std_logic_vector(n_bits_overflow + n_bits_resolution downto 0);
    signal UR_Last_signals : Array_signals := (others => (others => '0'));
    signal UI_Last_signals : Array_signals := (others => (others => '0'));
    signal coeficients : Array_coeficients := (others => (others => '0'));
    signal UR_process : Array_multiplication := (others => (others => '0'));
    signal IR_process : Array_multiplication := (others => (others => '0'));
    signal sum_i : std_logic_vector(n_bits_resolution downto 0) := others => '0';
    signal sum_r : std_logic_vector(n_bits_resolution downto 0) := others => '0';
begin
    calcul_process: process(clk, reset)
  begin
    --TODO separar o processo em batidas de clock 
    if reset = '1' then
      UR_out <= (others => '0'); 
      IR_out <= (others => '0'); 
    elsif rising_edge(clk) then
      for i in 0 to n_signals_used loop
        for j in 0 to n_polygnos_degree  loop
          UR_process[i + j] <=  pow(UR_Last_signals[i], j); 
          IR_process[i + j] <=  pow(UI_Last_signals[i], j); 
        end loop;
      end loop;
      for i in 0 to n_signals_used loop
        for j in 0 to n_polygnos_degree  loop
          UR_process[i + j] <=  UR_process[i + j] * coeficients[i+j]; 
          IR_process[i + j] <=  IR_process[i + j] * coeficients[i+j]; 
        end loop;
      end loop;
      for i in 0 to (n_signals_used * n_polygnos_degree) loop
        sum_r <= sum_r + UR_process[i](UR_process'left downto UR_process'left - sum_r'length + 1);
        sum_i <= sum_i + IR_process[i](IR_process'left downto IR_process'left - sum_i'length + 1);
      end loop;
    else
      sum_i :=  others => '0'
      sum_r :=  others => '0'
    end if;

  end process;
  
  process_change_signal: process(clk)
  begin
    if reset = '1' then
      UR_out <= (others => '0'); 
      IR_out <= (others => '0'); 
    elsif rising_edge(clk) then
      for i in 1 to n_signals_used loop
        UR_Last_signals[i-1] <= UR_Last_signals[i];
        UI_Last_signals[i-1] <= UI_Last_signals[i];
      end loop;
      UR_out <= UR_Last_signals[n_signals_used - 1];
      IR_out <= UI_Last_signals[n_signals_used - 1];
    end if;
  end process;
    
end architecture;