// Copie este bloco para a seção da tese que apresenta a arquitetura do DPD.
#figure(
  image("arquitetura_dpd_generalizada.svg", width: 100%),
  caption: [Arquitetura generalizada do predistorcedor digital baseado em
  polinômio com memória. Para cada uma das $M$ amostras, o ramo $m$ gera
  $P_m$ funções de base, que são multiplicadas por coeficientes complexos,
  alinhadas temporalmente e combinadas por uma árvore de soma.],
) <fig:arquitetura-dpd-generalizada>

O circuito implementa o modelo

$
  y[n] = sum_(m=0)^(M-1) sum_(p=0)^(P_m-1)
  c_(m,p) x[n-m] abs(x[n-m])^(2p),
$

em que $M$ representa a profundidade de memória e
$bold(P) = [P_0, P_1, ..., P_(M-1)]$ define a quantidade de funções de base
empregada em cada atraso. Assim, a quantidade total de termos processados é
$N_T = sum_(m=0)^(M-1) P_m$.

Inicialmente, o banco de atrasos disponibiliza simultaneamente as amostras
$x[n], x[n-1], ..., x[n-M+1]$. Para cada amostra $x[n-m]$, calcula-se a potência
instantânea $r_m[n] = abs(x[n-m])^2$. As funções de base são então produzidas
recursivamente, partindo de $phi_(m,0)[n] = x[n-m]$ e aplicando
$phi_(m,p)[n] = phi_(m,p-1)[n] r_m[n]$. Essa recorrência produz
$phi_(m,p)[n] = x[n-m] abs(x[n-m])^(2p)$ sem calcular cada potência de maneira
independente.

Cada ramo possui $P_m$ termos e, portanto, pode apresentar uma ordem distinta.
Os termos passam por registradores de pipeline que compensam as diferentes
latências de geração. Após o alinhamento temporal, cada função de base é
multiplicada pelo coeficiente complexo correspondente $c_(m,p)$. Os
$N_T$ produtos resultantes são reduzidos por uma árvore balanceada de somadores
complexos. Finalmente, o resultado acumulado passa pelo ajuste de largura de
palavra e pela saturação antes de ser registrado na saída $y[n]$.
