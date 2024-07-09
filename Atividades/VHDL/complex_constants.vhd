-- Arquivo gerado automaticamente por um script Python
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package ComplexConstants is

  type complex_number is record
    real : integer;
    imag : integer;
  end record;

  type complex_array is array (0 to 3) of complex_number;

  constant complex_values : complex_array := (
    (real => 1, imag => 1),
    (real => 7, imag => -1),
    (real => -3, imag => 0),
    (real => 0, imag => 0)
  );

end package ComplexConstants;
