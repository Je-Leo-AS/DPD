Atividade 1:
Seja o conjunto de 5 medições (xi, yi), onde i=1, 2, ..., 5:
(x1, y1)= (0,0.2)
(x2, y2)= (0.1,0.3)
(x3, y3)= (0.2,0.45)
(x4, y4)= (0.3,0.7)
(x5, y5)= (0.4,0.8)
Deseja-se obter a melhor reta que relacione (xi, yi). Essa reta terá a seguinte equação yi=a.xi+b, onde a e b são constantes ainda a serem determinadas. Obter os valores ótimos dos coeficientes ajustáveis a e b, usando mínimos quadrados, de duas formas distintas:

A. Fazendo as contas no papel:
1. Defina, para cada par (xi, yi), um erro como sendo a diferença entre o valor medido (yi) e o valor fornecido pela equação da reta (a.xi+b). Após isso, realizar a soma dos quadrados dos erros. Essa equação, chamada de MSE, dependerá dos coeficientes ajustáveis a e b.
2. O objetivo aqui é escolher coeficientes ajustáveis a e b que minimizem o MSE. Para isso, buscam-se os pontos de mínimos de MSE em relação aos coeficientes ajustáveis a e b. Para isso:
2a) derivar a equação do MSE em relação ao coeficiente a e, na sequência, igualar o resultado a zero;
2b) derivar a equação do MSE em relação ao coeficiente b e, na sequência, igualar o resultado a zero;
2c) Resolver o sistema algébrico linear de 2 equações (equações resultantes dos itens 2a e 2b) nas 2 incógnitas que são os coeficientes ajustáveis a e b.
3. Use os coeficientes a e b obtidos em 2c e, para cada xi, obter a estimativa usando a equação da reta. Em um mesmo gráfico, visualizar (yi) x (xi); ( a.xi+b ) x (xi)

B. Usando mínimos quadrados no MATLAB (o texto abaixo refere-se a MATLAB, mas se você preferir, você pode usar o Python):
1.Usando notação matricial/vetorial, definir:
1a. vetor de saídas desejadas de dimensão 5x1: Y=[y1; y2;...;y5]
1b. vetor de entradas aplicadas de dimensão 5x1: X=[x1; x2;...;x5]
1b. matriz de regressão de dimensão 5x2 XX=[x1 1;x2 1; ...; x5 1]
1c. vetor de coeficientes ajustáveis de dimensão 2x1 COEF=[a; b]
2. Admitindo que todos os erros sejam nulos, tem-se o seguinte sistema algébrico linear de 5 equações (5 medições) em 2 incógnitas (coeficientes a e b): Y=XX.COEF. Em um sistema algébrico linear onde a quantidade de equações é maior que a quantidade de incógnitas, só há solução se houver equações redundantes. Sendo 5 medições diferentes, espera-se que não haja redundância. Dessa forma, não há solução para esse sistema. Contudo, é possível obter a solução que minimize o erro quadrático médio, cuja definição é a mesma do MSE feita anteriormente. No Matlab, isso é feito através do comando "\". Isso é chamado de mínimos quadrados. No Matlab, obtém-se o vetor de coeficientes ajustáveis através de COEF=XX\Y.
3. Use o vetor de coeficientes ajustáveis obtido em 2 para obter o vetor de saídas estimadas pela reta. Em um mesmo gráfico, visualizar (Y) x (X); (XX.COEF) x (X)
