module par_DFF_Asyn_rstn_tb ();
 parameter FF_TYPE_tb = "DFF"; 
 reg  d_tb,rstn_tb,clk_tb;
 wire q_DUT,qbar_DUT,q_REF,qbar_REF;
 
 //DUT and REF INSTANTIATIONS
 par_FF_Asyn_rstn #(FF_TYPE_tb) DUT (d_tb,rstn_tb,clk_tb,q_DUT,qbar_DUT);
 D_FF_Asyn_rstn  GOLD_REF (d_tb,rstn_tb,clk_tb,q_REF,qbar_REF);
 
 //Clock generation
 initial begin
    clk_tb=0;
    forever begin
        #2; clk_tb=~clk_tb;
    end
 end

 //TEST STIMULUS
 initial begin
    $display("---START SIMULATION---");
    /*---RESET Check---*/ 
    rstn_tb=0;
    d_tb=1;
    @(negedge clk_tb);
    rstn_tb=1;
    @(negedge clk_tb);
    /*---CHECK FUNCTIONALITY OF D_FF---*/
    repeat(5)begin
      d_tb=$random;
      @(negedge clk_tb);
      if(q_DUT != q_REF)begin
        $monitor("ERROR--DFF OUTPUT IS INCORRECT!! \nWHEN RESET =%b --- CLK =%b --- D=%b --- Q =%b --- Q_REF =%b",rstn_tb,clk_tb,d_tb,q_DUT,q_REF); 
        $stop;
      end
      rstn_tb=$random;
      repeat(3) @(negedge clk_tb);
      if(q_DUT != q_REF)begin
        $monitor("ERROR--DFF OUTPUT IS INCORRECT!! \nWHEN RESET =%b --- CLK =%b --- D=%b --- Q =%b --- Q_REF =%b",rstn_tb,clk_tb,d_tb,q_DUT,q_REF); 
        $stop;
      end
    end
    repeat(10)begin
      d_tb=$random;
      @(negedge clk_tb);
    end
    if(q_DUT != q_REF)begin
       $monitor("ERROR--DFF OUTPUT IS INCORRECT!! \nWHEN RESET =%b --- CLK =%b --- D=%b --- Q =%b --- Q_REF =%b",rstn_tb,clk_tb,d_tb,q_DUT,q_REF); 
       $stop;
    end
    $display("---END SIMULATION---");
    $stop;
 end

 //Monitor and Display Testing
 initial begin
   $monitor("RESET =%b --- CLK =%b --- D=%b --- Q =%b --- Q_REF =%b",rstn_tb,clk_tb,d_tb,q_DUT,q_REF);
 end
endmodule 
