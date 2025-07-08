module D_FF_Asyn_set (D,a_set,clk,q);
 input  D,a_set,clk;
 output reg q;
 //Sequential part
 always @(posedge clk or posedge a_set) begin
    if(a_set)
        q<=1;
    else 
        q<=D;
 end
endmodule