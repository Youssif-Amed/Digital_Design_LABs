module gray_counter (clk,rst,gray_out);
 input  clk,rst;
 output [1:0]gray_out;

 reg [1:0]binary_counter;

 always @(posedge clk) begin
    if(rst)begin
        binary_counter <= 0;
        gray_out <=0;
    end
    else begin
        binary_counter  <= binary_counter +1;
        /*
         This Way:
         The gray counter will suffer from one clock cycle delay
        gray_out[0] <= binary_counter[0]^binary_counter[1];
        gray_out[1] <= binary_counter[1]; 
        */
    end
 end
    assign gray_out[0] <= binary_counter[0]^binary_counter[1];
    assign gray_out[1] <= binary_counter[1]; 
endmodule