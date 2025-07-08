module ALSU_tb ();
 /* parameters */
 parameter INPUT_PRIORITY = "A";
 parameter FULL_ADDER = "ON";
 /* inputs */
 reg clk,rst;
 reg [2:0]A,B;
 reg cin,serial_in,red_op_A,red_op_B;
 reg [2:0]opcode;
 reg bypass_A,bypass_B,direction;
 /* outputs */
 wire [15:0]leds;
 wire [5:0]out;
 /* internal signals (Out_expected) */
 reg [5:0]out_expected;

 /* DUT Instantiation auto-connect the ports with same name */
 ALSU DUT (.*);

 /* clock generation */
 initial begin
    clk=0;
    forever begin
        #5; clk=~clk;
    end
  end

  /* Test Stimulus */
  initial begin
    $display("---START SIMULATION---");
    /* control signals intialization */
    bypass_A = 0;  bypass_B = 0;
    red_op_A = 0;  red_op_B = 0;
    direction = 0; 
    serial_in = 0; cin = 0;
    /* reset checking */
    rst=1;
    @(negedge clk);

    /* disable reset */
    rst=0;

    //------------------------------------------------------------------
    /* check the AND operation */
    $display("\nAND operation between A and B");
    A=3'b111;  B=3'b011;
    out_expected = A & B;
    opcode=3'b000;
    repeat(3) @(negedge clk); /* need 3 clk cycles to read the output */
    self_checking();

    /* check the bypass A input */
    $display("Activiate bypass A");
    bypass_A = 1;
    out_expected = A;
    repeat(3) @(negedge clk);   self_checking(); 

    bypass_A = 0;
    /* check the bypass B input */
    $display("Activiate bypass B");
    bypass_B =1;
    out_expected = B;
    repeat(3) @(negedge clk);   self_checking();

    /* check the bypass A & B and the priority */
    $display("Activiate bypass A and B at the same time, but priority is A");
    bypass_A = 1;
    out_expected = A;
    repeat(3) @(negedge clk);   self_checking();

    bypass_A = 0;   bypass_B =0;
    /* check the AND reduction of A */
    $display("Reduction AND of A");    
    red_op_A =1;
    out_expected = &A;
    repeat(3) @(negedge clk);   self_checking();

    red_op_A =0;
    /* check the AND reduction of B */
    $display("Reduction AND of B");
    red_op_B =1;
    out_expected = &B;
    repeat(3) @(negedge clk);   self_checking();

    /* check the AND reduction of the both of A and B at the same time */
    $display("Reduction AND of A and B at the same time, but priority is A");
    red_op_A =1;
    out_expected = &A;
    repeat(3) @(negedge clk);   self_checking();

    red_op_A =0;    red_op_B =0;

    //------------------------------------------------------------------
    /* check the XOR operation */
    $display("\nXOR operation between A and B");
    A=3'b101;  B=3'b010;
    out_expected = A ^ B;
    opcode=3'b001;
    repeat(3) @(negedge clk); /* need 3 clk cycles to read the output */
    self_checking();

    /* check the bypass A input */
    $display("Activiate bypass A");
    bypass_A = 1;
    out_expected = A;
    repeat(3) @(negedge clk); self_checking();

    bypass_A = 0;
    /* check the bypass B input */
    $display("Activiate bypass B");
    bypass_B =1;
    out_expected = B;
    repeat(3) @(negedge clk); self_checking();

    /* check the bypass the both of A and B and the priority */
    bypass_A = 1;
    $display("Activiate bypass A and B at the same time, but priority is A");
    out_expected = A;
    repeat(3) @(negedge clk); self_checking();

    bypass_A = 0;   bypass_B =0;
    /* check the XOR reduction of A */
    $display("Reduction XOR of A");
    red_op_A =1;
    out_expected = ^A;
    repeat(3) @(negedge clk); self_checking();

    red_op_A =0;
    /* check the XOR reduction of B */
    $display("Reduction XOR of B");
    red_op_B =1;
    out_expected = ^B;
    repeat(3) @(negedge clk); self_checking();

    /* check the XOR reduction of the both of A and B at the same time */
    red_op_A =1;
    $display("Reduction XOR of A and B at the same time, but priority is A");
    out_expected = ^A;
    repeat(3) @(negedge clk); self_checking();
    red_op_A =0;    red_op_B =0; 

    //------------------------------------------------------------------
    /* check the ADD operation */
    $display("\nADD operation between A and B");
    A=$urandom_range(5,7);  B=$random;
    cin =1;
    out_expected = A + B + cin;
    opcode=3'b010;
    repeat(3) @(negedge clk);   self_checking();

    //------------------------------------------------------------------
    /* check the Multiplication operation */
    $display("\nMultiplication operation between A and B");
    A=$urandom_range(5,7);  B=$urandom_range(1,5);
    out_expected = A * B ;
    opcode=3'b011;
    repeat(3) @(negedge clk);   self_checking();

    //------------------------------------------------------------------
    /* check left shift operation */
    $display("\nLeft shift operation ");
    direction =1; serial_in =1;
    out_expected = {out_expected[4:0],serial_in};
    opcode=3'b100;
    repeat(3) @(negedge clk);   self_checking();
    out_expected = {out_expected[4:0],serial_in};
    out_expected = {out_expected[4:0],serial_in};
    //------------------------------------------------------------------
    /* check right shift operation */
    $display("\nRight shift operation ");
    direction =0; serial_in =1;
    /* we waited 3 clk cycles that is mean out was shifted left 3 times not 1 */
    out_expected = {serial_in,out_expected[5:1]};
    opcode=3'b100;
    repeat(3) @(negedge clk);   self_checking();
    out_expected = {serial_in,out_expected[5:1]};
    out_expected = {serial_in,out_expected[5:1]};
    //------------------------------------------------------------------
    /* check left rotate operation */
    $display("\nLeft Rotate operation ");
    direction =1; 
    out_expected = {out_expected[4:0],out_expected[5]};
    opcode=3'b101;
    repeat(3) @(negedge clk);   self_checking();
    out_expected = {out_expected[4:0],out_expected[5]};
    out_expected = {out_expected[4:0],out_expected[5]};
    //------------------------------------------------------------------
    /* check right rotate operation */
    $display("\nRight Rotate operation ");
    direction =0; 
    out_expected = {out_expected[0],out_expected[5:1]};
    opcode=3'b101;
    repeat(3) @(negedge clk);   self_checking();

    //------------------------------------------------------------------
    /* Invalid case */
    $display("\noperation code is 111 ");
    opcode=3'b111;
    out_expected = 0;
    #100;
    rst=1;
    
    $display("---End SIMULATION---");
    $stop;
  end

  //Self checking task
  task self_checking();
    begin
      if(out != out_expected)begin
        $display("Error!!! \nout = %b while out_expected = %b",out,out_expected);
        $stop;
      end
      else begin
        $display("PASSED Iteration...\n");
      end
    end
  endtask

  //Test MONITOR 
  initial begin
  $monitor(" reset = %b -- bypass_A = %b -- bypass_B = %b -- opcode = %b \n red_op_A = %b -- red_op_B = %b -- direction = %b -- serial_in = %b -- cin = %b\n A = %b -- B = %b -- out = %b -- out_expected =%b\n"
           ,rst,bypass_A,bypass_B,opcode,red_op_A,red_op_B,direction,serial_in,cin,A,B,out,out_expected);
  end 
endmodule //ALSU_tb