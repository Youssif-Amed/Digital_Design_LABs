module Par_shift_reg #(
    parameter SHIFT_DIRECTION = "LEFT", /* specify shifting direction either LEFT or RIGHT */
    parameter SHIFT_AMOUNT = 1  /* specify the number of bits to be shifted, possible values are 1, 2, 3, 4, 5 */
) (
    input  clk,        /* clk input */
    input  rst,        /* Asynchronos Active high */
    input  load,       /* control signal if high, register should be loaded with the input “load_value” */
    input  [7:0]load_value, /* value to be loaded to the register */
    output reg[7:0]PO     /*  parallel out which represent the register to be shifted */
);
    always @(posedge clk or posedge rst) begin
        if(rst)
            PO <= 0;
        else if(load)
            PO <= load_value;
        else begin
            if(SHIFT_DIRECTION == "LEFT")
                PO <= PO << SHIFT_AMOUNT;
            else if (SHIFT_DIRECTION == "RIGHT")
                PO <= PO >> SHIFT_AMOUNT;
        end
    end
    always @(posedge clk or posedge set) begin
        if(set)
            PO <= 1;
        else if(load)
            PO <= load_value;
        else begin
            if(SHIFT_DIRECTION == "LEFT")
                PO <= PO << SHIFT_AMOUNT;
            else if (SHIFT_DIRECTION == "RIGHT")
                PO <= PO >> SHIFT_AMOUNT;
        end
    end
endmodule