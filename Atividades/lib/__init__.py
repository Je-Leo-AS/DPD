import numpy as np
import matplotlib.pyplot as plt
from scipy.io import loadmat



def mp(P, M, xn):
    L = xn.shape
    XX = np.zeros((L[0] - M, P * (M+1)), dtype=np.complex128)
    for l in range(M+1, L[0]):
        for p in range(1, P+1):
            for m in range(0, M+1):
                XX[l-M-1, ((p-1)*(M+1))+m] = (np.abs(xn[l-m])**(2*p-2)*(xn[l-m]))[0]
    return XX

def readeq(val, precision):
    return np.floor(val / (2 ** precision))

def extract_coefficients(in_ext,out_ext,M):
    XX_ext = mp(P, M, in_ext)
    coefficients, _, _, _ = np.linalg.lstsq(XX_ext, out_ext[M:], rcond=None)
    return coefficients

def mp_int(P, M, xn, bits):
    L = xn.shape
    XX = np.zeros((L[0] - M, P * (M+1)), dtype=np.complex128)
    for l in range(M+1, L[0]):
        for p in range(1, P+1):
            for m in range(0, M+1):
                    A = np.real(xn[l-m])[0]
                    B = np.imag(xn[l-m])[0]
                    modulo_power = 2**bits 
                    modulo_square = readeq(A ** 2 + B ** 2, bits)
                    for _ in range(1, p):
                       modulo_power = readeq(modulo_power * modulo_square, bits)
                    real_part = readeq(A * modulo_power,bits)
                    imag_part = readeq(B * modulo_power,bits)
                    XX[l-M-1, ((p-1)*(M+1))+m] = complex(real_part,imag_part)        
    return XX

def MultiplicadorMatrizes(coefficients, XX, precision):
    max_value = 0  
    coefficients = np.round(coefficients *(2**precision))
    result = np.zeros_like(XX, dtype=np.complex128)
    for i in range(XX.shape[0]):
        for j in range(XX.shape[1]):
            
            A = np.real(coefficients[j,0])
            B = np.imag(coefficients[j,0])
            C = np.real(XX[i, j])
            D = np.imag(XX[i, j])

            readequated_real = readeq(A * C - B * D, precision)
            readequated_imag = readeq(A * D + B * C, precision)

            max_value = max(max_value, readequated_real)
            max_value = max(max_value, readequated_imag)
            
            result[i, j] = complex(readequated_real, readequated_imag) 

    soma_filas = np.sum(result, axis=1).reshape(-1, 1)

    extra_bits = np.ceil(np.log2(max_value + 1))
    
    return soma_filas, extra_bits

def Calculo_do_modelo(P,M,p_bits,in_val_norm,out_val_norm,coefficients):
    in_val_fixed = np.round(in_val_norm * (2 ** p_bits)) 
    out_val_fixed = np.round(out_val_norm * (2 ** p_bits))
    XX_val = mp_int(P, M, in_val_fixed, p_bits)
    predicted_val_fixed, e_bits = MultiplicadorMatrizes(coefficients, XX_val, p_bits)
    nmse_fixed = nmse_calculo(predicted_val_fixed,out_val_fixed, M)
    # Levar em consideração os bits extras para evitar overflow
    total_bits = p_bits + 1 + e_bits
    return p_bits,e_bits, total_bits, nmse_fixed, in_val_fixed,out_val_fixed,predicted_val_fixed

nmse_calculo = lambda predicted_val, data_out, M:10 * np.log10(np.mean(np.abs(data_out[M:] - predicted_val) ** 2) / np.mean(np.abs(data_out[M:]) ** 2))
