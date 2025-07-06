module Nbit_ALU (
    A,B,OP,result
);
 parameter N=4; // Default Value
 input  [N-1:0]A;
 input  [N-1:0]B;
 input  [1:0]OP;
 output reg  [N-1:0]result;
 
 always @(*) begin
    case (OP)
        2'b00 : result = A+B;
        2'b10 : result = A-B;
        2'b01 : result = A|B; 
        2'b11 : result = A^B;
    endcase
 end
endmodule 