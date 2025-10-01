## --------------------------------------------------------
## Atividade M2 - Identificação com dados complexos (Octave)
## --------------------------------------------------------

clear; clc;

## 1. Carregar os dados complexos de treino e validação
load('in_out_SBRT2_direto.mat');

x_in_ext  = in_extraction(:);     % vetor coluna
y_out_ext = out_extraction(:);
x_in_val  = in_validation(:);
y_out_val = out_validation(:);

## 2. Definir parâmetros do Polinômio de Memória
ordem   = 3;    % ordem do polinômio
memoria = 2;    % número de atrasos
num_coef = ordem * (memoria+1);

## 3. Função de erro com coeficientes complexos
function e = erro_mp_complex(params, x_in, y_out, ordem, memoria)
    C = length(params)/2;
    coef = params(1:C) + 1i*params(C+1:end);   % reconstruir coef complexos

    N = length(x_in);
    y_est = zeros(N,1);

    for n = (memoria+1):N
        soma = 0;
        idx = 1;
        for m = 0:memoria
            for p = 1:ordem
                soma = soma + coef(idx) * (x_in(n-m)^p);
                idx = idx + 1;
            end
        end
        y_est(n) = soma;
    end

    e = abs(y_out - y_est);   % retorno = módulo do erro (real)
end

## 4. Função objetivo escalar (MSE real)
f = @(c) mean((erro_mp_complex(c, x_in_ext, y_out_ext, ordem, memoria)).^2);

## 5. Estimativa inicial (2*num_coef reais)
x0 = zeros(2*num_coef,1);

## 6. Otimização não linear
options = optimset('Display','iter');
[params_otimo, fval] = fminunc(f, x0, options);

## 7. Reconstituir coef complexos
coef_otimo = params_otimo(1:num_coef) + 1i*params_otimo(num_coef+1:end);

disp('Coeficientes complexos otimizados:')
disp(coef_otimo)

disp(['MSE (treino) = ', num2str(fval)])

## 8. Avaliar em validação
erro_val = erro_mp_complex(params_otimo, x_in_val, y_out_val, ordem, memoria);
mse_val  = mean(erro_val.^2);

disp(['MSE (validação) = ', num2str(mse_val)])

