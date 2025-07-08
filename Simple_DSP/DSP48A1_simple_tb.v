module Simple_DSP48A1_tb #(
    parameter OPERATION_tb = "ADD"
) ();
  // inputs and outputs 
  reg  [17:0]A_tb,B_tb,D_tb;
  reg  [47:0]C_tb;
  reg  clk_tb; 
  reg  rst_n_tb;
  wire [47:0]P_tb;

  //DUT INSTANTIATION
  Simple_DSP48A1 #(.OPERATION(OPERATION_tb)) DUT (
    .A(A_tb),.B(B_tb),.C(C_tb),.D(D_tb),.clk(clk_tb),.rst_n(rst_n_tb),.P(P_tb)
  );

  //clock generation
  initial begin
    clk_tb=0;
    forever begin
        #5; clk_tb=~clk_tb;
    end
  end

  //TEST STIMULUS
  initial begin
    $display("---START SIMULATION---");
    /* check reset signal */
    rst_n_tb = 0;
    @(negedge clk_tb);
    /* check the outputs according to timing constrains */
    rst_n_tb = 1;
    D_tb =100;
    B_tb =200;
    A_tb =300;
    C_tb =100;
    repeat(10) begin
        @(negedge clk_tb);
    end
    $display("---End SIMULATION---");
    $stop; 
  end

  //TEST MONITOR 
  initial begin
  $monitor("D = %x -- B = %x -- A = %x -- C = %x -- P = %x ",D_tb,B_tb,A_tb,C_tb,P_tb);
  end 
endmodule