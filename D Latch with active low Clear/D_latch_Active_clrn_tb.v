module D_latch_Active_clrn_tb ();
 reg  CLRn_tb,D_tb,G_tb;
 wire Q_DUT;

 //DUT INSTANTIATION
 D_latch_Active_clrn DUT (CLRn_tb,D_tb,G_tb,Q_DUT);

 //Clock generation
 initial begin
    G_tb=0;
    forever begin
        #1; G_tb=~G_tb;
    end
 end

 //TEST STIMULUS
 initial begin
    $display("---START SIMULATION---");
    /*---CLEAR Check---*/ 
    CLRn_tb=0;
    D_tb=1;
    #4;
    CLRn_tb=1;
    #4;
    /*---CHECK FUNCTIONALITY OF D_FF---*/
    repeat(20)begin
      D_tb=$random;
      #1;
      CLRn_tb=$random;
      #4;
    end
    $display("---END SIMULATION---");
    $stop;
 end

 //Monitor and Display Testing
 initial begin
   $monitor("CLEAR =%b --- G =%b --- D=%b --- Q =%b",CLRn_tb,G_tb,D_tb,Q_DUT);
 end
endmodule 