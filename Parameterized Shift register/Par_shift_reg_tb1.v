module Par_shift_reg_tb1 ();
 parameter SHIFT_DIRECTION_TB = "RIGHT";
 parameter SHIFT_AMOUNT_TB = 2;

 reg  clk,rst,set,load;
 reg  [7:0]load_value;
 wire [7:0]PO; 

 // DUT Instantiation
 Par_shift_reg #(.SHIFT_DIRECTION(SHIFT_DIRECTION_TB),
                 .SHIFT_AMOUNT(SHIFT_AMOUNT_TB)) DUT (clk,rst,load,load_value,PO);

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
    /* load a randomized value to the output */
    load = 1;
    load_value =$urandom_range(200,230);
    @(negedge clk);
    /* disable load signal and check the shifting */
    load = 0;
    repeat(3) @(negedge clk);
    /* load another randomized value to the output */
    load = 1;
    load_value =$urandom_range(100,200);
    @(negedge clk);
    /* disable load signal and check the shifting again */
    load = 0;
    repeat(3) @(negedge clk);

    $display("---End SIMULATION---");
    $stop; 
    end

    /* Test monitoring */
    initial begin
        $monitor("reset =%b -- load =%b -- load_value =%b out =%b ",rst,load,load_value,PO);
    end
 
endmodule