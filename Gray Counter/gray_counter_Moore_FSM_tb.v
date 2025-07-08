module gray_counter_moore_FSM_tb();
    /*--------------Inputs--------------*/
    reg clk;
    reg arst;
    /*--------------outputs-------------*/
    wire [1:0]y;
    wire [1:0]y_REF;
    /*---Instantiation of DUT and Ref---*/
    gray_counter_Moore_FSM DUT (.*);
    gray_counter REF (clk,arst,y_REF);
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns period
    end
    /*--------Stimulus process---------*/
    initial begin
        $display("start Simulation");
        //test the reset signal
        arst=1;
        #30;
        arst= 0;
        
        // wait 100ns to check the functionality
        #100;
        $display("End Simulation");
        $stop;
    end 
    /*--------Monitor testing--------*/
    initial begin
        $monitor("Y_DUT = %b --- Y_REF = %b ",y,y_REF);
    end
   
endmodule
