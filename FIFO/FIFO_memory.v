module fifo_memory #(
    /*----------- Parameters -----------*/
    parameter FIFO_WIDTH = 16,               /* Data in/out and memory word width */
    parameter FIFO_DEPTH = 512,              /* Memory depth */
    parameter ADDR_SIZE = $clog2(FIFO_DEPTH) /* Address size based on the memory depth */
)(
    /*--------------Inputs--------------*/
    input [FIFO_WIDTH-1:0] din_a,        /* Write Data: The input data bus used when writing the FIFO */
    input wen_a,                         /* Write Enable. If the FIFO is not full, make it high to write into FIFO */
    input ren_b,                         /* Read Enable. If the FIFO is not empty, make it high to read from FIFO */
    input clk_a,                         /* Clock for port a, used in the writing operation */
    input clk_b,                         /* Clock for port b, used in the reading operation */
    input rst,                           /* Active high synchronous reset. It resets dout_b and internal counter */
    /*--------------outputs-------------*/
    output reg [FIFO_WIDTH-1:0] dout_b,  /* Read Data: The output data bus used when reading from the FIFO */
    output  full,                        /* Full Flag: Indicates FIFO is full */
    output  empty                        /* Empty Flag: Indicates FIFO is empty */
);
    /*-----------FIFO MEMORY-----------*/
    reg [FIFO_WIDTH-1:0] fifo_mem [FIFO_DEPTH-1:0];
    /*------Write and Read Pointer-----*/
    reg [ADDR_SIZE-1:0] wr_ptr, rd_ptr;
    /*----Count of elements in FIFO----*/
    reg [ADDR_SIZE:0] fifo_count;

    /*-------Write into the FIFO-------*/
    always @(posedge clk_a ) begin
        if (rst) begin
            wr_ptr <= 0;
            fifo_count <= 0;
        end else if (wen_a && !full) begin
            fifo_mem[wr_ptr] <= din_a;
            wr_ptr <= wr_ptr + 1;
            fifo_count <= fifo_count + 1;
        end
    end

    /*-------Read from the FIFO-------*/
    always @(posedge clk_b) begin
        if (rst) begin
            rd_ptr <= 0;
            dout_b <= 0;
        end else if (ren_b && !empty) begin
            dout_b <= fifo_mem[rd_ptr];
            rd_ptr <= rd_ptr + 1;
            fifo_count <= fifo_count - 1;
        end
    end

    /* full and empty logic */
    assign  full =(fifo_count + 1 == FIFO_DEPTH)? 1 : 0;
    assign empty =(fifo_count - 1 == 0)? 1 : 0;

endmodule