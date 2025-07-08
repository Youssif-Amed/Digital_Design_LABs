module Vending_machine_tb();

 reg  Doller,Quarter,rst_n,clk;
 wire Dispence,change;

 //DUT Instantiation
 Vending_machine DUT (.*);
 
 //clock generation
 initial begin
    clk=0;
    forever begin
        #5; clk=~clk;
    end
 end

 //Test Stimulus
 initial begin
    $display("---START SIMULATION---");
    /* enable reset signal */
    rst_n=0;
    @(negedge clk);
    /* disable reset signal */
    rst_n=1;
    /* give a doller not quarter*/
    Doller=1;   Quarter=0;
    @(negedge clk);
    /* give a quarter not doller*/ 
    /* trasmit to Q25 */
    Doller=0;   Quarter=1;
    @(negedge clk);
    /* give another quarter */ 
    /* trasmit to Q50 */
    Doller=0;   Quarter=1;
    @(negedge clk);
    /* give another quarter */ 
    /* trasmit to Wait */
    Doller=0;   Quarter=1;
    @(negedge clk);
    $display("---END SIMULATION---");
    $stop;
 end

endmodule