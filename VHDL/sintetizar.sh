#!/bin/bash
# =============================================================
# Script de síntese lógica e relatório de recursos
# MP Original
# Usa Yosys + plugin GHDL
# =============================================================

YOSYS="/opt/oss-cad-suite/bin/yosys"
STD="--std=08"

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

TOP="DPD"

echo -e "${YELLOW}============================================${NC}"
echo -e "${YELLOW}  SÍNTESE LÓGICA — MP Original${NC}"
echo -e "${YELLOW}============================================${NC}"

# =============================================================
# Verifica se Yosys tem suporte ao GHDL
# =============================================================
if ! $YOSYS -m ghdl -p "help ghdl" > /dev/null 2>&1; then
    echo -e "${RED}Erro: Yosys não possui plugin GHDL habilitado.${NC}"
    echo -e "${YELLOW}Instale com:${NC} sudo pacman -S yosys ghdl yosys-ghdl"
    exit 1
fi

echo -e "${GREEN}Plugin GHDL detectado no Yosys ✔${NC}"

# =============================================================
# Rodar síntese
# =============================================================
echo -e "${YELLOW}Iniciando síntese...${NC}"

$YOSYS -m ghdl -p "
    # Importa VHDL via GHDL
    ghdl $STD functions.vhd DPD.vhd -e $TOP

    # Síntese genérica
    synth -top $TOP

    # Estatísticas
    stat
" 2>&1 | tee relatorio_sintese.txt

# =============================================================
# Verifica erro
# =============================================================
if [ ${PIPESTATUS[0]} -ne 0 ]; then
    echo -e "${RED}Erro durante a síntese.${NC}"
    exit 1
fi

echo -e "${GREEN}Síntese concluída com sucesso! ✔${NC}"
echo -e "${GREEN}Relatório salvo em: relatorio_sintese.txt${NC}"