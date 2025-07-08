/*
 Design Mealy FSM for vending machine that sell bottles of water for 0.75$
 - Customers can pay either a dollar or quarters
 - Once sufficient money is entered, vending machine will dispense a bottle of water
 - If the user enters a dollar, it will return 0.25 in change
 */
module Vending_machine (Doller,Quarter,rst_n,clk,Dispence,change);
 localparam Q25 = 3'b000;
 localparam Q50 = 3'b001;
 localparam WAIT = 3'b010;
 
 input  Doller,Quarter,rst_n,clk;
 output reg Dispence,change;

 reg [1:0]CS,NS;

 //state memory
 always @(posedge clk or negedge rst_n) begin
    if (~rst_n)
        CS <= WAIT;
    else
        CS <= NS;
 end

 //output logic
 always @(CS,Doller,Quarter) begin
    case(CS)
        Q25: begin
            Dispence = 0;
            change = 0;
        end
        Q50: begin
            if(Quarter)begin
                Dispence = 1;
                change = 0;
            end else begin
                Dispence = 0;
                change = 0;
            end
        end
        WAIT: begin
            if(Doller)begin
                Dispence = 1;
                change = 1;
            end
            else begin
                Dispence = 0;
                change = 0;
            end
        end     
        default: 
                NS=WAIT; 
    endcase
 end

 //next state logic
 always @(CS,Doller,Quarter) begin
    case (CS)
        Q25:
            if(Quarter)
                NS = Q50;
            else 
                NS=CS;
        Q50:
            if(Quarter)
                NS=WAIT;  
            else
                NS=CS;
        WAIT: begin
            if(Doller)
                NS=CS;
            else
                NS=Q25;
        end
        default: 
                NS=WAIT;  
    endcase
 end

endmodule //Vending_machine