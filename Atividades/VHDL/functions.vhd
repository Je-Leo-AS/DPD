library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Biblioteca para operações aritméticas e conversões.

package Math_Package is
    function std_logic_vector_to_integer(vec: std_logic_vector) return integer;
    function pow(base: std_logic_vector) return std_logic_vector;
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
    function pow(base: std_logic_vector) return std_logic_vector is
        variable base_int: integer;
        variable result_int: integer := 0;
        variable result_vec: std_logic_vector(base'range);
    begin
        base_int := std_logic_vector_to_integer(base);
        result_int := base_int * base_int;
        result_vec := std_logic_vector(to_unsigned(result_int, base'length - 1));
        return result_vec;
    end pow;
end Math_Package;
