module fifo_memory_tb();
    /*----------- Parameters -----------*/
    localparam FIFO_WIDTH = 16;
    localparam FIFO_DEPTH = 512;
    localparam ADDR_SIZE = $clog2(FIFO_DEPTH);
    /*--------------Inputs--------------*/
    reg [FIFO_WIDTH-1:0] din_a;
    reg wen_a;
    reg ren_b;
    reg clk_a;
    reg clk_b;
    reg rst;
    /*--------------outputs-------------*/
    wire [FIFO_WIDTH-1:0] dout_b;
    wire full;
    wire empty;

    /*------Instantiation of DUT--------*/
    fifo_memory #(
        .FIFO_WIDTH(FIFO_WIDTH),
        .FIFO_DEPTH(FIFO_DEPTH),
        .ADDR_SIZE(ADDR_SIZE)
    ) DUT (.*);

    /*-----clock Port-A generation------*/
    initial begin
        clk_a = 0;
        forever #5 clk_a = ~clk_a; // 10ns period
    end
    /*-----clock Port-B generation------*/
    initial begin
        clk_b = 0;
        forever #5 clk_b = ~clk_b; // 10ns period
    end
    /*--------Stimulus process---------*/
    initial begin
        $display("---START SIMULATION---");
        /* intialize the inputs */
        din_a = 0;
        wen_a = 0;
        ren_b = 0;
        rst   = 0;

        /* check reset signal */
        rst = 1;
        @(negedge clk_a);
        rst = 0;
        @(negedge clk_a);
        /* Write to FIFO */
        wen_a = 1;
        din_a = 16'hABCD;
        @(negedge clk_a);
        din_a = 16'hDCBA;
        @(negedge clk_a);
        din_a = 16'hCBCB;
        @(negedge clk_a);
        /* disable write enable */
        wen_a = 0;
        /* Read from FIFO */
        ren_b = 1;
        @(negedge clk_b);
        @(negedge clk_b);
        @(negedge clk_b);
        ren_b = 0;
        @(negedge clk_b);
        $display("---END SIMULATION---");
        $stop;
    end

    // Monitor signals
    initial begin
        $monitor("rst=%b, wen_a=%b, ren_b=%b, din_a=%h, dout_b=%h, full=%b, empty=%b", rst, wen_a, ren_b, din_a, dout_b, full, empty);
    end

endmodule