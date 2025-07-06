module Ripple_counter_4bit (clk,rstn,out);
 input  clk,rstn;
 output [3:0]out;
 
 wire q0,q1,q2,q3;
 //Structural modelling, FF Instantiations
 D_FF_Asyn_rstn ff1 (.D(out[0]),.rstn(rstn),.clk(clk),.q(q0),.qbar(out[0]));
 D_FF_Asyn_rstn ff2 (.D(out[1]),.rstn(rstn),.clk(q0),.q(q1),.qbar(out[1]));
 D_FF_Asyn_rstn ff3 (.D(out[2]),.rstn(rstn),.clk(q1),.q(q2),.qbar(out[2]));
 D_FF_Asyn_rstn ff4 (.D(out[3]),.rstn(rstn),.clk(q2),.q(q3),.qbar(out[3]));
 //rstn makes the q =0 and qbar=1 , so when we activiate the rstn out =1111
endmodule 