
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
force -freeze sim:/dpd/UR 000100101 0
force -freeze sim:/dpd/UI 010001001 0
run 100 ps
force -freeze sim:/dpd/UR 000001000 0
force -freeze sim:/dpd/UI 010001000 0
run 100 ps
force -freeze sim:/dpd/UR 111101101 0
force -freeze sim:/dpd/UI 010000001 0
run 100 ps
force -freeze sim:/dpd/UR 111010010 0
force -freeze sim:/dpd/UI 001111000 0
run 100 ps
force -freeze sim:/dpd/UR 110111100 0
force -freeze sim:/dpd/UI 001100111 0
run 100 ps
force -freeze sim:/dpd/UR 110100111 0
force -freeze sim:/dpd/UI 001010111 0
run 100 ps
force -freeze sim:/dpd/UR 110010100 0
force -freeze sim:/dpd/UI 001000101 0
run 100 ps
force -freeze sim:/dpd/UR 110000110 0
force -freeze sim:/dpd/UI 000110101 0
run 100 ps
force -freeze sim:/dpd/UR 101111100 0
force -freeze sim:/dpd/UI 000100111 0
run 100 ps
force -freeze sim:/dpd/UR 101110100 0
force -freeze sim:/dpd/UI 000100000 0
run 100 ps
force -freeze sim:/dpd/UR 101101111 0
force -freeze sim:/dpd/UI 000011010 0
run 100 ps
force -freeze sim:/dpd/UR 101101111 0
force -freeze sim:/dpd/UI 000011101 0
run 100 ps
force -freeze sim:/dpd/UR 101110000 0
force -freeze sim:/dpd/UI 000100001 0
run 100 ps
force -freeze sim:/dpd/UR 101110001 0
force -freeze sim:/dpd/UI 000101010 0
run 100 ps
force -freeze sim:/dpd/UR 101110101 0
force -freeze sim:/dpd/UI 000110001 0
run 100 ps
force -freeze sim:/dpd/UR 101110110 0
force -freeze sim:/dpd/UI 000111011 0
run 100 ps
force -freeze sim:/dpd/UR 101111000 0
force -freeze sim:/dpd/UI 000111110 0
run 100 ps
force -freeze sim:/dpd/UR 101111001 0
force -freeze sim:/dpd/UI 000111111 0
run 100 ps
force -freeze sim:/dpd/UR 101110110 0
force -freeze sim:/dpd/UI 000111100 0
run 100 ps
force -freeze sim:/dpd/UR 101101111 0
force -freeze sim:/dpd/UI 000110011 0