module DEMUX_1_to_4_tb ();
 reg  [1:0]S_tb;
 reg  D_tb;
 reg [3:0]Y_EXPECTED;
 wire [3:0]Y_DUT;
 integer i;

 //DUT INSTANTIATION
 DEMUX_1_to_4 DUT (D_tb,Y_DUT,S_tb);
 
 //TEST STIMULUS GENERATOR
 initial begin
    $display("\n----START SIMULATION----\n");
    /*----------Exhaustive------------*/
    D_tb=1;
    for ( i=0 ; i<4 ; i=i+1 ) begin
        S_tb = i;
        Y_EXPECTED[0] =(S_tb==0)? D_tb : 0;
        Y_EXPECTED[1] =(S_tb==1)? D_tb : 0;
        Y_EXPECTED[2] =(S_tb==2)? D_tb : 0;
        Y_EXPECTED[3] =(S_tb==3)? D_tb : 0;
        #10;
        if (Y_DUT != Y_EXPECTED) begin
        $monitor("ERROR--DEMUX OUTPUT IS INCORRECT!! \nWHEN D=%b -- Y_DUT=%b -- Y_EXPECTED=%b ",D_tb,Y_DUT,Y_EXPECTED); 
        $stop;
        end
        else begin
        $display("D=%b-- S=%b -- Y_DUT=%b -- Y_EXPECTED=%b ",D_tb,S_tb,Y_DUT,Y_EXPECTED);    
        end
    end
    $display("\n----SUCCESSFULL SIMULATION----");
    $display("\n----END SIMULATION----");    
    $stop;
end
endmodule
