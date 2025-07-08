module behav_Counter_Asetn_4bit (clk,ASETn,out);
 input clk,ASETn;
 output reg [3:0]out;

 always @(posedge clk or negedge ASETn) begin
    if(~ASETn)
        out=4'b1111;
    else
        out<=out+1;
 end
 
endmodule //Counter_4bit