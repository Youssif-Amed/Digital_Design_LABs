module Encoder_4bit(X,Y);
 input  [3:0]X;
 output [1:0]Y;

 assign Y[1]=X[3] | X[2];
 assign Y[0]=X[3] | (X[1] & (~X[2]));

endmodule 