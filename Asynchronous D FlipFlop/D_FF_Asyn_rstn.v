module D_FF_Asyn_rstn (D,rstn,clk,q,qbar);
 input  D,rstn,clk;
 output reg q;
 output qbar;
 //combinational part
 assign qbar = ~q ;
 //Sequential part
 always @(posedge clk or negedge rstn) begin
    if(~rstn)
        q<=0;
    else 
        q<=D;
    
 end
endmodule