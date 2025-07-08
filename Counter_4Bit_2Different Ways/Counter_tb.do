#create Work Folder
vlib work

#Compile files with names
vlog Behav_counter_4bit.v Counter_4bit_tb.v D_FF_Asyn_rstn.v Struc_counter_4bit.v

#simulate The TB file with module Name
vsim -voptargs=+acc work.Counter_4bit_tb

#add objects name to wave Window
add wave *

run -all

wave zoom full

