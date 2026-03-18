
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dpd/reset
add wave -noupdate /dpd/clk
add wave -noupdate /dpd/UR
add wave -noupdate /dpd/UI
add wave -noupdate /dpd/UR_out
add wave -noupdate /dpd/UI_out
add wave -noupdate /dpd/U_signal_out
add wave -noupdate /dpd/U_signal_in
add wave -noupdate /dpd/power_matrix
add wave -noupdate /dpd/confusion_matrix
add wave -noupdate /dpd/multiplic
add wave -noupdate /dpd/sum
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}

force -freeze sim:/dpd/reset 1 0
force -freeze sim:/dpd/UR 000000000 0
force -freeze sim:/dpd/UI 000000000 0
force -freeze sim:/dpd/clk 1 0, 0 {50 ps} -r 100
run 200 ps
force -freeze sim:/dpd/reset 0 0
run 100 ps

run 100 ps
force -freeze sim:/dpd/UR 00001110111 0
force -freeze sim:/dpd/UI 11010100000 0
run 100 ps
force -freeze sim:/dpd/UR 00001111011 0
force -freeze sim:/dpd/UI 11010011011 0
run 100 ps
force -freeze sim:/dpd/UR 00001110110 0
force -freeze sim:/dpd/UI 11010110100 0
run 100 ps
force -freeze sim:/dpd/UR 00001101011 0
force -freeze sim:/dpd/UI 11011101000 0
run 100 ps
force -freeze sim:/dpd/UR 00001011101 0
force -freeze sim:/dpd/UI 11100110000 0
run 100 ps
force -freeze sim:/dpd/UR 00001010000 0
force -freeze sim:/dpd/UI 11110000100 0
run 100 ps
force -freeze sim:/dpd/UR 00001000110 0
force -freeze sim:/dpd/UI 11111011000 0
run 100 ps
force -freeze sim:/dpd/UR 00001000011 0
force -freeze sim:/dpd/UI 00000100101 0
run 100 ps
force -freeze sim:/dpd/UR 00001001000 0
force -freeze sim:/dpd/UI 00001100001 0
run 100 ps
force -freeze sim:/dpd/UR 00001010100 0
force -freeze sim:/dpd/UI 00010000110 0
run 100 ps
force -freeze sim:/dpd/UR 00001101000 0
force -freeze sim:/dpd/UI 00010010001 0
run 100 ps
force -freeze sim:/dpd/UR 00010000000 0
force -freeze sim:/dpd/UI 00010000001 0
run 100 ps
force -freeze sim:/dpd/UR 00010011011 0
force -freeze sim:/dpd/UI 00001011010 0
run 100 ps
force -freeze sim:/dpd/UR 00010110111 0
force -freeze sim:/dpd/UI 00000100001 0
run 100 ps
force -freeze sim:/dpd/UR 00011010001 0
force -freeze sim:/dpd/UI 11111011110 0
run 100 ps
force -freeze sim:/dpd/UR 00011101001 0
force -freeze sim:/dpd/UI 11110011000 0
run 100 ps
force -freeze sim:/dpd/UR 00011111110 0
force -freeze sim:/dpd/UI 11101010110 0
run 100 ps
force -freeze sim:/dpd/UR 00100001111 0
force -freeze sim:/dpd/UI 11100100000 0
run 100 ps
force -freeze sim:/dpd/UR 00100011101 0
force -freeze sim:/dpd/UI 11011111000 0
run 100 ps
force -freeze sim:/dpd/UR 00100100111 0
force -freeze sim:/dpd/UI 11011100001 0
run 100 ps
force -freeze sim:/dpd/UR 00100101110 0
force -freeze sim:/dpd/UI 11011011011 0
run 100 ps
force -freeze sim:/dpd/UR 00100110000 0
force -freeze sim:/dpd/UI 11011100011 0
run 100 ps
force -freeze sim:/dpd/UR 00100101110 0
force -freeze sim:/dpd/UI 11011110101 0
run 100 ps
force -freeze sim:/dpd/UR 00100100101 0
force -freeze sim:/dpd/UI 11100001101 0
run 100 ps
force -freeze sim:/dpd/UR 00100010101 0
force -freeze sim:/dpd/UI 11100101001 0
run 100 ps
force -freeze sim:/dpd/UR 00011111101 0
force -freeze sim:/dpd/UI 11101000110 0
run 100 ps
force -freeze sim:/dpd/UR 00011011101 0
force -freeze sim:/dpd/UI 11101100010 0
run 100 ps
force -freeze sim:/dpd/UR 00010110111 0
force -freeze sim:/dpd/UI 11110000000 0
run 100 ps
force -freeze sim:/dpd/UR 00010001100 0
force -freeze sim:/dpd/UI 11110100000 0
run 100 ps
force -freeze sim:/dpd/UR 00001011111 0
force -freeze sim:/dpd/UI 11111000110 0
run 100 ps
force -freeze sim:/dpd/UR 00000110011 0
force -freeze sim:/dpd/UI 11111110100 0
run 100 ps
force -freeze sim:/dpd/UR 00000001011 0
force -freeze sim:/dpd/UI 00000101011 0
run 100 ps
force -freeze sim:/dpd/UR 11111101010 0
force -freeze sim:/dpd/UI 00001101100 0
run 100 ps
force -freeze sim:/dpd/UR 11111010000 0
force -freeze sim:/dpd/UI 00010110101 0
run 100 ps
force -freeze sim:/dpd/UR 11110111111 0
force -freeze sim:/dpd/UI 00100000010 0
run 100 ps
force -freeze sim:/dpd/UR 11110110101 0
force -freeze sim:/dpd/UI 00101001110 0
run 100 ps
force -freeze sim:/dpd/UR 11110101111 0
force -freeze sim:/dpd/UI 00110010001 0
run 100 ps
force -freeze sim:/dpd/UR 11110101011 0
force -freeze sim:/dpd/UI 00111000011 0
run 100 ps
force -freeze sim:/dpd/UR 11110100101 0
force -freeze sim:/dpd/UI 00111011111 0
run 100 ps
force -freeze sim:/dpd/UR 11110011010 0
force -freeze sim:/dpd/UI 00111011110 0
run 100 ps
force -freeze sim:/dpd/UR 11110000111 0
force -freeze sim:/dpd/UI 00110111110 0
run 100 ps
force -freeze sim:/dpd/UR 11101101011 0
force -freeze sim:/dpd/UI 00101111111 0
run 100 ps
force -freeze sim:/dpd/UR 11101001001 0
force -freeze sim:/dpd/UI 00100100110 0
run 100 ps
force -freeze sim:/dpd/UR 11100100001 0
force -freeze sim:/dpd/UI 00010111000 0
run 100 ps
force -freeze sim:/dpd/UR 11011111000 0
force -freeze sim:/dpd/UI 00000111111 0
run 100 ps
force -freeze sim:/dpd/UR 11011010011 0
force -freeze sim:/dpd/UI 11111000101 0
run 100 ps
force -freeze sim:/dpd/UR 11010110110 0
force -freeze sim:/dpd/UI 11101010100 0
run 100 ps
force -freeze sim:/dpd/UR 11010100100 0
force -freeze sim:/dpd/UI 11011110110 0
run 100 ps
force -freeze sim:/dpd/UR 11010100000 0
force -freeze sim:/dpd/UI 11010110000 0
run 100 ps
force -freeze sim:/dpd/UR 11010101011 0
force -freeze sim:/dpd/UI 11010000111 0