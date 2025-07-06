#create Work Folder
vlib work

#Compile files with names
vlog Ripple_counter_4bit.v Ripple_counter_4bit_tb.v

#simulate The TB file with module Name
vsim -voptargs=+acc work.Ripple_counter_4bit_tb

#add objects name to wave Window
add wave *

run -all

wave zoom full

