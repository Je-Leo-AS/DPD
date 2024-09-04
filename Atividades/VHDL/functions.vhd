LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
PACKAGE Math_Package IS

  CONSTANT n_bits_resolution : INTEGER := 9;
  CONSTANT n_bits_overflow : INTEGER := 10;
  
  CONSTANT n_signals_used : INTEGER := 2;
  CONSTANT n_polygnos_degree : INTEGER := 2;
  
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
  
  TYPE Array_signals IS ARRAY (0 TO n_signals_used) OF complex_number;
  TYPE Array_signals_overflow IS ARRAY (0 TO n_signals_used) OF complex_number_overflow;
  TYPE Array_poly_degree is ARRAY (0 TO n_polygnos_degree) OF complex_number;
  TYPE Array_poly_degree_overflow IS ARRAY (0 TO n_signals_used - 1) OF complex_number_overflow;
  TYPE Array_signals_multip IS ARRAY (0 TO n_signals_used - 1) OF Array_poly_degree;
  TYPE Array_signals_multip_overflow IS ARRAY (0 TO n_polygnos_degree - 1) OF Array_poly_degree_overflow;
  TYPE Array_signals_powers IS ARRAY (0 TO n_polygnos_degree - 1) OF Array_poly_degree;
  TYPE Array_signals_powers_overflow IS ARRAY (0 TO n_polygnos_degree - 1) OF Array_poly_degree_overflow;
  

  CONSTANT coefficients : complex_array := (
    (reall => 1, imag => 1),
    (reall => 8, imag => - 1),
    (reall => - 3, imag => - 1),
    (reall => 1, imag => 1)
  );
  FUNCTION cast_to_limited(
			  input : complex_number_overflow
			) RETURN complex_number;
			
	FUNCTION sum_rows(
	input_array : Array_signals
	) RETURN complex_number;
	
	FUNCTION sum_columns(
	input_array : Array_poly_degree
	) RETURN complex_number;
	
	Function multiplication(
		A : complex_number; 
		B : complex_number
		) return complex_number;
	
	Function power(
				A : complex_number
				) return complex_number;
END Math_Package;

PACKAGE BODY Math_Package IS
		FUNCTION cast_to_limited(
			  input : complex_number_overflow
			) RETURN complex_number IS
			  VARIABLE result : complex_number;
			BEGIN
			  -- Divisão dos sinais pela diferença de resolução
			  result.reall := input.reall / (2 ** n_bits_overflow);
			  result.imag := input.imag / (2 ** n_bits_overflow);

			  -- Retorna o resultado do tipo complex_number
			  RETURN result;
			END FUNCTION;
		 function multiplication(A : complex_number; B : complex_number) return complex_number is
			  variable result : complex_number_overflow;
		 begin
			  -- Exemplo de processamento: Incrementa os valores real e imaginário em 1
			result.reall:= A.reall * B.reall - A.imag * B.imag;
			result.imag := A.imag * B.reall + A.reall * B.imag;			
		
		  return cast_to_limited(result);
	 end function;
	 
	 function power(A : complex_number) return complex_number is
			  variable result : complex_number_overflow;
		 begin
			  -- Exemplo de processamento: Incrementa os valores real e imaginário em 1
			result.reall := A.reall * A.reall;
			result.imag := A.imag * A.imag;		
		
		  return cast_to_limited(result);
	 end function;
	 
	 FUNCTION sum_rows(input_array : Array_signals) RETURN complex_number IS
		  VARIABLE result : complex_number := (reall => 0, imag => 0);
		BEGIN
		  FOR i IN 0 TO n_signals_used LOOP
			 result.reall := result.reall + input_array(i).reall;
			 result.imag := result.imag + input_array(i).imag;
		  END LOOP;
		  RETURN result;
		END FUNCTION;

		
	FUNCTION sum_columns(input_array : Array_poly_degree) RETURN complex_number IS
		  VARIABLE result : complex_number := (reall => 0, imag => 0);
		BEGIN
		  FOR i IN 0 TO n_polygnos_degree LOOP
			 result.reall := result.reall + input_array(i).reall;
			 result.imag := result.imag + input_array(i).imag;
		  END LOOP;
		  RETURN result;
		END FUNCTION;
END Math_Package;