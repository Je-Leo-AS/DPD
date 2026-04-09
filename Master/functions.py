import numpy as np
import matplotlib.pyplot as plt
from scipy.io import loadmat
import sympy as sp
import os

# %%
def mp(P, M, xn):
    L = xn.shape
    XX = np.zeros((L[0] - M, P * (M+1)), dtype=np.complex128)
    for l in range(M+1, L[0]):
        for p in range(1, P+1):
            for m in range(0, M+1):
                XX[l-M-1, ((p-1)*(M+1))+m] = (np.abs(xn[l-m])**(2*p-2)*(xn[l-m]))
    return XX
# %%
def readeq_int(val, precision):
    return np.floor(val / (2 ** precision))

def readeq_complex(val, precision):
    real_part = np.real(val)
    imag_part = np.imag(val)
    return np.floor(real_part / (2 ** precision)) + 1j * np.floor(imag_part / (2 ** precision))

def modulo_preservando_sinal(dividendo, divisor):
    resto = dividendo % divisor
    return resto if dividendo >= 0 else resto - divisor

def mp_int(P, M, xn, bits):
    L = xn.shape
    XX = np.zeros((L[0] - M, P * (M+1)), dtype=np.complex128)
    for l in range(0, L[0]):
        for p in range(1, P+1):
            for m in range(0, M+1):
                    A = np.real(xn[l-m])
                    B = np.imag(xn[l-m])
                    modulo_power = 2**bits 
                    modulo_square = readeq_int(A ** 2, bits) + readeq_int(B ** 2, bits)
                    for _ in range(1, p):
                       modulo_power = readeq_int(modulo_power * modulo_square, bits)
                    real_part = modulo_preservando_sinal(readeq_int(A * modulo_power,bits), 2**bits) 
                    imag_part = modulo_preservando_sinal(readeq_int(B * modulo_power,bits), 2**bits) 
                    XX[l-M-1, ((p-1)*(M+1))+m] = complex(real_part,imag_part)        
    return XX

def MultiplicadorMatrizes(coefficients, XX, precision):
    max_value = 0  
    coefficients = np.round(coefficients *(2**precision))
    result = np.zeros_like(XX, dtype=np.complex128)
    for i in range(XX.shape[0]):
        for j in range(XX.shape[1]):
            
            A = np.real(coefficients[j])
            B = np.imag(coefficients[j])
            C = np.real(XX[i, j])
            D = np.imag(XX[i, j])

            readequated_real = readeq_int(A * C, precision) - readeq_int(B * D, precision)
            readequated_imag = readeq_int(A * D, precision) + readeq_int(B * C, precision)

            max_value = max(max_value, readequated_real, readequated_imag)

            
            result[i, j] = complex(readequated_real, readequated_imag) 

    soma_filas = np.sum(result, axis=1).reshape(-1, 1)

    extra_bits = np.ceil(np.log2(max_value + 1))
    
    return soma_filas, extra_bits


def Calculo_do_modelo(P, M, p_bits, coefficients, in_val_norm, out_val_norm):
    in_val_fixed = np.round(in_val_norm * (2 ** p_bits)) 
    out_val_fixed = np.round(out_val_norm * (2 ** p_bits))
    XX_val = mp_int(P, M, in_val_fixed, p_bits)
    predicted_val_fixed, e_bits = MultiplicadorMatrizes(coefficients, XX_val, p_bits)
    nmse_fixed = nmse_calculo(predicted_val_fixed,out_val_fixed, M)
    # Levar em consideração os bits extras para evitar overflow
    total_bits = p_bits + 1 + e_bits
    return p_bits,e_bits, total_bits, nmse_fixed, in_val_fixed,out_val_fixed,predicted_val_fixed

nmse_calculo = lambda predicted_val, data_out, M:10 * np.log10(np.mean(np.abs(data_out[M:] - predicted_val) ** 2) / np.mean(np.abs(data_out[M:]) ** 2))

def plot_signals(in_data_ext, out_data_ext, in_data_val, out_data_val):
    # plotar sinais de entrada e saída
    x_ext = range(len(in_data_ext))
    x_val = range(len(in_data_val))

    fig, axs = plt.subplots(2, sharex=True, figsize=(8, 6))
    fig.suptitle('Sinais de entrada e saída')
    axs[0].plot(x_ext, np.real(in_data_ext), label='Entrada')
    axs[0].plot(x_ext, np.real(out_data_ext), label='Saída')
    axs[0].legend()
    axs[1].plot(x_val, np.real(in_data_val), label='Entrada')
    axs[1].plot(x_val, np.real(out_data_val), label='Saída')
    axs[1].legend()
    plt.show()

def extract_coefficients(in_ext,out_ext,M, P):
    XX_ext = mp(P, M, in_ext)
    N = abs(out_ext.shape[0]-XX_ext.shape[0])
    coefficients, _, _, _ = np.linalg.lstsq(XX_ext, out_ext[N:], rcond=None)
    return XX_ext, coefficients   

inteiro_para_binario = lambda numero, pbits: bin(numero & ((1 << pbits) - 1))[2:].zfill(pbits)


def _as_complex_vector(values):
    values = np.asarray(values)
    if values.ndim == 0:
        values = values.reshape(1)
    return values.astype(np.complex128).reshape(-1)


def load_complex_csv_reference(path, real_col=None, imag_col=None):
    import pandas as pd

    df = pd.read_csv(path)
    if real_col is None or imag_col is None:
        cols = list(df.columns)
        if len(cols) < 2:
            raise ValueError(f"Referencia '{path}' precisa ter ao menos duas colunas.")
        real_col, imag_col = cols[0], cols[1]

    return (df[real_col].to_numpy() + 1j * df[imag_col].to_numpy()).astype(np.complex128)


def load_simulation_output(path):
    import pandas as pd

    df = pd.read_csv(path, header=None)
    basename = os.path.basename(path).lower()

    if "debug" in basename or df.shape[1] >= 5:
        if df.shape[1] < 5:
            raise ValueError(
                f"Saida debug '{path}' deveria ter 5 colunas (idx, in_re, in_im, out_re, out_im)."
            )
        sim = (df.iloc[:, 3].to_numpy() + 1j * df.iloc[:, 4].to_numpy()).astype(np.complex128)
        case = "debug"
    elif df.shape[1] >= 2:
        sim = (df.iloc[:, 0].to_numpy() + 1j * df.iloc[:, 1].to_numpy()).astype(np.complex128)
        case = "real"
    else:
        raise ValueError(f"Formato de saida nao reconhecido para '{path}'.")

    return sim, case, df


def estimate_delay_mae(sim, ref, max_delay=50, discard_head=0):
    sim = _as_complex_vector(sim)[discard_head:]
    ref = _as_complex_vector(ref)[discard_head:]

    best_delay = 0
    best_err = np.inf

    for delay in range(max_delay + 1):
        sim_d = sim[delay:]
        n = min(len(sim_d), len(ref))
        if n <= 0:
            continue

        err = np.mean(np.abs(sim_d[:n] - ref[:n]))
        if err < best_err:
            best_err = err
            best_delay = delay

    return best_delay, best_err


def align_by_delay(sim, ref, delay):
    sim = _as_complex_vector(sim)
    ref = _as_complex_vector(ref)

    if delay < 0:
        ref = ref[-delay:]
    else:
        sim = sim[delay:]

    n = min(len(sim), len(ref))
    return sim[:n], ref[:n]


def compare_complex_vectors(sim, ref, max_delay=50, discard_head=0, atol=0.0):
    delay, mae = estimate_delay_mae(sim, ref, max_delay=max_delay, discard_head=discard_head)
    sim_aligned, ref_aligned = align_by_delay(sim, ref, delay)

    err = sim_aligned - ref_aligned
    max_err = float(np.max(np.abs(err))) if len(err) else np.nan
    nmse = (
        10 * np.log10(np.mean(np.abs(err) ** 2) / np.mean(np.abs(ref_aligned) ** 2))
        if len(err) and np.mean(np.abs(ref_aligned) ** 2) > 0
        else np.nan
    )
    exact = bool(np.allclose(sim_aligned, ref_aligned, atol=atol, rtol=0.0))

    return {
        "delay": int(delay),
        "mae": float(mae),
        "max_err": max_err,
        "nmse_db": float(nmse) if np.isfinite(nmse) else np.nan,
        "exact": exact,
        "length": int(len(sim_aligned)),
        "sim_aligned": sim_aligned,
        "ref_aligned": ref_aligned,
    }


def compare_vhdl_output(
    output_path,
    predicted_real=None,
    debug_reference_paths=None,
    max_delay=50,
    discard_head=0,
    atol=0.0,
):
    sim, detected_case, _ = load_simulation_output(output_path)

    if debug_reference_paths is None:
        debug_reference_paths = []

    if detected_case == "debug":
        if not debug_reference_paths:
            raise ValueError("Forneca ao menos uma referencia debug para comparar a saida debug.")

        candidates = []
        for ref_path in debug_reference_paths:
            ref = load_complex_csv_reference(ref_path)
            result = compare_complex_vectors(
                sim,
                ref,
                max_delay=max_delay,
                discard_head=discard_head,
                atol=atol,
            )
            result["reference_path"] = ref_path
            candidates.append(result)

        best = min(candidates, key=lambda item: (item["mae"], item["max_err"]))
    else:
        if predicted_real is None:
            raise ValueError("Forneca predicted_real para comparar a saida do fluxo real.")

        best = compare_complex_vectors(
            sim,
            predicted_real,
            max_delay=max_delay,
            discard_head=discard_head,
            atol=atol,
        )
        best["reference_path"] = "predicted_val_fixed_DPD_trunc"

    best["case"] = detected_case
    best["output_path"] = output_path
    return best
 
