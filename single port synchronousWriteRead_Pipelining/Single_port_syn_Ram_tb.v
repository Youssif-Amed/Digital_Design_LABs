module single_port_Ram_tb #(
    parameter MEM_WIDTH = 16,
    parameter MEM_DEPTH = 1024,
    parameter ADD_SIZE = 10,
    parameter ADDR_PIPELINE = "FALSE",
    parameter DOUT_PIPELINE = "TRUE",
    parameter PARITY_ENABLE = 1
) ();
  /*--------------Inputs--------------*/
  reg  [MEM_WIDTH-1:0]din;  
  reg  [ADD_SIZE-1:0]addr;  
  reg  addr_en;
  reg  dout_en;  
  reg  wr_en;  
  reg  rd_en;  
  reg  blk_select;  
  reg  clk;  
  reg  rst;  
  /*--------------outputs-------------*/
  wire [MEM_WIDTH-1:0]dout;
  wire parity_out;
  /*---Instantiation of DUT and Ref---*/
  single_port_Ram  DUT (.*);
  /*---------clock generation---------*/
  initial begin
    clk=0;
    forever begin
        #20; clk=~clk;
    end
  end
  integer i;
  integer j;
  /*--------Stimulus process---------*/
  initial begin
    $display("---START SIMULATION---");
    $readmemh("mem.dat",DUT.mem);
    /* intialize the inputs */
    rst = 0;
    addr_en = 0;
    dout_en = 0;
    wr_en = 0;
    rd_en = 0;
    blk_select = 0;
    din = 0;
    addr = 0;
    /* enable reset signal */
    rst = 1;
    repeat(2) @(negedge clk);
    /* disable reset signal */
    rst = 0;
    /* enable blk_select */
    blk_select=1;
    /* enable read and disable write */
    rd_en = 1;      wr_en = 0;
    din =$random;
    addr=$random;
    repeat(2) @(negedge clk);
    /* disable read and enable write */
    rd_en = 0;      wr_en = 1;
    din =$random;
    addr =$random;
    repeat(2) @(negedge clk);
    wr_en = 0;
    /* Dout pipeline (if enabled) */
    dout_en = 1;
    @(negedge clk);
    dout_en = 0;
    /* Test Case 6: Write and Read multiple addresses */
    blk_select = 1;
    wr_en = 1;
    for ( i = 0; i < 10; i = i + 1) begin
        din = i;
        addr = $urandom_range(0,512);
        repeat(2) @(negedge clk);
    end
    wr_en = 0;
    rd_en = 1;
    for ( j = 0; j < 10; j = j + 1) begin
        addr = $urandom_range(512,1024);
        repeat(2) @(negedge clk);
    end
    rd_en = 0;

    $display("---END SIMULATION---");
    $stop;
  end

endmodule