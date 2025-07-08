module gray_counter_Moore_FSM (
    input  clk,  /* clock signal input */
    input  arst, /* Active high asynchronous */
    output reg [1:0]y
);
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;

  
reg [1:0]CS,NS;     /* CS -> current state  NS -> next state */

// state memory
always @(posedge clk or posedge arst) begin
    if(arst)
        CS <= A;
    else
        CS <= NS;
end

//next state logic
always @(CS) begin
    case(CS)
        A:  NS = B;
        B:  NS = C;
        C:  NS = D;
        D:  NS = A;
    endcase
end

// output logic depends only on Current state
always @(CS) begin
    case(CS)
        A:  y = 2'b00;
        B:  y = 2'b01;
        C:  y = 2'b11;
        D:  y = 2'b10;
    endcase
end

endmodule //gray_counter_Moore_FSM