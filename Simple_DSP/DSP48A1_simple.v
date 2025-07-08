module Simple_DSP48A1 #(
    /*  operation parameter takes ADD or SUBSTRACT
        When substracting-> (D-B) and (multiplier_out-C)  */
    parameter OPERATION = "ADD" /* ADD is the default value */
) (
    input  [17:0]A,B,D,
    input  [47:0]C,
    input  clk,   /* input clock */ 
    input  rst_n, /* synchronous active LOW */
    output reg [47:0]P
);
  /* create registers "D-FF" for all inputs and 
     multiplier_in0 , multiplier_in1
     multiplier_out , P_out                     */
  reg [17:0]A_r,B_r,D_r;
  reg [47:0]C_r;
  reg [47:0]P_r;
  reg [17:0]multiplier_in0_r,multiplier_in1_r;
  reg [47:0]multiplier_out_r;

  always @(posedge clk) begin
    if(~rst_n)begin
        A_r <= 0;
        B_r <= 0;
        C_r <= 0;
        D_r <= 0;
        multiplier_in0_r <= 0;
        multiplier_in1_r <= 0;
        multiplier_out_r <= 0;
        P_r <= 0;
    end
    else begin
        A_r <= A;
        B_r <= B;
        C_r <= C;
        D_r <= D;
        if(OPERATION=="ADD")begin
            multiplier_in0_r <= D_r + B_r;
            multiplier_in1_r <= A_r;
            multiplier_out_r <= multiplier_in0_r * multiplier_in1_r;
            P_r <= multiplier_out_r + C_r ;
        end
        else if(OPERATION=="SUBSTRACT")begin
            multiplier_in0_r <= D_r - B_r;
            multiplier_in1_r <= A_r;
            multiplier_out_r <= multiplier_in0_r * multiplier_in1_r;
            P_r <= multiplier_out_r - C_r ;
        end
    end
    P <= P_r;
  end
endmodule