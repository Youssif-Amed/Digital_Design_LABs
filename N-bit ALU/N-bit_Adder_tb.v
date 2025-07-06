module Nbit_Adder_tb ();
parameter N_tb =1;
reg  [N_tb-1:0]A_tb,B_tb,F_EXPECTED;
wire [N_tb-1:0]F_DUT;


//DUT INSTANTIATION
 Nbit_Adder #(.N(N_tb)) DUT (A_tb,B_tb,F_DUT);

//TEST STIMULUS GENERATOR
initial begin
    $display("\n----START SIMULATION----\n");
    /*----------Randomize------------*/
    repeat(100)begin
        A_tb=$random;
        B_tb=$random;
        F_EXPECTED = A_tb ^ B_tb; //Another implmentation of adder
        #10;
        if (F_DUT != F_EXPECTED) begin
        $monitor("ERROR--ADDER OUTPUT IS INCORRECT!! \nWHEN A=%b -- B=%b --- F_DUT=%b -- F_EXPECTED=%b",A_tb,B_tb,F_DUT,F_EXPECTED); 
        $stop;
        end
        else begin
        $monitor("A=%b -- B=%b --- F_DUT=%b -- F_EXPECTED=%b",A_tb,B_tb,F_DUT,F_EXPECTED);    
        end
    end
    $display("\n----SUCCESSFULL SIMULATION----");
    $display("\n----END SIMULATION----");    
    $stop;
end

endmodule