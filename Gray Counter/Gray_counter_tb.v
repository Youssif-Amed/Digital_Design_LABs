module gray_counter_tb ();
 reg  clk,rst;
 wire [1:0]gray_out;

 //DUT instantiation
 gray_counter DUT (.*);

 //clock generation
 initial begin
    clk=0;
    forever begin
        #5; clk=~clk;
    end
 end
 //test stimulus
 initial begin
    $display("---START SIMULATION---");
    /* Activiate reset signal */
    rst = 1;
    @(negedge clk);
    /* disable reset signal */
    rst  = 0;
    /* Monitor the gray pattern */
    repeat(6) @(negedge clk);
    $display("---End SIMULATION---");
    $stop; 
    end

    /* Test monitoring */
    initial begin
        $monitor("reset =%b -- gray_out =%b ",rst,gray_out);
    end
 
endmodule
 

 

