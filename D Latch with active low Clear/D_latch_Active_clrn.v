module D_latch_Active_clrn (CLRn,D,G,Q);
 input  CLRn,D,G;
 output reg Q;

 always @(G , CLRn,D) begin
    if(~CLRn)begin
      Q<=0;
    end
    else if(G)begin
      Q<=D;
    end
 end
endmodule