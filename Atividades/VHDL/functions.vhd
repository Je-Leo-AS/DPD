library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package ComplexConstants is

end package ComplexConstants;

package Math_Package is
  
  constant n_bits_resolution : INTEGER := 9;
  
  constant max_value : INTEGER := 2**n_bits_resolution -1;
  
  subtype limited_integer is integer range - max_value to max_value;
  
  function pow(base: limited_integer) return integer;
 
  type complex_number is record
    real : limited_integer;
    imag : limited_integer;
  end record;

  type complex_array is array (0 to 3) of complex_number;

  constant coefficients : complex_array := (
    (real => 1, imag => 1),
    (real => 8, imag => -1),
    (real => -3, imag => -1),
    (real => 1, imag => 1)
  );

end Math_Package;

package body Math_Package is
    
    -- Função para calcular a potência
    function pow(base: limited_integer) return integer is
        variable result_int: integer := 0;
	variable base_int: limited_integer;
    begin
        result_int := base_int * base_int;
        return result_int;
    end pow;
end Math_Package;
