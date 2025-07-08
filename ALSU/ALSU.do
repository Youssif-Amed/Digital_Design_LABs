#create Work Folder
vlib work

#Compile files with names
vlog ALSU.v ALSU_tb.v

#simulate The TB file with module Name
vsim -voptargs=+acc work.ALSU_tb

#add the variables and internal signals with specific order
#to notice them easily
add wave -position insertpoint  \
sim:/ALSU_tb/INPUT_PRIORITY
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/First_priority
add wave -position insertpoint  \
sim:/ALSU_tb/FULL_ADDER 
add wave -position insertpoint  \
sim:/ALSU_tb/clk 
add wave -position insertpoint  \
sim:/ALSU_tb/rst 
add wave -position insertpoint  \
sim:/ALSU_tb/serial_in 
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/serial_in_r 
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/cin 
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/cin_r 
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/bypass_A 
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/bypass_A_r 
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/bypass_B 
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/bypass_B_r 
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/opcode 
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/opcode_r 
add wave -position insertpoint  \
sim:/ALSU_tb/red_op_A 
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/red_op_A_r 
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/red_op_B 
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/red_op_B_r 
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/direction 
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/direction_r 
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/A
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/A_r
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/B
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/B_r
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/out_r 
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/out 
add wave -position insertpoint  \
sim:/ALSU_tb/out_expected 
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/invalid_case 
add wave -position insertpoint  \
sim:/ALSU_tb/DUT/leds 

run -all

wave zoom full

