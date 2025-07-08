module Counter_4bit_tb ();
 reg clk_tb,ASETn_tb;
 wire [3:0]out_DUT;
 wire [3:0]out_REF;

 //DUT & REF INSTANTIATION
 behav_Counter_Asetn_4bit DUT (clk_tb,ASETn_tb,out_DUT);
 Struc_counter_4bit       REF (clk_tb,ASETn_tb,out_REF);
 
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
   if(out_DUT != out_REF)begin
            $monitor("ERROR !!! -- Out_DUT is not equal Out_REF \n");
            $stop;
    end
   ASETn_tb=1;
   repeat(16) begin
        @(negedge clk_tb);
        if(out_DUT != out_REF)begin
            $monitor("ERROR !!! -- Out_DUT is not equal Out_REF \n");
            $stop;
        end
   end
   $display("---End SIMULATION---");
   $stop;
 end
 //TEST MONITOR
 initial begin
  $monitor("Out_Behav_counter = %b --- Out_Struc_counter = %b",out_DUT,out_REF);
 end 


endmodule //Counter_4bit_tb