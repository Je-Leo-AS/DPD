%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   ARQUIVO PRINCIPAL — ATIVIDADE M3
%   TOTALMENTE COMPATÍVEL COM OCTAVE 10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function atividade_m3()

    % =============================
    % 1) Leitura dos dados
    % =============================
    data = load("in_out_SBRT2_direto.mat");

    in_data_ext = data.in_extraction(:);
    out_data_ext = data.out_extraction(:);
    in_data_val = data.in_validation(:);
    out_data_val = data.out_validation(:);

    % =============================
    % 2) Normalização
    % =============================
    modulos = [
        max(real(in_data_ext));
        max(imag(in_data_ext));
        max(real(out_data_ext));
        max(imag(out_data_ext));
        max(real(in_data_val));
        max(imag(in_data_val));
        max(real(out_data_val));
        max(imag(out_data_val))
    ];

    maior_modulo = max(abs(modulos));

    in_ext_norm  = in_data_ext  / maior_modulo;
    out_ext_norm = out_data_ext / maior_modulo;

    % =============================
    % 3) Quantização
    % =============================
    precision = 8;
    scale = 2^precision;

    in_ext_q  = round(real(in_ext_norm) * scale) + 1i * round(imag(in_ext_norm) * scale);
    out_ext_q = round(real(out_ext_norm) * scale) + 1i * round(imag(out_ext_norm) * scale);

    % =============================
    % 4) Modelo MP
    % =============================
    ordem = 3;
    memoria = 2;

    % =============================
    % 5) Execução da otimização
    % =============================
    [p_opt, custo] = optimize_coeffs(in_ext_q, out_ext_q, ordem, memoria, precision);

    fprintf("\nCusto final: %e\n", custo);

    num_coef = ordem * (memoria + 1);

    coef_complex = (p_opt(1:num_coef) + 1i * p_opt(num_coef+1:end)) / scale;

    fprintf("\nCoeficientes complexos otimizados:\n");
    disp(coef_complex);

endfunction



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNÇÃO DE CUSTO — Modelo Polinomial de Memória Quantizado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function cost = cost_quantized(p, x_in, y_out, ordem, memoria, precision)

    scale = 2^precision;
    num_coef = ordem * (memoria + 1);

    ar = p(1:num_coef) / scale;
    ai = p(num_coef+1:end) / scale;
    coefs = ar + 1i * ai;

    N = length(x_in);
    y_est = zeros(N, 1);

    for n = memoria+1:N

        acc = 0;
        idx = 1;

        for m = 0:memoria

            xr0 = real(x_in(n-m)) / scale;
            xi0 = imag(x_in(n-m)) / scale;

            xr_p = xr0;
            xi_p = xi0;

            for pwr = 1:ordem

                if pwr > 1
                    real_mult = xr_p * xr0 - xi_p * xi0;
                    imag_mult = xr_p * xi0 + xi_p * xr0;

                    xr_p = round(real_mult * scale) / scale;
                    xi_p = round(imag_mult * scale) / scale;
                end

                acc += coefs(idx) * complex(xr_p, xi_p);
                idx++;
            end
        end

        y_est(n) = acc;
    end

    cost = sum(abs(y_out - y_est).^2);

endfunction



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  PSO IMPLEMENTADO EM OCTAVE PURO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [best_position, best_cost] = pso_solve(cost_func, dim, lb, ub)

    swarm_size = 30;
    max_iter = 80;

    w  = 0.72;
    c1 = 1.49;
    c2 = 1.49;

    pos = lb + rand(swarm_size, dim) .* (ub - lb);
    vel = zeros(swarm_size, dim);

    for i = 1:swarm_size
        cost(i) = cost_func(pos(i,:));
    end

    pbest = pos;
    pbest_cost = cost;

    [best_cost, idx] = min(cost);
    gbest = pos(idx,:);

    for it = 1:max_iter

        for i = 1:swarm_size

            r1 = rand(1, dim);
            r2 = rand(1, dim);

            vel(i,:) = w * vel(i,:) ...
                      + c1 * r1 .* (pbest(i,:) - pos(i,:)) ...
                      + c2 * r2 .* (gbest - pos(i,:));

            pos(i,:) = pos(i,:) + vel(i,:);
            pos(i,:) = max(pos(i,:), lb);
            pos(i,:) = min(pos(i,:), ub);

            c = cost_func(pos(i,:));

            if c < pbest_cost(i)
                pbest(i,:) = pos(i,:);
                pbest_cost(i) = c;

                if c < best_cost
                    gbest = pos(i,:);
                    best_cost = c;
                end
            end
        end

        fprintf("Iter %d | Melhor custo = %e\n", it, best_cost);

    end

    best_position = gbest;

endfunction



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNÇÃO DE OTIMIZAÇÃO DE COEFICIENTES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [p_best, cost_best] = optimize_coeffs(x_in, y_out, ordem, memoria, precision)

    num_coef = ordem * (memoria + 1);
    dim = num_coef * 2;

    lb = -255 * ones(1, dim);
    ub =  255 * ones(1, dim);

    cost_handle = @(p) cost_quantized(p, x_in, y_out, ordem, memoria, precision);

    [p_best, cost_best] = pso_solve(cost_handle, dim, lb, ub);

endfunction



