module par_FF_Asyn_rstn (d,rstn,clk,q,qbar);
 parameter FF_TYPE = "DFF" ; //Default Case, act as D-FF
 input  d,rstn,clk;
 output reg q;
 output qbar;
 
 //combinational part
 assign qbar = ~q ;
 //Sequential part
 always @(posedge clk or negedge rstn) begin
    if(~rstn)
        q<=0;
    else if(FF_TYPE=="DFF")begin
        q<=d;
    end
    else if(FF_TYPE=="TFF")begin
        if(d)   q<=~q;
    end
 end
endmodule