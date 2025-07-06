module Nbit_Adder #(
    parameter N = 1
) (A,B,F);
 input  [N-1:0]A,B;
 output [N-1:0]F;

 assign F = A+B;
    
endmodule