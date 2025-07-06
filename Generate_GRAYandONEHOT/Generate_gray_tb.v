module Generate_gray_tb ();
parameter USE_GRAY_tb =1;
reg  [2:0]A_tb;
wire [6:0]B_GRAY_DUT;
integer i;

//DUT INSTANTIATION
 Generate_gray_onehot #(.USE_GRAY(USE_GRAY_tb)) GRAY_DUT (A_tb,B_GRAY_DUT);

//TEST STIMULUS GENERATOR
initial begin
    $display("\n----START SIMULATION----\n");
    /*----------Exhaustive------------*/
    for ( i=0 ; i<8 ; i=i+1 ) begin
        A_tb = i;
        $monitor("A=%b -- OUT_GRAY=%b ",A_tb,B_GRAY_DUT);
        #10;
    end
    $display("\n----SUCCESSFULL SIMULATION----");
    $display("----END SIMULATION----");    
    $stop;
end
endmodule