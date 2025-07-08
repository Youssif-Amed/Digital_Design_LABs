module single_port_Ram #(
    parameter MEM_WIDTH = 16,           /* Data in/out and memory word width */
    parameter MEM_DEPTH = 1024,         /*  Memory depth */
    parameter ADD_SIZE = 10,            /* Address size based upon the memory depth */
    parameter ADDR_PIPELINE = "FALSE",  /* If "TRUE", the address should be pipelined before writing/reading the RAM, if
                                          "FALSE" then the address input will be assigned directly to the RAM's address port */
    parameter DOUT_PIPELINE = "TRUE",   /* If "TRUE" then the data out should be pipelined, if "FALSE" then the output will be
                                           out of the RAM directly */
    parameter PARITY_ENABLE = 1         /* If the parameter value is 1 then the parity should be calculated and assigned to
                                           parity_out port, if the parameter is O then the parity_out port should be tied to O */
)(
  /*--------------Inputs--------------*/
  input  [MEM_WIDTH-1:0]din,  
  input  [ADD_SIZE-1:0]addr,  
  input  addr_en,     /*  enable signal for the flipflop that pipelines the address */
  input  dout_en,     /*  enable signal for the flipflop that pipelines the data out */
  input  wr_en,       /*  enable signal for writing in ram */
  input  rd_en,       /*  enable signal for reading from ram */
  input  blk_select,  /*  enable signal to the ram */
  input  clk,         /*  clock signal input */
  input  rst,         /*  active high synchronous reset */

  /*--------------outputs-------------*/
  output [MEM_WIDTH-1:0]dout,  /* data out of Ram */
  output parity_out   /*  calculates the even parity on the dout bus */
);
 
 reg[MEM_WIDTH-1:0]mem [MEM_DEPTH-1:0];
 
 wire [ADD_SIZE-1:0]addr_final;  /* the address I will use to  access the location of reading or writing */
 /* Address Pipeline stage */
 generate
    if(ADDR_PIPELINE=="TRUE")
        peline_stage_mod #(.WIDTH(ADD_SIZE),  // parameter defines the width of input and output
                            .RSTTYPE("SYNC") // parameter defines the type of rst, takes SYNC or ASYNC
                )ADDR_PIPELINE_reg (.in(addr),   // [Width-1:0]input
                                    .clk(clk),    // clock input
                                    .FF_en(addr_en), // clock enable
                                    .rst(rst),    // reset signal
                                    .sel(1),    // selction of the mux
                                    .out(addr_final)     // output of the mux
                                    );
    else if(ADDR_PIPELINE=="FALSE")
        peline_stage_mod #(.WIDTH(ADD_SIZE),  // parameter defines the width of input and output
                            .RSTTYPE("SYNC") // parameter defines the type of rst, takes SYNC or ASYNC
                )ADDR_PIPELINE_reg (.in(addr),   // [Width-1:0]input
                                    .clk(clk),    // clock input
                                    .FF_en(addr_en), // clock enable
                                    .rst(rst),    // reset signal
                                    .sel(0),    // selction of the mux
                                    .out(addr_final)     // output of the mux
                                    );
 endgenerate


 reg [MEM_WIDTH-1:0]dout_from_mem;  /* the direct data output of Ram */
 always @(posedge clk ) begin
    if(rst)
        dout_from_mem <= 0;
    else begin
        if(blk_select)begin
            if(wr_en)
                mem[addr_final] <= din;
            if(rd_en)
                dout_from_mem <= mem[addr_final];
        end
    end
 end
 
 /* Dout Pipeline stage */
  generate
    if(DOUT_PIPELINE=="TRUE")
        peline_stage_mod #(.WIDTH(MEM_WIDTH),  // parameter defines the width of input and output
                            .RSTTYPE("SYNC") // parameter defines the type of rst, takes SYNC or ASYNC
                )Dout_PIPELINE_reg (.in(dout_from_mem),   // [Width-1:0]input
                                    .clk(clk),    // clock input
                                    .FF_en(dout_en), // clock enable
                                    .rst(rst),    // reset signal
                                    .sel(1),    // selction of the mux
                                    .out(dout)     // output of the mux
                                    );
    else if(DOUT_PIPELINE=="FALSE")
        peline_stage_mod #(.WIDTH(MEM_WIDTH),  // parameter defines the width of input and output
                            .RSTTYPE("SYNC") // parameter defines the type of rst, takes SYNC or ASYNC
                )Dout_PIPELINE_reg (.in(dout_from_mem),   // [Width-1:0]input
                                    .clk(clk),    // clock input
                                    .FF_en(dout_en), // clock enable
                                    .rst(rst),    // reset signal
                                    .sel(0),    // selction of the mux
                                    .out(dout)     // output of the mux
                                    );
 endgenerate

 /* Calculate parity check if the PARITY_ENABLE = 1 */
 generate
    if(PARITY_ENABLE==1)
        assign parity_out = ^dout;
    else if(PARITY_ENABLE==0)
        assign parity_out = 0;
 endgenerate

endmodule //Ram