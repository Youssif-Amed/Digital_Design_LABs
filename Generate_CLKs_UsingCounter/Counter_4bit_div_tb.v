module Counter_4bit_div_tb ();
 reg clk_tb,ASETn_tb;
 wire [3:0]out_DUT;
 wire CLK_DIV_2,CLK_DIV_4;


 //DUT & REF INSTANTIATION
 Counter_4bit_div DUT (clk_tb,ASETn_tb,out_DUT,CLK_DIV_2,CLK_DIV_4);

 
 //Clock generation
 initial begin
    clk_tb=0;
    forever begin
        #5; clk_tb=~clk_tb;
    end
 end

 //TEST STIMULUS
 initial begin
   $display("---START SIMULATION---");
   /*  CHECK THE ASYN_SET, WHICH MAKES OUT=1111  */
   ASETn_tb=0;  
   @(negedge clk_tb);
   ASETn_tb=1;
   repeat(16)  @(negedge clk_tb);
   $display("---End SIMULATION---");
   $stop;
 end
endmodule 