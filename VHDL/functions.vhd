LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
PACKAGE functions IS

	CONSTANT n_signals_used : INTEGER := 2;
	CONSTANT n_polygnos_degree : INTEGER := 2;

	CONSTANT n_bits_resolution : INTEGER := 8 + 1;
	CONSTANT n_bits_overflow : INTEGER := 8;

	CONSTANT max_value : INTEGER := 2 ** (n_bits_resolution) - 1;
	CONSTANT min_value : INTEGER := 2 ** (n_bits_resolution);
	CONSTANT max_value_overflow : INTEGER := 2 ** (n_bits_resolution + n_bits_overflow) - 1;
	CONSTANT min_value_overflow : INTEGER := 2 ** (n_bits_resolution + n_bits_overflow);

	SUBTYPE limited_integer IS INTEGER RANGE -min_value TO max_value;
	-- SUBTYPE overflow_integer IS INTEGER RANGE -min_value_overflow TO max_value_overflow;
	TYPE complex_number IS RECORD
		reall : INTEGER;
		imag : INTEGER;
	END RECORD;

	TYPE complex_coefficients IS ARRAY (0 TO n_signals_used + n_polygnos_degree - 1) OF complex_number;
	TYPE Array_signals IS ARRAY (0 TO n_signals_used - 1) OF complex_number;
	-- TYPE Array_signals_overflow IS ARRAY (0 TO n_signals_used - 1) OF complex_number_overflow;
	TYPE Array_poly_degree IS ARRAY (0 TO n_polygnos_degree - 1) OF complex_number;
	-- TYPE Array_poly_degree_overflow IS ARRAY (0 TO n_signals_used - 1) OF complex_number_overflow;
	TYPE Array_signals_multip IS ARRAY (0 TO n_signals_used - 1) OF Array_poly_degree;
	-- TYPE Array_signals_multip_overflow IS ARRAY (0 TO n_polygnos_degree - 1) OF Array_poly_degree_overflow;
	TYPE Array_signals_powers IS ARRAY (0 TO n_polygnos_degree - 1) OF Array_poly_degree;
	-- TYPE Array_signals_powers_overflow IS ARRAY (0 TO n_polygnos_degree - 1) OF Array_poly_degree_overflow;
	CONSTANT coefficients : complex_coefficients := (
		(reall => -45, imag => -27),
		(reall =>  88, imag =>   5),	
		(reall => 239, imag =>  31),	
		(reall => -40, imag => -15)		
	);
	FUNCTION readeq(
		input : integer
	) RETURN integer;

	FUNCTION multiplication(
		A : complex_number;
		B : complex_number
	) RETURN complex_number;

	FUNCTION power(
		A : complex_number
	) RETURN complex_number;

	FUNCTION sum_matrix_elements(
		matrix : Array_signals_multip
		) RETURN complex_number;

END functions;

PACKAGE BODY functions IS
	FUNCTION readeq(
		input : integer
	) RETURN integer IS
    VARIABLE result : integer;
    VARIABLE int_as_slv : signed(n_bits_overflow + n_bits_resolution - 1 downto 0);
    constant n_shft_bits : integer := 8;
	BEGIN
	int_as_slv := to_signed(input, int_as_slv'length);

    	-- Converter o resultado de volta para integer
	result := to_integer(int_as_slv(n_bits_overflow + n_bits_resolution - 1) & 
			     int_as_slv(n_bits_resolution + n_shft_bits - 2 downto n_shft_bits));
	RETURN result;
	END FUNCTION;

	FUNCTION multiplication(A : complex_number; B : complex_number) RETURN complex_number IS
		VARIABLE result : complex_number;
	BEGIN
		result.reall := readeq(A.reall * B.reall) - readeq(A.imag * B.imag);
		result.imag := readeq(A.imag * B.reall) + readeq(A.reall * B.imag);
		RETURN result;
	END FUNCTION;

	FUNCTION power(A : complex_number) RETURN complex_number IS
		VARIABLE result : complex_number;
		VARIABLE modulo_square : integer := 0;
		VARIABLE prod : integer :=0;
	BEGIN
		prod := A.reall * A.reall;
		modulo_square := readeq(prod);
		modulo_square := modulo_square + readeq(A.imag * A.imag);
		result.reall :=readeq(A.reall * modulo_square);
		result.imag := readeq(A.imag * modulo_square);

		RETURN result;
	END FUNCTION;

	FUNCTION sum_matrix_elements(matrix : Array_signals_multip) RETURN complex_number IS
		VARIABLE result : complex_number;
	BEGIN
		result.reall := 0;
		result.imag := 0;
		FOR i IN matrix'RANGE LOOP
			FOR j IN matrix(i)'RANGE LOOP
				-- Soma as partes reais e imaginarias
				result.reall := result.reall + matrix(i)(j).reall;
				result.imag := result.imag + matrix(i)(j).imag;
			END LOOP;
		END LOOP;
		result.reall := result.reall;
		result.imag := result.imag;
		RETURN result;

	END FUNCTION;

END functions;