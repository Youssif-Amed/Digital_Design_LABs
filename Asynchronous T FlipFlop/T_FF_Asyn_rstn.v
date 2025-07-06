module T_FF_Asyn_rstn (t,rstn,clk,q,qbar);
 input  t,rstn,clk;
 output reg q;
 output qbar;
 //combinational part
 assign qbar = ~q ;
 //Sequential part
 always @(posedge clk or negedge rstn) begin
    if(~rstn)
        q<=0;
    else if(t)
        q<=~q;
 end
endmodule