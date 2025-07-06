module T_FF_Asyn_rstn_tb ();
 reg  t_tb,rstn_tb,clk_tb;
 wire q_DUT,qbar_DUT;

 //DUT INSTANTIATION
 T_FF_Asyn_rstn DUT (t_tb,rstn_tb,clk_tb,q_DUT,qbar_DUT);
 
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
    t_tb=1;
    @(negedge clk_tb);
    rstn_tb=1;
    @(negedge clk_tb);
    /*---CHECK FUNCTIONALITY OF D_FF---*/
    repeat(20)begin
      t_tb=$random;
      @(negedge clk_tb);
      rstn_tb=$random;
      repeat(3) @(negedge clk_tb);
    end
    $display("---END SIMULATION---");
    $stop;
 end

 //Monitor and Display Testing
 initial begin
   $monitor("RESET =%b --- CLK =%b --- T=%b --- Q =%b --- Q_bar =%b",rstn_tb,clk_tb,t_tb,q_DUT,qbar_DUT);
 end
endmodule 