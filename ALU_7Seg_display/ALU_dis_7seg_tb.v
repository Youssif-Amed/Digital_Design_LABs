module ALU_dis_7seg_tb ();
 parameter N_tb=4;
 reg  [N_tb-1:0]A_tb,B_tb;
 reg  [1:0]OP_tb;
 reg  enable;
 wire a,b,c,d,e,f,g;

 //DUT INSTANTIATION
 ALU_dis_7seg #(.N(N_tb)) DUT (.A(A_tb),.B(B_tb),.OP(OP_tb),.enable(enable),.a(a),.b(b),.c(c),.d(d),.e(e),.f(f),.g(g));

 //TEST STIMULUS GENERATOR
 initial begin
    $display("\n----START SIMULATION----\n");
    /*----------directive------------*/
    /*--DISPLAY NOTHING--*/
    enable=0;
    A_tb =4'b0000;
    B_tb =4'b0000;
    OP_tb=2'b00; /*     Addition     */
    #10;
    /*--DISPLAY 0--*/
    enable=1;
    A_tb =4'b0101;
    B_tb =4'b0101;
    OP_tb=2'b10; /*   Substraction   */
    #10;
    /*--DISPLAY 1--*/
    enable=1;
    A_tb =4'b1111;
    B_tb =4'b1110;
    OP_tb=2'b11; /*   XOR   */
    #10;
    /*--DISPLAY 2--*/
    A_tb =4'b0010;
    B_tb =4'b0000;
    OP_tb=2'b01; /*   OR   */
    #10;
    /*--DISPLAY 3--*/
    A_tb =4'b0001;
    B_tb =4'b0010;
    OP_tb=2'b00; /*   Addition   */
    #10;
    /*--DISPLAY 4--*/
    A_tb =4'b0010;
    B_tb =4'b0010;
    OP_tb=2'b00; /*   Addition   */
    #10;
    /*--DISPLAY 5--*/
    A_tb =4'b1010;
    B_tb =4'b1111;
    OP_tb=2'b11; /*   XOR   */
    #10;
    /*--DISPLAY 6--*/
    A_tb =4'b1010;
    B_tb =4'b0100;
    OP_tb=2'b10; /*   Substraction   */
    #10;
    /*--DISPLAY 7--*/
    A_tb =4'b1010;
    B_tb =4'b0010;
    OP_tb=2'b10; /*   Substraction   */
    #10;
    /*--DISPLAY 8--*/
    A_tb =4'b0100;
    B_tb =4'b0100;
    OP_tb=2'b00; /*   Addition   */
    #10;
    /*--DISPLAY 9--*/
    A_tb =4'b1010;
    B_tb =4'b0001;
    OP_tb=2'b10; /*   Substraction   */
    #10;
    /*--DISPLAY A--*/
    A_tb =4'b1100;
    B_tb =4'b0010;
    OP_tb=2'b10; /*   Substraction   */
    #10;
    /*--DISPLAY B--*/
    A_tb =4'b1010;
    B_tb =4'b0001;
    OP_tb=2'b00; /*   Addition   */
    #10;
    /*--DISPLAY C--*/
    A_tb =4'b1100;
    B_tb =4'b0000;
    OP_tb=2'b10; /*   Substraction   */
    #10;
    /*--DISPLAY D--*/
    A_tb =4'b1010;
    B_tb =4'b0011;
    OP_tb=2'b00; /*   Addition   */
    #10;
    /*--DISPLAY E--*/
    A_tb =4'b1010;
    B_tb =4'b0100;
    OP_tb=2'b01; /*   OR   */
    #10;
    /*--DISPLAY F--*/
    A_tb =4'b1111;
    B_tb =4'b0000;
    OP_tb=2'b11; /*   XOR   */
    #10;
    /////////////////////////////////////////////
    $display("\n----SUCCESSFULL SIMULATION----");
    $display("\n----END SIMULATION----");    
    $stop;
end

endmodule //ALU_dis_7seg_tb
