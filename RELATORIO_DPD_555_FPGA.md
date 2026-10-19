# DPD 5,5,5 — recursos, frequência e FPGA-alvo

## Escopo

Consolidação da execução do Xilinx ISE identificada pelo usuário como modelo padrão **5,5,5 (DPD 555)**. A associação desse nome à execução foi fornecida pelo usuário; não foi auditada a parametrização do HDL. Não foi executada nova síntese, implementação ou simulação para produzir este documento.

Os relatórios são de **18 de outubro de 2026**: MAP às 15:36:57, início do PAR às 15:37:44 e conclusão do TRACE às 15:38:31, conforme os horários internos dos arquivos, sem conversão de fuso.[1][2][3]

**Resultado principal: o projeto está completamente roteado, mas não atende à restrição de 100 MHz.** A análise pós-roteamento reporta frequência máxima de **93,153 MHz**, slack de setup de **−0,735 ns** e **44 erros de setup**.[2][3]

## 1. FPGA-alvo e ferramentas

| Item | Valor |
|---|---|
| Fabricante / família | Xilinx / Artix-7 |
| Dispositivo | `xc7a100t` |
| Encapsulamento | `csg324` |
| Speed grade | `-2` |
| Identificador MAP | `xc7a100t-csg324-2` |
| Identificação completa TRACE | `xc7a100t,csg324,C,-2` |
| Ferramenta | Xilinx ISE 14.7, release P.20131013 |
| Modelo de velocidade | `PRODUCTION 1.10 2013-10-13` |
| Temperatura inicializada no PAR | 85 °C |
| Tensão inicializada no PAR | 0,950 V |

Dados dos cabeçalhos MAP, PAR e TRACE. Temperatura e tensão são condições do modelo de análise, não medições em hardware. Os relatórios não identificam uma placa de desenvolvimento específica.[1][2][3]

### Situação da simulação

A FPGA acima é o alvo da implementação analisada. O resumo atual marca tanto o **ISIM Simulator Log** quanto o **Post-Place and Route Simulation Model Report** como **Out of Date**, com datas de maio de 2026. Portanto, não há base nesses relatórios para afirmar que uma nova simulação temporal do modelo 5,5,5 foi executada ou validada.[6]

## 2. Consumo de recursos lógicos e dedicados

Valores do PAR, conferidos com o MAP. Percentuais recalculados como `100 × utilizado / disponível`, arredondados para duas casas decimais; os percentuais inteiros originais do ISE podem diferir.[1][2]

| Recurso | Utilizado | Disponível | Utilização calculada |
|---|---:|---:|---:|
| Slice LUTs — total | 3.163 | 63.400 | 4,99% |
| Slice Registers — posições utilizadas | 1.936 | 126.800 | 1,53% |
| Slices ocupados | 1.198 | 15.850 | 7,56% |
| DSP48E1 | 67 | 240 | 27,92% |
| RAMB36E1 / FIFO36E1 | 0 | 135 | 0,00% |
| RAMB18E1 / FIFO18E1 | 0 | 270 | 0,00% |
| IOBs utilizados (bonded) | 46 | 210 | 21,90% |
| BUFG / BUFGCTRL | 1 | 32 | 3,13% |

Detalhamento dos recursos:[1][2]

- LUTs usadas como lógica: **2.978**.
- LUTs usadas como memória: **88**, todas como shift registers; RAM single-port e dual-port: **0**.
- LUTs usadas exclusivamente como route-thrus: **97**.
- Flip-flops efetivos: **1.642**; posições de registradores usadas como lógica AND/OR: **294**. Assim, o total de 1.936 Slice Registers não equivale a 1.936 flip-flops efetivos.
- Latches e latch-thrus: **0**.
- Pares LUT–FF utilizados: **3.818**, dos quais **1.196** plenamente utilizados.
- BUFGs: **1**; BUFGCTRLs: **0**.
- MMCME2_ADV e PLLE2_ADV: **0**.

Os subtotais de LUTs estão incluídos no total. As capacidades RAMB18/RAMB36 representam modos dos recursos BRAM e não devem ser somadas como bancos físicos independentes.

## 3. Frequência e timing

### Pós-place & route — resultado principal da implementação

| Métrica | Resultado |
|---|---|
| Clock | `clk` / `clk_BUFGP` |
| Restrição | Período de 10 ns, duty cycle de 50% |
| Frequência-alvo equivalente | **100 MHz** |
| Período mínimo reportado | **10,735 ns** |
| Frequência máxima reportada | **93,153 MHz** |
| Pior slack de setup | **−0,735 ns** |
| Pior slack de hold no resumo PAR | **+0,003 ns** |
| Erros de setup | **44** |
| Erros de hold | **0** |
| Erros de component switching limit | **0** |
| Endpoints analisados / com falha | **6.957 / 44** |
| Timing score | **23.418** |
| Restrições não atendidas | **1**, `TS_clk` |
| Roteamento | Completo, sem erros de roteamento |

Valores extraídos do PAR, TRACE e UCF. **O clock-alvo de 100 MHz não foi atendido nesta execução.** O término do roteamento não implica aprovação de timing.[2][3][5]

A relação `1000 / 10,735 ns ≈ 93,153 MHz` confirma a frequência máxima reportada. Essa é uma estimativa de análise estática, não uma frequência medida em placa nem garantia de funcionamento a esse valor sem nova verificação das condições de operação. A nota do TRACE informa que o período mínimo assume atrasos de ciclo único.[3]

Primeiro caminho crítico de setup listado:[3]

- Origem: `multiplied[8]_reall_1` (FF).
- Destino: `UR_out_2` (FF).
- Requisito: **10,000 ns**.
- Atraso do caminho de dados: **10,565 ns**, com **15 níveis de lógica**.
- Skew de clock: **−0,135 ns**.
- Incerteza de clock: **0,035 ns**.
- Slack: **−0,735 ns**.

### Síntese XST — estimativa anterior ao roteamento

O XST reporta período mínimo de **9,302 ns** e frequência máxima de **107,499 MHz**. Essa estimativa não substitui o resultado pós-roteamento de **93,153 MHz** e não demonstra atendimento de 100 MHz na implementação final.[3][4]

Não foram inferidos throughput, taxa de amostragem ou latência: é necessário confirmar o pipeline e o escalonamento da arquitetura.

## 4. Consumo elétrico / potência

**Não disponível nos relatórios encontrados.** A busca por arquivos `.pwr` na árvore do projeto ISE não encontrou resultados, e a linha `Power Report` no resumo HTML está vazia.[6]

Não há valor fundamentado de potência total, estática ou dinâmica em W/mW. O MAP foi executado com `-power off`, indicando otimização de potência desabilitada, não consumo elétrico zero.[1]

Para preencher essa informação será necessária uma análise de potência, por exemplo com XPower Analyzer, com atividade de comutação e condições operacionais documentadas. Utilização de LUTs e DSPs não é uma estimativa de potência elétrica.

## 5. Avisos e limitações

- MAP: **0 erros e 48 warnings**.[1]
- PAR: **0 mensagens de erro e 1 warning**, mas **44 erros de timing**. São contagens de categorias diferentes; não interpretar “0 mensagens de erro” como fechamento de timing.[2]
- O UCF consultado restringe apenas o clock. A análise não constitui uma validação completa das interfaces externas.[5]
- A identificação do modelo foi fornecida pelo usuário; não foi comprovada equivalência entre os fontes usados pelo ISE e os fontes atuais do projeto principal.
- Os resultados não constituem medições em placa nem comprovação de simulação funcional/temporal atualizada.[6]

## 6. Evidências preservadas

Diretório de origem:

`/home/je/Applications/Xilinx_ISE_DS_Lin_14.7_1015_1/ise/DPD/`

Cópias dos seis arquivos-fonte deste documento, verificadas por SHA-256 contra os originais no momento da cópia:

`/home/je/Code/DPD/reports/DPD_555_2026-10-18/`

As referências abaixo apontam para essas cópias, evitando que uma nova execução do ISE substitua as evidências deste relatório. O relatório anterior `RELATORIO_DPD_531_FPGA.md` não foi alterado; seus links para a pasta original do ISE já não representam necessariamente os arquivos da execução antiga.

Pontos de consulta nas cópias:

- `DPD_map.mrp`: linhas 1–13 (FPGA e data), 15–95 (recursos e contagens de avisos).
- `DPD.par`: linhas 4–17 (data e condições), 21–98 (recursos), 184–206 (timing e estado).
- `DPD.twr`: linhas 28–46 (restrição e caminho crítico), 887–901 (resumo e data).
- `DPD.syr`: linha 1031 (período e frequência estimados na síntese).
- `constraints.ucf`: linha 9 (restrição de clock).
- `DPD_summary.html`: linha 472 (Power Report vazio), linhas 479–480 (simulação desatualizada).

## Sources

[1] file:///home/je/Code/DPD/reports/DPD_555_2026-10-18/DPD_map.mrp — DPD_map.mrp
[2] file:///home/je/Code/DPD/reports/DPD_555_2026-10-18/DPD.par — DPD.par
[3] file:///home/je/Code/DPD/reports/DPD_555_2026-10-18/DPD.twr — DPD.twr
[4] file:///home/je/Code/DPD/reports/DPD_555_2026-10-18/DPD.syr — DPD.syr
[5] file:///home/je/Code/DPD/reports/DPD_555_2026-10-18/constraints.ucf — constraints.ucf
[6] file:///home/je/Code/DPD/reports/DPD_555_2026-10-18/DPD_summary.html — DPD_summary.html
