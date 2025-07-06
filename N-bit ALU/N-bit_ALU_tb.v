module Nbit_ALU_tb ();
parameter N_tb=4;
reg  [1:0]OP_tb;
reg  [N_tb-1:0]A_tb,B_tb,result_EXP;
wire [N_tb-1:0]result_DUT;

//DUT INSTANTIATION
 Nbit_ALU #(.N(N_tb)) DUT (.A(A_tb),.B(B_tb),.OP(OP_tb),.result(result_DUT));

//TEST STIMULUS GENERATOR
initial begin
    $display("\n----START SIMULATION----\n");
    /*----------Randomize------------*/
    repeat(100)begin
        A_tb=$random;
        B_tb=$random;
	OP_tb=$random;
        case (OP_tb)
            2'b00 : result_EXP = A_tb+B_tb;
            2'b10 : result_EXP = A_tb-B_tb;
            2'b01 : result_EXP = A_tb|B_tb; 
            2'b11 : result_EXP = A_tb^B_tb;
        endcase
        #10;
        if (result_DUT != result_EXP) begin
        $monitor("ERROR--ALU OUTPUT IS INCORRECT!! \nWHEN A=%b -- B=%b --- result_DUT=%b -- result_EXPECTED=%b",A_tb,B_tb,result_DUT,result_EXP); 
        $stop;
        end
        else begin
        $monitor("A=%b -- B=%b --- result_DUT=%b -- result_EXPECTED=%b",A_tb,B_tb,result_DUT,result_EXP);    
        end
        #10;
        if (result_DUT != result_EXP) begin
        $monitor("ERROR--ALU OUTPUT IS INCORRECT!! \nWHEN A=%b -- B=%b --- result_DUT=%b -- result_EXPECTED=%b",A_tb,B_tb,result_DUT,result_EXP); 
        $stop;
        end
        else begin
        $monitor("A=%b -- B=%b --- result_DUT=%b -- result_EXPECTED=%b",A_tb,B_tb,result_DUT,result_EXP);    
        end
    end
    $display("\n----SUCCESSFULL SIMULATION----");
    $display("\n----END SIMULATION----");    
    $stop;
end

endmodule