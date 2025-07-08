module LFSR (
    input  clk,rst,set,
    output [3:0]out
);

wire  XOR_out4_out0; /* input of FF2 */
assign XOR_out4_out0 = out[3]^ out[0];
//flipflops instatiations
D_FF_Asyn_set FF1 (.D(out[3]),.a_set(set),.clk(clk),.q(out[0]));
D_FF_Asyn_rst FF2 (.D(XOR_out4_out0),.a_rst(rst),.clk(clk),.q(out[1]));
D_FF_Asyn_rst FF3 (.D(out[1]),.a_rst(rst),.clk(clk),.q(out[2]));
D_FF_Asyn_rst FF4 (.D(out[2]),.a_rst(rst),.clk(clk),.q(out[3]));
    
endmodule