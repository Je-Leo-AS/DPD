-- Arquivo gerado automaticamente por um script Python
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package ComplexConstants is
  constant n_bits_resolution : INTEGER := 8 + 1;
  
  subtype limited_integer is integer range 0 to 2**n_bits_resolution - 1;
  
  type complex_number is record
    real : limited_integer;
    imag : limited_integer;
  end record;

  type complex_array is array (0 to 3) of complex_number;

  constant complex_values : complex_array := (
    (real => 1, imag => 1),
    (real => 7, imag => -1),
    (real => -3, imag => -1),
    (real => 1, imag => 1)
  );

end package ComplexConstants;
