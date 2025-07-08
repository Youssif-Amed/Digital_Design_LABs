module Ram_tb #(
    parameter MEM_WIDTH = 16,
    parameter MEM_DEPTH = 1024,
    parameter ADD_SIZE = 10
) ();
  reg  [MEM_WIDTH-1:0]din;  
  reg  [ADD_SIZE-1:0]addr_wr;  
  reg  [ADD_SIZE-1:0]addr_rd;  
  reg  wr_en;  
  reg  rd_en;  
  reg  blk_select;  
  reg  clk;  
  reg  rst;  
  wire [MEM_WIDTH-1:0]dout  ;

  //DUT Instantiation
    Ram DUT (.*);

  //clock generation
  initial begin
    clk=0;
    forever begin
        #20; clk=~clk;
    end
  end

  //Test Stimulus
  initial begin
    $display("---START SIMULATION---");
    $readmemh("mem.dat",DUT.mem);
    /* enable reset signal */
    rst = 1;
    @(negedge clk);
    /* disable reset signal */
    rst = 0;
    /* enable blk_select */
    blk_select=1;
    /* enable read and disable write */
    rd_en = 1;      wr_en = 0;
    din =$random;
    addr_rd =$random;
    @(negedge clk);
    /* disable read and enable write */
    rd_en = 0;      wr_en = 1;
    din =$random;
    addr_wr =$random;
    @(negedge clk);
    /* enable read and enable write at the same time */
    rd_en = 1;      wr_en = 1;
    din =$random;
    addr_wr =$urandom_range(0,500);   addr_rd=$urandom_range(500,1023);
    @(negedge clk);

    $display("---END SIMULATION---");
    $stop;
  end

  //Test monitoring 
  initial begin
    $monitor("rst=%b -- read_en=%b -- address_read=%x\n          write_en=%b -- address_write%x\ndata_in=%x -- data_out=%x"
             ,rst,rd_en,addr_rd,wr_en,addr_wr,din,dout);
  end




    
endmodule