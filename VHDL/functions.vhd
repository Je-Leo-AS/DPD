LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
PACKAGE Math_Package IS

	CONSTANT n_signals_used : INTEGER := 2;
	CONSTANT n_polygnos_degree : INTEGER := 2;

	CONSTANT n_bits_resolution : INTEGER := 8 + 1;
	CONSTANT n_bits_overflow : INTEGER := 8;

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

	TYPE complex_coefficients IS ARRAY (0 TO 3) OF complex_number;
	TYPE Array_signals IS ARRAY (0 TO n_signals_used - 1) OF complex_number;
	TYPE Array_signals_overflow IS ARRAY (0 TO n_signals_used - 1) OF complex_number_overflow;
	TYPE Array_poly_degree IS ARRAY (0 TO n_polygnos_degree - 1) OF complex_number;
	TYPE Array_poly_degree_overflow IS ARRAY (0 TO n_signals_used - 1) OF complex_number_overflow;
	TYPE Array_signals_multip IS ARRAY (0 TO n_signals_used - 1) OF Array_poly_degree;
	TYPE Array_signals_multip_overflow IS ARRAY (0 TO n_polygnos_degree - 1) OF Array_poly_degree_overflow;
	TYPE Array_signals_powers IS ARRAY (0 TO n_polygnos_degree - 1) OF Array_poly_degree;
	TYPE Array_signals_powers_overflow IS ARRAY (0 TO n_polygnos_degree - 1) OF Array_poly_degree_overflow;
	CONSTANT coefficients : complex_coefficients := (
	(reall => 1, imag => 1),
		(reall => 8, imag => - 1),
		(reall => - 3, imag => - 1),
		(reall => 1, imag => 1)
	);
	FUNCTION cast_to_limited(
		input : complex_number_overflow
	) RETURN complex_number;

	FUNCTION multiplication(
		A : complex_number;
		B : complex_number
	) RETURN complex_number;

	FUNCTION power(
		A : complex_number
	) RETURN complex_number;

    	PROCEDURE sum_matrix_elements(matrix : IN Array_signals_multip; signal_result : OUT complex_number);

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
	FUNCTION multiplication(A : complex_number; B : complex_number) RETURN complex_number IS
		VARIABLE result : complex_number_overflow;
	BEGIN
		result.reall := A.reall * B.reall - A.imag * B.imag;
		result.imag := A.imag * B.reall + A.reall * B.imag;

		RETURN cast_to_limited(result);
	END FUNCTION;

	FUNCTION power(A : complex_number) RETURN complex_number IS
		VARIABLE result : complex_number_overflow;
		VARIABLE modulo_power : overflow_integer := max_value + 1;
		VARIABLE modulo_square : overflow_integer;
	BEGIN
		modulo_square := ( A.reall * A.reall +  A.imag * A.imag ) / (2 ** n_bits_overflow);
		result.reall := A.reall * modulo_square;
		result.imag :=  A.imag  * modulo_square ;

		RETURN cast_to_limited(result);
	END FUNCTION;

	PROCEDURE sum_matrix_elements(matrix : IN Array_signals_multip; signal_result : OUT complex_number) IS
	variable result : complex_number := (reall => 0, imag => 0);
	BEGIN
		-- Inicializa o resultado
		result.reall := 0;
		result.imag := 0;

		-- Loop pelos sinais usados
		FOR i IN matrix'RANGE LOOP
			-- Loop pelos graus do polin�mio
			FOR j IN matrix(i)'RANGE LOOP
				-- Soma as partes reais e imagin�rias
				result.reall := result.reall + matrix(i)(j).reall;
				result.imag := result.imag + matrix(i)(j).imag;
			END LOOP;
		END LOOP;
		signal_result := result;
	END PROCEDURE;

END Math_Package;