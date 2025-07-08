module tb_control_unit_Self_driving();
    /*----------- Parameters -----------*/
    parameter MIN_DISTANCE = 7'd40;
    /*--------------Inputs--------------*/
    reg [7:0] speed_limit;
    reg [7:0] car_speed;
    reg [6:0] leading_distance;
    reg clk;
    reg rst;
    /*--------------outputs-------------*/
    wire unlock_doors;
    wire accelerate_car;
    /*------Instantiation of DUT--------*/
    control_unit_Self_driving #(MIN_DISTANCE) DUT (.*);
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns period
    end
    /*--------Stimulus process---------*/
    initial begin
        $display("start Simulation");
        // Initialize Inputs
        speed_limit = 0;
        car_speed = 0;
        leading_distance = 0;
        //test the reset signal
        rst=1;
        #20;
        rst = 0;
        
        // Test Case 1: Initial condition
        speed_limit = 8'd60;
        car_speed = 8'd0;
        leading_distance = 7'd50;
        #20;
        
        // Test Case 2: Accelerate
        speed_limit = 8'd60;
        car_speed = 8'd30;
        leading_distance = 7'd50;
        #20;
        
        // Test Case 3: Decelerate due to leading distance
        speed_limit = 8'd60;
        car_speed = 8'd30;
        leading_distance = 7'd30;
        #20;
        
        // Test Case 4: Decelerate due to speed limit
        speed_limit = 8'd60;
        car_speed = 8'd70;
        leading_distance = 7'd50;
        #20;
        
        // Test Case 5: Stop when car speed is zero
        speed_limit = 8'd60;
        car_speed = 8'd0;
        leading_distance = 7'd30;
        #20;

        // Test Case 6: Accelerate when safe to do so
        speed_limit = 8'd60;
        car_speed = 8'd30;
        leading_distance = 7'd50;
        #20;

        // Test Case 7: Reset during operation
        rst = 1;
        #10;
        rst = 0;
        #20;

        // Test Case 8: Return to normal operation
        speed_limit = 8'd60;
        car_speed = 8'd30;
        leading_distance = 7'd50;
        #20;

        $display("End Simulation");
        $stop;
    end 
endmodule
