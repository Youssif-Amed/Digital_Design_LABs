module parameterized_adder #(
    parameter WIDTH = 4, /* width of a, b ,sum */
    /* If it is high then the output of the sum and carry will be available in the positive clock edge 
    (sequential)otherwise the circuit is pure combinational,default is high. Valid values: 0 or 1. */
    parameter PIPELINE_ENABLE = 1, /* default value */
    /* if this parameter is high then cin signal will be used during the cout and sum calculation 
    from the input signals, otherwise if this parameter is low ignore the cin input */
    parameter USE_FULL_ADDER = 1 
)(
    input  [WIDTH-1:0]a,b,
    input  clk,  /* clk input */
    input  cin,  /* carry in bit */
    input  rst,  /* Active high synchronous reset */
    output reg[WIDTH-1:0]sum,
    output reg cout  /* carry out bit */
);
    wire [WIDTH-1:0]sum_comb;
    wire cout_comb;
    // combinational full/half adder
    assign {cout_comb,sum_comb} = a + b + (USE_FULL_ADDER? cin : 0);

    //sequential full/half adder
    always @(posedge clk or posedge rst) begin
        if(rst)
            {cout, sum} <= 0;
        else if(PIPELINE_ENABLE)begin
            {cout,sum}<={cout_comb,sum_comb};
        end
        else
            {cout,sum}<={cout_comb,sum_comb};
    end
endmodule //parameterized_adder