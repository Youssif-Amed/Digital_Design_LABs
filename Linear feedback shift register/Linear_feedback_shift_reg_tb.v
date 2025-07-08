module LFSR_tb ();
 /* inputs */
 reg  clk,rst,set;
 /* outputs */
 wire [3:0]out;

 /* DUT instantiation */
 LFSR DUT (.clk(clk),.rst(rst),.set(set),.out(out));

 /* clock generation */
 initial begin
    clk=0;
    forever begin
        #5; clk=~clk;
    end
 end

 /* Test Stimulus */
 initial begin
    $display("---START SIMULATION---");
    /* Activiate reset and set signals at the same time */
    rst = 1;
    set = 1;
    @(negedge clk);
    /* disable reset and set signals and waits for 16 clk cycles */
    rst =0;
    set= 0;
    repeat(16) @(negedge clk);
    $display("---End SIMULATION---");
    $stop; 
 end
 /* Test monitoring */
 initial begin
    $monitor("reset = %b -- set = %b -- out = %b ",rst,set,out);
 end
endmodule //Linear_feedback_shift_reg_tb