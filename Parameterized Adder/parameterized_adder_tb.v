module parameterized_adder_tb ();
    parameter WIDTH_TB = 4;
    parameter PIPELINE_ENABLE_TB = 1;
    parameter USE_FULL_ADDER_TB = 1;
    // inputs
    reg  [WIDTH_TB-1:0]a_tb,b_tb;
    reg  clk_tb; 
    reg  cin_tb; 
    reg  rst_tb;
    // outputs
    wire [WIDTH_TB-1:0]sum_DUT;
    wire cout_DUT;
    // sum_expected and cout_expected for self checking
    reg [WIDTH_TB-1:0]sum_expected;
    reg cout_expected;

    // DUT INSTANTIATION
    parameterized_adder #(.WIDTH(WIDTH_TB),
                          .PIPELINE_ENABLE(PIPELINE_ENABLE_TB),
                          .USE_FULL_ADDER(USE_FULL_ADDER_TB))
                        DUT(
                          .a(a_tb),.b(b_tb),.clk(clk_tb),
                          .cin(cin_tb),.rst(rst_tb),.sum(sum_DUT),.cout(cout_DUT));

    // clock generation 
    initial begin
        clk_tb=0;
        forever begin
            #5; clk_tb=~clk_tb;
        end
    end

    //test stimulus
    initial begin
    $display("---START SIMULATION---");
    /* Activiate reset signal */
    rst_tb = 1;
    @(negedge clk_tb);
    /* disable reset signal */
    rst_tb =0;
    repeat(5) begin
        cin_tb=$random;
        a_tb=$urandom_range(3,9);
        b_tb=$urandom_range(10,15);
        {cout_expected,sum_expected} = a_tb + b_tb + cin_tb ;
        @(negedge clk_tb);
        self_checking();
    end
    $display("---End SIMULATION---");
    $stop; 
    end

    //Self checking task
    task self_checking();
    begin
      if({cout_expected,sum_expected} != {cout_DUT,sum_DUT})begin
        $display("Error!!! \nout_DUT = %b while out_expected = %b"
                  ,{cout_DUT,sum_DUT},{cout_expected,sum_expected});
        $stop;
      end
      else begin
        $display("PASSED Iteration...\n");
      end
    end
    endtask

    /* Test monitoring */
    initial begin
        $monitor("reset =%b -- A =%b -- B =%b -- cin =%b \nout_DUT =%b -- out_expected =%b "
                 ,rst_tb,a_tb,b_tb,cin_tb,{cout_DUT,sum_DUT},{cout_expected,sum_expected});
    end
    
endmodule //parameterized_adder_tb