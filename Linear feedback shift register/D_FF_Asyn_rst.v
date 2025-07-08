module D_FF_Asyn_rst (D,a_rst,clk,q);
 input  D,a_rst,clk;
 output reg q;
 //Sequential part
 always @(posedge clk or posedge a_rst) begin
    if(a_rst)
        q<=0;
    else 
        q<=D;
 end
endmodule