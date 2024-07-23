LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
PACKAGE Math_Package IS

  CONSTANT n_bits_resolution : INTEGER := 9;
  CONSTANT n_bits_overflow : INTEGER := 10;

  CONSTANT max_value : INTEGER := 2 ** (n_bits_resolution - 1) - 1;
  CONSTANT max_value_overflow : INTEGER := 2 ** (n_bits_resolution + n_bits_overflow - 1) - 1;

  SUBTYPE limited_integer IS INTEGER RANGE -max_value TO max_value;
  SUBTYPE overflow_integer IS INTEGER RANGE -max_value_overflow TO max_value_overflow;

  TYPE complex_number IS RECORD
    reall : limited_integer;
    imag : limited_integer;
  END RECORD;

  TYPE complex_number_overflow IS RECORD
    reall : overflow_integer;
    imag : overflow_integer;
  END RECORD;

  TYPE complex_array IS ARRAY (0 TO 3) OF complex_number;

  CONSTANT coefficients : complex_array := (
    (reall => 1, imag => 1),
    (reall => 8, imag => - 1),
    (reall => - 3, imag => - 1),
    (reall => 1, imag => 1)
  );

END Math_Package;

PACKAGE BODY Math_Package IS

END Math_Package;