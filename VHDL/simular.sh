#!/bin/bash
# =============================================================
# Script de simulação VHDL — MP Original
# Usa o OSS CAD Suite em /opt/oss-cad-suite
# =============================================================

GHDL="/opt/oss-cad-suite/bin/ghdl"
GTKWAVE="/opt/oss-cad-suite/bin/gtkwave"
STD="--std=08"

echo "=============================="
echo " Limpando compilações antigas"
echo "=============================="
rm -f *.cf

echo "=============================="
echo " Compilando arquivos VHDL"
echo "=============================="
$GHDL -a $STD functions.vhd
$GHDL -a $STD DPD.vhd
$GHDL -a $STD tb_main.vhd

echo "=============================="
echo " Elaborando testbench"
echo "=============================="
$GHDL -e $STD tb

echo "=============================="
echo " Rodando simulação"
echo "=============================="
$GHDL -r $STD tb --vcd=output.vcd --stop-time=20us

echo "=============================="
echo " Abrindo formas de onda"
echo "=============================="
# $GTKWAVE output.vcd &

echo "Simulação concluída! Arquivo de saída: output.vcd"
