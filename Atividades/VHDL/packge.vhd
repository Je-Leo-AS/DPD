library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package Math_Package is
    function std_logic_vector_to_integer(vec: std_logic_vector) return integer;
    function pow(base: std_logic_vector; exponent: integer) return std_logic_vector;
end Math_Package;

package body Math_Package is
    -- Função para converter std_logic_vector para integer
    function std_logic_vector_to_integer(vec: std_logic_vector) return integer is
        variable result: integer := 0;
    begin
        for i in vec'range loop
            if vec(i) = '1' then
                result := result + 2**(vec'length - 1 - i);
            end if;
        end loop;
        return result;
    end std_logic_vector_to_integer;

    -- Função para calcular a potência
    function pow(base: std_logic_vector; exponent: integer) return std_logic_vector is
        variable result: integer := 1;
        variable base_int: integer;
        variable result_int: integer := 1;
        variable base_tmp: integer;
    begin
        base_int := std_logic_vector_to_integer(base);
        base_tmp := base_int;
        if exponent = 0 then
            return (others => '0');
        elsif exponent = 1 then
            return base;
        end if;
        for i in 1 to exponent loop
            result_int := result_int * base;
        end loop;

        result := result_int;
        return std_logic_vector(to_signed(result, base'length));
    end pow;
end Math_Package;

-- Exemplo de uso do pacote e funções
entity Test_Power is
end Test_Power;

architecture Behavioral of Test_Power is
    signal vec: std_logic_vector(7 downto 0) := "00000101"; -- Representa o número 5
    signal n: integer := 3; -- Exponente
    signal result: std_logic_vector(7 downto 0);
begin
    process
    begin
        result <= pow(vec, n);
        wait;
    end process;
end Behavioral;
