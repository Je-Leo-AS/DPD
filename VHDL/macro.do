
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
force -freeze sim:/dpd/UR 00001110011 0
force -freeze sim:/dpd/UI 11010101010 0
run 100 ps
force -freeze sim:/dpd/UR 00001110111 0
force -freeze sim:/dpd/UI 11010100110 0
run 100 ps
force -freeze sim:/dpd/UR 00001110011 0
force -freeze sim:/dpd/UI 11010111110 0
run 100 ps
force -freeze sim:/dpd/UR 00001101000 0
force -freeze sim:/dpd/UI 11011110001 0
run 100 ps
force -freeze sim:/dpd/UR 00001011010 0
force -freeze sim:/dpd/UI 11100110111 0
run 100 ps
force -freeze sim:/dpd/UR 00001001101 0
force -freeze sim:/dpd/UI 11110000111 0
run 100 ps
force -freeze sim:/dpd/UR 00001000100 0
force -freeze sim:/dpd/UI 11111011010 0
run 100 ps
force -freeze sim:/dpd/UR 00001000001 0
force -freeze sim:/dpd/UI 00000100100 0
run 100 ps
force -freeze sim:/dpd/UR 00001000101 0
force -freeze sim:/dpd/UI 00001011110 0
run 100 ps
force -freeze sim:/dpd/UR 00001010010 0
force -freeze sim:/dpd/UI 00010000010 0
run 100 ps
force -freeze sim:/dpd/UR 00001100100 0
force -freeze sim:/dpd/UI 00010001101 0
run 100 ps
force -freeze sim:/dpd/UR 00001111100 0
force -freeze sim:/dpd/UI 00001111101 0
run 100 ps
force -freeze sim:/dpd/UR 00010010110 0
force -freeze sim:/dpd/UI 00001011000 0
run 100 ps
force -freeze sim:/dpd/UR 00010110001 0
force -freeze sim:/dpd/UI 00000100000 0
run 100 ps
force -freeze sim:/dpd/UR 00011001011 0
force -freeze sim:/dpd/UI 11111011111 0
run 100 ps
force -freeze sim:/dpd/UR 00011100010 0
force -freeze sim:/dpd/UI 11110011011 0
run 100 ps
force -freeze sim:/dpd/UR 00011110110 0
force -freeze sim:/dpd/UI 11101011011 0
run 100 ps
force -freeze sim:/dpd/UR 00100000111 0
force -freeze sim:/dpd/UI 11100100111 0
run 100 ps
force -freeze sim:/dpd/UR 00100010100 0
force -freeze sim:/dpd/UI 11100000000 0
run 100 ps
force -freeze sim:/dpd/UR 00100011110 0
force -freeze sim:/dpd/UI 11011101010 0
run 100 ps
force -freeze sim:/dpd/UR 00100100101 0
force -freeze sim:/dpd/UI 11011100100 0
run 100 ps
force -freeze sim:/dpd/UR 00100100111 0
force -freeze sim:/dpd/UI 11011101011 0
run 100 ps
force -freeze sim:/dpd/UR 00100100101 0
force -freeze sim:/dpd/UI 11011111101 0
run 100 ps
force -freeze sim:/dpd/UR 00100011100 0
force -freeze sim:/dpd/UI 11100010101 0
run 100 ps
force -freeze sim:/dpd/UR 00100001100 0
force -freeze sim:/dpd/UI 11100101111 0
run 100 ps
force -freeze sim:/dpd/UR 00011110101 0
force -freeze sim:/dpd/UI 11101001011 0
run 100 ps
force -freeze sim:/dpd/UR 00011010111 0
force -freeze sim:/dpd/UI 11101100111 0
run 100 ps
force -freeze sim:/dpd/UR 00010110010 0
force -freeze sim:/dpd/UI 11110000100 0
run 100 ps
force -freeze sim:/dpd/UR 00010001000 0
force -freeze sim:/dpd/UI 11110100011 0
run 100 ps
force -freeze sim:/dpd/UR 00001011100 0
force -freeze sim:/dpd/UI 11111001000 0
run 100 ps
force -freeze sim:/dpd/UR 00000110001 0
force -freeze sim:/dpd/UI 11111110100 0
run 100 ps
force -freeze sim:/dpd/UR 00000001011 0
force -freeze sim:/dpd/UI 00000101010 0
run 100 ps
force -freeze sim:/dpd/UR 11111101010 0
force -freeze sim:/dpd/UI 00001101001 0
run 100 ps
force -freeze sim:/dpd/UR 11111010010 0
force -freeze sim:/dpd/UI 00010110000 0
run 100 ps
force -freeze sim:/dpd/UR 11111000001 0
force -freeze sim:/dpd/UI 00011111011 0
run 100 ps
force -freeze sim:/dpd/UR 11110110111 0
force -freeze sim:/dpd/UI 00101000100 0
run 100 ps
force -freeze sim:/dpd/UR 11110110010 0
force -freeze sim:/dpd/UI 00110000100 0
run 100 ps
force -freeze sim:/dpd/UR 11110101110 0
force -freeze sim:/dpd/UI 00110110101 0
run 100 ps
force -freeze sim:/dpd/UR 11110101000 0
force -freeze sim:/dpd/UI 00111010000 0
run 100 ps
force -freeze sim:/dpd/UR 11110011101 0
force -freeze sim:/dpd/UI 00111001111 0
run 100 ps
force -freeze sim:/dpd/UR 11110001010 0
force -freeze sim:/dpd/UI 00110110000 0
run 100 ps
force -freeze sim:/dpd/UR 11101110000 0
force -freeze sim:/dpd/UI 00101110011 0
run 100 ps
force -freeze sim:/dpd/UR 11101001110 0
force -freeze sim:/dpd/UI 00100011101 0
run 100 ps
force -freeze sim:/dpd/UR 11100101000 0
force -freeze sim:/dpd/UI 00010110010 0
run 100 ps
force -freeze sim:/dpd/UR 11100000000 0
force -freeze sim:/dpd/UI 00000111101 0
run 100 ps
force -freeze sim:/dpd/UR 11011011100 0
force -freeze sim:/dpd/UI 11111000110 0
run 100 ps
force -freeze sim:/dpd/UR 11011000000 0
force -freeze sim:/dpd/UI 11101011001 0
run 100 ps
force -freeze sim:/dpd/UR 11010101110 0
force -freeze sim:/dpd/UI 11011111110 0
run 100 ps
force -freeze sim:/dpd/UR 11010101011 0
force -freeze sim:/dpd/UI 11010111011 0
run 100 ps
force -freeze sim:/dpd/UR 11010110110 0
force -freeze sim:/dpd/UI 11010010010 0