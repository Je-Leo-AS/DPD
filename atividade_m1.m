## --------------------------------------------------------
## Atividade M1 - Identificação de coeficientes via fminunc
## --------------------------------------------------------

clear; clc;

## 1. Carregar os dados do arquivo .mat
##    (substitua 'dados.mat' pelo nome do seu arquivo)
load('IN_OUT_PA.mat');

## Assumindo que dentro do .mat existam vetores 'in' e 'out'
x_in  = in(:);   % força em coluna
y_out = out(:);

## 2. Definir parâmetros do MP
ordem   = 3;   % ordem do polinômio (ajuste conforme Ativ.2)
memoria = 2;   % número de atrasos (ajuste conforme Ativ.2)
num_coef = ordem * (memoria+1);

## 3. Função de erro (vetorial)
function e = erro_mp(coef, x_in, y_out, ordem, memoria)
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
    e = y_out - y_est;
end

## 4. Função objetivo escalar (MSE)
f = @(c) sumsq(erro_mp(c, x_in, y_out, ordem, memoria));

## 5. Estimativa inicial dos coeficientes
x0 = zeros(num_coef,1);  % pode testar ones() ou randn()

## 6. Otimização não linear
options = optimset('Display','iter');  % mostra iterações
[coef_otimo, fval] = fminunc(f, x0, options);

## 7. Resultados
disp('Coeficientes otimizados:')
disp(coef_otimo)
disp(['MSE final = ', num2str(fval/length(y_out))])

