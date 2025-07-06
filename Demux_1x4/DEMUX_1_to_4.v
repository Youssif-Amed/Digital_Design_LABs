module DEMUX_1_to_4 (D,Y,S);
 input  D;
 input  [1:0]S;
 output reg [3:0]Y;
 
 always @(*) begin
    Y[3:0]=0;
    case (S)
        0 : Y[0]=D;
        1 : Y[1]=D;
        2 : Y[2]=D;
        3 : Y[3]=D;
    endcase
 end

endmodule