
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
force -freeze sim:/dpd/UR 000111101 0
force -freeze sim:/dpd/UI 010100000 0
run 100 ps
force -freeze sim:/dpd/UR 000011100 0
force -freeze sim:/dpd/UI 010100101 0
run 100 ps
force -freeze sim:/dpd/UR 111111001 0
force -freeze sim:/dpd/UI 010100001 0
run 100 ps
force -freeze sim:/dpd/UR 111011010 0
force -freeze sim:/dpd/UI 010010111 0
run 100 ps
force -freeze sim:/dpd/UR 110111101 0
force -freeze sim:/dpd/UI 010001000 0
run 100 ps
force -freeze sim:/dpd/UR 110100101 0
force -freeze sim:/dpd/UI 001110100 0
run 100 ps
force -freeze sim:/dpd/UR 110001111 0
force -freeze sim:/dpd/UI 001011110 0
run 100 ps
force -freeze sim:/dpd/UR 101111110 0
force -freeze sim:/dpd/UI 001001000 0
run 100 ps
force -freeze sim:/dpd/UR 101110000 0
force -freeze sim:/dpd/UI 000110101 0
run 100 ps
force -freeze sim:/dpd/UR 101100110 0
force -freeze sim:/dpd/UI 000100100 0
run 100 ps
force -freeze sim:/dpd/UR 101011111 0
force -freeze sim:/dpd/UI 000011010 0
run 100 ps
force -freeze sim:/dpd/UR 101011011 0
force -freeze sim:/dpd/UI 000010101 0
run 100 ps
force -freeze sim:/dpd/UR 101011010 0
force -freeze sim:/dpd/UI 000010111 0
run 100 ps
force -freeze sim:/dpd/UR 101011011 0
force -freeze sim:/dpd/UI 000011100 0
run 100 ps
force -freeze sim:/dpd/UR 101011100 0
force -freeze sim:/dpd/UI 000100110 0
run 100 ps
force -freeze sim:/dpd/UR 101011110 0
force -freeze sim:/dpd/UI 000101111 0
run 100 ps
force -freeze sim:/dpd/UR 101100000 0
force -freeze sim:/dpd/UI 000111001 0
run 100 ps
force -freeze sim:/dpd/UR 101100010 0
force -freeze sim:/dpd/UI 000111110 0
run 100 ps
force -freeze sim:/dpd/UR 101100001 0
force -freeze sim:/dpd/UI 000111111 0
run 100 ps
force -freeze sim:/dpd/UR 101011111 0
force -freeze sim:/dpd/UI 000111011 0
run 100 ps
force -freeze sim:/dpd/UR 101011010 0
force -freeze sim:/dpd/UI 000110010 0
run 100 ps
force -freeze sim:/dpd/UR 101010100 0
force -freeze sim:/dpd/UI 000100101 0
run 100 ps
force -freeze sim:/dpd/UR 101010000 0
force -freeze sim:/dpd/UI 000010110 0
run 100 ps
force -freeze sim:/dpd/UR 101001011 0
force -freeze sim:/dpd/UI 000001011 0
run 100 ps
force -freeze sim:/dpd/UR 101000111 0
force -freeze sim:/dpd/UI 000000011 0
run 100 ps
force -freeze sim:/dpd/UR 101001001 0
force -freeze sim:/dpd/UI 000000001 0
run 100 ps
force -freeze sim:/dpd/UR 101001111 0
force -freeze sim:/dpd/UI 000001000 0
run 100 ps
force -freeze sim:/dpd/UR 101011011 0
force -freeze sim:/dpd/UI 000011000 0
run 100 ps
force -freeze sim:/dpd/UR 101101101 0
force -freeze sim:/dpd/UI 000110001 0
run 100 ps
force -freeze sim:/dpd/UR 110000011 0
force -freeze sim:/dpd/UI 001010000 0
run 100 ps
force -freeze sim:/dpd/UR 110011110 0
force -freeze sim:/dpd/UI 001110010 0
run 100 ps
force -freeze sim:/dpd/UR 110111101 0
force -freeze sim:/dpd/UI 010010011 0
run 100 ps
force -freeze sim:/dpd/UR 111011011 0
force -freeze sim:/dpd/UI 010110001 0
run 100 ps
force -freeze sim:/dpd/UR 111111000 0
force -freeze sim:/dpd/UI 011000101 0
run 100 ps
force -freeze sim:/dpd/UR 000010011 0
force -freeze sim:/dpd/UI 011001011 0
run 100 ps
force -freeze sim:/dpd/UR 000101000 0
force -freeze sim:/dpd/UI 011000011 0
run 100 ps
force -freeze sim:/dpd/UR 000111000 0
force -freeze sim:/dpd/UI 010101100 0
run 100 ps
force -freeze sim:/dpd/UR 001000000 0
force -freeze sim:/dpd/UI 010000111 0
run 100 ps
force -freeze sim:/dpd/UR 001000001 0
force -freeze sim:/dpd/UI 001010101 0
run 100 ps
force -freeze sim:/dpd/UR 000111100 0
force -freeze sim:/dpd/UI 000011110 0
run 100 ps
force -freeze sim:/dpd/UR 000101111 0
force -freeze sim:/dpd/UI 111100100 0
run 100 ps
force -freeze sim:/dpd/UR 000011100 0
force -freeze sim:/dpd/UI 110101101 0
run 100 ps
force -freeze sim:/dpd/UR 000000110 0
force -freeze sim:/dpd/UI 110000000 0
run 100 ps
force -freeze sim:/dpd/UR 111101111 0
force -freeze sim:/dpd/UI 101011100 0
run 100 ps
force -freeze sim:/dpd/UR 111010110 0
force -freeze sim:/dpd/UI 101001010 0
run 100 ps
force -freeze sim:/dpd/UR 110111100 0
force -freeze sim:/dpd/UI 101001001 0
run 100 ps
force -freeze sim:/dpd/UR 110100011 0
force -freeze sim:/dpd/UI 101010101 0
run 100 ps
force -freeze sim:/dpd/UR 110001111 0
force -freeze sim:/dpd/UI 101110001 0
run 100 ps
force -freeze sim:/dpd/UR 101111101 0
force -freeze sim:/dpd/UI 110010110 0
run 100 ps
force -freeze sim:/dpd/UR 101101101 0
force -freeze sim:/dpd/UI 111000001 0