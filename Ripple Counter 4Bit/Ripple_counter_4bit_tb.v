module Ripple_counter_4bit_tb ();
 reg  clk,rstn;
 wire [3:0]out;

 //DUT 
 Ripple_counter_4bit DUT (clk,rstn,out);

 //Clock generation
 initial begin
    clk=0;
    forever begin
        #2; clk=~clk;
    end
 end

 initial begin
   $display("---START SIMULATION---");
   /*  make the q of ff equals 0, so the out=1111  */
   rstn=0;  
   @(negedge clk);
   rstn=1;
   repeat(16) @(negedge clk);
   $display("---End SIMULATION---");
   $stop;
 end
 
 initial begin
  $monitor("Out = %b",out);
 end
endmodule 