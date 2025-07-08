#create Work Folder
vlib work

#Compile files with names
vlog Single_Port_syn_Ram.v Single_Port_syn_Ram_tb.v

#simulate The TB file with module Name
vsim -voptargs=+acc work.single_port_Ram_tb

#add the variables and internal signals with specific order to notice them easily

add wave -position insertpoint  \
sim:/single_port_Ram_tb/DUT/MEM_WIDTH \
sim:/single_port_Ram_tb/DUT/MEM_DEPTH \
sim:/single_port_Ram_tb/DUT/ADD_SIZE \
sim:/single_port_Ram_tb/DUT/ADDR_PIPELINE \
sim:/single_port_Ram_tb/DUT/DOUT_PIPELINE \
sim:/single_port_Ram_tb/DUT/PARITY_ENABLE \
sim:/single_port_Ram_tb/DUT/rst \
sim:/single_port_Ram_tb/DUT/clk \
sim:/single_port_Ram_tb/DUT/blk_select \
sim:/single_port_Ram_tb/i \
sim:/single_port_Ram_tb/DUT/din \
sim:/single_port_Ram_tb/DUT/addr \
sim:/single_port_Ram_tb/DUT/addr_en \
\sim:/single_port_Ram_tb/DUT/addr_final \
sim:/single_port_Ram_tb/DUT/wr_en \
sim:/single_port_Ram_tb/DUT/rd_en \
sim:/single_port_Ram_tb/j \
sim:/single_port_Ram_tb/DUT/dout_from_mem \
sim:/single_port_Ram_tb/DUT/dout_en \
sim:/single_port_Ram_tb/DUT/dout \
sim:/single_port_Ram_tb/DUT/parity_out \
sim:/single_port_Ram_tb/DUT/mem 

run -all

wave zoom full