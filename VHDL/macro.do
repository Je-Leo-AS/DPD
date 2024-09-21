
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
force -freeze sim:/dpd/UR 000100100 0
force -freeze sim:/dpd/UI 010001011 0
run 100 ps
force -freeze sim:/dpd/UR 000000101 0
force -freeze sim:/dpd/UI 010001010 0
run 100 ps
force -freeze sim:/dpd/UR 011101011 0
force -freeze sim:/dpd/UI 010000011 0
run 100 ps
force -freeze sim:/dpd/UR 011010001 0
force -freeze sim:/dpd/UI 001111001 0
run 100 ps
force -freeze sim:/dpd/UR 010111010 0
force -freeze sim:/dpd/UI 001101001 0
run 100 ps
force -freeze sim:/dpd/UR 010100101 0
force -freeze sim:/dpd/UI 001011000 0
run 100 ps
force -freeze sim:/dpd/UR 010010011 0
force -freeze sim:/dpd/UI 001001000 0
run 100 ps
force -freeze sim:/dpd/UR 010000100 0
force -freeze sim:/dpd/UI 000110111 0
run 100 ps
force -freeze sim:/dpd/UR 001111010 0
force -freeze sim:/dpd/UI 000101010 0
run 100 ps
force -freeze sim:/dpd/UR 001110010 0
force -freeze sim:/dpd/UI 000100000 0