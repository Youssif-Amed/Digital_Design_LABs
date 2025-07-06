module Encoder_4bit_tb();
 reg  [3:0]X_tb;
 reg  [1:0]Y_EXPECTED;
 wire [1:0]Y_DUT;

//DUT INSTANTIATION
 Encoder_4bit DUT (X_tb,Y_DUT);

//TEST STIMULUS GENERATOR
initial begin
    $display("\n----START SIMULATION----\n");
    /*----------Randomize------------*/
    repeat(30)begin
        X_tb=$random;
        Y_EXPECTED = (X_tb[3] ? 2'b11 :
                     (X_tb[2] ? 2'b10 :
                     (X_tb[1] ? 2'b01 : 2'b00)));
        #10;
        if (Y_DUT != Y_EXPECTED) begin
        $monitor("ERROR--ENCODER OUTPUT IS INCORRECT!! \nWHEN X=%b -- Y_DUT=%b -- Y_EXPECTED=%b",X_tb,Y_DUT,Y_EXPECTED); 
        $stop;
        end
        else begin
        $monitor("X=%b---Y_DUT=%b---Y_EXPECTED=%b",X_tb,Y_DUT,Y_EXPECTED);    
        end
    end
    $display("\n----SUCCESSFULL SIMULATION----");
    $display("\n----END SIMULATION----");    
    $stop;
end
endmodule 