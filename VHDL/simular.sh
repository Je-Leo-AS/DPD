#!/bin/bash
# =============================================================
# Script de simulação VHDL — MP Original
# Usa o OSS CAD Suite em /opt/oss-cad-suite
# =============================================================
GHDL="/opt/oss-cad-suite/bin/ghdl"
GTKWAVE="/opt/oss-cad-suite/bin/gtkwave"
STD="--std=08"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Função que executa um comando e para se houver erro
run_step() {
    local description="$1"
    shift
    echo -e "${YELLOW}>>> $description${NC}"
    "$@"
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo -e "${RED}✗ ERRO em: $description (código $exit_code)${NC}"
        echo -e "${RED}  Comando: $@${NC}"
        echo -e "${RED}  Simulação abortada.${NC}"
        exit $exit_code
    fi
    echo -e "${GREEN}✓ OK: $description${NC}\n"
}

echo "=============================="
echo " Limpando compilações antigas"
echo "=============================="
rm -f *.cf
echo -e "${GREEN}✓ Limpeza concluída${NC}\n"

echo "=============================="
echo " Compilando arquivos VHDL"
echo "=============================="
run_step "Compilando functions.vhd"  $GHDL -a $STD functions.vhd
run_step "Compilando DPD.vhd"        $GHDL -a $STD DPD.vhd
run_step "Compilando tb_main.vhd"    $GHDL -a $STD tb_main.vhd

echo "=============================="
echo " Elaborando testbench"
echo "=============================="
run_step "Elaborando tb" $GHDL -e $STD tb

echo "=============================="
echo " Rodando simulação"
echo "=============================="
run_step "Simulando tb" $GHDL -r $STD tb --vcd=output.vcd --stop-time=20us

echo "=============================="
echo " Abrindo formas de onda"
echo "=============================="
# $GTKWAVE output.vcd &

echo -e "${GREEN}=============================="
echo " Simulação concluída!"
echo -e " Arquivo de saída: output.vcd${NC}"