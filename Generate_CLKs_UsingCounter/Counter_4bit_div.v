module Counter_4bit_div (clk,ASETn,out,DIV_2,DIV_4);
 input clk,ASETn;
 output reg [3:0]out;
 output DIV_2,DIV_4;

 always @(posedge clk or negedge ASETn) begin
    if(~ASETn)
        out=4'b1111;
    else
        out<=out+1;
 end
 //CLOCK DIV2-->Out[1] toggles with 2 clock cycle
 //CLOCK DIV4-->Out[2] toggles with 4 clock cycle
 assign DIV_2 =out[1];
 assign DIV_4 =out[2];

endmodule 
